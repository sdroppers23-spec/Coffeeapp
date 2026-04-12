import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../shared/widgets/glass_container.dart';
import 'brewing_detail_screen.dart';

// ─── Method metadata for icons and gradient colors ────────────────────────────
const _methodMeta = {
  'v60': _MethodMeta(
    assetPath: 'assets/images/methods/v60.png',
    gradient: [Color(0xFFD4A574), Color(0xFF8B5E3C)],
  ),
  'chemex': _MethodMeta(
    assetPath: 'assets/images/methods/chemex.png',
    gradient: [Color(0xFFE8D5B7), Color(0xFF9C7048)],
  ),
  'aeropress': _MethodMeta(
    assetPath: 'assets/images/methods/aeropress.png',
    gradient: [Color(0xFFB8C4CC), Color(0xFF5A7A8A)],
  ),
  'french_press': _MethodMeta(
    assetPath: 'assets/images/methods/french_press.png',
    gradient: [Color(0xFFC8A96E), Color(0xFF7A5C2E)],
  ),
  'espresso': _MethodMeta(
    assetPath: 'assets/images/methods/espresso.png',
    gradient: [Color(0xFF8B2635), Color(0xFF4A1520)],
  ),
  'cold_brew': _MethodMeta(
    assetPath: 'assets/images/methods/cold_brew.png',
    gradient: [Color(0xFF4A90D9), Color(0xFF1A3A5C)],
  ),
};

class _MethodMeta {
  final String assetPath;
  final List<Color> gradient;
  const _MethodMeta({required this.assetPath, required this.gradient});
}

class MethodTile extends StatelessWidget {
  final BrewingRecipe recipe;
  final bool isGrid;
  const MethodTile({super.key, required this.recipe, this.isGrid = true});

  String get _formattedTime {
    final s = recipe.totalTimeSec;
    if (s >= 3600) return '${s ~/ 3600}h';
    if (s >= 60) return '${s ~/ 60}m';
    return '${s}s';
  }

  Color _difficultyColor(String d) {
    switch (d) {
      case 'Beginner':
        return Colors.greenAccent;
      case 'Intermediate':
        return Colors.amberAccent;
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta =
        _methodMeta[recipe.methodKey] ??
        const _MethodMeta(
          assetPath: 'assets/images/methods/v60.png',
          gradient: [Color(0xFFD4A574), Color(0xFF8B5E3C)],
        );

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BrewingDetailScreen(recipe: recipe)),
      ),
      child: GlassContainer(
        padding: EdgeInsets.zero,
        borderRadius: 24,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  meta.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: meta.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Bottom Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.4, 0.95],
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.9),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    recipe.name,
                    style: GoogleFonts.outfit(
                      fontSize: isGrid ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _CompactInfoChip(
                        icon: Icons.timer_outlined,
                        label: _formattedTime,
                      ),
                      const SizedBox(width: 8),
                      _CompactInfoChip(
                        icon: Icons.signal_cellular_alt_rounded,
                        label: recipe.difficulty,
                        color: _difficultyColor(recipe.difficulty),
                      ),
                      if (!isGrid) ...[
                        const SizedBox(width: 8),
                         _CompactInfoChip(
                          icon: Icons.coffee_rounded,
                          label: recipe.flavorProfile,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _CompactInfoChip({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
