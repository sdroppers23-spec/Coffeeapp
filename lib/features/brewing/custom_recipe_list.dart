import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/modern_undo_timer.dart';
import 'widgets/custom_recipe_card.dart';
import '../discover/discovery_filter_provider.dart';
import '../discover/widgets/discovery_action_bar.dart';
import '../navigation/navigation_providers.dart';

// ─── Selection Provider ───────────────────────────────────────────────────────
class BrewingSelectionNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void updateState(Set<String> newState) {
    state = newState;
  }
}

final brewingSelectedIdsProvider =
    NotifierProvider<BrewingSelectionNotifier, Set<String>>(() {
      return BrewingSelectionNotifier();
    });

// ─── Provider ─────────────────────────────────────────────────────────────────
final customRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, methodKey) {
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
  ConsumerState<CustomRecipeListTab> createState() =>
      _CustomRecipeListTabState();
}

class _CustomRecipeListTabState extends ConsumerState<CustomRecipeListTab> {
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
          ref.read(navBarVisibleProvider.notifier).show();
        }
      } else {
        _selectedIds.add(id);
        if (!_isSelectionMode) {
          _isSelectionMode = true;
          ref.read(navBarVisibleProvider.notifier).hide();
        }
      }
    });
  }

  void _selectAll(List<CustomRecipeDto> recipes) {
    setState(() {
      if (_selectedIds.length == recipes.length) {
        _selectedIds.clear();
        _isSelectionMode = false;
        ref.read(navBarVisibleProvider.notifier).show();
      } else {
        _selectedIds.addAll(recipes.map((r) => r.id));
        _isSelectionMode = true;
        ref.read(navBarVisibleProvider.notifier).hide();
      }
    });
  }

  Future<void> _deleteSelected() async {
    final count = _selectedIds.length;
    final idsToDelete = List<String>.from(_selectedIds);

    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
    ref.read(navBarVisibleProvider.notifier).show();

    final String deleteKey = count == 1
        ? 'deleted_1'
        : (count >= 2 && count <= 4)
        ? 'deleted_2_4'
        : 'deleted_5_plus';

    ModernUndoTimer.show(
      context,
      message: ref.t(deleteKey, args: {'count': count.toString()}),
      onUndo: () {
        // Implement undo if needed, but for now we just show the message
      },
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
    final recipesAsync = ref.watch(
      customRecipesForMethodProvider(widget.methodKey),
    );

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
            child: Text(
              ref.t('no_recipes_found'),
              style: const TextStyle(color: Colors.white70),
            ),
          );
        }

        return Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
              itemCount: recipes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, i) => CustomRecipeCard(
                recipe: recipes[i],
                methodKey: widget.methodKey,
                ref: ref,
                isSelectionMode: _isSelectionMode,
                isSelected: _selectedIds.contains(recipes[i].id),
                onTap: () {
                  if (_isSelectionMode) {
                    _toggleSelection(recipes[i].id);
                  }
                },
                onLongPress: () {
                  if (!_isSelectionMode) {
                    setState(() {
                      _isSelectionMode = true;
                      _selectedIds.add(recipes[i].id);
                    });
                    ref.read(navBarVisibleProvider.notifier).hide();
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
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${_selectedIds.length} ${ref.t('selected')}',
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
                              () {
                                setState(() {
                                  _isSelectionMode = false;
                                  _selectedIds.clear();
                                });
                                ref.read(navBarVisibleProvider.notifier).show();
                              },
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

  Widget _buildSelectionAction(
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
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
  ConsumerState<GlobalCustomRecipeList> createState() =>
      _GlobalCustomRecipeListState();
}

class _GlobalCustomRecipeListState
    extends ConsumerState<GlobalCustomRecipeList> {
  bool _isSelectionMode = false;

  void _selectAll(List<CustomRecipeDto> recipes) {
    final current = ref.read(brewingSelectedIdsProvider);
    final allIds = recipes.map((r) => r.id).toSet();

    if (current.length == allIds.length) {
      ref.read(brewingSelectedIdsProvider.notifier).updateState({});
      setState(() => _isSelectionMode = false);
      ref.read(navBarVisibleProvider.notifier).show();
    } else {
      ref.read(brewingSelectedIdsProvider.notifier).updateState(allIds);
      setState(() => _isSelectionMode = true);
      ref.read(navBarVisibleProvider.notifier).hide();
    }
  }

  Future<void> _deleteSelectedBatch() async {
    final selectedIds = ref.read(brewingSelectedIdsProvider);
    final count = selectedIds.length;
    final idsToDelete = List<String>.from(selectedIds);

    setState(() {
      _isSelectionMode = false;
      ref.read(brewingSelectedIdsProvider.notifier).updateState({});
    });
    ref.read(navBarVisibleProvider.notifier).show();

    final String deleteKey = count == 1
        ? 'deleted_1'
        : (count >= 2 && count <= 4)
        ? 'deleted_2_4'
        : 'deleted_5_plus';

    ModernUndoTimer.show(
      context,
      message: ref.t(deleteKey, args: {'count': count.toString()}),
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
    final filterState = ref.watch(brewingFilterProvider);
    final selectedIds = ref.watch(brewingSelectedIdsProvider);

    return recipesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.white70)),
      ),
      data: (recipes) {
        // 1. Filter by Sub-Tab (All / Favorites / Archive)
        List<CustomRecipeDto> filtered = recipes.where((r) {
          if (filterState.showFavoritesOnly) return r.isFavorite;
          if (filterState.showArchivedOnly) return r.isArchived;
          return !r.isArchived; // "All" means everything not archived
        }).toList();

        // 2. Filter by Search
        if (filterState.search.isNotEmpty) {
          final query = filterState.search.toLowerCase();
          filtered = filtered.where((r) {
            return r.name.toLowerCase().contains(query) ||
                r.methodKey.toLowerCase().contains(query) ||
                (r.notes).toLowerCase().contains(query);
          }).toList();
        }

        // 3. Sort
        switch (filterState.sortType) {
          case SortType.alphabetAsc:
            filtered.sort((a, b) => a.name.compareTo(b.name));
            break;
          case SortType.alphabetDesc:
            filtered.sort((a, b) => b.name.compareTo(a.name));
            break;
          case SortType.dateDesc:
            filtered.sort(
              (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
                a.createdAt ?? DateTime.now(),
              ),
            );
            break;
          case SortType.dateAsc:
            filtered.sort(
              (a, b) => (a.createdAt ?? DateTime.now()).compareTo(
                b.createdAt ?? DateTime.now(),
              ),
            );
            break;
          default:
            // Default: Newest first
            filtered.sort(
              (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
                a.createdAt ?? DateTime.now(),
              ),
            );
        }

        if (filtered.isEmpty) {
          return Column(
            children: [
              const SizedBox(height: 140),
              DiscoveryActionBar(
                filterProvider: brewingFilterProvider,
                selectionProvider: brewingSelectedIdsProvider,
                onCompareTap: () {},
                showComparison: false,
                showViewModeToggle: false,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    ref.t('no_recipes_found'),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          );
        }

        bool isEspresso(String? method, String? type) {
          if (type == 'espresso') return true;
          final m = (method ?? '').toLowerCase();
          return m.contains('espresso') || m.contains('lever');
        }

        final espressoRecipes = filtered
            .where((r) => isEspresso(r.methodKey, r.recipeType))
            .toList();
        final filterRecipes = filtered
            .where((r) => !isEspresso(r.methodKey, r.recipeType))
            .toList();

        return Column(
          children: [
            // Spacer for BrewingMainScreen's PremiumAppBar + TabBar
            const SizedBox(height: 170),

            // Internal Header: Search + Action Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: TextField(
                        onChanged: (val) => ref
                            .read(brewingFilterProvider.notifier)
                            .updateSearch(val),
                        style: GoogleFonts.outfit(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: ref.t('search_recipes'),
                          hintStyle: GoogleFonts.outfit(color: Colors.white38),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFFC8A96E),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DiscoveryActionBar(
                    filterProvider: brewingFilterProvider,
                    selectionProvider: brewingSelectedIdsProvider,
                    showComparison: false,
                    showViewModeToggle: false,
                    onSelectAll: () => _selectAll(filtered),
                    onCompareTap: () {},
                  ),
                ],
              ),
            ),

            // Main List Content
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    children: [
                      if (espressoRecipes.isNotEmpty) ...[
                        _CategoryHeader(title: ref.t('espresso').toUpperCase()),
                        const SizedBox(height: 16),
                        ...espressoRecipes.map(
                          (r) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomRecipeCard(
                              recipe: r,
                              methodKey: r.methodKey,
                              ref: ref,
                              isSelectionMode: _isSelectionMode,
                              isSelected: selectedIds.contains(r.id),
                              onTap: () {
                                if (_isSelectionMode) {
                                  final next = Set<String>.from(selectedIds);
                                  if (next.contains(r.id)) {
                                    next.remove(r.id);
                                    if (next.isEmpty) {
                                      setState(() => _isSelectionMode = false);
                                      ref
                                          .read(navBarVisibleProvider.notifier)
                                          .show();
                                    }
                                  } else {
                                    next.add(r.id);
                                  }
                                  ref
                                      .read(brewingSelectedIdsProvider.notifier)
                                      .updateState(next);
                                }
                              },
                              onLongPress: () {
                                if (!_isSelectionMode) {
                                  setState(() => _isSelectionMode = true);
                                  ref
                                      .read(brewingSelectedIdsProvider.notifier)
                                      .updateState({r.id});
                                  ref
                                      .read(navBarVisibleProvider.notifier)
                                      .hide();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                      if (filterRecipes.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _CategoryHeader(title: ref.t('filter').toUpperCase()),
                        const SizedBox(height: 16),
                        ...filterRecipes.map(
                          (r) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomRecipeCard(
                              recipe: r,
                              methodKey: r.methodKey,
                              ref: ref,
                              isSelectionMode: _isSelectionMode,
                              isSelected: selectedIds.contains(r.id),
                              onTap: () {
                                if (_isSelectionMode) {
                                  final next = Set<String>.from(selectedIds);
                                  if (next.contains(r.id)) {
                                    next.remove(r.id);
                                    if (next.isEmpty) {
                                      setState(() => _isSelectionMode = false);
                                      ref
                                          .read(navBarVisibleProvider.notifier)
                                          .show();
                                    }
                                  } else {
                                    next.add(r.id);
                                  }
                                  ref
                                      .read(brewingSelectedIdsProvider.notifier)
                                      .updateState(next);
                                }
                              },
                              onLongPress: () {
                                if (!_isSelectionMode) {
                                  setState(() => _isSelectionMode = true);
                                  ref
                                      .read(brewingSelectedIdsProvider.notifier)
                                      .updateState({r.id});
                                  ref
                                      .read(navBarVisibleProvider.notifier)
                                      .hide();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  if (_isSelectionMode)
                    Positioned(
                      bottom: 30,
                      left: 20,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF121212),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${selectedIds.length} ${ref.t('selected')}',
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
                                      _selectAll(filtered);
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  _buildSelectionAction(
                                    Icons.delete_outline_rounded,
                                    const Color(0xFFEF5350),
                                    selectedIds.isEmpty
                                        ? null
                                        : _deleteSelectedBatch,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildSelectionAction(
                                    Icons.close_rounded,
                                    Colors.white70,
                                    () {
                                      setState(() {
                                        _isSelectionMode = false;
                                        ref
                                            .read(
                                              brewingSelectedIdsProvider
                                                  .notifier,
                                            )
                                            .updateState({});
                                      });
                                      ref
                                          .read(navBarVisibleProvider.notifier)
                                          .show();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectionAction(
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
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
