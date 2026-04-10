import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import 'custom_recipe_form.dart';
import 'custom_recipe_timer_screen.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final customRecipesForMethodProvider =
    FutureProvider.family<List<CustomRecipeDto>, String>((ref, methodKey) async {
  final db = ref.watch(databaseProvider);
  return db.getCustomRecipesForMethod('', methodKey);
});

final globalCustomRecipesProvider = FutureProvider<List<CustomRecipeDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllCustomRecipes('');
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
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CustomRecipeFormScreen(methodKey: methodKey),
          ));
          ref.invalidate(customRecipesForMethodProvider(methodKey));
        },
        icon: const Icon(Icons.add_rounded),
        label: Text('New Recipe', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFC8A96E),
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      body: recipesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
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
                        const Icon(Icons.auto_awesome_rounded, size: 48, color: Color(0xFFC8A96E)),
                        const SizedBox(height: 16),
                        Text('No custom recipes yet',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text('Your perfect brew starts here.',
                            style: TextStyle(color: Colors.white54, fontSize: 14)),
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
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) =>
                _CustomRecipeCard(recipe: recipes[i], methodKey: methodKey, ref: ref),
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
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
        data: (recipes) {
          if (recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history_rounded, size: 48, color: Colors.white24),
                  const SizedBox(height: 16),
                  Text('History is empty',
                      style: GoogleFonts.poppins(color: Colors.white38, fontSize: 16)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 100),
            itemCount: recipes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) =>
                _CustomRecipeCard(recipe: recipes[i], methodKey: recipes[i].methodKey, ref: ref),
          );
        },
      ),
    );
  }
}

// ─── Recipe Card ─────────────────────────────────────────────────────────────
class _CustomRecipeCard extends StatelessWidget {
  final CustomRecipeDto recipe;
  final String methodKey;
  final WidgetRef ref;
  const _CustomRecipeCard(
      {required this.recipe, required this.methodKey, required this.ref});

  List<Map<String, dynamic>> get _pours {
    try {
      return (jsonDecode(recipe.pourScheduleJson) as List)
          .cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pours = _pours;

    return GlassContainer(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.coffee_rounded, color: Color(0xFFC8A96E), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    recipe.name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                  ),
                ),
                // Rating stars
                if (recipe.rating > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        recipe.rating,
                        (_) => const Icon(Icons.star_rounded, color: Color(0xFFC8A96E), size: 14),
                      ),
                    ),
                  ),
                // Actions
                IconButton(
                  icon: const Icon(Icons.more_horiz_rounded, color: Colors.white38),
                  onPressed: () {
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
                              leading: const Icon(Icons.edit_rounded, color: Colors.white70),
                              title: const Text('Edit Recipe', style: TextStyle(color: Colors.white)),
                              onTap: () async {
                                Navigator.pop(context);
                                await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CustomRecipeFormScreen(
                                      methodKey: methodKey, existingRecipe: recipe),
                                ));
                                ref.invalidate(customRecipesForMethodProvider(methodKey));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                              title: const Text('Delete Recipe', style: TextStyle(color: Colors.redAccent)),
                              onTap: () async {
                                Navigator.pop(context);
                                final db = ref.read(databaseProvider);
                                await db.deleteCustomRecipe(recipe.id);
                                ref.invalidate(customRecipesForMethodProvider(methodKey));
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
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
                _Tag(Icons.scale_rounded, '${recipe.coffeeGrams.toStringAsFixed(1)}g'),
                _Tag(Icons.water_drop_rounded, '${recipe.totalWaterMl.toStringAsFixed(0)}ml'),
                if (recipe.brewTempC > 0) _Tag(Icons.thermostat_rounded, '${recipe.brewTempC.toInt()}°C'),
                if (recipe.grindNumber > 0) _Tag(Icons.settings_input_component_rounded, 'Grind ${recipe.grindNumber}'),
                if (recipe.totalPours > 1) _Tag(Icons.opacity_rounded, '${recipe.totalPours} pours'),
              ],
            ),
          ),
          
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pour #$n',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: const Color(0xFFC8A96E))),
                        const SizedBox(height: 2),
                        if (ml != null)
                          Text('${ml}ml',
                              style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
                        if (at != null)
                          Text('at ${at}min',
                              style: const TextStyle(fontSize: 11, color: Colors.white38)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Start Button
          if (pours.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CustomRecipeTimerScreen(recipe: recipe)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8A96E),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer_outlined, size: 20),
                      const SizedBox(width: 10),
                      Text('START BREWING', 
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500)),
        ],
      ),
    );
}
