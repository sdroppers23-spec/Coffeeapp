import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/database/dtos.dart';
import '../../../core/l10n/app_localizations.dart';
import '../discovery_filter_provider.dart';
import 'lots_providers.dart';
import 'lot_card_widgets.dart';
import '../widgets/discovery_action_bar.dart';

class MyLotsContent extends ConsumerStatefulWidget {
  const MyLotsContent({super.key});

  @override
  ConsumerState<MyLotsContent> createState() => _MyLotsContentState();
}

class _MyLotsContentState extends ConsumerState<MyLotsContent> with TickerProviderStateMixin {
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
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';
    final lotsAsync = ref.watch(userLotsProvider);
    final filter = ref.watch(myLotsFilterProvider);

    return Column(
      children: [
        // Sub-tabs for All/Favs/Archive
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            height: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
              controller: _subTabController,
              indicator: BoxDecoration(
                color: const Color(0xFFC8A96E),
                borderRadius: BorderRadius.circular(16),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white54,
              labelStyle: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: isUk ? 'Усі' : 'All'),
                Tab(text: isUk ? 'Улюблене' : 'Favs'),
                Tab(text: isUk ? 'Архів' : 'Archive'),
              ],
            ),
          ),
        ),

        // Action Bar (Filters, View Mode)
        lotsAsync.when(
          data: (lots) {
            final countries = lots.where((l) => l.originCountry != null).map((l) => l.originCountry!).toSet().toList()..sort();
            final processes = lots.where((l) => l.process != null).map((l) => l.process!).toSet().toList()..sort();
            final flavors = lots.where((l) => l.flavorProfile != null).expand((l) => l.flavorProfile!.split(',').map((s) => s.trim())).where((s) => s.isNotEmpty).toSet().toList()..sort();

            return DiscoveryActionBar(
              filterProvider: myLotsFilterProvider,
              onCompareTap: () {
                // Navigate to Comparison
              },
              availableCountries: countries,
              availableFlavors: flavors,
              availableProcesses: processes,
              showFavoritesButton: false, // We have a sub-tab for this
            );
          },
          loading: () => const SizedBox(height: 48),
          error: (_, __) => const SizedBox(height: 48),
        ),

        Expanded(
          child: TabBarView(
            controller: _subTabController,
            children: [
              _buildListView(lotsAsync, filter, 'all'),
              _buildListView(lotsAsync, filter, 'favorites'),
              _buildListView(lotsAsync, filter, 'archive'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView(AsyncValue<List<CoffeeLotDto>> lotsAsync, DiscoveryFilterState filter, String type) {
    return lotsAsync.when(
      data: (lots) {
        var filteredLots = lots.where((lot) {
          if (lot.isDeletedLocal) return false;
          if (type == 'favorites') return lot.isFavorite && !lot.isArchived;
          if (type == 'archive') return lot.isArchived;
          return !lot.isArchived;
        }).toList();

        // Apply filters
        filteredLots = _applyFilters(filteredLots, filter);

        if (filteredLots.isEmpty) {
          return const Center(child: Text('Поки порожньо', style: TextStyle(color: Colors.white24)));
        }

        if (filter.isGrid) {
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemCount: filteredLots.length,
            itemBuilder: (context, index) {
              return MyLotGridCard(
                lot: filteredLots[index],
                isSelected: _selectedLotIds.contains(filteredLots[index].id),
                isSelectionMode: _selectedLotIds.isNotEmpty,
                onLongPress: (id) => setState(() => _selectedLotIds.add(id)),
                onTap: (id) => context.push('/edit_lot', extra: filteredLots[index]),
                onFavoriteToggle: (lot) {
                  // Toggle favorite
                },
              );
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            return MyLotListCard(
              lot: filteredLots[index],
              isSelected: _selectedLotIds.contains(filteredLots[index].id),
              isSelectionMode: _selectedLotIds.isNotEmpty,
              onLongPress: (id) => setState(() => _selectedLotIds.add(id)),
              onTap: (id) => context.push('/edit_lot', extra: filteredLots[index]),
              onFavoriteToggle: (lot) {
                // TODO: Implement favorite toggle logic
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text('Error: $e')),
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
