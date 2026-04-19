import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import 'custom_recipe_form.dart';
import 'widgets/custom_recipe_card.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final customRecipesForMethodProvider =
    FutureProvider.family<List<CustomRecipeDto>, String>((
      ref,
      methodKey,
    ) async {
      final db = ref.watch(databaseProvider);
      return db.getCustomRecipesForMethod(methodKey);
    });

final globalCustomRecipesProvider = FutureProvider<List<CustomRecipeDto>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  return db.getAllCustomRecipes();
});

// ─── Tab widget (embedded inside BrewingDetailScreen Tab 2) ───────────────────
class CustomRecipeListTab extends ConsumerWidget {
  final String methodKey;
  const CustomRecipeListTab({super.key, required this.methodKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(customRecipesForMethodProvider(methodKey));

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CustomRecipeFormScreen(methodKey: methodKey),
            ),
          );
          ref.invalidate(customRecipesForMethodProvider(methodKey));
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(
          ref.t('add_recipe'),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFC8A96E),
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      body: recipesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
        ),
        error: (e, _) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        data: (recipes) {
          if (recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          size: 48,
                          color: Color(0xFFC8A96E),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          ref.t('no_recipes_yet'),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ref.t('perfect_brew_starts_here'),
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: recipes.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) => CustomRecipeCard(
              recipe: recipes[i],
              methodKey: methodKey,
              ref: ref,
            ),
          );
        },
      ),
    );
  }
}

class GlobalCustomRecipeList extends ConsumerWidget {
  const GlobalCustomRecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(globalCustomRecipesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: recipesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
        ),
        error: (e, _) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        data: (recipes) {
          if (recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.history_rounded,
                    size: 48,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ref.t('history_empty'),
                    style: GoogleFonts.poppins(
                      color: Colors.white38,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 100),
            itemCount: recipes.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) => CustomRecipeCard(
              recipe: recipes[i],
              methodKey: recipes[i].methodKey,
              ref: ref,
            ),
          );
        },
      ),
    );
  }
}
