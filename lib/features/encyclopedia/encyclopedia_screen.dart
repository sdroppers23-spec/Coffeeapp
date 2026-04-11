import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/dtos.dart';
import 'encyclopedia_providers.dart';
import '../discover/widgets/discovery_action_bar.dart';
import '../discover/discovery_filter_provider.dart';
import '../../core/l10n/app_localizations.dart';
import 'widgets/encyclopedia_card_widgets.dart';
import 'coffee_lot_detail_screen.dart';
import '../discover/farmers_screen.dart'; // Додав імпорт FarmersBody
import 'comparison_screen.dart'; // Новий екран порівняння!

// ─── Body (Embedded Version) ──────────────────────────────────────────────────
class EncyclopediaBody extends ConsumerStatefulWidget {
  const EncyclopediaBody({super.key});

  @override
  ConsumerState<EncyclopediaBody> createState() => _EncyclopediaBodyState();
}

class _EncyclopediaBodyState extends ConsumerState<EncyclopediaBody> {
  @override
  Widget build(BuildContext context) {
    final originsAsync = ref.watch(encyclopediaDataProvider);

    return DefaultTabController(
      // Зменшив кількість табів до 2 (Catalog та Farmers)
      length: 2, 
      child: Column(
        children: [
          // ── Premium Action Bar ─────────────────────────────────────────────
          DiscoveryActionBar(
            filterProvider: encyclopediaFilterProvider,
            onCompareTap: () {
              // Відкриваємо екран порівняння замість перемикання таба
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ComparisonScreen()),
              );
            },
            availableCountries: ref.watch(availableEncyclopediaCountriesProvider),
            availableFlavors: ref.watch(availableEncyclopediaFlavorsProvider),
            availableProcesses: ref.watch(availableEncyclopediaProcessesProvider),
            showFavoritesButton: true,
          ),

          const SizedBox(height: 8),

          // ── Secondary Tabs ──────────────────────────────────────────────────
          TabBar(
            indicatorColor: const Color(0xFFC8A96E),
            labelColor: const Color(0xFFC8A96E),
            unselectedLabelColor: Colors.white54,
            dividerColor: Colors.transparent,
            labelStyle: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            tabs: [
              Tab(text: context.t('catalog')), // Catalog
              const Tab(text: 'Farmers'),     // Farmers
            ],
          ),

          // ── Content ─────────────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              children: [
                _buildList(originsAsync),
                const FarmersBody(), // Вставлений екран фермерів
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    AsyncValue<List<LocalizedBeanDto>> originsAsync,
  ) {
    final filterState = ref.watch(encyclopediaFilterProvider);
    final isGrid = filterState.isGrid;
    final showFavoritesOnly = filterState.showFavoritesOnly;

    return originsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (entries) {
        var filtered = entries;
        if (showFavoritesOnly) {
          filtered = filtered.where((e) => e.isFavorite).toList();
        }

        if (filtered.isEmpty) {
          final search = filterState.search;
          return _EmptyState(
            message: showFavoritesOnly && search.isEmpty
                ? context.t('no_favorites')
                : '${context.t('no_results')} "$search"',
          );
        }

        if (isGrid) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final entry = filtered[i];
              return EncyclopediaLotGridCard(
                entry: entry,
                onTap: () => _navigateToDetail(entry),
              );
            },
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final entry = filtered[i];
            return EncyclopediaLotListCard(
              entry: entry,
              onTap: () => _navigateToDetail(entry),
            );
          },
        );
      },
    );
  }

  void _navigateToDetail(LocalizedBeanDto entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeLotDetailScreen(entry: entry),
      ),
    );
  }
}

// ─── Screen Wrapper ──────────────────────────────────────────────────────────
class EncyclopediaScreen extends ConsumerWidget {
  const EncyclopediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              ref.t('encyclopedia'),
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 12),
            const _CloudStatusBadge(),
          ],
        ),
      ),
      body: const EncyclopediaBody(),
    );
  }
}

class _CloudStatusBadge extends StatelessWidget {
  const _CloudStatusBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Live',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.travel_explore, size: 56, color: Colors.black26),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }
}
