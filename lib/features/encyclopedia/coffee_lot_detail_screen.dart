import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/network/price_sync_service.dart';
import '../../shared/widgets/recipe_type_bottom_sheet.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../shared/widgets/lot_detail_widgets.dart';
import '../../shared/widgets/sensory_radar_chart.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/utils/sensory_utils.dart';
import '../navigation/navigation_providers.dart';
import '../encyclopedia/encyclopedia_providers.dart';
import '../../shared/services/toast_service.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/sync_indicator.dart';
import '../../shared/widgets/modern_undo_timer.dart';
import '../../core/utils/responsive_utils.dart';
import '../brewing/widgets/custom_recipe_card.dart';

class CoffeeLotDetailScreen extends ConsumerStatefulWidget {
  final LocalizedBeanDto entry;
  const CoffeeLotDetailScreen({super.key, required this.entry});

  @override
  ConsumerState<CoffeeLotDetailScreen> createState() =>
      _CoffeeLotDetailScreenState();
}

class _CoffeeLotDetailScreenState extends ConsumerState<CoffeeLotDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Hide navbar when entering detail screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Show navbar when leaving detail screen
    ref.read(navBarVisibleProvider.notifier).show();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          entry.fullDisplayName.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final favoritesAsync = ref.watch(favoriteIdsProvider);
              return favoritesAsync.maybeWhen(
                data: (ids) {
                  final isFavorite = ids.contains(entry.id);
                  return IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite ? Colors.redAccent : Colors.white70,
                    ),
                    onPressed: () async {
                      await ref
                          .read(databaseProvider)
                          .toggleFavorite(entry.id, !isFavorite);
                      unawaited(
                        ref.read(syncStatusProvider.notifier).syncEverything(),
                      );
                      if (context.mounted) {
                        if (isFavorite) {
                          ToastService.showInfo(
                            context,
                            ref.t('toast_removed_from_favorites'),
                          );
                        } else {
                          ToastService.showSuccess(
                            context,
                            ref.t('toast_added_to_favorites'),
                          );
                        }
                      }
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF141414), Color(0xFF000000)],
          ),
        ),
        child: Column(
          children: [
            // Image Header
            Stack(
              children: [
                Hero(
                  tag: 'lot_image_${entry.id}',
                  child: Container(
                    height: math.min(screenWidth * 1.0, 950.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: entry.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(entry.imageUrl),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            )
                          : DecorationImage(
                              image: NetworkImage(entry.effectiveFlagUrl),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                    ),
                    child:
                        (entry.imageUrl.isEmpty &&
                            entry.effectiveFlagUrl.isEmpty)
                        ? Center(
                            child: Icon(
                              Icons.coffee_rounded,
                              size: 64,
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                // Gradient Overlays
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 1.0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                // Lot Info Overlay
                Positioned(
                  bottom: 20,
                  left: context.isTablet ? 40 : 20,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.country.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.region.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            LotBadge(
                              label: '${entry.scaScore} SCA',
                              theme: theme,
                            ),
                            const SizedBox(width: 8),
                            LotBadge(
                              label: entry.roastLevel.toUpperCase(),
                              theme: theme,
                              isPrimary: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: ref.t('tab_info')),
                Tab(text: ref.t('tab_sensory')),
                Tab(text: ref.t('tab_recipes')),
              ],
              indicatorColor: theme.colorScheme.primary,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: Colors.white54,
              labelStyle: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _InfoTab(entry: entry),
                  _ProfileTab(entry: entry),
                  _RecipesTab(entry: entry),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends ConsumerStatefulWidget {
  final LocalizedBeanDto entry;
  const _InfoTab({required this.entry});

  @override
  ConsumerState<_InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends ConsumerState<_InfoTab> {
  Map<String, String?> _fetchedPrices = {};
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    if (widget.entry.url?.contains('3champsroastery') ?? false) {
      _fetchPrices();
    }
  }

  Future<void> _fetchPrices() async {
    setState(() => _isFetching = true);
    final service = PriceSyncService();
    final results = await service.fetch3ChampsPrices(widget.entry.url ?? '');
    if (mounted) {
      setState(() {
        _fetchedPrices = results;
        _isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;
    final pTable = entry.pricing;
    final navHeight = ref.watch(navBarHeightProvider);

    final retail250 =
        _fetchedPrices['retail_250'] ?? pTable['retail_250']?.toString();
    final retail1k =
        _fetchedPrices['retail_1k'] ?? pTable['retail_1k']?.toString();
    final wholesale250 =
        _fetchedPrices['wholesale_250'] ?? pTable['wholesale_250']?.toString();
    final wholesale1k =
        _fetchedPrices['wholesale_1k'] ?? pTable['wholesale_1k']?.toString();

    final hasPrices = [
      retail250,
      retail1k,
      wholesale250,
      wholesale1k,
    ].any((v) => v != null && v != '---');

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 20, 20, navHeight + 40),
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: LotCompactStat(
                      label: ref.t('varieties'),
                      value: entry.varieties,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  Expanded(
                    child: LotCompactStat(
                      label: ref.t('altitude'),
                      value: _formatAltitude(
                        entry.altitudeMin,
                        entry.altitudeMax,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: Colors.white10),
              Row(
                children: [
                  Expanded(
                    child: LotCompactStat(
                      label: ref.t('process'),
                      value: entry.processMethod,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  Expanded(
                    child: LotCompactStat(
                      label: 'SCA SCORE',
                      value: entry.scaScore,
                    ),
                  ),
                ],
              ),
              if (entry.region.isNotEmpty) ...[
                const Divider(height: 24, color: Colors.white10),
                LotCompactStat(label: ref.t('region'), value: entry.region),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        Text(
          ref.t('lot_details').toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        LotDetailRow(label: ref.t('lot_number_label'), value: entry.lotNumber),
        LotDetailRow(label: ref.t('farm'), value: entry.farm ?? 'N/A'),
        LotDetailRow(
          label: ref.t('wash_station'),
          value: entry.washStation ?? 'N/A',
        ),
        LotDetailRow(label: ref.t('weight'), value: entry.weight ?? 'N/A'),
        LotDetailRow(
          label: ref.t('harvest_season'),
          value: entry.harvestSeason ?? 'N/A',
        ),
        LotDetailRow(
          label: ref.t('roast_date'),
          value: entry.roastDate ?? 'N/A',
        ),
        LotDetailRow(
          label: ref.t('is_decaf'),
          value: entry.isDecaf ? ref.t('yes') : ref.t('no'),
        ),
        const SizedBox(height: 24),
        if (hasPrices) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.t('prices_header').toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.5,
                ),
              ),
              if (_isFetching)
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 12),
          GlassContainer(
            padding: EdgeInsets.zero,
            child: Table(
              children: [
                TableRow(
                  children: [
                    _Cell(ref.t('weight'), isHeader: true),
                    _Cell(ref.t('retail'), isHeader: true),
                    _Cell(ref.t('wholesale'), isHeader: true),
                  ],
                ),
                _priceRow('250g', retail250, wholesale250),
                _priceRow('1kg', retail1k, wholesale1k),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        Text(
          ref.t('description').toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        MarkdownBody(
          data: entry.description,
          extensionSet: md.ExtensionSet.gitHubWeb,
          styleSheet: MarkdownStyleSheet(
            p: GoogleFonts.outfit(
              fontSize: 13,
              height: 1.6,
              color: Colors.white70,
            ),
            strong: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  String _formatAltitude(int? min, int? max) {
    final pref = ref.watch(preferencesProvider);
    final unit = pref.lengthUnit;

    if (min == null && max == null) return 'N/A';

    if (unit == LengthUnit.feet) {
      final minFt = min != null ? (min * 3.28084).toStringAsFixed(0) : 'N/A';
      final maxFt = max != null ? (max * 3.28084).toStringAsFixed(0) : 'N/A';
      return '$minFt-$maxFt ft';
    } else {
      return '${min ?? 'N/A'}-${max ?? 'N/A'} m';
    }
  }

  TableRow _priceRow(String weight, String? retail, String? wholesale) {
    final pref = ref.watch(preferencesProvider);
    final symbol = _getCurrencySymbol(pref.currency);

    if ((retail == null || retail == '---') &&
        (wholesale == null || wholesale == '---')) {
      return const TableRow(children: [SizedBox(), SizedBox(), SizedBox()]);
    }
    return TableRow(
      children: [
        _Cell(weight),
        _Cell(retail != null && retail != '---' ? '$retail $symbol' : '---'),
        _Cell(
          wholesale != null && wholesale != '---'
              ? '$wholesale $symbol'
              : '---',
        ),
      ],
    );
  }

  String _getCurrencySymbol(Currency c) {
    switch (c) {
      case Currency.uah:
        return '₴';
      case Currency.eur:
        return '€';
      case Currency.usd:
        return r'$';
    }
  }
}

class _ProfileTab extends ConsumerWidget {
  final LocalizedBeanDto entry;
  const _ProfileTab({required this.entry});

  void _showProcessDetails(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, controller) => GlassContainer(
          borderRadius: 32,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                ref.t('process_detail').toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 2,
                ),
              ),
              const Divider(height: 32, color: Colors.white10),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    MarkdownBody(
                      data: entry.detailedProcess,
                      extensionSet: md.ExtensionSet.gitHubWeb,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.outfit(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.white70,
                        ),
                        strong: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navHeight = ref.watch(navBarHeightProvider);

    final mappedSensory = SensoryUtils.map4To6Axis(entry.sensoryPoints);

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, navHeight + 100),
      children: [
        SizedBox(
          height: 400,
          child: SensoryRadarChart(
            interactive: false,
            staticValues: <String, double>{
              'bitterness': (mappedSensory['bitterness'] ?? 1.0) / 5.0,
              'acidity': (mappedSensory['acidity'] ?? 1.0) / 5.0,
              'sweetness': (mappedSensory['sweetness'] ?? 1.0) / 5.0,
              'body': (mappedSensory['body'] ?? 1.0) / 5.0,
              'intensity': (mappedSensory['intensity'] ?? 1.0) / 5.0,
              'aftertaste': (mappedSensory['aftertaste'] ?? 1.0) / 5.0,
            },
            height: 400,
          ),
        ),
        Text(
          ref.t('sensory_grid').toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        SensoryIndicator(
          label: ref.t('bitterness'),
          value: (mappedSensory['bitterness'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('acidity'),
          value: (mappedSensory['acidity'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('sweetness'),
          value: (mappedSensory['sweetness'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('body'),
          value: (mappedSensory['body'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('intensity'),
          value: (mappedSensory['intensity'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('aftertaste'),
          value: (mappedSensory['aftertaste'] ?? 1.0) / 5.0,
          color: const Color(0xFFC8A96E),
        ),
        if (entry.detailedProcess.isNotEmpty) ...[
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _showProcessDetails(context, ref),
              icon: const Icon(Icons.info_outline, size: 18),
              label: Text(
                ref.t('process_details').toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RecipesTab extends ConsumerStatefulWidget {
  final LocalizedBeanDto entry;
  const _RecipesTab({required this.entry});

  @override
  ConsumerState<_RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends ConsumerState<_RecipesTab> {
  final Set<String> _selectedIds = {};
  bool _isSelectionMode = false;
  final Set<String> _pendingDeleteIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
          ref.read(navBarVisibleProvider.notifier).show();
        }
      } else {
        if (!_isSelectionMode) {
          ref.read(navBarVisibleProvider.notifier).hide();
        }
        _selectedIds.add(id);
        _isSelectionMode = true;
      }
    });
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
  }

  void _selectAll(List<CustomRecipeDto> recipes) {
    setState(() {
      if (_selectedIds.length == recipes.length) {
        _selectedIds.clear();
        _isSelectionMode = false;
        ref.read(navBarVisibleProvider.notifier).show();
      } else {
        if (!_isSelectionMode) {
          ref.read(navBarVisibleProvider.notifier).hide();
        }
        _selectedIds.addAll(recipes.map((r) => r.id));
        _isSelectionMode = true;
      }
    });
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
  }

  void _showModernUndo(List<CustomRecipeDto> recipes) {
    final ids = recipes.map((r) => r.id).toList();
    setState(() {
      _pendingDeleteIds.addAll(ids);
      _selectedIds.clear();
      _isSelectionMode = false;
    });
    ref.read(navBarVisibleProvider.notifier).show();

    final db = ref.read(databaseProvider);
    final lotId = widget.entry.id.toString();

    ModernUndoTimer.show(
      context,
      message: recipes.length == 1
          ? ref.t('toast_recipe_deleted')
          : '${recipes.length} ${ref.t('tab_recipes').toLowerCase()} ${ref.t('toast_deleted')}',
      onUndo: () {
        setState(() {
          _pendingDeleteIds.removeAll(ids);
        });
      },
      onDismiss: () async {
        for (final id in ids) {
          await db.deleteEncyclopediaRecipe(id);
        }
        if (mounted) {
          setState(() {
            _pendingDeleteIds.removeAll(ids);
          });
          ref.invalidate(encyclopediaRecipesForLotProvider(lotId));
          unawaited(ref.read(syncStatusProvider.notifier).syncEverything());
        }
      },
    );
  }

  Future<void> _showAddRecipeFlow() async {
    final db = ref.read(databaseProvider);
    final lotId = widget.entry.id.toString();
    final recipes = await db.getCustomRecipesForLot(lotId);

    final espressoCount =
        recipes.where((r) => r.recipeType == 'espresso').length;
    final filterCount = recipes.where((r) => r.recipeType == 'filter').length;

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => RecipeTypeBottomSheet(
        title: ref.t('choose_brewing_type'),
        filterCount: filterCount,
        espressoCount: espressoCount,
        onTypeSelected: (type) async {
          final count = type == 'espresso' ? espressoCount : filterCount;
          if (count >= 10) {
            Navigator.pop(ctx);
            ToastService.showError(
              context,
              '${ref.t('limit_reached')}: 10',
            );
            return;
          }

          Navigator.pop(ctx);
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AddRecipeDialog(
              lotId: lotId,
              recipeSegment: RecipeSegment.encyclopedia,
              initialMethod: type == 'espresso' ? 'espresso' : 'v60',
            ),
          );
          if (result == true) {
            ref.invalidate(encyclopediaRecipesForLotProvider(lotId));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendedAsync = ref.watch(
      recommendedRecipesForLotProvider(widget.entry.id),
    );
    final customRecipesAsync = ref.watch(
      encyclopediaRecipesForLotProvider(widget.entry.id.toString()),
    );
    final navHeight = ref.watch(navBarHeightProvider);

    return Stack(
      children: [
        customRecipesAsync.when(
          data: (allRecipes) {
            final recipes = allRecipes
                .where((r) => !_pendingDeleteIds.contains(r.id))
                .toList();

            return ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, navHeight + 100),
              children: [
                // Recommended Recipes Section
                recommendedAsync.when(
                  data: (recRecipes) {
                    if (recRecipes.isEmpty || _isSelectionMode) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(ref.t('recommended_recipes')),
                        const SizedBox(height: 12),
                        ...recRecipes.map((r) => _RecommendedCard(recipe: r)),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),

                // Custom User Recipes Section
                if (recipes.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SectionHeader(ref.t('my_recipes')),
                      if (_isSelectionMode)
                        TextButton(
                          onPressed: () => _selectAll(recipes),
                          child: Text(
                            _selectedIds.length == recipes.length
                                ? ref.t('deselect_all')
                                : ref.t('select_all'),
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFFC8A96E),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...recipes.map((r) {
                    final isSelected = _selectedIds.contains(r.id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CustomRecipeCard(
                        recipe: r,
                        segment: RecipeSegment.encyclopedia,
                        methodKey: r.methodKey,
                        ref: ref,
                        isSelectionMode: _isSelectionMode,
                        isSelected: isSelected,
                        onTap: () {
                          if (_isSelectionMode) {
                            _toggleSelection(r.id);
                          }
                        },
                        onLongPress: () => _toggleSelection(r.id),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],


                if (recipes.isEmpty &&
                    (recommendedAsync.value?.isEmpty ?? true))
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        ref.t('no_recipes_for_lot'),
                        style: const TextStyle(
                          color: Colors.white24,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error: $e'),
        ),

        // Floating Selection Bar
        if (_isSelectionMode)
          Positioned(
            bottom: navHeight + 20,
            left: 20,
            right: 20,
            child: _buildSelectionBar(),
          ),

        // Floating Add Button (Snapshot 3 Style)
        if (!_isSelectionMode)
          Positioned(
            bottom: 90,
            right: 20,
            child: PressableScale(
              onTap: _showAddRecipeFlow,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFC8A96E),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.black, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      ref.t('add_recipe'),
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Text(
            '${_selectedIds.length} ${ref.t('selected')}',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
            onPressed: () {
              final customRecipesAsync = ref.read(
                encyclopediaRecipesForLotProvider(widget.entry.id.toString()),
              );
              customRecipesAsync.whenData((allRecipes) {
                final toDelete = allRecipes
                    .where((r) => _selectedIds.contains(r.id))
                    .toList();
                if (toDelete.isNotEmpty) {
                  _showModernUndo(toDelete);
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white70),
            onPressed: () {
              setState(() {
                _selectedIds.clear();
                _isSelectionMode = false;
              });
              ref.read(navBarVisibleProvider.notifier).show();
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1.5,
      ),
    );
  }
}

// _CustomRecipeCardWrapper removed in favor of unified CustomRecipeCard

final recommendedRecipesForLotProvider =
    FutureProvider.family<List<RecommendedRecipeDto>, int>((ref, lotId) async {
      final db = ref.watch(databaseProvider);
      return db.getRecommendedRecipesForLot(lotId);
    });

final customRecipesForLotProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, lotId) {
      final db = ref.watch(databaseProvider);
      return db.watchEncyclopediaRecipesForLot(lotId);
    });

// Local widget _CompactStat removed in favor of shared widgets

class _Cell extends StatelessWidget {
  final String label;
  final bool isHeader;
  const _Cell(this.label, {this.isHeader = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: isHeader ? 9 : 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white38 : Colors.white,
        ),
      ),
    );
  }
}

class _RecommendedCard extends ConsumerWidget {
  final RecommendedRecipeDto recipe;
  const _RecommendedCard({required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = LocaleService.currentLocale == 'uk';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recipe.methodKey.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text(
                        recipe.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, color: Colors.amber, size: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Stat(isUk ? 'КАВА' : 'COFFEE', '${recipe.coffeeGrams}g'),
                _Stat(isUk ? 'ВОДА' : 'WATER', '${recipe.waterGrams}ml'),
                _Stat('TEMP', '${recipe.tempC.toInt()}°C'),
                _Stat(isUk ? 'ЧАС' : 'TIME', '${recipe.timeSec}s'),
              ],
            ),
            if (recipe.notes.isNotEmpty) ...[
              const Divider(height: 24, color: Colors.white10),
              Text(
                recipe.notes,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: Colors.white54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// _formatTemp removed as it's no longer used

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary.withValues(alpha: 0.6),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
