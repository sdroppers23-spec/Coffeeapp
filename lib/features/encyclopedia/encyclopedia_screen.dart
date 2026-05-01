import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/dtos.dart';
import 'encyclopedia_providers.dart';
import '../discover/widgets/discovery_action_bar.dart';
import '../discover/discovery_filter_provider.dart';
import '../../core/l10n/app_localizations.dart';
import 'widgets/encyclopedia_card_widgets.dart';
import 'coffee_lot_detail_screen.dart';
import 'comparison_screen.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/profile_button.dart';
import '../../shared/widgets/scroll_to_top_button.dart';
import '../../shared/services/toast_service.dart';

// ─── Body (Embedded Version) ──────────────────────────────────────────────────
class EncyclopediaBody extends ConsumerStatefulWidget {
  const EncyclopediaBody({super.key});

  @override
  ConsumerState<EncyclopediaBody> createState() => _EncyclopediaBodyState();
}

class _EncyclopediaBodyState extends ConsumerState<EncyclopediaBody> {
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

  @override
  Widget build(BuildContext context) {
    final originsAsync = ref.watch(encyclopediaDataProvider);

    return PremiumBackground(
      child: Stack(
        children: [
          Column(
            children: [
              // ── Premium Action Bar ─────────────────────────────────────────────
              DiscoveryActionBar(
                filterProvider: encyclopediaFilterProvider,
                selectionProvider: encyclopediaSelectedIdsProvider,
                searchHint: context.t('search_coffee'),
                onCompareTap: () {
                  final selectedCount = ref
                      .read(encyclopediaSelectedIdsProvider)
                      .length;
                  if (selectedCount == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ComparisonScreen(
                          source: ComparisonSource.encyclopedia,
                        ),
                      ),
                    );
                  } else if (selectedCount == 1) {
                    ToastService.showInfo(
                      context,
                      context.t('toast_select_second_lot'),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ComparisonScreen(
                          source: ComparisonSource.encyclopedia,
                        ),
                      ),
                    );
                  }
                },
                availableCountries: ref.watch(
                  availableEncyclopediaCountriesProvider,
                ),
                availableFlavors: ref.watch(
                  availableEncyclopediaFlavorsProvider,
                ),
                availableProcesses: ref.watch(
                  availableEncyclopediaProcessesProvider,
                ),
                showFavoritesButton: true,
                showSwipeModeToggle: false,
              ),

              const SizedBox(height: 8),

              // ── Content ─────────────────────────────────────────────────────────
              Expanded(
                child: Stack(
                  children: [
                    _buildList(originsAsync),
                    ScrollToTopButton(
                      scrollController: _scrollController,
                      threshold: 400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList(AsyncValue<List<LocalizedBeanDto>> originsAsync) {
    final filterState = ref.watch(encyclopediaFilterProvider);
    final isGrid = filterState.isGrid;
    final showFavoritesOnly = filterState.showFavoritesOnly;
    final showArchivedOnly = filterState.showArchivedOnly;

    return originsAsync.when(
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFFC8A96E),
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              context.t('loading_lots'),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.white70)),
      ),
      data: (filtered) {
        if (filtered.isEmpty) {
          final search = filterState.search;
          String emptyMessage = context.t('no_results');
          if (showFavoritesOnly && search.isEmpty) {
            emptyMessage = context.t('no_favorites');
          } else if (showArchivedOnly && search.isEmpty) {
            emptyMessage = context.t('no_archived');
          } else if (search.isNotEmpty) {
            emptyMessage = '${context.t('no_results')} "$search"';
          }

          return _EmptyState(message: emptyMessage);
        }

        if (isGrid) {
          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 220,
            ),
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
          controller: _scrollController,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 180,
          ),
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
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: PremiumAppBar(
        title: ref.t('encyclopedia'),
        actions: const [_CloudStatusBadge(), ProfileButton()],
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          top: kToolbarHeight + 40,
        ), // Offset for blurred bar
        child: EncyclopediaBody(),
      ),
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
