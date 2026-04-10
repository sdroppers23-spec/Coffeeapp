import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/sensory_radar_chart.dart';
import '../../shared/widgets/sensory_preview.dart';
import '../../core/network/price_sync_service.dart';
import '../brewing/custom_recipe_form.dart';
import '../navigation/main_scaffold.dart';

class CoffeeLotDetailScreen extends ConsumerStatefulWidget {
  final EncyclopediaEntry entry;
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
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
            const SizedBox(height: kToolbarHeight + 40),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: ref.t('tab_product')),
                Tab(text: ref.t('tab_profile')),
                Tab(text: ref.t('tab_recipes')),
              ],
              indicatorColor: theme.colorScheme.primary,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: Colors.white54,
              labelStyle:
                  GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold),
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
  final EncyclopediaEntry entry;
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

    final hasPrices = [retail250, retail1k, wholesale250, wholesale1k]
        .any((v) => v != null && v != '---');

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
                      child: _CompactStat(
                          label: ref.t('varieties'), value: entry.varieties)),
                  Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.05)),
                  Expanded(
                      child: _CompactStat(
                          label: ref.t('altitude'),
                          value:
                              '${entry.altitudeMin ?? '?'}-${entry.altitudeMax ?? '?'} m')),
                ],
              ),
              const Divider(height: 24, color: Colors.white10),
              Row(
                children: [
                  Expanded(
                      child: _CompactStat(
                          label: ref.t('process'), value: entry.processMethod)),
                  Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.05)),
                  Expanded(
                      child: _CompactStat(
                          label: 'SCA SCORE', value: entry.scaScore)),
                ],
              ),
              if (entry.region.isNotEmpty) ...[
                const Divider(height: 24, color: Colors.white10),
                _CompactStat(label: ref.t('region'), value: entry.region),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (hasPrices) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ref.t('prices_header').toUpperCase(),
                  style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      letterSpacing: 1.5)),
              if (_isFetching)
                const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(strokeWidth: 2)),
            ],
          ),
          const SizedBox(height: 12),
          GlassContainer(
            padding: EdgeInsets.zero,
            child: Table(
              children: [
                TableRow(children: [
                  _Cell(ref.t('weight'), isHeader: true),
                  _Cell(ref.t('retail'), isHeader: true),
                  _Cell(ref.t('wholesale'), isHeader: true),
                ]),
                _priceRow('250g', retail250, wholesale250),
                _priceRow('1kg', retail1k, wholesale1k),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        Text(ref.t('description').toUpperCase(),
            style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 1.5)),
        const SizedBox(height: 12),
        Text(entry.description,
            style: GoogleFonts.outfit(
                fontSize: 13, height: 1.5, color: Colors.white70)),
      ],
    );
  }

  TableRow _priceRow(String weight, String? retail, String? wholesale) {
    if ((retail == null || retail == '---') &&
        (wholesale == null || wholesale == '---')) {
      return const TableRow(children: [SizedBox(), SizedBox(), SizedBox()]);
    }
    return TableRow(children: [
      _Cell(weight),
      _Cell(retail != null && retail != '---' ? '$retail ₴' : '---'),
      _Cell(wholesale != null && wholesale != '---' ? '$wholesale ₴' : '---'),
    ]);
  }
}

class _ProfileTab extends ConsumerWidget {
  final EncyclopediaEntry entry;
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
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              Text(ref.t('process_detail').toUpperCase(),
                  style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 2)),
              const Divider(height: 32, color: Colors.white10),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Text(entry.detailedProcess,
                        style: GoogleFonts.outfit(
                            fontSize: 14, height: 1.6, color: Colors.white70)),
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

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, navHeight + 40),
      children: [
        SizedBox(
          height: 400,
          child: SensoryRadarChart(
            interactive: false,
            staticValues: entry.sensoryPoints.map((k, v) {
              final val = (v as num).toDouble();
              // Round to 1-5 scale, then map to 0.2-1.0
              final normalized =
                  (val > 5 ? val / 2.0 : val).round().clamp(1, 5);
              return MapEntry(k, normalized / 5.0);
            }),
            height: 400,
          ),
        ),
        Text(ref.t('sensory_profile_header').toUpperCase(),
            style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 1.5)),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SensoryPreview(
            points: entry.sensoryPoints.map((k, v) => MapEntry(k, v as num)),
            isGrid: true,
          ),
        ),
        if (entry.detailedProcess.isNotEmpty) ...[
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _showProcessDetails(context, ref),
              icon: const Icon(Icons.info_outline, size: 18),
              label: Text(ref.t('process_details').toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(
                    color: theme.colorScheme.primary.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RecipesTab extends ConsumerWidget {
  final EncyclopediaEntry entry;
  const _RecipesTab({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recommendedRecipesForLotProvider(entry.id));
    final theme = Theme.of(context);
    final navHeight = ref.watch(navBarHeightProvider);

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 20, 20, navHeight + 40),
      children: [
        recipesAsync.when(
          data: (recipes) {
            if (recipes.isEmpty) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(ref.t('no_recipes_for_lot'),
                    style:
                        const TextStyle(color: Colors.white24, fontSize: 13)),
              ));
            }
            return Column(
              children:
                  recipes.map((r) => _RecommendedCard(recipe: r)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error: $e'),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CustomRecipeFormScreen(methodKey: 'v60'),
                  ));
            },
            icon: const Icon(Icons.add_circle_outline, size: 18),
            label: Text(ref.t('add_custom_recipe'),
                style: const TextStyle(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              foregroundColor: theme.colorScheme.primary,
              side: BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}

final recommendedRecipesForLotProvider =
    FutureProvider.family<List<RecommendedRecipeDto>, int>((ref, lotId) async {
  final db = ref.watch(databaseProvider);
  return db.getRecommendedRecipesForLot(lotId);
});

class _CompactStat extends StatelessWidget {
  final String label;
  final String value;
  const _CompactStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label.toUpperCase(),
            style: GoogleFonts.outfit(
                fontSize: 9,
                color: Colors.white38,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  final String label;
  final bool isHeader;
  const _Cell(this.label, {this.isHeader = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(label,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
              fontSize: isHeader ? 9 : 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.white38 : Colors.white)),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  final RecommendedRecipeDto recipe;
  const _RecommendedCard({required this.recipe});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                Text(recipe.methodKey.toUpperCase(),
                    style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(children: [
                    Text(recipe.rating.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.amber)),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, color: Colors.amber, size: 10),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Stat(Icons.coffee, '${recipe.coffeeGrams}g'),
                _Stat(Icons.water_drop, '${recipe.waterGrams}ml'),
                _Stat(Icons.thermostat, '${recipe.tempC.toInt()}°C'),
                _Stat(Icons.timer, '${recipe.timeSec}s'),
              ],
            ),
            if (recipe.notes.isNotEmpty) ...[
              const Divider(height: 24, color: Colors.white10),
              Text(recipe.notes,
                  style: GoogleFonts.outfit(
                      fontSize: 11,
                      color: Colors.white54,
                      fontStyle: FontStyle.italic)),
            ],
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  const _Stat(this.icon, this.value);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon,
            size: 16, color: theme.colorScheme.primary.withValues(alpha: 0.4)),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}
