import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import 'widgets/custom_recipe_card.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final customRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((
      ref,
      methodKey,
    ) {
      final db = ref.watch(databaseProvider);
      // Assuming watchCustomRecipesForMethod exists or we use watchAll and filter
      // Actually app_database.dart has watchCustomRecipesForLot, let's see if it has for method.
      // If not, we can use watchAll and filter or add it.
      return db.watchCustomRecipesForMethod(methodKey);
    });

final globalCustomRecipesProvider = StreamProvider<List<CustomRecipeDto>>((
  ref,
) {
  final db = ref.watch(databaseProvider);
  return db.watchAllCustomRecipes();
});

// ─── Tab widget (embedded inside BrewingDetailScreen Tab 2) ───────────────────
class CustomRecipeListTab extends ConsumerWidget {
  final String methodKey;
  final bool showFab;
  const CustomRecipeListTab({
    super.key,
    required this.methodKey,
    this.showFab = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(customRecipesForMethodProvider(methodKey));

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: !showFab ? null : FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AddRecipeDialog(
              lotId: '', // Adding a general recipe for the method
              initialMethod: methodKey,
            ),
          );
          if (result == true) {
            ref.invalidate(customRecipesForMethodProvider(methodKey));
          }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => const AddRecipeDialog(
              lotId: '',
            ),
          );
          if (result == true) {
            ref.invalidate(globalCustomRecipesProvider);
          }
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
                  const Icon(
                    Icons.history_rounded,
                    size: 48,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ref.t('history_empty'),
                    style: GoogleFonts.outfit(
                      color: Colors.white38,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Button to add first recipe
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => const AddRecipeDialog(lotId: ''),
                      );
                      if (result == true) {
                        ref.invalidate(globalCustomRecipesProvider);
                      }
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: Text(ref.t('add_recipe')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                      foregroundColor: const Color(0xFFC8A96E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            );
          }

          bool isEspresso(String? method, String? type) {
            if (type == 'espresso') return true;
            final m = (method ?? '').toLowerCase();
            return m.contains('espresso') || m.contains('lever');
          }

          final espressoRecipes = recipes.where((r) => isEspresso(r.methodKey, r.recipeType)).toList();
          final filterRecipes = recipes.where((r) => !isEspresso(r.methodKey, r.recipeType)).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 160, 16, 100),
            children: [
              if (espressoRecipes.isNotEmpty) ...[
                _CategoryHeader(title: ref.t('espresso').toUpperCase()),
                const SizedBox(height: 16),
                ...espressoRecipes.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomRecipeCard(recipe: r, methodKey: r.methodKey, ref: ref),
                )),
                const SizedBox(height: 16),
              ],
              if (filterRecipes.isNotEmpty) ...[
                _CategoryHeader(title: ref.t('alternative').toUpperCase()),
                const SizedBox(height: 16),
                ...filterRecipes.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomRecipeCard(recipe: r, methodKey: r.methodKey, ref: ref),
                )),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String title;
  const _CategoryHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
