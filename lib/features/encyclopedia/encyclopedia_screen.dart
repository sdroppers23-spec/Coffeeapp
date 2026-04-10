import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import '../discover/discovery_providers.dart';


// ─── Provider ─────────────────────────────────────────────────────────────────
final encyclopediaProvider = FutureProvider<List<EncyclopediaEntry>>((ref) async {
  final lang = ref.watch(localeProvider);
  return ref.watch(databaseProvider).getAllOrigins(lang);
});

// ─── Screen ───────────────────────────────────────────────────────────────────
class EncyclopediaScreen extends ConsumerStatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  ConsumerState<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends ConsumerState<EncyclopediaScreen> {
  String _search = '';
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final originsAsync = ref.watch(encyclopediaProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.t('coffee_origins'),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() {
                _search = v.toLowerCase();
                _expandedIndex = null;
              }),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: ref.t('search_origins'),
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38), size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/compare'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(Icons.compare_arrows, color: Theme.of(context).colorScheme.onPrimary),
        label: Text(ref.t('compare'), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: originsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (entries) {
            final filtered = _search.isEmpty
                ? entries
                : entries
                    .where((e) =>
                        e.country.toLowerCase().contains(_search) ||
                        e.region.toLowerCase().contains(_search) ||
                        e.flavorNotes.any((f) => f.toLowerCase().contains(_search)))
                    .toList();

            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.travel_explore, size: 56, color: Colors.black26),
                    const SizedBox(height: 12),
                    Text('${ref.t('no_results')} "$_search"',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38))),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final entry = filtered[i];
                final isExpanded = _expandedIndex == i;
                final flavors = entry.flavorNotes;

                return _OriginCard(
                  entry: entry,
                  flavors: flavors,
                  isExpanded: isExpanded,
                  onTap: () => setState(() =>
                      _expandedIndex = isExpanded ? null : i),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ─── Origin Card ─────────────────────────────────────────────────────────────
class _OriginCard extends ConsumerWidget {
  final EncyclopediaEntry entry;
  final List<String> flavors;
  final bool isExpanded;
  final VoidCallback onTap;

  const _OriginCard({
    required this.entry,
    required this.flavors,
    required this.isExpanded,
    required this.onTap,
  });

  Color get _scoreColor {
    if (entry.cupsScore >= 90) return Colors.purpleAccent;
    if (entry.cupsScore >= 87) return Colors.amber;
    if (entry.cupsScore >= 85) return Colors.greenAccent;
    return Colors.white70;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        opacity: isExpanded ? 0.12 : 0.08,
        borderColor: isExpanded ? const Color(0xFFC8A96E).withValues(alpha: 0.5) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(entry.countryEmoji ?? '', style: const TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.country,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.onSurface)),
                        Text(entry.region,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white54)),
                      ],
                    ),
                  ),
                  // SCA Score badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _scoreColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _scoreColor.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          entry.cupsScore.toStringAsFixed(1),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _scoreColor,
                              fontSize: 15),
                        ),
                        Text('SCA', style: TextStyle(fontSize: 8, color: _scoreColor.withValues(alpha: 0.7), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
            // ── Flavor chips (always visible) ─────────────────────────────────
            if (flavors.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: flavors.map((f) => _FlavorChip(f)).toList(),
                ),
              ),
            // ── Expanded content ──────────────────────────────────────────────
            if (isExpanded) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Colors.white12, height: 1),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.description,
                        style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.85), height: 1.6, fontSize: 13.5)),
                    const SizedBox(height: 20),
                    _SensoryVisualization(entry: entry),
                    const SizedBox(height: 20),
                    // Detail grid
                    _DetailGrid(entry: entry),
                    
                    // Farm Details
                    if (entry.farmDescription.isNotEmpty || (entry.farmPhotosUrlCover?.isNotEmpty ?? false)) ...[
                      const SizedBox(height: 28),
                      Row(
                        children: [
                           const Icon(Icons.terrain_rounded, size: 16, color: Color(0xFFC8A96E)),
                          const SizedBox(width: 8),
                          Text(ref.t('about_farm_region'), 
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      if (entry.farmPhotosUrlCover?.isNotEmpty ?? false)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              entry.farmPhotosUrlCover!,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 160,
                                color: Colors.white.withValues(alpha: 0.05),
                                child: const Icon(Icons.broken_image_outlined, color: Colors.white24),
                              ),
                            ),
                          ),
                        ),
                      if (entry.farmDescription.isNotEmpty)
                        Text(entry.farmDescription, 
                          style: GoogleFonts.inter(color: Colors.white70, height: 1.6, fontSize: 13)),
                    ],

                    // Processing Methods
                    if (entry.processingMethodsJson != '[]') ...[
                      const SizedBox(height: 32),
                      Row(
                        children: [
                           const Icon(Icons.science_rounded, size: 16, color: Color(0xFFC8A96E)),
                          const SizedBox(width: 8),
                          Text(ref.t('recipes_processing'), 
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _ProcessingMethodsList(jsonInfo: entry.processingMethodsJson),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Flavor Chip ─────────────────────────────────────────────────────────────
class _FlavorChip extends StatelessWidget {
  final String label;
  const _FlavorChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500)),
    );
  }
}

// ─── Detail Grid ─────────────────────────────────────────────────────────────
class _DetailGrid extends ConsumerWidget {
  final EncyclopediaEntry entry;
  const _DetailGrid({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      ('⛰ ${ref.t('altitude')}', '${entry.altitudeMin}–${entry.altitudeMax} m'),
      ('🌿 ${ref.t('varieties')}', entry.varieties),
      ('⚙️ ${ref.t('process')}', entry.processMethod),
      ('📅 ${ref.t('harvest')}', entry.harvestSeason ?? 'N/A'),
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                child: Text(item.$1,
                    style: const TextStyle(fontSize: 12, color: Colors.white38)),
              ),
              Expanded(
                child: Text(item.$2,
                    style: const TextStyle(fontSize: 12, color: Colors.white70)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Processing Methods List ─────────────────────────────────────────────────
class _ProcessingMethodsList extends StatelessWidget {
  final String jsonInfo;
  const _ProcessingMethodsList({required this.jsonInfo});

  @override
  Widget build(BuildContext context) {
    if (jsonInfo.isEmpty || jsonInfo == '[]') return const SizedBox();
    try {
      final List methods = jsonDecode(jsonInfo);
      return Column(
        children: methods.map((m) {
          final map = m as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.water_drop, size: 16, color: Color(0xFFC8A96E)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(map['name']?.toString() ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(map['desc']?.toString() ?? '', style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } catch (_) {
      return const SizedBox();
    }
  }
}

class OriginDetailsScreen extends ConsumerWidget {
  final EncyclopediaEntry entry;
  const OriginDetailsScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final roasterAsync = ref.watch(brandByIdProvider(entry.brandId ?? 0));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              stretch: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (entry.farmPhotosUrlCover?.isNotEmpty ?? false)
                      Image.network(entry.farmPhotosUrlCover!, fit: BoxFit.cover)
                    else
                      Container(color: Colors.grey.shade900),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roasterAsync.when(
                            data: (brand) => Text(brand?.name.toUpperCase() ?? '', 
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFC8A96E), letterSpacing: 2)),
                            loading: () => const SizedBox(),
                            error: (_, __) => const SizedBox(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.region,
                            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
                          ),
                          const SizedBox(height: 4),
                          Text('${entry.countryEmoji} ${entry.country}', 
                            style: GoogleFonts.inter(fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: const Color(0xFFC8A96E),
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: const Color(0xFFC8A96E),
                  tabs: [
                    Tab(text: ref.t('tab_product')),
                    Tab(text: ref.t('tab_source')),
                    Tab(text: ref.t('tab_recipes')),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _ProductTab(entry: entry),
              _SourceTab(entry: entry),
              _RecipesTab(lotId: entry.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.black, child: _tabBar);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class _ProductTab extends ConsumerWidget {
  final EncyclopediaEntry entry;
  const _ProductTab({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _SectionHeader(ref.t('purchase_details')),
        _InfoTile(label: ref.t('price'), value: (entry.price ?? 'N/A'), icon: Icons.payments_outlined),
        _InfoTile(label: ref.t('weight'), value: (entry.weight ?? 'N/A'), icon: Icons.scale_outlined),
        _InfoTile(label: ref.t('roast_date'), value: (entry.roastDate ?? 'N/A'), icon: Icons.calendar_today_outlined),
        _InfoTile(label: ref.t('lot_number'), value: entry.lotNumber.isEmpty ? 'N/A' : entry.lotNumber, icon: Icons.tag),
        const SizedBox(height: 24),
        _SectionHeader(ref.t('roast_level')),
        _RoastLevelIndicator(level: entry.roastLevel),
        const SizedBox(height: 32),
        if (entry.url?.isNotEmpty ?? false)
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
            label: Text(ref.t('shop_coffee')),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC8A96E),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
      ],
    );
  }
}

class _SourceTab extends ConsumerWidget {
  final EncyclopediaEntry entry;
  const _SourceTab({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _SectionHeader(ref.t('terroir_farm')),
        _InfoTile(label: ref.t('region'), value: entry.region, icon: Icons.location_on_outlined),
        _InfoTile(label: ref.t('altitude'), value: '${entry.altitudeMin} - ${entry.altitudeMax}m', icon: Icons.height_outlined),
        _InfoTile(label: ref.t('varieties'), value: entry.varieties, icon: Icons.grass_outlined),
        _InfoTile(
          label: ref.t('process'),
          value: entry.processMethod,
          icon: Icons.shutter_speed_outlined,
          trailing: _hasLocalizedDescription(entry.processMethod, ref) 
            ? IconButton(
                onPressed: () => _showLocalizedProcessSheet(context, entry, ref),
                icon: const Icon(Icons.info_outline, color: Color(0xFFC8A96E), size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            : entry.detailedProcessMarkdown.isNotEmpty 
              ? IconButton(
                  onPressed: () => _showProcessDetailSheet(context, entry, ref),
                  icon: const Icon(Icons.info_outline, color: Color(0xFFC8A96E), size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              : null,
        ),
        const SizedBox(height: 24),
        _SectionHeader(ref.t('sensory_grid')),
        _SensoryVisualization(entry: entry),
        _CuppingScoreCard(score: entry.cupsScore),
        const SizedBox(height: 24),
        _SectionHeader(ref.t('story_terroir')),
        Text(_getLocalizedDescription(entry, ref), style: const TextStyle(color: Colors.white70, height: 1.6)),
      ],
    );
  }

  String _getLocalizedDescription(EncyclopediaEntry entry, WidgetRef ref) {
    final country = entry.country.toLowerCase();
    
    // Mad Heads
    if (country.contains('utengule')) return ref.t('lot_desc_tanzania_utengule');
    if (country.contains('alto de osos')) return ref.t('lot_desc_col_alto_osos');
    if (country.contains('frinsa manis')) return ref.t('lot_desc_indonesia_manis');
    if (country.contains('gichathaini')) return ref.t('lot_desc_kenya_gichathaini');
    
    // 3Champs
    if (country.contains('colombia 46 filter')) return ref.t('lot_desc_col_46_filter');
    if (country.contains('colombia 31 filter')) return ref.t('lot_desc_col_31_filter');
    if (country.contains('kenya 20 filter')) return ref.t('lot_desc_kenya_20_filter');
    if (country.contains('ethiopia 37 filter')) return ref.t('lot_desc_eth_37_filter');
    if (country.contains('colombia 46 espresso')) return ref.t('lot_desc_col_46_espresso');

    // Fallback to original database string (which is Ukrainian for 3Champs seed)
    return entry.description;
  }
}

class _RecipesTab extends ConsumerWidget {
  final int lotId;
  const _RecipesTab({required this.lotId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(lotRecipesProvider(lotId));

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('${ref.t('error_loading')}: $e')),
      data: (recipes) {
        if (recipes.isEmpty) {
          return Center(child: Text(ref.t('no_recipes_for_lot')));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, i) {
             // Reusing the same card logic as BrewingDetailScreen
             return _RecommendedRecipeCard(recipe: recipes[i]);
          },
        );
      },
    );
  }
}

final lotRecipesProvider = FutureProvider.family<List<RecommendedRecipeDto>, int>((ref, lotId) async {
  final db = ref.watch(databaseProvider);
  return db.getRecommendedRecipesForLot(lotId);
});

class _SectionHeader extends StatelessWidget {
  final String title;
  _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white38, letterSpacing: 1.5)),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Widget? trailing;
  const _InfoTile({required this.label, required this.value, required this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFC8A96E)),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(color: Colors.white54)),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            trailing!,
          ],
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}

class _RoastLevelIndicator extends ConsumerWidget {
  final String level;
  const _RoastLevelIndicator({required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double progress = 0.5;
    if (level.toLowerCase().contains('light')) progress = 0.2;
    if (level.toLowerCase().contains('dark')) progress = 0.8;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            color: const Color(0xFFC8A96E),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ref.t('roast_light'), style: const TextStyle(fontSize: 10, color: Colors.white38)),
            Text(ref.t('roast_medium'), style: const TextStyle(fontSize: 10, color: Colors.white38)),
            Text(ref.t('roast_dark'), style: const TextStyle(fontSize: 10, color: Colors.white38)),
          ],
        ),
      ],
    );
  }
}

class _CuppingScoreCard extends ConsumerWidget {
  final double score;
  const _CuppingScoreCard({required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: Color(0xFFC8A96E), size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ref.t('cupping_score').toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              Text(score.toString(), style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFFC8A96E))),
            ],
          ),
        ],
      ),
    );
  }
}

// Dummy classes to support _RecommendedRecipeCard reuse (need to implement shared widgets)
class _RecommendedRecipeCard extends StatelessWidget {
  final RecommendedRecipeDto recipe;
  const _RecommendedRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
       child: Column(
         children: [
           Row(
             children: [
               Icon(Icons.coffee_maker, color: const Color(0xFFC8A96E)),
               const SizedBox(width: 12),
               Text(recipe.methodKey.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
               const Spacer(),
               Text('${recipe.rating} ★'),
             ],
           ),
           const Divider(color: Colors.white10, height: 24),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Text('${recipe.coffeeGrams}g'),
               Text('${recipe.waterGrams}g'),
               Text('${recipe.tempC}°C'),
               Text('${recipe.timeSec}s'),
             ],
           ),
         ],
       ),
    );
  }
}

class _SensoryVisualization extends StatelessWidget {
  final EncyclopediaEntry entry;
  const _SensoryVisualization({required this.entry});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> sensory = {};
    try {
      sensory = jsonDecode(entry.sensoryJson);
    } catch (_) {}

    final indicators = sensory['indicators'] as Map<String, dynamic>? ?? {};
    if (indicators.isEmpty && sensory['aroma'] == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (indicators.isNotEmpty) ...[
            SizedBox(
              height: 200,
              child: _RadarChart(indicators: indicators),
            ),
            const SizedBox(height: 16),
            _DotScale(label: 'Acidity', value: (indicators['acidity'] ?? 0).toDouble()),
            _DotScale(label: 'Sweetness', value: (indicators['sweetness'] ?? 0).toDouble()),
            _DotScale(label: 'Bitterness', value: (indicators['bitterness'] ?? 0).toDouble()),
            _DotScale(label: 'Intensity', value: (indicators['intensity'] ?? 0).toDouble()),
            const SizedBox(height: 16),
          ],
          if (sensory['aroma'] != null)
            _ProfileLine(label: 'Aroma', value: sensory['aroma']),
          if (sensory['acidityType'] != null)
            _ProfileLine(label: 'Acidity Type', value: sensory['acidityType']),
          if (sensory['bodyType'] != null)
            _ProfileLine(label: 'Body', value: sensory['bodyType']),
          if (sensory['aftertaste'] != null)
            _ProfileLine(label: 'Aftertaste', value: sensory['aftertaste']),
        ],
      ),
    );
  }
}

class _DotScale extends StatelessWidget {
  final String label;
  final num value;
  const _DotScale({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white38)),
          ),
          ...List.generate(5, (i) {
            final filled = i < value;
            return Container(
              margin: const EdgeInsets.only(right: 6),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: filled ? const Color(0xFFC8A96E) : Colors.white10,
                border: filled ? null : Border.all(color: Colors.white24, width: 0.5),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ProfileLine extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontSize: 12, color: Colors.white38)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, color: Colors.white70))),
        ],
      ),
    );
  }
}

void _showProcessDetailSheet(BuildContext context, EncyclopediaEntry entry, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.history_edu, color: Color(0xFFC8A96E)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(ref.t('process_detail').toUpperCase(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(entry.processMethod.toUpperCase(), style: const TextStyle(color: Colors.white38, letterSpacing: 1.2, fontSize: 12)),
          ),
          const Divider(height: 32, color: Colors.white10),
          Expanded(
            child: Markdown(
              controller: scrollController,
              data: _translateDetailedDescription(entry, ref),
              styleSheet: MarkdownStyleSheet(
                h3: GoogleFonts.poppins(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 16),
                p: const TextStyle(color: Colors.white70, height: 1.6, fontSize: 14),
                listBullet: const TextStyle(color: Color(0xFFC8A96E)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String _translateDetailedDescription(EncyclopediaEntry entry, WidgetRef ref) {
  final p = entry.processMethod.toLowerCase();
  if (p.contains('natural') || p.contains('натур')) return ref.t('process_natural_desc');
  if (p.contains('washed') || p.contains('мит')) return ref.t('process_washed_desc');
  if (p.contains('anaerobic') || p.contains('анаероб')) return ref.t('process_anaerobic_desc');
  if (p.contains('thermal') || p.contains('термал')) return ref.t('process_thermal_desc');
  if (p.contains('honey') || p.contains('хані')) return ref.t('process_honey_desc');
  return entry.detailedProcessMarkdown;
}

class _RadarChart extends ConsumerWidget {
  final Map<String, dynamic> indicators;
  const _RadarChart({required this.indicators});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFFC8A96E).withValues(alpha: 0.2),
            borderColor: const Color(0xFFC8A96E),
            entryRadius: 3,
            dataEntries: [
              RadarEntry(value: (indicators['acidity'] as num? ?? 0).toDouble()),
              RadarEntry(value: (indicators['sweetness'] as num? ?? 0).toDouble()),
              RadarEntry(value: (indicators['bitterness'] as num? ?? 0).toDouble()),
              RadarEntry(value: (indicators['intensity'] as num? ?? 0).toDouble()),
              RadarEntry(value: 3), // placeholder for balance/body
            ],
          ),
        ],
        radarBackgroundColor: Colors.transparent,
        borderData: FlBorderData(show: false),
        radarBorderData: const BorderSide(color: Colors.white10),
        tickBorderData: const BorderSide(color: Colors.white10),
        gridBorderData: const BorderSide(color: Colors.white10, width: 0.5),
        ticksTextStyle: const TextStyle(color: Colors.transparent),
        getTitle: (index, angle) {
          switch (index) {
            case 0: return RadarChartTitle(text: ref.t('acidity').toUpperCase(), angle: 0);
            case 1: return RadarChartTitle(text: ref.t('sweetness').toUpperCase(), angle: 0);
            case 2: return RadarChartTitle(text: ref.t('bitterness').toUpperCase(), angle: 0);
            case 3: return RadarChartTitle(text: ref.t('intensity').toUpperCase(), angle: 0);
            case 4: return RadarChartTitle(text: ref.t('body').toUpperCase(), angle: 0);
            default: return const RadarChartTitle(text: '');
          }
        },
        titleTextStyle: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}


bool _hasLocalizedDescription(String process, WidgetRef ref) {
  final p = process.toLowerCase();
  return p.contains('natural') || p.contains('натур') || 
         p.contains('washed') || p.contains('мит') || 
         p.contains('anaerobic') || p.contains('анаероб') || 
         p.contains('thermal') || p.contains('термал') ||
         p.contains('honey') || p.contains('хані');
}

void _showLocalizedProcessSheet(BuildContext context, EncyclopediaEntry entry, WidgetRef ref) {
  final description = _getLocalizedDetailedProcess(entry.processMethod, ref);
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ref.t('process_detail').toUpperCase(), 
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFFC8A96E), letterSpacing: 1.2)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white54)),
              ],
            ),
            const Divider(color: Colors.white10, height: 32),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  MarkdownBody(
                    data: description,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
                      h3: GoogleFonts.poppins(color: const Color(0xFFC8A96E), fontSize: 18, fontWeight: FontWeight.bold),
                      listBullet: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

String _getLocalizedDetailedProcess(String process, WidgetRef ref) {
  final p = process.toLowerCase();
  if (p.contains('natural') || p.contains('натур')) return ref.t('process_natural_desc');
  if (p.contains('washed') || p.contains('мит')) return ref.t('process_washed_desc');
  if (p.contains('anaerobic') || p.contains('анаероб')) return ref.t('process_anaerobic_desc');
  if (p.contains('thermal') || p.contains('термал')) return ref.t('process_thermal_desc');
  return ''; // Fallback
}
