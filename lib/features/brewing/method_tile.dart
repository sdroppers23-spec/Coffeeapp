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
  const MethodTile({super.key, required this.recipe});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Image.asset(
                        meta.assetPath,
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formattedTime,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _difficultyColor(recipe.difficulty),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe.difficulty,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
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
