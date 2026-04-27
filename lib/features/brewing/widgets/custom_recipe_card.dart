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
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 4),
              child: Row(
                children: [
                  if (widget.isSelectionMode) ...[
                    Icon(
                      widget.isSelected 
                        ? Icons.check_circle_rounded 
                        : Icons.radio_button_unchecked_rounded,
                      color: widget.isSelected ? const Color(0xFFC8A96E) : Colors.white24,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.recipe.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFC8A96E),
                                ),
                              ),
                            ),
                            if (widget.recipe.isFavorite)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 16),
                              ),
                          ],
                        ),
                        Text(
                          '${widget.recipe.methodKey.toUpperCase()} • ${widget.recipe.totalWaterMl.toInt()}ml',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isSelectionMode)
                    Row(
                      children: [
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: _isExpanded ? 0.5 : 0,
                          child: Icon(
                            Icons.expand_more_rounded,
                            color: _isExpanded ? const Color(0xFFC8A96E) : Colors.white38,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz_rounded, color: Colors.white38),
                          onPressed: () => _showActions(context),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Key stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Tag(
                    Icons.scale_rounded,
                    '${widget.recipe.coffeeGrams.toStringAsFixed(1)}g',
                  ),
                  _Tag(
                    Icons.water_drop_rounded,
                    '${widget.recipe.totalWaterMl.toStringAsFixed(0)}ml',
                  ),
                  if (widget.recipe.brewTempC > 0)
                    _Tag(
                      Icons.thermostat_rounded,
                      '${widget.recipe.brewTempC.toInt()}°C',
                    ),
                  if (widget.recipe.brewRatio != null && widget.recipe.brewRatio! > 0)
                    _Tag(
                      Icons.balance_rounded,
                      '1:${widget.recipe.brewRatio!.toStringAsFixed(1)}',
                    ),
                  if (widget.recipe.grinderName != 'Other' && widget.recipe.grinderName != null)
                    _Tag(
                      Icons.settings_input_component_rounded,
                      '${widget.recipe.grinderName}: ${_getGrinderValue()}',
                    ),
                  if (widget.recipe.microns != null && widget.recipe.microns! > 0)
                    _Tag(
                      Icons.height_rounded, 
                      '${widget.recipe.microns}μm',
                    ),
                  if (widget.recipe.totalPours > 1 && widget.recipe.recipeType != 'espresso')
                    _Tag(Icons.opacity_rounded, widget.ref.t('pours_count', args: {'count': widget.recipe.totalPours.toString()})),
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
                        children: pours.map<Widget>((pour) {
                          final n = pour['pourNumber'] ?? '–';
                          final ml = pour['waterMl'];
                          final at = pour['atMinute'];
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
                                  widget.ref.t('pour_number', args: {'n': n.toString()}),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: const Color(0xFFC8A96E),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                if (ml != null)
                                  Text(
                                    '${ml}ml',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                if (at != null)
                                  Text(
                                    widget.ref.t('at_min', args: {'min': at.toString()}),
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
                            const Icon(Icons.notes_rounded, size: 14, color: Colors.white38),
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
                              builder: (_) => CustomRecipeTimerScreen(recipe: widget.recipe),
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
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
                widget.recipe.isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                color: widget.recipe.isFavorite ? Colors.redAccent : Colors.white70,
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
                await db.toggleCustomRecipeFavorite(widget.recipe.id, !widget.recipe.isFavorite);
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            ),
            ListTile(
              leading: Icon(
                widget.recipe.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined,
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
                await db.toggleCustomRecipeArchive(widget.recipe.id, !widget.recipe.isArchived);
                widget.ref.invalidate(globalCustomRecipesProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_rounded, color: Colors.white70),
              title: Text(widget.ref.t('edit_recipe'), style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _editRecipe(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
              title: Text(widget.ref.t('delete_recipe'), style: const TextStyle(color: Colors.redAccent)),
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
    if (widget.recipe.grinderName == 'EK43') return widget.recipe.ek43Division.toString();
    if (widget.recipe.grinderName != null && widget.recipe.grinderName!.contains('Comandante')) {
      return widget.recipe.comandanteClicks.toString();
    }
    return widget.recipe.grindNumber.toString();
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Tag(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFC8A96E)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
