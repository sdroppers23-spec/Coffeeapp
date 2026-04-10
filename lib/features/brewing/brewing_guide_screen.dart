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
      appBar: AppBar(
        title: Text(
          'Brewing Guide',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
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
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading recipes…',
                    style: TextStyle(color: Colors.white54),
                  ),
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
            itemBuilder: (context, i) => MethodTile(recipe: recipes[i]),
          );
        },
      ),
    );
  }
}
