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

enum RecipeSort { date, alphabet, method }

class GlobalCustomRecipeList extends ConsumerStatefulWidget {
  const GlobalCustomRecipeList({super.key});

  @override
  ConsumerState<GlobalCustomRecipeList> createState() => _GlobalCustomRecipeListState();
}

class _GlobalCustomRecipeListState extends ConsumerState<GlobalCustomRecipeList> {
  RecipeSort _sortBy = RecipeSort.date;
  bool _isSelectionMode = false;
  final Set<int> _selectedIds = {};

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  Future<void> _deleteSelected() async {
    final db = ref.read(databaseProvider);
    for (final id in _selectedIds) {
      await db.deleteCustomRecipe(id);
    }
    setState(() {
      _selectedIds.clear();
      _isSelectionMode = false;
    });
    ref.invalidate(globalCustomRecipesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(globalCustomRecipesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: _isSelectionMode ? null : FloatingActionButton.extended(
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
                ],
              ),
            );
          }

          // Sorting
          List<CustomRecipeDto> sortedRecipes = List.from(recipes);
          switch (_sortBy) {
            case RecipeSort.date:
              sortedRecipes.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
              break;
            case RecipeSort.alphabet:
              sortedRecipes.sort((a, b) => a.name.compareTo(b.name));
              break;
            case RecipeSort.method:
              sortedRecipes.sort((a, b) => (a.methodKey ?? '').compareTo(b.methodKey ?? ''));
              break;
          }

          bool isEspresso(String? method, String? type) {
            if (type == 'espresso') return true;
            final m = (method ?? '').toLowerCase();
            return m.contains('espresso') || m.contains('lever');
          }

          final espressoRecipes = sortedRecipes.where((r) => isEspresso(r.methodKey, r.recipeType)).toList();
          final filterRecipes = sortedRecipes.where((r) => !isEspresso(r.methodKey, r.recipeType)).toList();

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 170, 16, 120),
                children: [
                  if (espressoRecipes.isNotEmpty) ...[
                    _CategoryHeader(title: ref.t('espresso').toUpperCase()),
                    const SizedBox(height: 16),
                    ...espressoRecipes.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CustomRecipeCard(
                        recipe: r, 
                        methodKey: r.methodKey, 
                        ref: ref,
                        isSelectionMode: _isSelectionMode,
                        isSelected: _selectedIds.contains(r.id),
                        onTap: () => _toggleSelection(r.id),
                      ),
                    )),
                    const SizedBox(height: 16),
                  ],
                  if (filterRecipes.isNotEmpty) ...[
                    _CategoryHeader(title: ref.t('filter').toUpperCase()),
                    const SizedBox(height: 16),
                    ...filterRecipes.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CustomRecipeCard(
                        recipe: r, 
                        methodKey: r.methodKey, 
                        ref: ref,
                        isSelectionMode: _isSelectionMode,
                        isSelected: _selectedIds.contains(r.id),
                        onTap: () => _toggleSelection(r.id),
                      ),
                    )),
                  ],
                ],
              ),

              // Sticky Header for Sorting & Selection
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 110, 16, 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF0F0E0D),
                        const Color(0xFF0F0E0D).withValues(alpha: 0.9),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.8, 1.0],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _SortChip(
                                label: ref.t('date_added'),
                                isSelected: _sortBy == RecipeSort.date,
                                onTap: () => setState(() => _sortBy = RecipeSort.date),
                              ),
                              const SizedBox(width: 8),
                              _SortChip(
                                label: ref.t('alphabetical'),
                                isSelected: _sortBy == RecipeSort.alphabet,
                                onTap: () => setState(() => _sortBy = RecipeSort.alphabet),
                              ),
                              const SizedBox(width: 8),
                              _SortChip(
                                label: ref.t('brewing_method'),
                                isSelected: _sortBy == RecipeSort.method,
                                onTap: () => setState(() => _sortBy = RecipeSort.method),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _ActionIcon(
                        icon: _isSelectionMode ? Icons.close_rounded : Icons.checklist_rounded,
                        onTap: () => setState(() {
                          _isSelectionMode = !_isSelectionMode;
                          if (!_isSelectionMode) _selectedIds.clear();
                        }),
                        color: _isSelectionMode ? Colors.redAccent : const Color(0xFFC8A96E),
                      ),
                      if (_isSelectionMode && _selectedIds.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        _ActionIcon(
                          icon: Icons.delete_sweep_rounded,
                          onTap: _deleteSelected,
                          color: Colors.redAccent,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC8A96E) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFC8A96E) : Colors.white12,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _ActionIcon({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, color: color, size: 20),
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
