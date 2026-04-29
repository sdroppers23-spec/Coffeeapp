import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/sensory_radar_chart.dart';
import '../navigation/navigation_providers.dart';

import '../../shared/widgets/recipe_type_bottom_sheet.dart';
import '../../core/database/database_provider.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../shared/widgets/lot_detail_widgets.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/preferences_provider.dart';

class CustomLotDetailScreen extends ConsumerStatefulWidget {
  final CoffeeLotDto lot;
  const CustomLotDetailScreen({super.key, required this.lot});

  @override
  ConsumerState<CustomLotDetailScreen> createState() =>
      _CustomLotDetailScreenState();
}

class _CustomLotDetailScreenState extends ConsumerState<CustomLotDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Hide nav bar while viewing details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Restore nav bar when leaving
    Future.microtask(() {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lot = widget.lot;

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
          (lot.coffeeName ?? lot.id).toUpperCase(),
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
            // Image Header or Placeholder
            Stack(
              children: [
                Hero(
                  tag: 'lot_image_${lot.id}',
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: lot.imageUrl != null && lot.imageUrl!.isNotEmpty
                          ? (lot.imageUrl!.startsWith('http')
                                ? DecorationImage(
                                    image: NetworkImage(lot.imageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: FileImage(File(lot.imageUrl!)),
                                    fit: BoxFit.cover,
                                  ))
                          : null,
                    ),
                    child: lot.imageUrl == null || lot.imageUrl!.isEmpty
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
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (lot.roasteryName != null)
                        Text(
                          lot.roasteryName!.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        (lot.coffeeName ?? lot.id).toUpperCase(),
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
                          if (lot.scaScore != null)
                            LotBadge(
                              label: '${lot.scaScore} SCA',
                              theme: theme,
                            ),
                          if (lot.roastLevel != null) ...[
                            const SizedBox(width: 8),
                            LotBadge(
                              label: lot.roastLevel!.toUpperCase(),
                              theme: theme,
                              isPrimary: true,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

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
              labelStyle: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _InfoTab(lot: lot),
                  _ProfileTab(lot: lot),
                  _RecipesTab(lot: lot),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipesTab extends ConsumerStatefulWidget {
  final CoffeeLotDto lot;
  const _RecipesTab({required this.lot});

  @override
  ConsumerState<_RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends ConsumerState<_RecipesTab> {
  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);

    return FutureBuilder<List<CustomRecipeDto>>(
      future: db.getCustomRecipesForLot(widget.lot.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final recipes = snapshot.data ?? [];
        final limitReached = recipes.length >= 10;

        return Column(
          children: [
            Expanded(
              child: recipes.isEmpty
                  ? Center(
                      child: Text(
                        ref.t('no_recipes_for_lot'),
                        style: GoogleFonts.outfit(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipes[index];
                        return _buildRecipeCard(recipe);
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  if (limitReached)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        ref.t('recipe_limit_reached'),
                        style: GoogleFonts.outfit(
                          color: Colors.redAccent.withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: PressableScale(
                      onTap: limitReached
                          ? null
                          : () async {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (ctx) => RecipeTypeBottomSheet(
                                  title: ref.t('choose_brewing_type'),
                                  onTypeSelected: (type) async {
                                    Navigator.pop(ctx);
                                    final result = await showDialog(
                                      context: context,
                                      builder: (context) => AddRecipeDialog(
                                        lotId: widget.lot.id,
                                        initialMethod: type == 'espresso'
                                            ? 'espresso'
                                            : 'v60',
                                      ),
                                    );
                                    if (result == true) setState(() {});
                                  },
                                ),
                              );
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: limitReached
                              ? Colors.white10
                              : const Color(0xFFC8A96E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            ref.t('add_recipe').toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: limitReached
                                  ? Colors.white24
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecipeCard(CustomRecipeDto recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        borderRadius: 20,
        opacity: 0.1,
        blur: 20,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.coffee_maker_outlined,
                color: Color(0xFFC8A96E),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.methodKey.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFC8A96E),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < recipe.rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 14,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe.name,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${recipe.coffeeGrams}g / ${recipe.totalWaterMl}ml • ${_formatTemp(ref, recipe.brewTempC)}',
                    style: GoogleFonts.outfit(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white24,
                size: 20,
              ),
              onPressed: () async {
                final confirmed = await _showDeleteRecipeConfirmation(recipe);
                if (confirmed) {
                  await ref
                      .read(databaseProvider)
                      .deleteCustomRecipe(recipe.id);
                  if (mounted) setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteRecipeConfirmation(CustomRecipeDto recipe) async {
    final isUk = LocaleService.currentLocale == 'uk';
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.8),
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: GlassContainer(
                borderRadius: 40,
                padding: const EdgeInsets.all(32),
                opacity: 0.12,
                blur: 35,
                borderColor: Colors.white.withValues(alpha: 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.delete_sweep_rounded,
                        size: 40,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      isUk ? 'ВИДАЛИТИ РЕЦЕПТ?' : 'DELETE RECIPE?',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isUk
                          ? 'Ви впевнені, що хочете видалити рецепт "${recipe.name}"?'
                          : 'Are you sure you want to delete the recipe "${recipe.name}"?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white60,
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGlassDialogButton(
                            label: isUk ? 'СКАСУВАТИ' : 'CANCEL',
                            onTap: () => Navigator.pop(context, false),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildGlassDialogButton(
                            label: isUk ? 'ВИДАЛИТИ' : 'DELETE',
                            onTap: () {
                              ref
                                  .read(settingsProvider.notifier)
                                  .triggerHeavyVibrate();
                              Navigator.pop(context, true);
                            },
                            color: Colors.redAccent,
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  Widget _buildGlassDialogButton({
    required String label,
    required VoidCallback onTap,
    required Color color,
    bool isPrimary = false,
  }) {
    return PressableScale(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        onTap();
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: isPrimary
                ? color.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: isPrimary
                  ? color.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.08),
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  color: isPrimary ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTab extends ConsumerWidget {
  final CoffeeLotDto lot;
  const _InfoTab({required this.lot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navHeight = ref.watch(navBarHeightProvider);

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
                      label: ref.t('roastery'),
                      value: lot.roasteryName ?? 'N/A',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  Expanded(
                    child: LotCompactStat(
                      label: ref.t('origin'),
                      value: lot.originCountry ?? 'N/A',
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
                      value: lot.process ?? 'N/A',
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
                      value: lot.scaScore ?? 'N/A',
                    ),
                  ),
                ],
              ),
              if (lot.region?.isNotEmpty ?? false) ...[
                const Divider(height: 24, color: Colors.white10),
                LotCompactStat(label: ref.t('region'), value: lot.region!),
              ],
              if (lot.altitude?.isNotEmpty ?? false) ...[
                const Divider(height: 24, color: Colors.white10),
                LotCompactStat(
                  label: ref.t('altitude'),
                  value: _formatAltitude(ref, lot.altitude!),
                ),
              ],
              if (lot.varieties?.isNotEmpty ?? false) ...[
                const Divider(height: 24, color: Colors.white10),
                LotCompactStat(
                  label: ref.t('varieties'),
                  value: lot.varieties!,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (lot.flavorProfile?.isNotEmpty ?? false) ...[
          Text(
            ref.t('flavor_profile').toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            lot.flavorProfile!,
            style: GoogleFonts.outfit(
              fontSize: 13,
              height: 1.5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 24),
        ],

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
        LotDetailRow(
          label: ref.t('lot_number_label'),
          value: lot.lotNumber ?? 'N/A',
        ),
        LotDetailRow(label: ref.t('weight'), value: lot.weight ?? 'N/A'),
        LotDetailRow(
          label: ref.t('roast_level'),
          value: lot.roastLevel ?? 'N/A',
        ),
        LotDetailRow(label: ref.t('farm'), value: lot.farm ?? 'N/A'),
        LotDetailRow(
          label: ref.t('wash_station'),
          value: lot.washStation ?? 'N/A',
        ),
        LotDetailRow(label: ref.t('farmer'), value: lot.farmer ?? 'N/A'),
      ],
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  final CoffeeLotDto lot;
  const _ProfileTab({required this.lot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navHeight = ref.watch(navBarHeightProvider);

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, navHeight + 100),
      children: [
        SizedBox(
          height: 400,
          child: SensoryRadarChart(
            interactive: false,
            staticValues: lot.sensoryPoints.map((k, v) {
              final val = (v as num).toDouble();
              // Round to 1-5 scale, then map to 0.2-1.0
              final normalized = (val > 5 ? val / 2.0 : val).round().clamp(
                1,
                5,
              );
              return MapEntry(k, normalized / 5.0);
            }),
            height: 400,
          ),
        ),
        Text(
          ref.t('sensory_profile_header').toUpperCase(),
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
          value: lot.sensoryPoints['bitterness'] != null
              ? (lot.sensoryPoints['bitterness'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('acidity'),
          value: lot.sensoryPoints['acidity'] != null
              ? (lot.sensoryPoints['acidity'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('sweetness'),
          value: lot.sensoryPoints['sweetness'] != null
              ? (lot.sensoryPoints['sweetness'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('body'),
          value: lot.sensoryPoints['body'] != null
              ? (lot.sensoryPoints['body'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('intensity'),
          value: lot.sensoryPoints['intensity'] != null
              ? (lot.sensoryPoints['intensity'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        SensoryIndicator(
          label: ref.t('aftertaste'),
          value: lot.sensoryPoints['aftertaste'] != null
              ? (lot.sensoryPoints['aftertaste'] as num).toDouble() / 5.0
              : 0.2,
          color: const Color(0xFFC8A96E),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

String _formatTemp(WidgetRef ref, double celsius) {
  final pref = ref.watch(preferencesProvider);
  if (pref.tempUnit == TempUnit.fahrenheit) {
    final f = (celsius * 9 / 5) + 32;
    return '${f.toStringAsFixed(0)}°F';
  }
  return '${celsius.toStringAsFixed(0)}°C';
}

String _formatAltitude(WidgetRef ref, String altitude) {
  final pref = ref.watch(preferencesProvider);
  if (pref.lengthUnit == LengthUnit.meters) return '$altitude m';

  // Try to parse range like "1200-1500" or single value "1200"
  try {
    final parts = altitude
        .split('-')
        .map((s) => s.trim().replaceAll(RegExp(r'[^0-9]'), ''))
        .toList();
    if (parts.isEmpty) return altitude;

    final converted = parts
        .map((p) {
          final val = int.tryParse(p);
          if (val == null) return p;
          return (val * 3.28084).toStringAsFixed(0);
        })
        .join('-');

    return '$converted ft';
  } catch (e) {
    return altitude;
  }
}
