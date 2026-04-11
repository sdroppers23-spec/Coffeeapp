import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/settings_provider.dart';
import '../../../../core/database/dtos.dart';
import '../../discovery_filter_provider.dart';
import '../lots_providers.dart';
import 'lot_card_widgets.dart';
import '../../widgets/discovery_action_bar.dart';

class MyLotsContent extends ConsumerStatefulWidget {
  const MyLotsContent({super.key});

  @override
  ConsumerState<MyLotsContent> createState() => _MyLotsContentState();
}

class _MyLotsContentState extends ConsumerState<MyLotsContent> with SingleTickerProviderStateMixin {
  late TabController _subTabController;
  final Set<String> _selectedLotIds = {};
  final Set<String> _pendingDeleteIds = {};
  
  bool get _isSelectionMode => _selectedLotIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _subTabController.dispose();
    super.dispose();
  }

  Future<bool> _confirmDeleteDialog(CoffeeLotDto lot) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) {
        return Dialog(
          backgroundColor: const Color(0xFF1D1812),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A1F14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFD4A843),
                    size: 36,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Видалити лот?',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Ви впевнені, що хочете видалити ${lot.coffeeName ?? 'цей лот'}?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.white60,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(ctx, false),
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white24),
                            color: Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'СКАСУВАТИ',
                            style: GoogleFonts.outfit(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 1.0,
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
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xFFD32F2F),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'ВИДАЛИТИ',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 1.0,
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
        );
      }
    );
    return result ?? false;
  }

  void _stageDelete(CoffeeLotDto lot) {
    setState(() => _pendingDeleteIds.add(lot.id));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1D1B1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        content: Row(
          children: [
            const SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Лот видалено. Скасувати?', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'СКАСУВАТИ',
          textColor: const Color(0xFFC8A96E),
          onPressed: () {
            setState(() => _pendingDeleteIds.remove(lot.id));
          },
        ),
        duration: const Duration(seconds: 15),
      ),
    ).closed.then((reason) async {
      if (reason != SnackBarClosedReason.action && mounted) {
        if (_pendingDeleteIds.contains(lot.id)) {
          final db = ref.read(databaseProvider);
          await db.deleteUserLot(lot.id);
          if (mounted) setState(() => _pendingDeleteIds.remove(lot.id));
          ref.invalidate(userLotsProvider);
        }
      }
    });
  }

  void _toggleLotSelection(String id) {
    setState(() {
      if (_selectedLotIds.contains(id)) {
        _selectedLotIds.remove(id);
      } else {
        _selectedLotIds.add(id);
      }
    });
  }

  void _selectAll(List<CoffeeLotDto> visibleLots) {
    setState(() {
      if (_selectedLotIds.length == visibleLots.length) {
        _selectedLotIds.clear();
      } else {
        _selectedLotIds.addAll(visibleLots.map((l) => l.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(myLotsFilterProvider);
    final lotsAsync = ref.watch(userLotsProvider);

    return Stack(
      children: [
        Column(
          children: [
            DiscoveryActionBar(
              filterProvider: myLotsFilterProvider,
              onCompareTap: () => context.push('/comparison'),
              availableCountries: const [],
              availableFlavors: const [],
              availableProcesses: const [],
              showFavoritesButton: false,
            ),
            lotsAsync.when(
              data: (userLots) {
                final filteredByTab = userLots.where((lot) {
                  if (_pendingDeleteIds.contains(lot.id)) return false;
                  final isArchived = lot.isArchived;
                  if (_subTabController.index == 0) return !isArchived;
                  if (_subTabController.index == 1) return lot.isFavorite && !isArchived;
                  if (_subTabController.index == 2) return isArchived;
                  return !isArchived;
                }).toList();
                final visibleLots = _applyFilters(filteredByTab, filter);
                return _buildSubTabs(visibleLots);
              },
              loading: () => _buildSubTabs([]),
              error: (_, _) => _buildSubTabs([]),
            ),
            Expanded(
              child: _buildListView(lotsAsync, filter),
            ),
          ],
        ),

        // Floating Action Button OR Selection Bar
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSelectionMode
                ? _buildSelectionBar()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: _buildFloatingAddButton(),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubTabs(List<CoffeeLotDto> visibleLots) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (_isSelectionMode) ...[
            GestureDetector(
              onTap: () => _selectAll(visibleLots),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _selectedLotIds.length == visibleLots.length
                      ? Icons.deselect_rounded
                      : Icons.select_all_rounded,
                  color: const Color(0xFFC8A96E),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: TabBar(
                controller: _subTabController,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: const Color(0xFFC8A96E),
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white54,
                labelStyle: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold),
                tabs: [
                  const Tab(text: 'Усі'),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite_rounded, size: 14),
                        SizedBox(width: 4),
                        Text('Улюблені'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.archive_outlined, size: 14),
                        SizedBox(width: 4),
                        Text('Архів'),
                      ],
                    ),
                  ),
                ],
                onTap: (_) => setState(() {}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(AsyncValue<List<CoffeeLotDto>> lotsAsync, DiscoveryFilterState filter) {
    return lotsAsync.when(
      data: (userLots) {
        final activeTab = _subTabController.index;
        final filteredByTab = userLots.where((lot) {
          if (_pendingDeleteIds.contains(lot.id)) return false;
          final isArchived = lot.isArchived;
          if (activeTab == 0) return !isArchived; // All
          if (activeTab == 1) return lot.isFavorite && !isArchived; // Favorites
          if (activeTab == 2) return isArchived; // Archive
          return !isArchived;
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
            padding: const EdgeInsets.all(16).copyWith(bottom: 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemCount: filteredLots.length,
            itemBuilder: (context, index) {
              final lot = filteredLots[index];
              return MyLotGridCard(
                lot: lot,
                isSelected: _selectedLotIds.contains(lot.id),
                isSelectionMode: _isSelectionMode,
                onLongPress: (id) => _toggleLotSelection(id),
                onTap: (id) => context.push('/edit_lot', extra: lot),
                onFavoriteToggle: (lot) async {
                  ref.read(settingsProvider.notifier).triggerHaptic();
                  final db = ref.read(databaseProvider);
                  await db.upsertUserLot(CoffeeLotsCompanion(
                    id: Value(lot.id),
                    isFavorite: Value(!lot.isFavorite),
                  ));
                  ref.invalidate(userLotsProvider);
                },
              );
            },
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(bottom: 100),
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            final lot = filteredLots[index];
            return MyLotListCard(
              lot: lot,
              isSelected: _selectedLotIds.contains(lot.id),
              isSelectionMode: _isSelectionMode,
              onLongPress: (id) => _toggleLotSelection(id),
              onTap: (id) => context.push('/edit_lot', extra: lot),
              onFavoriteToggle: (lot) async {
                ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                final db = ref.read(databaseProvider);
                await db.upsertUserLot(CoffeeLotsCompanion(
                  id: Value(lot.id),
                  isFavorite: Value(!lot.isFavorite),
                ));
                ref.invalidate(userLotsProvider);
              },
              onEditSwipe: (lot) {
                context.push('/edit_lot', extra: lot);
              },
              onDeleteSwipe: (lot) async {
                final confirm = await _confirmDeleteDialog(lot);
                if (confirm) {
                  _stageDelete(lot);
                  return true;
                }
                return false;
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  List<CoffeeLotDto> _applyFilters(List<CoffeeLotDto> lots, DiscoveryFilterState filter) {
    var result = lots.toList();
    if (filter.search.isNotEmpty) {
      final q = filter.search.toLowerCase();
      result = result.where((l) => (l.coffeeName?.toLowerCase().contains(q) ?? false) || (l.roasteryName?.toLowerCase().contains(q) ?? false)).toList();
    }
    // Add other filters as needed...
    return result;
  }

  // --- FLOATING ACTIONS --- //

  Widget _buildFloatingAddButton() {
    return GestureDetector(
      onTap: () => context.push('/add_lot'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFB8955A),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC8A96E).withValues(alpha: 0.35),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_rounded, color: Colors.black87, size: 20),
            const SizedBox(width: 8),
            Text(
              'ДОДАТИ НОВИЙ ЛОТ',
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

  Widget _buildSelectionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B1A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _selectionCountText,
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          _buildSelectionAction(
            Icons.favorite_rounded,
            Colors.redAccent,
            () async {
              final db = ref.read(databaseProvider);
              for (var id in _selectedLotIds) {
                await db.upsertUserLot(CoffeeLotsCompanion(id: Value(id), isFavorite: const Value(true)));
              }
              setState(() => _selectedLotIds.clear());
              ref.invalidate(userLotsProvider);
            },
          ),
          const SizedBox(width: 16),
          _buildSelectionAction(
            Icons.archive_outlined,
            Colors.white,
            () async {
              final db = ref.read(databaseProvider);
              for (var id in _selectedLotIds) {
                await db.upsertUserLot(CoffeeLotsCompanion(id: Value(id), isArchived: const Value(true)));
              }
              setState(() => _selectedLotIds.clear());
              ref.invalidate(userLotsProvider);
            },
          ),
          const SizedBox(width: 16),
          _buildSelectionAction(
            Icons.delete_outline_rounded,
            Colors.redAccent,
            () async {
              // Delete multiple items (can implement similar staging or direct delete)
              final db = ref.read(databaseProvider);
              for (var id in _selectedLotIds) {
                await db.deleteUserLot(id);
              }
              setState(() => _selectedLotIds.clear());
              ref.invalidate(userLotsProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionAction(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  String get _selectionCountText {
    final count = _selectedLotIds.length;
    // Simple declension for "Обрано X лотів/лоти/лот"
    if (count % 10 == 1 && count % 100 != 11) {
      return 'Обрано $count лот';
    } else if ([2, 3, 4].contains(count % 10) && ![12, 13, 14].contains(count % 100)) {
      return 'Обрано $count лоти';
    } else {
      return 'Обрано $count лотів';
    }
  }
}
