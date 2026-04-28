import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';
import '../../../shared/widgets/add_recipe_dialog.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../../../shared/widgets/glass_container.dart';
import '../custom_recipe_timer_screen.dart';
import '../custom_recipe_list.dart';
import '../../../shared/widgets/glass_swipe_wrapper.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../shared/widgets/modern_undo_timer.dart';
import '../../../core/l10n/app_localizations.dart';

class CustomRecipeCard extends StatefulWidget {
  final CustomRecipeDto recipe;
  final String methodKey;
  final WidgetRef ref;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CustomRecipeCard({
    super.key,
    required this.recipe,
    required this.methodKey,
    required this.ref,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<CustomRecipeCard> createState() => _CustomRecipeCardState();
}

class _CustomRecipeCardState extends State<CustomRecipeCard> {
  bool _isExpanded = false;

  List<Map<String, dynamic>> get _pours {
    try {
      return (jsonDecode(widget.recipe.pourScheduleJson) as List)
          .cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pours = _pours;

    final card = PressableScale(
      onLongPress: () {
        if (!kIsWeb && !Platform.isWindows) {
          Vibration.vibrate(duration: 50, amplitude: 128);
        }
        widget.onLongPress?.call();
      },
      onTap: widget.isSelectionMode
          ? widget.onTap
          : () => setState(() => _isExpanded = !_isExpanded),
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        opacity: widget.isSelected ? 0.25 : 0.15,
        borderColor: widget.isSelected
            ? const Color(0xFFC8A96E)
            : Colors.white.withValues(alpha: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isSelectionMode) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(
                        widget.isSelected
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: widget.isSelected
                            ? const Color(0xFFC8A96E)
                            : Colors.white24,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipe.name,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.recipe.methodKey.toUpperCase()} • ${widget.recipe.totalWaterMl.toInt()}ml',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.65),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (!widget.isSelectionMode)
                    Column(
                      children: [
                        _CircularIndicator(
                          onTap: () =>
                              setState(() => _isExpanded = !_isExpanded),
                          isExpanded: _isExpanded,
                        ),
                        const SizedBox(height: 4),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.white30,
                            size: 20,
                          ),
                          onPressed: () => _showActions(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.white.withValues(alpha: 0.08),
                height: 1,
              ),
            ),

            // Stats row (Standardized)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCell(
                      icon: Icons.timer_outlined,
                      value: _formatSeconds(widget.recipe.extractionTimeSeconds ?? 0),
                      label: widget.ref.t('stat_time'),
                      color: Colors.white,
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.thermostat_rounded,
                      value: '${widget.recipe.brewTempC.toInt()}${widget.ref.t('unit_c')}',
                      label: widget.ref.t('stat_temp'),
                      color: const Color(0xFFFFAB91), // Brighter coral
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.balance_rounded,
                      value: (widget.recipe.brewRatio != null && widget.recipe.brewRatio! > 0)
                          ? '1:${widget.recipe.brewRatio!.toStringAsFixed(1)}'
                          : '—',
                      label: widget.ref.t('stat_ratio'),
                      color: const Color(0xFFEBCB8B), // Brighter gold
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.scale_rounded,
                      value: '${widget.recipe.coffeeGrams.toStringAsFixed(1)}${widget.ref.t('unit_g')}',
                      label: widget.ref.t('stat_coffee'),
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Animated Detail Section
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pours.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: Colors.white12, height: 24),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                            child: Row(
                        children: pours.asMap().entries.map<Widget>((entry) {
                          final index = entry.key;
                          final pour = entry.value;
                          final n = index + 1;
                          final ml = pour['water'];
                          final min = pour['min'] ?? 0;
                          final sec = pour['sec'] ?? 0;
                          
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                    widget.ref.t(
                                      'pour_number',
                                      args: {'n': n.toString()},
                                    ),
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: const Color(0xFFEBCB8B),
                                    ),
                                  ),
                                const SizedBox(height: 2),
                                if (ml != null)
                                  Text(
                                    '$ml${widget.ref.t('unit_ml')}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                Text(
                                  widget.ref.t(
                                    'at_min',
                                    args: {'min': '$min:${sec.toString().padLeft(2, '0')}'},
                                  ),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white38,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  if (widget.recipe.notes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.notes_rounded,
                              size: 14,
                              color: Colors.white38,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.recipe.notes,
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Grinder Info (Moved to expanded)
                  if (widget.recipe.grinderName != 'Other' &&
                      widget.recipe.grinderName != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_input_component_rounded,
                            size: 14,
                            color: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${widget.recipe.grinderName}: ${_getGrinderValue()}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                          if (widget.recipe.microns != null &&
                              widget.recipe.microns! > 0) ...[
                            const SizedBox(width: 12),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.white10,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${widget.recipe.microns}μm',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                  // Start Button
                  if (pours.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CustomRecipeTimerScreen(
                                recipe: widget.recipe,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC8A96E),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.timer_outlined, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                widget.ref.t('start_brewing'),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );

    if (widget.isSelectionMode) return card;

    return GlassSwipeWrapper(
      dismissibleKey: Key('glass_swipe_recipe_${widget.recipe.id}'),
      leftAction: GlassSwipeAction(
        icon: Icons.edit_outlined,
        label: widget.ref.t('edit'),
        color: const Color(0xFF2DD4BF),
        onTap: () => _editRecipe(context),
      ),
      rightAction: widget.recipe.isArchived
          ? GlassSwipeAction(
              icon: Icons.unarchive_outlined,
              label: widget.ref.t('restore'),
              color: const Color(0xFF3A7BBF),
              onTap: () async {
                final db = widget.ref.read(databaseProvider);
                await db.toggleCustomRecipeArchive(widget.recipe.id, false);
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            )
          : GlassSwipeAction(
              icon: Icons.archive_outlined,
              label: widget.ref.t('archive'),
              color: const Color(0xFFF59E0B),
              onTap: () async {
                final db = widget.ref.read(databaseProvider);
                await db.toggleCustomRecipeArchive(widget.recipe.id, true);
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            ),
      child: card,
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 20),
        borderRadius: 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                widget.recipe.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: widget.recipe.isFavorite
                    ? Colors.redAccent
                    : Colors.white70,
              ),
              title: Text(
                widget.recipe.isFavorite
                    ? widget.ref.t('remove_from_favorites')
                    : widget.ref.t('add_to_favorites'),
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                final db = widget.ref.read(databaseProvider);
                await db.toggleCustomRecipeFavorite(
                  widget.recipe.id,
                  !widget.recipe.isFavorite,
                );
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            ),
            ListTile(
              leading: Icon(
                widget.recipe.isArchived
                    ? Icons.unarchive_outlined
                    : Icons.archive_outlined,
                color: Colors.white70,
              ),
              title: Text(
                widget.recipe.isArchived
                    ? widget.ref.t('restore_from_archive')
                    : widget.ref.t('archive_recipe'),
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                final db = widget.ref.read(databaseProvider);
                await db.toggleCustomRecipeArchive(
                  widget.recipe.id,
                  !widget.recipe.isArchived,
                );
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_rounded, color: Colors.white70),
              title: Text(
                widget.ref.t('edit_recipe'),
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _editRecipe(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
              title: Text(
                widget.ref.t('delete_recipe'),
                style: const TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(context);
                _showModernUndo(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _editRecipe(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddRecipeDialog(
        lotId: widget.recipe.lotId ?? '',
        existingRecipe: widget.recipe,
      ),
    );
    if (result == true) {
      widget.ref.invalidate(customRecipesForMethodProvider(widget.methodKey));
    }
  }

  void _showModernUndo(BuildContext context) {
    ModernUndoTimer.show(
      context,
      message: widget.ref.t('recipe_deleted'),
      onUndo: () {
        // Just cancel
      },
      onDismiss: () async {
        final db = widget.ref.read(databaseProvider);
        await db.deleteCustomRecipe(widget.recipe.id);
        widget.ref.invalidate(customRecipesForMethodProvider(widget.methodKey));
        widget.ref.invalidate(globalCustomRecipesProvider);
      },
    );
  }

  String _getGrinderValue() {
    if (widget.recipe.grinderName == 'EK43') {
      return widget.recipe.ek43Division.toString();
    }
    if (widget.recipe.grinderName != null &&
        widget.recipe.grinderName!.contains('Comandante')) {
      return widget.recipe.comandanteClicks.toString();
    }
    return widget.recipe.grindNumber.toString();
  }

  String _formatSeconds(int s) {
    if (s <= 0) return '—';
    if (s >= 3600) return '${(s / 3600).toStringAsFixed(1)} h';
    final m = s ~/ 60;
    final sec = s % 60;
    if (m > 0) return '$m:${sec.toString().padLeft(2, '0')}';
    return '$sec ${widget.ref.t('time_sec')}';
  }
}

class _CircularIndicator extends StatelessWidget {
  final VoidCallback onTap;
  final bool isExpanded;
  const _CircularIndicator({required this.onTap, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: gold.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: gold.withValues(alpha: 0.3)),
        ),
        child: AnimatedRotation(
          duration: const Duration(milliseconds: 200),
          turns: isExpanded ? 0.5 : 0,
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: gold,
          ),
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: c.withValues(alpha: 0.8)),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: c,
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 8,
              color: Colors.white.withValues(alpha: 0.45),
              letterSpacing: 0.2,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.white.withValues(alpha: 0.08),
    );
  }
}
