import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/modern_undo_timer.dart';
import 'dart:ui';
import 'widgets/custom_recipe_card.dart';
import '../../shared/widgets/glass_container.dart';

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
                top: 0,
                left: 0,
                right: 0,
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: 16,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white),
                        onPressed: () => setState(() {
                          _isSelectionMode = false;
                          _selectedIds.clear();
                        }),
                      ),
                      Text(
                        '${_selectedIds.length} ${isUk ? 'вибрано' : 'selected'}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.select_all_rounded, color: Colors.white),
                        tooltip: ref.t('select_all'),
                        onPressed: () => _selectAll(recipes),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF5350)),
                        onPressed: _selectedIds.isEmpty ? null : _deleteSelected,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
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
              padding: const EdgeInsets.fromLTRB(16, 140, 16, 120),
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

            // Sticky Header for Sorting
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
                      const Color(0xFF0F0E0D).withValues(alpha: 0.95),
                      const Color(0xFF0F0E0D).withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.7, 1.0],
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
                  ],
                ),
              ),
            ),

            // Bottom Selection Bar
            if (_isSelectionMode)
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1B1A).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          _ActionButton(
                            icon: Icons.close_rounded,
                            onTap: () => setState(() {
                              _isSelectionMode = false;
                              _selectedIds.clear();
                            }),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${_selectedIds.length} ${isUk ? 'вибрано' : 'selected'}',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          _ActionButton(
                            icon: Icons.select_all_rounded,
                            onTap: () {
                              final recipes = recipesAsync.value ?? [];
                              _selectAll(recipes);
                            },
                          ),
                          const SizedBox(width: 8),
                          _ActionButton(
                            icon: Icons.delete_outline_rounded,
                            color: const Color(0xFFEF5350),
                            onTap: _selectedIds.isEmpty ? null : _deleteSelectedBatch,
                          ),
                        ],
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
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
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
