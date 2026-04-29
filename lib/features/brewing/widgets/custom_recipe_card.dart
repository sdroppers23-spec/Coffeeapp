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
        opacity: widget.isSelected ? 0.25 : 0.08,
        backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF121212).withValues(alpha: 0.1),
            Colors.black.withValues(alpha: 0.2),
          ],
        ),
        borderColor: widget.isSelected
            ? const Color(0xFFC8A96E).withValues(alpha: 0.4)
            : Colors.white.withValues(alpha: 0.08),
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
                      value: _formatSeconds(
                        widget.recipe.extractionTimeSeconds ?? 0,
                      ),
                      label: widget.ref.t('stat_time'),
                      color: const Color(0xFF00E5FF), // Neon Cyan
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.thermostat_rounded,
                      value:
                          '${widget.recipe.brewTempC.toInt()}${widget.ref.t('unit_c')}',
                      label: widget.ref.t('stat_temp'),
                      color: const Color(0xFFFF5252), // Neon Red
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.scale_rounded,
                      value:
                          '${widget.recipe.coffeeGrams.toStringAsFixed(1)}${widget.ref.t('unit_g')}',
                      label: widget.ref.t('stat_coffee'),
                      color: const Color(0xFFFFD740), // Neon Amber
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.balance_rounded,
                      value: _getFormattedRatio(),
                      label: widget.ref.t('stat_ratio'),
                      color: const Color(0xFF69F0AE), // Neon Green
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatCell(
                      icon: Icons.psychology_outlined,
                      value: '',
                      customValue: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getDifficultyText(
                              widget.recipe.difficulty,
                              widget.ref,
                            ),
                            style: GoogleFonts.outfit(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: _getDifficultyColor(
                                widget.recipe.difficulty,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final stars = _getDifficultyStars(
                                widget.recipe.difficulty,
                              );
                              final color = _getDifficultyColor(
                                widget.recipe.difficulty,
                              );
                              return Icon(
                                index < stars
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                size: 9,
                                color: index < stars
                                    ? color
                                    : color.withValues(alpha: 0.2),
                              );
                            }),
                          ),
                        ],
                      ),
                      label: widget.ref.t('stat_difficulty'),
                      color: _getDifficultyColor(widget.recipe.difficulty),
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
                                    args: {
                                      'min':
                                          '$min:${sec.toString().padLeft(2, '0')}',
                                    },
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
      final div = widget.recipe.ek43Division;
      return div > 0 ? div.toString() : widget.recipe.grindNumber.toString();
    }
    if (widget.recipe.grinderName != null &&
        widget.recipe.grinderName!.contains('Comandante')) {
      final clicks = widget.recipe.comandanteClicks;
      return clicks > 0
          ? clicks.toString()
          : widget.recipe.grindNumber.toString();
    }
    return widget.recipe.grindNumber.toString();
  }

  String _getFormattedRatio() {
    // Priority 1: use stored brewRatio
    if (widget.recipe.brewRatio != null && widget.recipe.brewRatio! > 0) {
      return '1:${widget.recipe.brewRatio!.toStringAsFixed(1)}';
    }
    // Priority 2: calculate from water / coffee
    final coffee = widget.recipe.coffeeGrams;
    final water = widget.recipe.totalWaterMl;
    if (coffee > 0 && water > 0) {
      final ratio = water / coffee;
      return '1:${ratio.toStringAsFixed(1)}';
    }
    return '—';
  }

  String _getDifficultyText(String? difficulty, WidgetRef ref) {
    final d = (difficulty ?? 'intermediate').toLowerCase().trim();
    switch (d) {
      case '1':
      case 'easy':
      case 'beginner':
        return ref.t('difficulty_beginner');
      case '2':
      case 'medium':
      case 'intermediate':
        return ref.t('difficulty_intermediate');
      case '3':
      case 'hard':
      case 'advanced':
        return ref.t('difficulty_advanced');
      case '4':
      case 'expert':
        return ref.t('difficulty_expert');
      case '5':
      case 'master':
        return ref.t('difficulty_master');
      default:
        final n = int.tryParse(d);
        if (n == 1) return ref.t('difficulty_beginner');
        if (n == 2) return ref.t('difficulty_intermediate');
        if (n == 3) return ref.t('difficulty_advanced');
        if (n == 4) return ref.t('difficulty_expert');
        if (n == 5) return ref.t('difficulty_master');
        return ref.t('difficulty_intermediate');
    }
  }

  String _formatSeconds(int totalSeconds) {
    if (totalSeconds < 0) return '—';
    if (totalSeconds == 0) return '00:00';
    final int h = totalSeconds ~/ 3600;
    final int m = (totalSeconds % 3600) ~/ 60;
    final int s = totalSeconds % 60;

    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color _getDifficultyColor(String? difficulty) {
    final d = (difficulty ?? 'intermediate').toLowerCase().trim();
    switch (d) {
      case '1':
      case 'easy':
      case 'beginner':
        return const Color(0xFF00FF88);
      case '2':
      case 'intermediate':
      case 'medium':
        return const Color(0xFFFFEE00);
      case '3':
      case 'hard':
      case 'advanced':
        return const Color(0xFFFF3333);
      case '4':
      case 'expert':
        return const Color(0xFFFF3366);
      case '5':
      case 'master':
        return const Color(0xFFCC00FF);
      default:
        return const Color(0xFFFFEE00);
    }
  }

  int _getDifficultyStars(String? difficulty) {
    final d = (difficulty ?? 'intermediate').toLowerCase().trim();
    switch (d) {
      case '1':
      case 'easy':
      case 'beginner':
        return 1;
      case '2':
      case 'medium':
      case 'intermediate':
        return 2;
      case '3':
      case 'hard':
      case 'advanced':
        return 3;
      case '4':
      case 'expert':
        return 4;
      case '5':
      case 'master':
        return 5;
      default:
        final n = int.tryParse(d);
        if (n != null && n >= 1 && n <= 5) return n;
        return 2;
    }
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
  final Widget? customValue;
  final String label;
  final Color? color;

  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
    this.customValue,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.03),
            shape: BoxShape.circle,
            border: Border.all(color: c.withValues(alpha: 0.1), width: 0.8),
            boxShadow: [
              BoxShadow(
                color: c.withValues(alpha: 0.02),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 12,
            color: c,
            shadows: [Shadow(color: c.withValues(alpha: 0.3), blurRadius: 4)],
          ),
        ),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          child:
              customValue ??
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: c,
                  shadows: [
                    Shadow(color: c.withValues(alpha: 0.3), blurRadius: 4),
                  ],
                ),
                maxLines: 1,
              ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: Colors.white.withValues(alpha: 0.35),
              letterSpacing: 0.3,
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
