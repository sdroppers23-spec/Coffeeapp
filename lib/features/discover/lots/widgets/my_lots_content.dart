import 'dart:ui';
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
  bool _isUndoVisible = false;
  final Set<String> _selectedLotIds = {};
  final Set<String> _pendingDeleteIds = {};
  
  bool get _isSelectionMode => _selectedLotIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 3, vsync: this);
    _subTabController.addListener(() {
      if (_subTabController.indexIsChanging) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subTabController.dispose();
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
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                            color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
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
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'СКАСУВАТИ',
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
                                    color: Colors.redAccent.withValues(alpha: 0.2),
                                    border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ВИДАЛИТИ',
                                    style: GoogleFonts.outfit(
                                      color: Colors.redAccent,
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

  void _showPremiumUndo(CoffeeLotDto lot, BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).clearSnackBars();
    
    if (mounted) setState(() => _isUndoVisible = true);

    final controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        duration: const Duration(seconds: 4),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: _CountdownProgress(duration: const Duration(seconds: 4)),
                        ),
                        const Icon(
                          Icons.timer_outlined,
                          color: Color(0xFFC8A96E),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Лот видалено',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                      final db = ref.read(databaseProvider);
                      // Re-insert the lot into database to "undo" deletion
                      await db.upsertUserLot(CoffeeLotsCompanion(
                        id: Value(lot.id),
                        userId: Value(lot.userId ?? ''),
                        roasteryName: Value(lot.roasteryName),
                        roasteryCountry: Value(lot.roasteryCountry),
                        coffeeName: Value(lot.coffeeName),
                        originCountry: Value(lot.originCountry),
                        region: Value(lot.region),
                        altitude: Value(lot.altitude),
                        process: Value(lot.process),
                        roastLevel: Value(lot.roastLevel),
                        roastDate: Value(lot.roastDate),
                        openedAt: Value(lot.openedAt),
                        weight: Value(lot.weight),
                        lotNumber: Value(lot.lotNumber),
                        isDecaf: Value(lot.isDecaf),
                        farm: Value(lot.farm),
                        washStation: Value(lot.washStation),
                        farmer: Value(lot.farmer),
                        varieties: Value(lot.varieties),
                        flavorProfile: Value(lot.flavorProfile),
                        scaScore: Value(lot.scaScore),
                        isFavorite: Value(lot.isFavorite),
                        isArchived: Value(lot.isArchived),
                        isOpen: Value(lot.isOpen),
                        isGround: Value(lot.isGround),
                        sensoryJson: Value(lot.sensoryJson),
                        priceJson: Value(lot.priceJson),
                        createdAt: Value(lot.createdAt),
                        updatedAt: Value(DateTime.now()),
                      ));
                      ref.invalidate(userLotsProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                    },
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'СКАСУВАТИ',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFC8A96E),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    controller.closed.then((reason) {
      if (mounted) {
        setState(() => _isUndoVisible = false);
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
            padding: const EdgeInsets.fromLTRB(21, 16, 21, 100),
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
          padding: const EdgeInsets.fromLTRB(26, 16, 26, 100),
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
                  final db = ref.read(databaseProvider);
                  await db.deleteUserLot(lot.id);
                  ref.invalidate(userLotsProvider);
                  if (context.mounted) {
                    _showPremiumUndo(lot, context, ref);
                  }
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

  Widget _buildSelectionBar(AsyncValue<List<CoffeeLotDto>> lotsAsync) {
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
              final toDelete = _selectedLotIds.toList();
              final lotsReady = lotsAsync.asData?.value ?? [];
              final firstLot = lotsReady.firstWhere((l) => l.id == toDelete.first, orElse: () => throw 'Lot not found');
              
              final confirmed = await _confirmDeleteDialog(firstLot);
              if (confirmed && mounted) {
                final db = ref.read(databaseProvider);
                for (var id in toDelete) {
                  final lot = lotsReady.firstWhere((l) => l.id == id, orElse: () => throw 'Lot not found');
                  await db.deleteUserLot(id);
                  if (id == toDelete.last && mounted) {
                    _showPremiumUndo(lot, context, ref);
                  }
                }
                ref.invalidate(userLotsProvider);
                setState(() => _selectedLotIds.clear());
              }
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

class _CountdownProgress extends StatefulWidget {
  final Duration duration;
  const _CountdownProgress({required this.duration});

  @override
  State<_CountdownProgress> createState() => _CountdownProgressState();
}

class _CountdownProgressState extends State<_CountdownProgress> with SingleTickerProviderStateMixin {
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
