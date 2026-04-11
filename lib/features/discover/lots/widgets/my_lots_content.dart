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

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(myLotsFilterProvider);
    final lotsAsync = ref.watch(userLotsProvider);

    return Column(
      children: [
        DiscoveryActionBar(
          filterProvider: myLotsFilterProvider,
          onCompareTap: () => context.push('/comparison'),
          availableCountries: const [],
          availableFlavors: const [],
          availableProcesses: const [],
          showFavoritesButton: false,
        ),
        _buildSubTabs(),
        Expanded(
          child: _buildListView(lotsAsync, filter),
        ),
      ],
    );
  }

  Widget _buildSubTabs() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
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
        unselectedLabelColor: Colors.white70,
        labelStyle: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'Усі'),
          Tab(text: 'Улюблені'),
          Tab(text: 'Архів'),
        ],
        onTap: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildListView(AsyncValue<List<CoffeeLotDto>> lotsAsync, DiscoveryFilterState filter) {
    return lotsAsync.when(
      data: (userLots) {
        final activeTab = _subTabController.index;
        final filteredByTab = userLots.where((lot) {
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
            padding: const EdgeInsets.all(16),
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
                isSelectionMode: _selectedLotIds.isNotEmpty,
                onLongPress: (id) => setState(() => _selectedLotIds.add(id)),
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
          padding: const EdgeInsets.all(16),
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            final lot = filteredLots[index];
            return MyLotListCard(
              lot: lot,
              isSelected: _selectedLotIds.contains(lot.id),
              isSelectionMode: _selectedLotIds.isNotEmpty,
              onLongPress: (id) => setState(() => _selectedLotIds.add(id)),
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
}
