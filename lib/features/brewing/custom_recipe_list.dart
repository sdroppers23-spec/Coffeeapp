import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/modern_undo_timer.dart';
import 'widgets/custom_recipe_card.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final customRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((
      ref,
      methodKey,
    ) {
      final db = ref.watch(databaseProvider);
      return db.watchCustomRecipesForMethod(methodKey);
    });

final globalCustomRecipesProvider = StreamProvider<List<CustomRecipeDto>>((
  ref,
) {
  final db = ref.watch(databaseProvider);
  return db.watchAllCustomRecipes();
});

// ─── Tab widget (embedded inside BrewingDetailScreen Tab 2) ───────────────────
class CustomRecipeListTab extends ConsumerStatefulWidget {
  final String methodKey;
  final bool showFab;
  const CustomRecipeListTab({
    super.key,
    required this.methodKey,
    this.showFab = true,
  });

  @override
  ConsumerState<CustomRecipeListTab> createState() => _CustomRecipeListTabState();
}

class _CustomRecipeListTabState extends ConsumerState<CustomRecipeListTab> {
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll(List<CustomRecipeDto> recipes) {
    setState(() {
      if (_selectedIds.length == recipes.length) {
        _selectedIds.clear();
      } else {
        _selectedIds.addAll(recipes.map((r) => r.id));
      }
    });
  }

  Future<void> _deleteSelected() async {
    final isUk = LocaleService.currentLocale == 'uk';
    final idsToDelete = List<String>.from(_selectedIds);
    final count = idsToDelete.length;

    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });

    ModernUndoTimer.show(
      context,
      message: isUk ? 'Видалено $count рецептів' : 'Deleted $count recipes',
      onUndo: () {},
      onDismiss: () async {
        final db = ref.read(databaseProvider);
        for (final id in idsToDelete) {
          await db.deleteCustomRecipe(id);
        }
        ref.invalidate(customRecipesForMethodProvider(widget.methodKey));
        ref.invalidate(globalCustomRecipesProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUk = LocaleService.currentLocale == 'uk';
    final recipesAsync = ref.watch(customRecipesForMethodProvider(widget.methodKey));

    return recipesAsync.when(
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
            child: isUk 
              ? const Text('Рецепти не знайдено', style: TextStyle(color: Colors.white70)) 
              : const Text('No recipes found', style: TextStyle(color: Colors.white70)),
          );
        }

        return Stack(
          children: [
            ListView.separated(
              padding: EdgeInsets.fromLTRB(16, _isSelectionMode ? 100 : 16, 16, 120),
              itemCount: recipes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, i) => CustomRecipeCard(
                recipe: recipes[i],
                methodKey: widget.methodKey,
                ref: ref,
                isSelectionMode: _isSelectionMode,
                isSelected: _selectedIds.contains(recipes[i].id),
                onTap: () => _toggleSelection(recipes[i].id),
                onLongPress: () {
                  if (!_isSelectionMode) {
                    setState(() {
                      _isSelectionMode = true;
                      _selectedIds.add(recipes[i].id);
                    });
                  }
                },
              ),
            ),
            if (_isSelectionMode)
              Positioned(
                bottom: 90,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1B1A),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${_selectedIds.length} ${isUk ? 'вибрано' : 'selected'}',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            _buildSelectionAction(
                              Icons.select_all_rounded,
                              Colors.white,
                              () => _selectAll(recipes),
                            ),
                            const SizedBox(width: 12),
                            _buildSelectionAction(
                              Icons.delete_outline_rounded,
                              const Color(0xFFEF5350),
                              _selectedIds.isEmpty ? null : _deleteSelected,
                            ),
                            const SizedBox(width: 8),
                            _buildSelectionAction(
                              Icons.close_rounded,
                              Colors.white70,
                              () => setState(() {
                                _isSelectionMode = false;
                                _selectedIds.clear();
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSelectionAction(IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: color, size: 26),
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
  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll(List<CustomRecipeDto> recipes) {
    setState(() {
      if (_selectedIds.length == recipes.length) {
        _selectedIds.clear();
      } else {
        _selectedIds.addAll(recipes.map((r) => r.id));
      }
    });
  }

  Future<void> _deleteSelectedBatch() async {
    final isUk = LocaleService.currentLocale == 'uk';
    final idsToDelete = List<String>.from(_selectedIds);
    final count = idsToDelete.length;

    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });

    ModernUndoTimer.show(
      context,
      message: isUk ? 'Видалено $count рецептів' : 'Deleted $count recipes',
      onUndo: () {},
      onDismiss: () async {
        final db = ref.read(databaseProvider);
        for (final id in idsToDelete) {
          await db.deleteCustomRecipe(id);
        }
        ref.invalidate(globalCustomRecipesProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(globalCustomRecipesProvider);
    final isUk = LocaleService.currentLocale == 'uk';

    return recipesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.white70)),
      ),
      data: (recipes) {
        if (recipes.isEmpty) {
          return Center(
            child: isUk 
              ? const Text('Рецепти не знайдено', style: TextStyle(color: Colors.white70)) 
              : const Text('No recipes found', style: TextStyle(color: Colors.white70)),
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
            sortedRecipes.sort((a, b) => a.methodKey.compareTo(b.methodKey));
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
              padding: const EdgeInsets.fromLTRB(16, 200, 16, 120),
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
                      onLongPress: () {
                        if (!_isSelectionMode) {
                          setState(() {
                            _isSelectionMode = true;
                            _selectedIds.add(r.id);
                          });
                        }
                      },
                    ),
                  )),
                ],
                if (filterRecipes.isNotEmpty) ...[
                  const SizedBox(height: 16),
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
                      onLongPress: () {
                        if (!_isSelectionMode) {
                          setState(() {
                            _isSelectionMode = true;
                            _selectedIds.add(r.id);
                          });
                        }
                      },
                    ),
                  )),
                ],
              ],
            ),

            // Sticky Header with Filters and Sort
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 160, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF0A0908),
                      const Color(0xFF0A0908).withValues(alpha: 0.95),
                      const Color(0xFF0A0908).withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
                child: Row(
                  children: [
                    _ActionButton(
                      icon: Icons.filter_list_rounded,
                      label: ref.t('filters'),
                      isActive: false, // Placeholder for now
                      onTap: () {
                        // Show sort sheet or filter logic
                      },
                    ),
                    const SizedBox(width: 12),
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
                  ],
                ),
              ),
            ),

            if (_isSelectionMode)
              Positioned(
                bottom: 90,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1B1A),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${_selectedIds.length} ${isUk ? 'вибрано' : 'selected'}',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            _buildSelectionAction(
                              Icons.select_all_rounded,
                              Colors.white,
                              () {
                                final recipes = recipesAsync.value ?? [];
                                _selectAll(recipes);
                              },
                            ),
                            const SizedBox(width: 12),
                            _buildSelectionAction(
                              Icons.delete_outline_rounded,
                              const Color(0xFFEF5350),
                              _selectedIds.isEmpty ? null : _deleteSelectedBatch,
                            ),
                            const SizedBox(width: 8),
                            _buildSelectionAction(
                              Icons.close_rounded,
                              Colors.white70,
                              () => setState(() {
                                _isSelectionMode = false;
                                _selectedIds.clear();
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSelectionAction(IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: color, size: 26),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFC8A96E)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.black : const Color(0xFFC8A96E),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.black : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


