import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../utils/sensory_utils.dart';
import 'glass_container.dart';
import 'sensory_radar_chart.dart';
import 'sensory_preview.dart';
import 'lot_detail_widgets.dart';
import '../../features/brewing/widgets/custom_recipe_card.dart';
import '../../shared/models/processing_methods_repository.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LotDetailView extends ConsumerStatefulWidget {
  final CoffeeLotDto? lot;
  final EncyclopediaEntry? entry;
  final String? heroTag;

  const LotDetailView({
    super.key,
    this.lot,
    this.entry,
    this.heroTag,
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
    _tabController.addListener(() {
      if (_tabController.indexIsChanging || !_tabController.indexIsChanging) {
        setState(() {}); // Required to update header based on tab
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    // Reactively watch for updates if we have IDs
    final lotAsync = widget.lot != null ? ref.watch(lotProvider(widget.lot!.id)) : const AsyncValue.data(null);
    final beanAsync = widget.entry != null ? ref.watch(beanProvider(widget.entry!.id)) : const AsyncValue.data(null);

    return lotAsync.when(
      loading: () => const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(backgroundColor: Colors.black, body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white)))),
      data: (liveLot) {
        return beanAsync.when(
          loading: () => const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator())),
          error: (e, s) => Scaffold(backgroundColor: Colors.black, body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white)))),
          data: (liveBean) {
            // Priority: Live Data -> Widget Extra (Fallback)
            final String coffeeName = liveLot?.coffeeName ?? liveBean?.varieties ?? widget.lot?.coffeeName ?? widget.entry?.fullDisplayName ?? 'Unnamed';
            final String roasteryName = liveLot?.roasteryName ?? 'Specialty Roaster';
            
            // Priority: Live Lot Image -> Live Bean Image -> Entry Image -> Flag Fallback
            final String? imageUrl = liveLot?.imageUrl ?? liveBean?.farmPhotosUrlCover ?? widget.lot?.imageUrl ?? widget.entry?.imageUrl;
            
            // Map sensory points using the shared utility
            final rawPoints = liveLot?.sensoryPoints ?? liveBean?.sensoryPoints ?? widget.lot?.sensoryPoints ?? widget.entry?.sensoryPoints ?? {};
            final mappedPoints = SensoryUtils.map4To6Axis(rawPoints);

            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [theme.colorScheme.surface, Colors.black],
                  ),
                ),
                child: Column(
                  children: [
                    _DetailHeader(
                      coffeeName: coffeeName,
                      roasteryName: roasteryName,
                      imageUrl: imageUrl,
                      lot: liveLot ?? widget.lot,
                      bean: liveBean ?? widget.entry,
                      heroTag: widget.heroTag,
                      isImageVisible: _tabController.index < 2, // Hide on Recipes tab
                      onBack: () => Navigator.pop(context),
                      isFavorite: liveLot?.isFavorite ?? liveBean?.isFavorite ?? false,
                      onToggleFavorite: () async {
                        final db = ref.read(databaseProvider);
                        if (liveLot != null) {
                          await db.toggleLotFavorite(liveLot.id, !liveLot.isFavorite);
                        } else if (liveBean != null) {
                          await db.toggleFavorite(liveBean.id, !liveBean.isFavorite);
                        }
                        if (!kIsWeb && !Platform.isWindows) {
                          await Vibration.vibrate(duration: 50);
                        }
                      },
                      onEdit: liveLot != null ? () {
                        if (!kIsWeb && !Platform.isWindows) {
                          Vibration.vibrate(duration: 50);
                        }
                        context.push('/edit_lot', extra: liveLot);
                      } : null,
                    ),
                    TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      indicatorColor: theme.colorScheme.primary,
                      labelColor: theme.colorScheme.primary,
                      unselectedLabelColor: Colors.white24,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2),
                      tabs: [
                        Tab(text: ref.t('tab_info')),
                        Tab(text: ref.t('tab_sensory')),
                        Tab(text: ref.t('tab_recipes')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _InfoTab(lot: liveLot ?? widget.lot, bean: liveBean ?? widget.entry),
                          _SensoryTab(points: mappedPoints, isUk: isUk),
                          _RecipesTab(lotId: liveLot?.id ?? widget.lot?.id ?? widget.entry?.lotNumber ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: _tabController.index == 2 ? Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 8),
                child: FloatingActionButton.extended(
                  onPressed: () => _showRecipeTypeSelector(context, ref, liveLot?.id ?? widget.lot!.id),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black,
                  label: Text(
                    ref.t("add_recipe"),
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ) : null,
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            );
          },
        );
      },
    );
  }

  void _showRecipeTypeSelector(BuildContext context, WidgetRef ref, String lotId) async {
    final isUk = LocaleService.currentLocale == 'uk';
    final db = ref.read(databaseProvider);
    final recipes = await db.getCustomRecipesForLot(lotId);
    
    final espressoCount = recipes.where((r) => r.recipeType == 'espresso').length;
    final filterCount = recipes.where((r) => r.recipeType == 'filter').length;

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => GlassContainer(
        padding: const EdgeInsets.all(24),
        borderRadius: 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 24),
            Text(
              isUk ? 'Оберіть тип рецепту' : 'Select recipe type',
              style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFC8A96E), letterSpacing: 2),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _RecipeTypeCard(
                    title: isUk ? 'Фільтр' : 'Filter',
                    icon: Icons.coffee_rounded,
                    count: filterCount,
                    isLimitReached: filterCount >= 10,
                    onTap: () {
                      Navigator.pop(ctx);
                      context.push('/custom_recipe_form', extra: {
                        'lotId': lotId,
                        'methodKey': 'v60',
                        'recipeType': 'filter',
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _RecipeTypeCard(
                    title: isUk ? 'Еспресо' : 'Espresso',
                    icon: Icons.coffee_maker_rounded,
                    count: espressoCount,
                    isLimitReached: espressoCount >= 10,
                    onTap: () {
                      Navigator.pop(ctx);
                      context.push('/custom_recipe_form', extra: {
                        'lotId': lotId,
                        'methodKey': 'espresso',
                        'recipeType': 'espresso',
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _RecipeTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final bool isLimitReached;
  final VoidCallback onTap;

  const _RecipeTypeCard({
    required this.title,
    required this.icon,
    required this.count,
    required this.isLimitReached,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    return GestureDetector(
      onTap: isLimitReached ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isLimitReached 
              ? Colors.red.withValues(alpha: 0.3)
              : theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon, 
              color: isLimitReached ? Colors.red.withValues(alpha: 0.5) : theme.colorScheme.primary, 
              size: 32
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 14, 
                fontWeight: FontWeight.bold, 
                color: isLimitReached ? Colors.white24 : Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count / 10',
              style: GoogleFonts.outfit(
                fontSize: 11, 
                color: isLimitReached ? Colors.redAccent : Colors.white38,
              ),
            ),
            if (isLimitReached) ...[
              const SizedBox(height: 8),
              Text(
                isUk ? 'ЛІМІТ' : 'LIMIT',
                style: GoogleFonts.outfit(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final String coffeeName;
  final String roasteryName;
  final String? imageUrl;
  final CoffeeLotDto? lot;
  final LocalizedBeanDto? bean;
  final String? heroTag;
  final bool isImageVisible;
  final VoidCallback onBack;
  final VoidCallback? onEdit;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  const _DetailHeader({
    required this.coffeeName,
    required this.roasteryName,
    this.imageUrl,
    this.lot,
    this.bean,
    this.heroTag,
    this.isImageVisible = true,
    required this.onBack,
    this.onEdit,
    this.isFavorite = false,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Flag fallback logic
    final effectiveImageUrl = (imageUrl != null && imageUrl!.isNotEmpty) 
        ? imageUrl 
        : (lot?.effectiveFlagUrl ?? bean?.effectiveFlagUrl);
    final hasImage = isImageVisible && effectiveImageUrl != null && effectiveImageUrl.isNotEmpty;

    return Stack(
      children: [
        Hero(
          tag: heroTag ?? 'default_lot_hero_${lot?.id ?? coffeeName}',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isImageVisible ? 320 : 160,
            width: double.infinity,
            decoration: BoxDecoration(
              image: hasImage 
                  ? (effectiveImageUrl.startsWith('http') 
                      ? DecorationImage(image: CachedNetworkImageProvider(effectiveImageUrl), fit: BoxFit.cover)
                      : DecorationImage(image: FileImage(File(effectiveImageUrl)), fit: BoxFit.cover))
                  : null,
              color: Colors.black12,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withValues(alpha: 0.2), Colors.black],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle, border: Border.all(color: Colors.white10)),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            ),
          ),
        ),
        if (onEdit != null)
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: onEdit,
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
        if (onToggleFavorite != null)
          Positioned(
            top: 50,
            right: onEdit != null ? 70 : 20,
            child: GestureDetector(
              onTap: onToggleFavorite,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(color: isFavorite ? Colors.red.withValues(alpha: 0.3) : Colors.white10),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 20,
                ),
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
                  letterSpacing: 2
                ),
              ),
              const SizedBox(height: 8),
              Text(
                coffeeName,
                style: GoogleFonts.cormorantGaramond(
                  color: Colors.white, 
                  fontSize: 36, 
                  fontWeight: FontWeight.bold,
                  height: 1.1, // Better spacing for multi-line
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTab extends ConsumerWidget {
  final CoffeeLotDto? lot;
  final LocalizedBeanDto? bean;

  const _InfoTab({super.key, this.lot, this.bean});

  void _showProcessInfoSheet(BuildContext context, WidgetRef ref, String process) {
    final isUk = LocaleService.currentLocale == 'uk';
    final method = ProcessingMethodsRepository.getByMatchingName(process);
    
    final String title = method != null 
        ? ref.t(method.nameKey) 
        : process;
        
    final String description = method?.extendedInfoKey != null
        ? ref.t(method!.extendedInfoKey!)
        : (method != null ? ref.t(method.descKey) : (isUk 
            ? 'Детальна інформація про цей метод обробки поки відсутня в нашому довіднику.'
            : 'Detailed information about this process is not yet available in our guide.'));

    final String? characters = method?.characterKey != null
        ? ref.t(method!.characterKey!)
        : null;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => GlassContainer(
          padding: const EdgeInsets.all(24),
          borderRadius: 32,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                title.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              if (characters != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    characters.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFC8A96E),
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const Divider(color: Colors.white10),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    description,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = LocaleService.currentLocale == 'uk';

    // Grouping fields for a premium look
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        // ── STATS GRID ────────────────────────────────────────────────────
        GlassContainer(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: LotCompactStat(
                      label: isUk ? 'Різновид' : 'Variety',
                      value: lot?.varieties ?? bean?.varieties ?? 'N/A',
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.white10),
                  Expanded(
                    child: LotCompactStat(
                      label: isUk ? 'Висота' : 'Altitude',
                      value: lot?.altitude ?? (bean?.altitudeMin != null ? '${bean!.altitudeMin}-${bean!.altitudeMax}m' : 'N/A'),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: Colors.white10),
              Row(
                children: [
                  Expanded(
                    child: LotCompactStat(
                      label: isUk ? 'Обробка' : 'Process',
                      value: lot?.process ?? bean?.processMethod ?? 'N/A',
                      onTap: (lot?.process ?? bean?.processMethod) != null 
                        ? () => _showProcessInfoSheet(context, ref, lot?.process ?? bean?.processMethod ?? '')
                        : null,
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.white10),
                  Expanded(
                    child: LotCompactStat(
                      label: 'SCA SCORE',
                      value: lot?.scaScore ?? bean?.scaScore ?? 'N/A',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── ORIGIN \u0026 FARM ─────────────────────────────────────────────
        _SectionTitle(title: isUk ? 'ПОХОДЖЕННЯ ТА ФЕРМА' : 'ORIGIN \u0026 FARM'),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _InfoRow(label: isUk ? 'Назва кави' : 'Coffee Name', value: lot?.coffeeName ?? bean?.fullDisplayName),
              _InfoRow(label: isUk ? 'Країна' : 'Country', value: lot?.originCountry ?? bean?.country),
              _InfoRow(label: isUk ? 'Регіон' : 'Region', value: lot?.region ?? bean?.region),
              _InfoRow(label: isUk ? 'Ферма' : 'Farm', value: lot?.farm),
              _InfoRow(label: isUk ? 'Фермер' : 'Farmer', value: lot?.farmer),
              _InfoRow(label: isUk ? 'Станція' : 'Station', value: lot?.washStation),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── COFFEE SPECS ───────────────────────────────────────────────────
        _SectionTitle(title: isUk ? 'ХАРАКТЕРИСТИКИ КАВИ' : 'COFFEE SPECS'),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _InfoRow(label: isUk ? 'Сорт' : 'Variety', value: lot?.varieties ?? bean?.varieties),
              _InfoRow(
                label: isUk ? 'Обробка' : 'Process', 
                value: lot?.process ?? bean?.processMethod,
                onTap: (lot?.process ?? bean?.processMethod) != null 
                  ? () => _showProcessInfoSheet(context, ref, lot?.process ?? bean?.processMethod ?? '')
                  : null,
              ),
              _InfoRow(label: isUk ? 'Декаф' : 'Decaf', value: lot != null ? (lot!.isDecaf ? (isUk ? 'Так' : 'Yes') : (isUk ? 'Ні' : 'No')) : null),
              _InfoRow(label: isUk ? 'Мелена' : 'Ground', value: lot != null ? (lot!.isGround ? (isUk ? 'Так' : 'Yes') : (isUk ? 'Ні' : 'No')) : null),
              _InfoRow(label: 'SCA SCORE', value: lot?.scaScore ?? bean?.scaScore),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── ROAST \u0026 PURCHASE ───────────────────────────────────────────
        _SectionTitle(title: isUk ? 'ОБСМАЖЕННЯ ТА КУПІВЛЯ' : 'ROAST \u0026 PURCHASE'),
        GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _InfoRow(label: isUk ? 'Ростерія' : 'Roastery', value: lot?.roasteryName),
              _InfoRow(label: isUk ? 'Країна обсмажки' : 'Roast Country', value: lot?.roasteryCountry),
              _InfoRow(label: isUk ? 'Рівень' : 'Roast Level', value: lot?.roastLevel),
              _InfoRow(label: isUk ? 'Дата обсмажки' : 'Roast Date', value: lot?.roastDate?.toString().split(' ')[0]),
              _InfoRow(label: isUk ? 'Відкрито' : 'Opened At', value: lot?.openedAt?.toString().split(' ')[0]),
              _InfoRow(label: isUk ? 'Вага' : 'Weight', value: lot?.weight != null ? (lot!.weight!.endsWith('g') ? lot!.weight : '${lot!.weight}g') : null),
              _InfoRow(label: 'ID Лоту', value: lot?.lotNumber),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if ((lot != null && lot!.pricing.isNotEmpty) || (bean != null && (bean!.userPricing.isNotEmpty || bean!.pricing.isNotEmpty))) ...[
          _SectionTitle(title: isUk ? 'ЦІНИ' : 'PRICES'),
          GlassContainer(
            padding: EdgeInsets.zero,
            child: Table(
              children: [
                TableRow(
                  children: [
                    _Cell(isUk ? 'Вага' : 'Weight', isHeader: true),
                    _Cell(isUk ? 'Роздріб' : 'Retail', isHeader: true),
                    _Cell(isUk ? 'Опт' : 'Wholesale', isHeader: true),
                  ],
                ),
                _priceRow('250g', 
                  (lot?.pricing['retail_250'] ?? bean?.userPricing['retail_250'] ?? bean?.pricing['retail_250'])?.toString(),
                  (lot?.pricing['wholesale_250'] ?? bean?.userPricing['wholesale_250'] ?? bean?.pricing['wholesale_250'])?.toString()
                ),
                _priceRow('1kg', 
                  (lot?.pricing['retail_1k'] ?? bean?.userPricing['retail_1k'] ?? bean?.pricing['retail_1k'])?.toString(),
                  (lot?.pricing['wholesale_1k'] ?? bean?.userPricing['wholesale_1k'] ?? bean?.pricing['wholesale_1k'])?.toString()
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),

        // ── FLAVOR PROFILE ────────────────────────────────────────────────
        if ((lot?.flavorProfile != null && lot!.flavorProfile!.isNotEmpty) || (bean?.description != null && bean!.description.isNotEmpty)) ...[
          _SectionTitle(title: isUk ? 'ОПИС СМАКУ' : 'FLAVOR PROFILE'),
          GlassContainer(
            padding: const EdgeInsets.all(20),
            child: Text(
              lot?.flavorProfile ?? bean?.description ?? '',
              style: GoogleFonts.outfit(
                color: Colors.white70,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],

        const SizedBox(height: 100),
      ],
    );
  }
}

class _SensoryTab extends StatelessWidget {
  final Map<String, double> points;
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
              staticValues: points,
            ),
          ),
          const SizedBox(height: 30),
          _SectionTitle(title: isUk ? 'СЕНСОРНИЙ ПРОФІЛЬ' : 'SENSORY PROFILE'),
          SensoryPreview(
            points: points.map((k, v) => MapEntry(k, v)),
            isGrid: true,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

TableRow _priceRow(String weight, String? retail, String? wholesale) {
  return TableRow(
    children: [
      _Cell(weight),
      _Cell(retail != null && retail.isNotEmpty && retail != '---' ? '$retail ₴' : '---'),
      _Cell(wholesale != null && wholesale.isNotEmpty && wholesale != '---' ? '$wholesale ₴' : '---'),
    ],
  );
}

class _Cell extends StatelessWidget {
  final String label;
  final bool isHeader;
  const _Cell(this.label, {this.isHeader = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: isHeader ? 11 : 13,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
          color: isHeader ? Colors.white38 : Colors.white,
          letterSpacing: isHeader ? 1.0 : 0,
        ),
      ),
    );
  }
}


class _RecipesTab extends ConsumerWidget {
  final String lotId;

  const _RecipesTab({required this.lotId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = LocaleService.currentLocale == 'uk';
    final db = ref.watch(databaseProvider);
    
    return StreamBuilder<List<CustomRecipeDto>>(
      stream: db.watchCustomRecipesForLot(lotId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
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
                  style: GoogleFonts.outfit(color: Colors.white24, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2),
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
              return const SizedBox.shrink(); // Using FAB now
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomRecipeCard(recipe: recipes[index], methodKey: recipes[index].methodKey, ref: ref),
            );
          },
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _InfoRow({required this.label, this.value, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    final v = value;
    final t = trailing;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (v == null || v.isEmpty) ? 'N/A' : v,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (onTap != null) ...[
                  const SizedBox(width: 6),
                  Icon(
                    Icons.info_outline_rounded,
                    size: 12,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                  ),
                ],
                // ignore: use_null_aware_elements
                if (t != null) t,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
