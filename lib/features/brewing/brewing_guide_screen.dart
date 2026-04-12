import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import 'method_tile.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final brewingRecipesProvider = FutureProvider<List<BrewingRecipe>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllRecipes();
});

// ─── Screen ───────────────────────────────────────────────────────────────────
class BrewingGuideScreen extends ConsumerWidget {
  const BrewingGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(brewingRecipesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Brewing Methods',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
                  CircularProgressIndicator(color: Color(0xFFD4A574)),
                  SizedBox(height: 16),
                  Text(
                    'Setting up equipment...',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            );
          }

          // Group recipes by method
          final grouped = <String, List<BrewingRecipe>>{};
          for (var r in recipes) {
            grouped.putIfAbsent(r.methodKey, () => []).add(r);
          }

          final methods = grouped.keys.toList();

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.82,
            ),
            itemCount: methods.length,
            itemBuilder: (context, i) {
              final methodKey = methods[i];
              final methodRecipes = grouped[methodKey]!;
              return MethodTile(
                methodRecipes: methodRecipes,
              );
            },
          );
        },
      ),
    );
  }
}
