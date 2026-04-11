import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import '../discover/discovery_providers.dart';
import 'encyclopedia_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ─── Screen ───────────────────────────────────────────────────────────────────
// ─── Body (Embedded Version) ──────────────────────────────────────────────────
class EncyclopediaBody extends ConsumerStatefulWidget {
  const EncyclopediaBody({super.key});

  @override
  ConsumerState<EncyclopediaBody> createState() => _EncyclopediaBodyState();
}

class _EncyclopediaBodyState extends ConsumerState<EncyclopediaBody> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final originsAsync = ref.watch(encyclopediaDataProvider);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // ── Search & Action Row ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          onChanged: (v) => ref
                              .read(encyclopediaSearchQueryProvider.notifier)
                              .update(v),
                          style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Пошук за сортами, країнами, регіонами...',
                            hintStyle: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xFFC8A96E),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Premium Action Bar (Filter, Compare, Favorites, Layout)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ActionButton(
                      icon: Icons.tune_rounded,
                      label: 'Фільтри',
                      onTap: () {}, // TODO: Open Filter
                    ),
                    _ActionButton(
                      icon: Icons.compare_arrows_rounded,
                      label: 'Порівняння',
                      onTap: () {}, // TODO: Switch to Comparison Tab logic
                    ),
                    _ActionButton(
                      icon: Icons.star_border_rounded,
                      label: 'Обране',
                      onTap: () {}, // TODO: Filter favorites
                    ),
                    _ActionButton(
                      icon: Icons.grid_view_rounded,
                      label: 'Вигляд',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // ── Secondary Tabs ──────────────────────────────────────────────────
          TabBar(
            indicatorColor: const Color(0xFFC8A96E),
            labelColor: const Color(0xFFC8A96E),
            unselectedLabelColor: Colors.white54,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            tabs: [
              Tab(text: ref.t('catalog')),
              Tab(text: ref.t('favorites')),
              Tab(text: ref.t('compare_tab')),
            ],
          ),

          // ── Content ─────────────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              children: [
                _buildList(originsAsync, isFavoriteOnly: false),
                _buildList(originsAsync, isFavoriteOnly: true),
                const _ComparisonTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    AsyncValue<List<LocalizedBeanDto>> originsAsync, {
    required bool isFavoriteOnly,
  }) {
    return originsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (entries) {
        var filtered = entries;
        if (isFavoriteOnly) {
          filtered = filtered.where((e) => e.isFavorite).toList();
        }

        if (filtered.isEmpty) {
          final search = ref.watch(encyclopediaSearchQueryProvider);
          return _EmptyState(
            message: isFavoriteOnly && search.isEmpty
                ? ref.t('no_favorites')
                : '${ref.t('no_results')} "$search"',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final entry = filtered[i];
            final isExpanded = _expandedIndex == i;
            return _OriginCard(
              entry: entry,
              isExpanded: isExpanded,
              onTap: () =>
                  setState(() => _expandedIndex = isExpanded ? null : i),
            );
          },
        );
      },
    );
  }
}

// ─── Screen ───────────────────────────────────────────────────────────────────
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

// ─── Sorting Menu ─────────────────────────────────────────────────────────────

// ─── Origin Card ─────────────────────────────────────────────────────────────
class _OriginCard extends ConsumerWidget {
  final LocalizedBeanDto entry;
  final bool isExpanded;
  final VoidCallback onTap;

  const _OriginCard({
    required this.entry,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isExpanded
              ? const Color(0xFFC8A96E).withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded
                ? const Color(0xFFC8A96E).withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _OriginAvatar(url: entry.url, emoji: entry.countryEmoji),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.country} ${entry.region} - ${entry.processMethod}',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${entry.country} • ${entry.processMethod}',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white12,
                    size: 20,
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              const Divider(color: Colors.white10, height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.description,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailGrid(entry: entry),
                    const SizedBox(height: 12),
                    // Dash-style Sensory Overview
                    _SensoryDashes(sensory: entry.sensoryPoints),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OriginDetailsScreen(entry: entry),
                          ),
                        ),
                        child: Text(
                          ref.t('read_more'),
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFC8A96E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Icon(icon, color: const Color(0xFFC8A96E), size: 18),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 9,
              color: Colors.white38,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SensoryDashes extends StatelessWidget {
  final Map<String, dynamic> sensory;
  const _SensoryDashes({required this.sensory});

  @override
  Widget build(BuildContext context) {
    final keys = ['aroma', 'sweetness', 'acidity', 'bitterness', 'body', 'intensity'];
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: keys.map((key) {
        final val = (sensory[key] ?? 1).toInt();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key.toUpperCase(),
              style: GoogleFonts.outfit(fontSize: 8, color: Colors.white24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) {
                return Container(
                  width: 12,
                  height: 2,
                  margin: const EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                    color: i < val ? const Color(0xFFC8A96E) : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              }),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _OriginAvatar extends StatelessWidget {
  final String? url;
  final String? emoji;
  const _OriginAvatar({this.url, this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: url != null
            ? CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    emoji ?? '☕',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              )
            : Center(
                child: Text(emoji ?? '☕', style: const TextStyle(fontSize: 22)),
              ),
      ),
    );
  }
}


// ─── Comparison Tab ───────────────────────────────────────────────────────────
class _ComparisonTab extends ConsumerStatefulWidget {
  const _ComparisonTab();
  @override
  ConsumerState<_ComparisonTab> createState() => _ComparisonTabState();
}

class _ComparisonTabState extends ConsumerState<_ComparisonTab> {
  LocalizedBeanDto? _coffeeA;
  LocalizedBeanDto? _coffeeB;

  @override
  Widget build(BuildContext context) {
    final originsAsync = ref.watch(encyclopediaDataProvider);

    return originsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (entries) {
        if (entries.isEmpty) {
          return const _EmptyState(message: 'No coffees available');
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: _Selector(
                    label: 'Coffee A',
                    selected: _coffeeA,
                    entries: entries,
                    onChanged: (v) => setState(() => _coffeeA = v),
                    exclude: _coffeeB,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _Selector(
                    label: 'Coffee B',
                    selected: _coffeeB,
                    entries: entries,
                    onChanged: (v) => setState(() => _coffeeB = v),
                    exclude: _coffeeA,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_coffeeA != null && _coffeeB != null)
              _ComparisonResult(a: _coffeeA!, b: _coffeeB!)
            else
              const Center(
                child: Text(
                  'Select two coffees to compare',
                  style: TextStyle(color: Colors.white24),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Selector extends StatelessWidget {
  final String label;
  final LocalizedBeanDto? selected;
  final List<LocalizedBeanDto> entries;
  final ValueChanged<LocalizedBeanDto?> onChanged;
  final LocalizedBeanDto? exclude;

  const _Selector({
    required this.label,
    this.selected,
    required this.entries,
    required this.onChanged,
    this.exclude,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<LocalizedBeanDto>(
              isExpanded: true,
              value: selected,
              hint: const Text('Select...', style: TextStyle(fontSize: 12)),
              dropdownColor: const Color(0xFF1A1A1A),
              items: entries
                  .where((e) => e != exclude)
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        '${e.countryEmoji} ${e.country}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonResult extends StatelessWidget {
  final LocalizedBeanDto a;
  final LocalizedBeanDto b;
  const _ComparisonResult({required this.a, required this.b});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          _CompRow(
            'SCA Score',
            a.cupsScore.toString(),
            b.cupsScore.toString(),
            highlightHigher: true,
          ),
          _CompRow('Country', a.country, b.country),
          _CompRow('Region', a.region, b.region),
          _CompRow('Processing', a.processMethod, b.processMethod),
          _CompRow('Altitude', '${a.altitudeMin}m', '${b.altitudeMin}m'),
          _CompRow('Price', a.price ?? 'N/A', b.price ?? 'N/A'),
        ],
      ),
    );
  }
}

class _CompRow extends StatelessWidget {
  final String label, valA, valB;
  final bool highlightHigher;
  const _CompRow(
    this.label,
    this.valA,
    this.valB, {
    this.highlightHigher = false,
  });

  @override
  Widget build(BuildContext context) {
    final numA = double.tryParse(valA) ?? 0;
    final numB = double.tryParse(valB) ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              valA,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: highlightHigher && numA > numB
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: highlightHigher && numA > numB
                    ? const Color(0xFFC8A96E)
                    : Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valB,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: highlightHigher && numB > numA
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: highlightHigher && numB > numA
                    ? const Color(0xFFC8A96E)
                    : Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ─── Detail Grid ─────────────────────────────────────────────────────────────
class _DetailGrid extends ConsumerWidget {
  final LocalizedBeanDto entry;
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
                child: Text(
                  item.$1,
                  style: const TextStyle(fontSize: 12, color: Colors.white38),
                ),
              ),
              Expanded(
                child: Text(
                  item.$2,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}


class OriginDetailsScreen extends ConsumerWidget {
  final LocalizedBeanDto entry;
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
                      Image.network(
                        entry.farmPhotosUrlCover!,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(color: Colors.grey.shade900),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
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
                            data: (brand) => Text(
                              brand?.name.toUpperCase() ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC8A96E),
                                letterSpacing: 2,
                              ),
                            ),
                            loading: () => const SizedBox(),
                            error: (_, _) => const SizedBox(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.region,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${entry.countryEmoji} ${entry.country}',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.black, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class _ProductTab extends ConsumerWidget {
  final LocalizedBeanDto entry;
  const _ProductTab({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _SectionHeader(ref.t('purchase_details')),
        _InfoTile(
          label: ref.t('price'),
          value: (entry.price ?? 'N/A'),
          icon: Icons.payments_outlined,
        ),
        _InfoTile(
          label: ref.t('weight'),
          value: (entry.weight ?? 'N/A'),
          icon: Icons.scale_outlined,
        ),
        _InfoTile(
          label: ref.t('roast_date'),
          value: (entry.roastDate ?? 'N/A'),
          icon: Icons.calendar_today_outlined,
        ),
        _InfoTile(
          label: ref.t('lot_number'),
          value: entry.lotNumber.isEmpty ? 'N/A' : entry.lotNumber,
          icon: Icons.tag,
        ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
      ],
    );
  }
}

class _SourceTab extends ConsumerWidget {
  final LocalizedBeanDto entry;
  const _SourceTab({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _SectionHeader(ref.t('terroir_farm')),
        _InfoTile(
          label: ref.t('region'),
          value: entry.region,
          icon: Icons.location_on_outlined,
        ),
        _InfoTile(
          label: ref.t('altitude'),
          value: '${entry.altitudeMin} - ${entry.altitudeMax}m',
          icon: Icons.height_outlined,
        ),
        _InfoTile(
          label: ref.t('varieties'),
          value: entry.varieties,
          icon: Icons.grass_outlined,
        ),
        _InfoTile(
          label: ref.t('process'),
          value: entry.processMethod,
          icon: Icons.shutter_speed_outlined,
          trailing: _hasLocalizedDescription(entry.processMethod, ref)
              ? IconButton(
                  onPressed: () =>
                      _showLocalizedProcessSheet(context, entry, ref),
                  icon: const Icon(
                    Icons.info_outline,
                    color: Color(0xFFC8A96E),
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              : entry.detailedProcessMarkdown.isNotEmpty
              ? IconButton(
                  onPressed: () => _showProcessDetailSheet(context, entry, ref),
                  icon: const Icon(
                    Icons.info_outline,
                    color: Color(0xFFC8A96E),
                    size: 18,
                  ),
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
        Text(
          _getLocalizedDescription(entry, ref),
          style: const TextStyle(color: Colors.white70, height: 1.6),
        ),
      ],
    );
  }

  String _getLocalizedDescription(LocalizedBeanDto entry, WidgetRef ref) {
    final country = entry.country.toLowerCase();

    // Mad Heads
    if (country.contains('utengule')) {
      return ref.t('lot_desc_tanzania_utengule');
    }
    if (country.contains('alto de osos')) {
      return ref.t('lot_desc_col_alto_osos');
    }
    if (country.contains('frinsa manis')) {
      return ref.t('lot_desc_indonesia_manis');
    }
    if (country.contains('gichathaini')) {
      return ref.t('lot_desc_kenya_gichathaini');
    }

    // 3Champs
    if (country.contains('colombia 46 filter')) {
      return ref.t('lot_desc_col_46_filter');
    }
    if (country.contains('colombia 31 filter')) {
      return ref.t('lot_desc_col_31_filter');
    }
    if (country.contains('kenya 20 filter')) {
      return ref.t('lot_desc_kenya_20_filter');
    }
    if (country.contains('ethiopia 37 filter')) {
      return ref.t('lot_desc_eth_37_filter');
    }
    if (country.contains('colombia 46 espresso')) {
      return ref.t('lot_desc_col_46_espresso');
    }

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
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, i) {
            // Reusing the same card logic as BrewingDetailScreen
            return _RecommendedRecipeCard(recipe: recipes[i]);
          },
        );
      },
    );
  }
}

final lotRecipesProvider =
    FutureProvider.family<List<RecommendedRecipeDto>, int>((ref, lotId) async {
      final db = ref.watch(databaseProvider);
      return db.getRecommendedRecipesForLot(lotId);
    });

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white38,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Widget? trailing;
  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFC8A96E)),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(color: Colors.white54)),
          if (trailing != null) ...[const SizedBox(width: 4), trailing!],
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
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
            Text(
              ref.t('roast_light'),
              style: const TextStyle(fontSize: 10, color: Colors.white38),
            ),
            Text(
              ref.t('roast_medium'),
              style: const TextStyle(fontSize: 10, color: Colors.white38),
            ),
            Text(
              ref.t('roast_dark'),
              style: const TextStyle(fontSize: 10, color: Colors.white38),
            ),
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
        border: Border.all(
          color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: Color(0xFFC8A96E), size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ref.t('cupping_score').toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                score.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                ),
              ),
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
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.coffee_maker, color: const Color(0xFFC8A96E)),
              const SizedBox(width: 12),
              Text(
                recipe.methodKey.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
  final LocalizedBeanDto entry;
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
            SizedBox(height: 200, child: _RadarChart(indicators: indicators)),
            const SizedBox(height: 16),
            _DotScale(
              label: 'Acidity',
              value: (indicators['acidity'] ?? 0).toDouble(),
            ),
            _DotScale(
              label: 'Sweetness',
              value: (indicators['sweetness'] ?? 0).toDouble(),
            ),
            _DotScale(
              label: 'Bitterness',
              value: (indicators['bitterness'] ?? 0).toDouble(),
            ),
            _DotScale(
              label: 'Intensity',
              value: (indicators['intensity'] ?? 0).toDouble(),
            ),
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
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white38),
            ),
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
                border: filled
                    ? null
                    : Border.all(color: Colors.white24, width: 0.5),
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
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 12, color: Colors.white38),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

void _showProcessDetailSheet(
  BuildContext context,
  LocalizedBeanDto entry,
  WidgetRef ref,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.history_edu, color: Color(0xFFC8A96E)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ref.t('process_detail').toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              entry.processMethod.toUpperCase(),
              style: const TextStyle(
                color: Colors.white38,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
          ),
          const Divider(height: 32, color: Colors.white10),
          Expanded(
            child: Markdown(
              controller: scrollController,
              data: _translateDetailedDescription(entry, ref),
              styleSheet: MarkdownStyleSheet(
                h3: GoogleFonts.poppins(
                  color: const Color(0xFFC8A96E),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                p: const TextStyle(
                  color: Colors.white70,
                  height: 1.6,
                  fontSize: 14,
                ),
                listBullet: const TextStyle(color: Color(0xFFC8A96E)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String _translateDetailedDescription(LocalizedBeanDto entry, WidgetRef ref) {
  final p = entry.processMethod.toLowerCase();
  if (p.contains('natural') || p.contains('натур')) {
    return ref.t('process_natural_desc');
  }
  if (p.contains('washed') || p.contains('мит')) {
    return ref.t('process_washed_desc');
  }
  if (p.contains('anaerobic') || p.contains('анаероб')) {
    return ref.t('process_anaerobic_desc');
  }
  if (p.contains('thermal') || p.contains('термал')) {
    return ref.t('process_thermal_desc');
  }
  if (p.contains('honey') || p.contains('хані')) {
    return ref.t('process_honey_desc');
  }
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
              RadarEntry(
                value: (indicators['acidity'] as num? ?? 0).toDouble(),
              ),
              RadarEntry(
                value: (indicators['sweetness'] as num? ?? 0).toDouble(),
              ),
              RadarEntry(
                value: (indicators['bitterness'] as num? ?? 0).toDouble(),
              ),
              RadarEntry(
                value: (indicators['intensity'] as num? ?? 0).toDouble(),
              ),
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
            case 0:
              return RadarChartTitle(
                text: ref.t('acidity').toUpperCase(),
                angle: 0,
              );
            case 1:
              return RadarChartTitle(
                text: ref.t('sweetness').toUpperCase(),
                angle: 0,
              );
            case 2:
              return RadarChartTitle(
                text: ref.t('bitterness').toUpperCase(),
                angle: 0,
              );
            case 3:
              return RadarChartTitle(
                text: ref.t('intensity').toUpperCase(),
                angle: 0,
              );
            case 4:
              return RadarChartTitle(
                text: ref.t('body').toUpperCase(),
                angle: 0,
              );
            default:
              return const RadarChartTitle(text: '');
          }
        },
        titleTextStyle: const TextStyle(
          color: Colors.white38,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

bool _hasLocalizedDescription(String process, WidgetRef ref) {
  final p = process.toLowerCase();
  return p.contains('natural') ||
      p.contains('натур') ||
      p.contains('washed') ||
      p.contains('мит') ||
      p.contains('anaerobic') ||
      p.contains('анаероб') ||
      p.contains('thermal') ||
      p.contains('термал') ||
      p.contains('honey') ||
      p.contains('хані');
}

void _showLocalizedProcessSheet(
  BuildContext context,
  LocalizedBeanDto entry,
  WidgetRef ref,
) {
  final description = _getLocalizedDetailedProcess(entry.processMethod, ref);
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
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
                Text(
                  ref.t('process_detail').toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC8A96E),
                    letterSpacing: 1.2,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
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
                      p: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                      ),
                      h3: GoogleFonts.poppins(
                        color: const Color(0xFFC8A96E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
  if (p.contains('natural') || p.contains('натур')) {
    return ref.t('process_natural_desc');
  }
  if (p.contains('washed') || p.contains('мит')) {
    return ref.t('process_washed_desc');
  }
  if (p.contains('anaerobic') || p.contains('анаероб')) {
    return ref.t('process_anaerobic_desc');
  }
  if (p.contains('thermal') || p.contains('термал')) {
    return ref.t('process_thermal_desc');
  }
  return ''; // Fallback
}
