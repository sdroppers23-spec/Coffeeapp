import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import 'glass_container.dart';
import 'sensory_radar_chart.dart';
import '../../features/brewing/widgets/custom_recipe_card.dart';

class LotDetailView extends ConsumerStatefulWidget {
  final CoffeeLotDto? lot;
  final EncyclopediaEntry? entry;

  const LotDetailView({
    super.key,
    this.lot,
    this.entry,
  }) : assert(lot != null || entry != null, 'Either lot or entry must be provided');

  @override
  ConsumerState<LotDetailView> createState() => _LotDetailViewState();
}

class _LotDetailViewState extends ConsumerState<LotDetailView>
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
    final isUk = LocaleService.currentLocale == 'uk';
    final theme = Theme.of(context);
    
    // Normalize data from either lot or entry
    final String coffeeName = widget.lot?.coffeeName ?? widget.entry?.fullDisplayName ?? 'Unnamed';
    final String roasteryName = widget.lot?.roasteryName ?? 'Specialty Roaster';
    final String? imageUrl = widget.lot?.brandId != null ? null : widget.entry?.imageUrl;
    final Map<String, dynamic> points = widget.lot?.sensoryPoints ?? widget.entry?.sensoryPoints ?? {};

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          children: [
            // Top Image Area
            Stack(
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.black12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                if (widget.lot != null)
                  Positioned(
                    top: 50,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Vibration.vibrate(duration: 50);
                        // Using go_router to navigate to edit lot
                        context.push('/edit_lot', extra: widget.lot);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                        ),
                        child: Icon(Icons.edit_rounded, color: theme.colorScheme.primary, size: 20),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roasteryName.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: theme.colorScheme.primary.withValues(alpha: 0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coffeeName,
                        style: GoogleFonts.cormorantGaramond(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Tabs
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: Colors.white24,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
              tabs: [
                Tab(text: isUk ? 'ІНФО' : 'INFO'),
                Tab(text: isUk ? 'ПРОФІЛЬ' : 'PROFILE'),
                Tab(text: isUk ? 'РЕЦЕПТИ' : 'RECIPES'),
              ],
            ),
            
            const SizedBox(height: 10),
            
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _InfoTab(lot: widget.lot, entry: widget.entry),
                  _SensoryTab(points: points, isUk: isUk),
                  _RecipesTab(lotId: widget.lot?.id ?? widget.entry?.lotNumber ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends ConsumerWidget {
  final CoffeeLotDto? lot;
  final EncyclopediaEntry? entry;

  const _InfoTab({this.lot, this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = ref.watch(localeProvider) == 'uk';
    final String region = lot?.region ?? entry?.region ?? 'Unknown';
    final String? altitude = lot?.altitude ?? (entry?.altitudeMin != null ? '${entry!.altitudeMin}-${entry!.altitudeMax}m' : null);
    final String varieties = lot?.varieties ?? entry?.varieties ?? 'Unknown';
    final String process = lot?.process ?? entry?.processMethod ?? 'Unknown';
    final String? description = lot?.flavorProfile ?? entry?.description;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(title: isUk ? 'ТЕХНІЧНІ ХАРАКТЕРИСТИКИ' : 'TECHNICAL SPECS', isUk: isUk),
              _InfoRow(label: isUk ? 'Регіон' : 'Region', value: region),
              if (altitude != null) _InfoRow(label: isUk ? 'Висота' : 'Altitude', value: altitude),
              _InfoRow(label: isUk ? 'Сорт' : 'Variety', value: varieties),
              _InfoRow(label: isUk ? 'Обробка' : 'Process', value: process),
              if (entry?.harvestSeason != null) _InfoRow(label: isUk ? 'Врожай' : 'Harvest', value: entry!.harvestSeason!),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (description != null && description.isNotEmpty) ...[
          _SectionTitle(title: isUk ? 'ОПИС СМАКУ' : 'FLAVOR PROFILE', isUk: isUk),
          Text(
            description,
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
        ],
        const SizedBox(height: 100),
      ],
    );
  }
}

class _SensoryTab extends StatelessWidget {
  final Map<String, dynamic> points;
  final bool isUk;

  const _SensoryTab({required this.points, required this.isUk});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 350,
            child: SensoryRadarChart(
              interactive: false,
              height: 350,
              staticValues: points.map(
                (k, v) => MapEntry(k, (v as num).toDouble()),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _RecipesTab extends ConsumerWidget {
  final String lotId;

  const _RecipesTab({required this.lotId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = ref.watch(localeProvider) == 'uk';
    final db = ref.watch(databaseProvider);
    final theme = Theme.of(context);
    
    return StreamBuilder<List<CustomRecipeDto>>(
      stream: db.watchCustomRecipesForLot(lotId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final recipes = snapshot.data ?? [];

        if (recipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.coffee_maker_outlined, color: Colors.white10, size: 64),
                const SizedBox(height: 16),
                Text(
                  isUk ? 'НЕМАЄ РЕЦЕПТІВ ДЛЯ ЦЬОГО ЛОТУ' : 'NO RECIPES FOR THIS LOT',
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Vibration.vibrate(duration: 50);
                    // Navigate to add recipe screen
                    context.push('/custom_recipe_form', extra: {'lotId': lotId});
                  },
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(isUk ? 'ДОДАТИ РЕЦЕПТ' : 'ADD RECIPE'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.black,
                    textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: recipes.length + 1,
          itemBuilder: (context, index) {
            if (index == recipes.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: TextButton.icon(
                    onPressed: () => context.push('/custom_recipe_form', extra: {'lotId': lotId}),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(isUk ? 'ДОДАТИ ЩЕ ОДИН' : 'ADD ANOTHER ONE'),
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomRecipeCard(
                recipe: recipes[index],
                methodKey: recipes[index].methodKey,
                ref: ref,
              ),
            );
          },
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isUk;

  const _SectionTitle({required this.title, required this.isUk});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: const Color(0xFFC8A96E),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
