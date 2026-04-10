import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import 'glass_container.dart';
import 'sensory_radar_chart.dart';
import '../../features/brewing/custom_recipe_form.dart';

class LotDetailView extends ConsumerStatefulWidget {
  final EncyclopediaEntry entry;
  const LotDetailView({super.key, required this.entry});

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
    final theme = Theme.of(context);
    final gold = const Color(0xFFC8A96E);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header ───────────────────────────────────────────────────────────
        _buildHeader(theme),
        const SizedBox(height: 16),

        // ── Tabs Header ──────────────────────────────────────────────────────
        TabBar(
          controller: _tabController,
          indicatorColor: gold,
          labelColor: gold,
          unselectedLabelColor: Colors.white38,
          labelStyle: GoogleFonts.outfit(
              fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
          tabs: [
            Tab(text: ref.t('description').toUpperCase()),
            Tab(text: ref.t('sensory').toUpperCase()),
            Tab(text: ref.t('recipes').toUpperCase()),
          ],
        ),

        const SizedBox(height: 20),

        // ── Tab Views ────────────────────────────────────────────────────────
        SizedBox(
          height: 500, // Fixed height for content or auto-expanding
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDescriptionTab(theme),
              _buildSensoryTab(theme),
              _buildRecipesTab(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF88DDEE).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.entry.processMethod.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF88DDEE),
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.entry.fullDisplayName.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _ScaBadge(score: widget.entry.scaScore, theme: theme),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionTab(ThemeData theme) {
    final pTable = widget.entry.pricing;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(16),
            opacity: 0.04,
            child: Column(
              children: [
                _SpecRow(
                    label1: ref.t('varieties'),
                    value1: widget.entry.varieties,
                    label2: ref.t('altitude'),
                    value2:
                        '${widget.entry.altitudeMin ?? '?'}-${widget.entry.altitudeMax ?? '?'} m'),
                const Divider(
                    height: 24, thickness: 0.5, color: Colors.white10),
                _SpecRow(
                    label1: "LOT #",
                    value1: widget.entry.lotNumber,
                    label2: ref.t('roast_level'),
                    value2: widget.entry.roastLevel),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(title: ref.t('pricing'), theme: theme),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                pTable['retail_250']?.toString() ?? '?',
                style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text("₴",
                  style: GoogleFonts.outfit(fontSize: 24, color: Colors.white)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        pTable['wholesale_1k']?.toString() ?? '?',
                        style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38),
                      ),
                      const SizedBox(width: 2),
                      Text("₴",
                          style: GoogleFonts.outfit(
                              fontSize: 14, color: Colors.white38)),
                    ],
                  ),
                  Text(
                    ref.t('wholesale').toUpperCase(),
                    style: GoogleFonts.outfit(
                        fontSize: 8,
                        color: Colors.white24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle(title: ref.t('description'), theme: theme),
          const SizedBox(height: 8),
          Text(
            widget.entry.description,
            style: GoogleFonts.outfit(
                fontSize: 13, height: 1.5, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSensoryTab(ThemeData theme) {
    final sPoints = widget.entry.sensoryPoints;

    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: SensoryRadarChart(
              interactive: false,
              staticValues: widget.entry.sensoryPoints.map((k, v) => MapEntry(
                  k, (v as num).toDouble() / 5.0)), // Scale 1-5 instead of 1-10
            ),
          ),
          const SizedBox(height: 32),

          // ── Sensory Grid ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('aroma'),
                            points: (sPoints['aroma'] as num? ?? 0).toInt(),
                            theme: theme)),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('flavor'),
                            points: (sPoints['flavor'] as num? ?? 0).toInt(),
                            theme: theme)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('acidity'),
                            points: (sPoints['acidity'] as num? ?? 0).toInt(),
                            theme: theme)),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('body'),
                            points: (sPoints['body'] as num? ?? 0).toInt(),
                            theme: theme)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('aftertaste'),
                            points: (sPoints['aftertaste'] as num? ?? 0).toInt(),
                            theme: theme)),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _SensoryPointBar(
                            label: ref.t('balance'),
                            points: (sPoints['balance'] as num? ?? 0).toInt(),
                            theme: theme)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRecipesTab(ThemeData theme) {
    return FutureBuilder<List<RecommendedRecipeDto>>(
      future: ref
          .read(databaseProvider)
          .getRecommendedRecipesForLot(widget.entry.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final recipes = snapshot.data!;

        return Column(
          children: [
            if (recipes.isEmpty)
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("No recipes added to this lot yet.",
                    style: TextStyle(color: Colors.white24)),
              )),
            ...recipes.map((r) => _RecipeCard(recipe: r, theme: theme)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomRecipeFormScreen(
                        methodKey: 'v60',
                        lotId: widget.entry.id.toString(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Custom Recipe"),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      theme.colorScheme.primary.withValues(alpha: 0.1),
                  foregroundColor: theme.colorScheme.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Shared Helper Components ────────────────────────────────────────────────

class _ScaBadge extends StatelessWidget {
  final String score;
  final ThemeData theme;
  const _ScaBadge({required this.score, required this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Text("SCA",
            style: GoogleFonts.outfit(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary)),
        Text(score,
            style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ]),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;
  const _SectionTitle({required this.title, required this.theme});
  @override
  Widget build(BuildContext context) {
    return Text(title.toUpperCase(),
        style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
            letterSpacing: 1));
  }
}

class _SpecRow extends StatelessWidget {
  final String label1, value1, label2, value2;
  const _SpecRow(
      {required this.label1,
      required this.value1,
      required this.label2,
      required this.value2});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: _SpecItem(label: label1, value: value1)),
      const SizedBox(width: 16),
      Expanded(child: _SpecItem(label: label2, value: value2)),
    ]);
  }
}

class _SpecItem extends StatelessWidget {
  final String label, value;
  const _SpecItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label.toUpperCase(),
          style: GoogleFonts.outfit(
              fontSize: 9, color: Colors.white38, fontWeight: FontWeight.bold)),
      const SizedBox(height: 2),
      Text(value,
          style: GoogleFonts.outfit(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w500)),
    ]);
  }
}

// ── Shared Helper Components ────────────────────────────────────────────────

class _SensoryPointBar extends StatelessWidget {
  final String label;
  final num points;
  final ThemeData theme;
  const _SensoryPointBar(
      {required this.label, required this.points, required this.theme});
  @override
  Widget build(BuildContext context) {
    final cyan = const Color(0xFF88DDEE);
    // Auto-scaling: round to nearest integer (1-5)
    final int intValue = (points > 5 ? points / 2.0 : points.toDouble())
        .round()
        .toInt()
        .clamp(0, 5);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(),
                  style: GoogleFonts.outfit(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      color: Colors.white38,
                      fontWeight: FontWeight.bold)),
              Text("$intValue / 5",
                  style: GoogleFonts.outfit(
                      fontSize: 10, color: cyan, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (i) {
              final bool isActive = i < intValue;

              return Expanded(
                child: Container(
                  height: 2,
                  margin: EdgeInsets.only(right: i == 4 ? 0 : 4),
                  decoration: BoxDecoration(
                    color:
                        isActive ? cyan : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final RecommendedRecipeDto recipe;
  final ThemeData theme;
  const _RecipeCard({required this.recipe, required this.theme});
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      opacity: 0.05,
      child: Row(children: [
        Icon(Icons.coffee_maker, color: theme.colorScheme.primary, size: 30),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(recipe.methodKey.toUpperCase(),
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          Text("${recipe.coffeeGrams}g / ${recipe.waterGrams}ml",
              style: TextStyle(fontSize: 12, color: Colors.white38)),
        ]),
        const Spacer(),
        Text("${recipe.rating}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Icon(Icons.star, size: 14, color: Colors.amber),
      ]),
    );
  }
}
