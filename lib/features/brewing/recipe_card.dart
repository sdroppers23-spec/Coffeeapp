import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import 'brewing_detail_screen.dart';
import '../../core/l10n/app_localizations.dart';

class RecipeCard extends ConsumerWidget {
  final BrewingRecipeDto recipe;

  const RecipeCard({super.key, required this.recipe});

  String _formattedTime(WidgetRef ref) {
    final s = recipe.totalTimeSec ?? 0;
    if (s >= 3600) return '${(s / 3600).toStringAsFixed(1)} h';
    if (s >= 60) return '${s ~/ 60} ${ref.t('time_min')}';
    return '$s ${ref.t('time_sec')}';
  }

  String get _formattedRatio {
    final r = recipe.ratioGramsPerMl ?? 0.0;
    // Convert ratio g/ml to e.g. "1:15"
    if (r > 0) {
      final inverse = (1 / r).round();
      return '1:$inverse';
    }
    return '—';
  }

  String _getDifficultyLabel(WidgetRef ref) {
    switch ((recipe.difficulty ?? 'Medium').toLowerCase()) {
      case 'easy':
      case 'beginner':
        return ref.t('difficulty_easy');
      case 'medium':
      case 'intermediate':
        return ref.t('difficulty_med');
      case 'hard':
        return ref.t('difficulty_hard');
      case 'advanced':
        return ref.t('difficulty_advanced');
      case 'master':
        return ref.t('difficulty_master');
      default:
        return ref.t('difficulty_med');
    }
  }

  Color get _difficultyColor {
    switch ((recipe.difficulty ?? 'Medium').toLowerCase()) {
      case 'easy':
      case 'beginner':
        return const Color(0xFF4CAF50);
      case 'medium':
      case 'intermediate':
        return const Color(0xFFFFC107);
      case 'hard':
        return const Color(0xFFF44336);
      case 'advanced':
        return const Color(0xFFE91E63);
      case 'master':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFFFFC107);
    }
  }

  String _getIntensityLabel(WidgetRef ref) {
    final profile = (recipe.flavorProfile ?? '').toLowerCase();
    if (profile.contains('light') || profile.contains('легка')) {
      return ref.t('intensity_light');
    } else if (profile.contains('bold') ||
        profile.contains('сильна') ||
        profile.contains('strong')) {
      return ref.t('intensity_bold');
    } else if (profile.contains('medium') || profile.contains('середня')) {
      return ref.t('intensity_medium');
    }
    return recipe.flavorProfile ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gold = Color(0xFFC8A96E);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BrewingDetailScreen(recipe: recipe)),
      ),
      child: GlassContainer(
        padding: EdgeInsets.zero,
        borderRadius: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        if (recipe.description.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            recipe.description,
                            style: GoogleFonts.outfit(
                              fontSize: 13.5,
                              color: Colors.white.withValues(alpha: 0.65),
                              height: 1.45,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Arrow indicator
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: gold.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: gold.withValues(alpha: 0.3)),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Color(0xFFC8A96E),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Divider ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.white.withValues(alpha: 0.08),
                height: 1,
              ),
            ),

            // ── Stats row ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              child: Row(
                children: [
                  _StatCell(
                    icon: Icons.timer_outlined,
                    value: _formattedTime(ref),
                    label: ref.t('stat_time'),
                  ),
                  _VerticalDivider(),
                  _StatCell(
                    icon: Icons.thermostat_rounded,
                    value: '${recipe.tempC?.toInt() ?? 0}°C',
                    label: ref.t('stat_temp'),
                    color: const Color(0xFFFF8A65),
                  ),
                  _VerticalDivider(),
                  _StatCell(
                    icon: Icons.balance_rounded,
                    value: _formattedRatio,
                    label: ref.t('stat_ratio'),
                    color: gold,
                  ),
                  _VerticalDivider(),
                  _DifficultyCell(
                    label: _getDifficultyLabel(ref),
                    color: _difficultyColor,
                    ref: ref,
                  ),
                ],
              ),
            ),

            // ── Intensity Tag ─────────────────────────────────────────────
            if (recipe.flavorProfile != null &&
                recipe.flavorProfile!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: gold.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 11,
                        color: gold.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _getIntensityLabel(ref),
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: gold.withValues(alpha: 0.9),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat Cell ────────────────────────────────────────────────────────────────
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
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 15, color: c.withValues(alpha: 0.8)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: c,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 9,
              color: Colors.white.withValues(alpha: 0.45),
              letterSpacing: 0.3,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

// ─── Difficulty Cell ──────────────────────────────────────────────────────────
class _DifficultyCell extends StatelessWidget {
  final String label;
  final Color color;
  final WidgetRef ref;

  const _DifficultyCell({
    required this.label,
    required this.color,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 6),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            ref.t('difficulty_label'),
            style: GoogleFonts.outfit(
              fontSize: 9,
              color: Colors.white.withValues(alpha: 0.45),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Vertical Divider ─────────────────────────────────────────────────────────
class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withValues(alpha: 0.07),
    );
  }
}
