import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/providers/settings_provider.dart';
import '../../../../core/database/dtos.dart';
import '../../../../shared/widgets/modern_undo_timer.dart';
import '../../../../shared/widgets/scroll_to_top_button.dart';
import '../../discovery_filter_provider.dart';
import '../../../encyclopedia/encyclopedia_providers.dart';
import '../lots_providers.dart';
import 'lot_card_widgets.dart';
import '../../widgets/discovery_action_bar.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/services/toast_service.dart';
import '../../../../shared/widgets/sync_indicator.dart';

class MyLotsContent extends ConsumerStatefulWidget {
  const MyLotsContent({super.key});

  @override
  ConsumerState<MyLotsContent> createState() => _MyLotsContentState();
}

class _MyLotsContentState extends ConsumerState<MyLotsContent> {
  final Set<String> _pendingDeleteIds = {};
  bool _isUndoVisible = false;

  bool get _isSelectionMode => ref.watch(myLotsSelectedIdsProvider).isNotEmpty;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _confirmDeleteDialog(CoffeeLotDto lot) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFC8A96E),
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          context.t('delete_confirm_title'),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.t('delete_confirm_message'),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(ctx, false),
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white.withValues(alpha: 0.05),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    context.t('cancel').toUpperCase(),
                                    style: GoogleFonts.outfit(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(ctx, true),
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.redAccent, // Made opaque
                                    border: Border.all(
                                      color: Colors.redAccent.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    context.t('delete').toUpperCase(),
                                    style: GoogleFonts.outfit(
                                      color: Colors
                                          .white, // White text on red background
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  void _showModernUndo(
    List<CoffeeLotDto> lots,
    BuildContext context,
    WidgetRef ref, {
    bool isArchive = false,
  }) {
    if (lots.isEmpty) return;
    String message;

    final ids = lots.map((l) => l.id).toSet();
    setState(() {
      _pendingDeleteIds.addAll(ids);
      _isUndoVisible = true;
    });

    if (isArchive) {
      if (lots.length == 1) {
        message = context.t('toast_lot_archived');
      } else {
        message = context.t('toast_lots_archived');
      }
    } else {
      if (lots.length == 1) {
        message = context.t('toast_lot_deleted');
      } else {
        message = context.t('toast_lots_deleted');
      }
    }

    ModernUndoTimer.show(
      context,
      message: message,
      onUndo: () {
        if (mounted) {
          setState(() {
            _pendingDeleteIds.removeAll(ids);
            _isUndoVisible = false;
          });
        }
      },
      onDismiss: () async {
        if (!mounted) return;
        final db = ref.read(databaseProvider);

        // Physically delete/archive after timer
        for (final lot in lots) {
          if (isArchive) {
            await db.toggleLotArchive(lot.id, true);
          } else {
            await db.deleteUserLot(lot.id);
          }
        }

        if (mounted) {
          setState(() {
            _pendingDeleteIds.removeAll(ids);
            _isUndoVisible = false;
          });
          ref.invalidate(userLotsStreamProvider);
          unawaited(ref.read(syncStatusProvider.notifier).syncEverything());
        }
      },
    );
  }

  void _toggleLotSelection(String id) {
    ref.read(myLotsSelectedIdsProvider.notifier).toggle(id);
  }

  void _selectAll(List<CoffeeLotDto> visibleLots) {
    final currentSelected = ref.read(myLotsSelectedIdsProvider);
    final visibleIds = visibleLots.map((l) => l.id).toSet();

    // If all visible are already in global selection, remove them
    // (This is a simplified logic, matches encyclopedia behavior)
    if (visibleIds.every((id) => currentSelected.contains(id))) {
      for (final id in visibleIds) {
        ref.read(myLotsSelectedIdsProvider.notifier).remove(id);
      }
    } else {
      for (final id in visibleIds) {
        ref.read(myLotsSelectedIdsProvider.notifier).add(id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(myLotsFilterProvider);
    final lotsAsync = ref.watch(userLotsStreamProvider);

    return Stack(
      children: [
        Column(
          children: [
            lotsAsync.when(
              data: (userLots) {
                // Extract unique values for filter dialog
                final countries =
                    userLots
                        .map((l) => l.originCountry ?? '')
                        .where((c) => c.isNotEmpty)
                        .toSet()
                        .toList()
                      ..sort();

                final flavors =
                    userLots
                        .map((l) => l.flavorProfile ?? '')
                        .expand((f) => f.split(',').map((s) => s.trim()))
                        .where((f) => f.isNotEmpty)
                        .toSet()
                        .toList()
                      ..sort();

                final processes =
                    userLots
                        .map((l) => l.process ?? '')
                        .where((p) => p.isNotEmpty)
                        .toSet()
                        .toList()
                      ..sort();

                return DiscoveryActionBar(
                  filterProvider: myLotsFilterProvider,
                  selectionProvider: myLotsSelectedIdsProvider,
                  searchHint: context.t('search_lots'),
                  onCompareTap: () {
                    ref.read(settingsProvider.notifier).triggerHaptic();
                    context.push('/compare', extra: ComparisonSource.myLots);
                  },
                  onSelectAll: () => _selectAll(userLots),
                  availableCountries: countries,
                  availableFlavors: flavors,
                  availableProcesses: processes,
                  showFavoritesButton: false,
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
            Expanded(child: _buildListView(lotsAsync, filter)),
          ],
        ),

        // Floating Action Button OR Selection Bar
        Positioned(
          bottom: 90,
          left: 16,
          right: 16,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSelectionMode
                ? _buildSelectionBar(lotsAsync)
                : AnimatedScale(
                    scale: _isUndoVisible ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutBack,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: _buildFloatingAddButton(),
                    ),
                  ),
          ),
        ),
        ScrollToTopButton(scrollController: _scrollController, threshold: 1000),
      ],
    );
  }

  Widget _buildListView(
    AsyncValue<List<CoffeeLotDto>> lotsAsync,
    DiscoveryFilterState filter,
  ) {
    return lotsAsync.when(
      data: (userLots) {
        final filteredByTab = userLots.where((lot) {
          if (_pendingDeleteIds.contains(lot.id)) return false;

          if (filter.showFavoritesOnly) {
            return lot.isFavorite && !lot.isArchived;
          }
          if (filter.showArchivedOnly) {
            return lot.isArchived;
          }
          // Default: hide archived
          return !lot.isArchived;
        }).toList();

        final filteredLots = _applyFilters(filteredByTab, filter);

        if (filteredLots.isEmpty) {
          return const Center(
            child: Text(
              'Поки порожньо',
              style: TextStyle(color: Colors.white24),
            ),
          );
        }

        if (filter.isGrid) {
          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: filteredLots.length,
            itemBuilder: (context, index) {
              final lot = filteredLots[index];
              final isSelected = ref
                  .watch(myLotsSelectedIdsProvider)
                  .contains(lot.id);
              return MyLotGridCard(
                lot: lot,
                isSelected: isSelected,
                isSelectionMode: _isSelectionMode,
                onLongPress: (id) => _toggleLotSelection(id),
                onTap: (id) {
                  if (_isSelectionMode) {
                    _toggleLotSelection(id);
                  } else {
                    context.push('/lot_details', extra: {'lot': lot});
                  }
                },
                onFavoriteToggle: (lot) async {
                  ref.read(settingsProvider.notifier).triggerHaptic();
                  final db = ref.read(databaseProvider);
                  final newState = !lot.isFavorite;
                  await db.toggleLotFavorite(lot.id, newState);

                  if (context.mounted) {
                    final msg = newState
                        ? context.t('toast_added_to_favorites')
                        : context.t('toast_removed_from_favorites');
                    ToastService.showSuccess(context, msg);
                  }

                  ref.invalidate(userLotsStreamProvider);
                  unawaited(
                    ref.read(syncStatusProvider.notifier).syncEverything(),
                  );
                },
              );
            },
          );
        }
        return ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            final lot = filteredLots[index];
            final isSelected = ref
                .watch(myLotsSelectedIdsProvider)
                .contains(lot.id);
            return MyLotListCard(
              lot: lot,
              isSelected: isSelected,
              isSelectionMode: _isSelectionMode,
              onExpansionChanged: (isExpanded) {
                setState(() {});
              },
              onLongPress: (id) => _toggleLotSelection(id),
              onTap: (id) {
                if (_isSelectionMode) {
                  _toggleLotSelection(id);
                } else {
                  context.push('/lot_details', extra: {'lot': lot});
                }
              },
              onFavoriteToggle: (lot) async {
                ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                final db = ref.read(databaseProvider);
                final newState = !lot.isFavorite;
                await db.toggleLotFavorite(lot.id, newState);

                if (context.mounted) {
                  final msg = newState
                      ? context.t('toast_added_to_favorites')
                      : context.t('toast_removed_from_favorites');
                  ToastService.showSuccess(context, msg);
                }

                ref.invalidate(userLotsStreamProvider);
                unawaited(
                  ref.read(syncStatusProvider.notifier).syncEverything(),
                );
              },
              onEditSwipe: filter.showArchivedOnly
                  ? null
                  : (lot) {
                      context.push('/edit_lot', extra: lot);
                    },
              onRestoreSwipe: filter.showArchivedOnly
                  ? (lot) async {
                      final db = ref.read(databaseProvider);
                      await db.toggleLotArchive(lot.id, false);
                      ref.invalidate(userLotsStreamProvider);
                      unawaited(
                        ref.read(syncStatusProvider.notifier).syncEverything(),
                      );

                      if (!context.mounted) return;
                      ToastService.showSuccess(
                        context,
                        context.t('toast_lot_restored'),
                      );
                    }
                  : null,
              onDeleteSwipe: (lot) async {
                final confirm = await _confirmDeleteDialog(lot);
                if (confirm) {
                  if (context.mounted) {
                    _showModernUndo([lot], context, ref, isArchive: false);
                  }
                  return true;
                }
                return false;
              },
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  List<CoffeeLotDto> _applyFilters(
    List<CoffeeLotDto> lots,
    DiscoveryFilterState filter,
  ) {
    var result = lots.toList();

    // 1. Search
    if (filter.search.isNotEmpty) {
      final q = filter.search.toLowerCase();
      result = result
          .where(
            (l) =>
                (l.coffeeName?.toLowerCase().contains(q) ?? false) ||
                (l.roasteryName?.toLowerCase().contains(q) ?? false) ||
                (l.originCountry?.toLowerCase().contains(q) ?? false) ||
                (l.region?.toLowerCase().contains(q) ?? false),
          )
          .toList();
    }

    // 2. Countries
    if (filter.selectedCountries.isNotEmpty) {
      result = result
          .where((l) => filter.selectedCountries.contains(l.originCountry))
          .toList();
    }

    // 3. Flavor Notes
    if (filter.selectedFlavorNotes.isNotEmpty) {
      result = result.where((l) {
        final notes = (l.flavorProfile ?? '')
            .split(',')
            .map((s) => s.trim())
            .toSet();
        return filter.selectedFlavorNotes.any((f) => notes.contains(f));
      }).toList();
    }

    // 4. Process Methods
    if (filter.selectedProcesses.isNotEmpty) {
      result = result
          .where((l) => filter.selectedProcesses.contains(l.process))
          .toList();
    }

    // 5. Sorting
    switch (filter.sortType) {
      case SortType.alphabetAsc:
        result.sort(
          (a, b) => (a.coffeeName ?? '').compareTo(b.coffeeName ?? ''),
        );
        break;
      case SortType.alphabetDesc:
        result.sort(
          (a, b) => (b.coffeeName ?? '').compareTo(a.coffeeName ?? ''),
        );
        break;
      case SortType.dateAsc:
        result.sort(
          (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
            b.createdAt ?? DateTime(0),
          ),
        );
        break;
      case SortType.dateDesc:
        result.sort(
          (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
            a.createdAt ?? DateTime(0),
          ),
        );
        break;
      default:
        // Default to newest first
        result.sort(
          (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
            a.createdAt ?? DateTime(0),
          ),
        );
    }

    return result;
  }

  // --- FLOATING ACTIONS --- //

  Widget _buildFloatingAddButton() {
    return GestureDetector(
      onTap: () => context.push('/add_lot'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFC8A96E),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC8A96E).withValues(alpha: 0.35),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_rounded, color: Colors.black87, size: 20),
            const SizedBox(width: 8),
            Text(
              context.t('add_new_lot').toUpperCase(),
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionBar(AsyncValue<List<CoffeeLotDto>> lotsAsync) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
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
                    _selectionCountText,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                _buildSelectionAction(
                  Icons.favorite_rounded,
                  Colors.redAccent,
                  () async {
                    final db = ref.read(databaseProvider);
                    final idsToClear = Set<String>.from(
                      ref.read(myLotsSelectedIdsProvider),
                    );
                    for (var id in idsToClear) {
                      await db.toggleLotFavorite(id, true);
                      ref.read(myLotsSelectedIdsProvider.notifier).remove(id);
                    }
                    ref.invalidate(userLotsStreamProvider);
                    unawaited(
                      ref.read(syncStatusProvider.notifier).syncEverything(),
                    );
                  },
                ),
                const SizedBox(width: 16),
                _buildSelectionAction(
                  ref.read(myLotsFilterProvider).showArchivedOnly
                      ? Icons.unarchive_outlined
                      : Icons.archive_outlined,
                  Colors.white,
                  () async {
                    final db = ref.read(databaseProvider);
                    final isArchive = ref
                        .read(myLotsFilterProvider)
                        .showArchivedOnly;
                    final idsToClear = Set<String>.from(
                      ref.read(myLotsSelectedIdsProvider),
                    );
                    for (var id in idsToClear) {
                      await db.toggleLotArchive(id, !isArchive);
                      ref.read(myLotsSelectedIdsProvider.notifier).remove(id);
                    }

                    if (mounted) {
                      ToastService.showSuccess(
                        context,
                        context.t('toast_changes_saved'),
                      );
                    }
                    setState(() {});
                    ref.invalidate(userLotsStreamProvider);
                    unawaited(
                      ref.read(syncStatusProvider.notifier).syncEverything(),
                    );
                  },
                ),
                const SizedBox(width: 16),
                _buildSelectionAction(
                  Icons.delete_outline_rounded,
                  Colors.orangeAccent,
                  () async {
                    final confirm = await showGeneralDialog<bool>(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: '',
                      barrierColor: Colors.black54,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (ctx, anim1, anim2) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    24,
                                    32,
                                    24,
                                    24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFFC8A96E,
                                            ).withValues(alpha: 0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: Color(0xFFC8A96E),
                                            size: 32,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          context.t(
                                            'delete_confirm_batch_title',
                                          ),
                                          style: GoogleFonts.outfit(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          context.t(
                                            'delete_confirm_batch_message',
                                            args: {
                                              'count': ref
                                                  .read(
                                                    myLotsSelectedIdsProvider,
                                                  )
                                                  .length
                                                  .toString(),
                                            },
                                          ),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.outfit(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(ctx, false),
                                                child: Container(
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          14,
                                                        ),
                                                    color: Colors.white
                                                        .withValues(
                                                          alpha: 0.05,
                                                        ),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.1,
                                                          ),
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    context
                                                        .t('cancel')
                                                        .toUpperCase(),
                                                    style: GoogleFonts.outfit(
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(ctx, true),
                                                child: Container(
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          14,
                                                        ),
                                                    color: Colors.redAccent,
                                                    border: Border.all(
                                                      color: Colors.redAccent
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    context
                                                        .t('delete')
                                                        .toUpperCase(),
                                                    style: GoogleFonts.outfit(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    if (confirm == true) {
                      final selectedIdsSnapshot = Set<String>.from(
                        ref.read(myLotsSelectedIdsProvider),
                      );
                      final selectedLots = (lotsAsync.value ?? [])
                          .where((l) => selectedIdsSnapshot.contains(l.id))
                          .toList();
                      final isArchive = ref
                          .read(myLotsFilterProvider)
                          .showArchivedOnly;

                      for (final id in selectedIdsSnapshot) {
                        ref.read(myLotsSelectedIdsProvider.notifier).remove(id);
                      }

                      if (mounted) {
                        _showModernUndo(
                          selectedLots,
                          context,
                          ref,
                          isArchive: isArchive,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionAction(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }

  String get _selectionCountText {
    final count = ref.watch(myLotsSelectedIdsProvider).length;
    // Simple declension for "Обрано X лотів/лоти/лот"
    if (count % 10 == 1 && count % 100 != 11) {
      return 'Обрано $count лот';
    } else if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return 'Обрано $count лоти';
    } else {
      return 'Обрано $count лотів';
    }
  }
}

class _CountdownProgress extends StatefulWidget {
  final Duration duration;
  const _CountdownProgress({required this.duration});

  @override
  State<_CountdownProgress> createState() => _CountdownProgressState();
}

class _CountdownProgressState extends State<_CountdownProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.reverse(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: _controller.value,
          strokeWidth: 2,
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC8A96E)),
          backgroundColor: Colors.white.withValues(alpha: 0.1),
        );
      },
    );
  }
}
