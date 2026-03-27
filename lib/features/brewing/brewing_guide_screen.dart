import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../shared/widgets/glass_container.dart';
import 'brewing_detail_screen.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final brewingRecipesProvider = FutureProvider<List<BrewingRecipe>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllRecipes();
});

// ─── Method metadata for icons and gradient colors ────────────────────────────
const _methodMeta = {
  'v60': _MethodMeta(assetPath: 'assets/images/methods/v60.png', gradient: [Color(0xFFD4A574), Color(0xFF8B5E3C)]),
  'chemex': _MethodMeta(assetPath: 'assets/images/methods/chemex.png', gradient: [Color(0xFFE8D5B7), Color(0xFF9C7048)]),
  'aeropress': _MethodMeta(assetPath: 'assets/images/methods/aeropress.png', gradient: [Color(0xFFB8C4CC), Color(0xFF5A7A8A)]),
  'french_press': _MethodMeta(assetPath: 'assets/images/methods/french_press.png', gradient: [Color(0xFFC8A96E), Color(0xFF7A5C2E)]),
  'espresso': _MethodMeta(assetPath: 'assets/images/methods/espresso.png', gradient: [Color(0xFF8B2635), Color(0xFF4A1520)]),
  'cold_brew': _MethodMeta(assetPath: 'assets/images/methods/cold_brew.png', gradient: [Color(0xFF4A90D9), Color(0xFF1A3A5C)]),
};

class _MethodMeta {
  final String assetPath;
  final List<Color> gradient;
  const _MethodMeta({required this.assetPath, required this.gradient});
}

// ─── Screen ───────────────────────────────────────────────────────────────────
class BrewingGuideScreen extends ConsumerWidget {
  const BrewingGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(brewingRecipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Brewing Guide', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: recipesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (recipes) {
          if (recipes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading recipes…', style: TextStyle(color: Colors.white54)),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, i) => _MethodCard(recipe: recipes[i]),
          );
        },
      ),
    );
  }
}

// ─── Method Card ─────────────────────────────────────────────────────────────
class _MethodCard extends StatelessWidget {
  final BrewingRecipe recipe;
  const _MethodCard({required this.recipe});

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
    final meta = _methodMeta[recipe.methodKey] ??
        const _MethodMeta(assetPath: 'assets/images/methods/v60.png', gradient: [Color(0xFFD4A574), Color(0xFF8B5E3C)]);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BrewingDetailScreen(recipe: recipe)),
      ),
      child: GlassContainer(
        padding: EdgeInsets.zero,
        opacity: 0.08,
        imageUrl: meta.assetPath,
        imageOpacity: 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                recipe.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                recipe.flavorProfile,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
              const Spacer(),
              // Stats row
              Row(
                children: [
                  _StatChip(label: _formattedTime, icon: Icons.timer_outlined),
                  const SizedBox(width: 6),
                  _StatChip(
                    label: '${recipe.tempC.toInt()}°',
                    icon: Icons.thermostat_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _difficultyColor(recipe.difficulty).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _difficultyColor(recipe.difficulty).withOpacity(0.5),
                  ),
                ),
                child: Text(
                  recipe.difficulty,
                  style: TextStyle(
                    fontSize: 10,
                    color: _difficultyColor(recipe.difficulty),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _StatChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.white60),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white60)),
      ],
    );
  }
}
