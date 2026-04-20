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
            // Priority: Live Lot Image -> Live Bean Image -> Entry Image
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
                      isImageVisible: _tabController.index < 2, // Hide on Recipes tab
                      onBack: () => Navigator.pop(context),
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
                          _InfoTab(lot: liveLot ?? widget.lot, bean: liveBean),
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
  final bool isImageVisible;
  final VoidCallback onBack;
  final VoidCallback? onEdit;

  const _DetailHeader({
    required this.coffeeName,
    required this.roasteryName,
    this.imageUrl,
    this.lot,
    this.isImageVisible = true,
    required this.onBack,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isImageVisible ? 320 : 160,
          width: double.infinity,
          decoration: BoxDecoration(
            image: (isImageVisible && imageUrl != null && imageUrl!.isNotEmpty) 
                ? (imageUrl!.startsWith('http') 
                    ? DecorationImage(image: CachedNetworkImageProvider(imageUrl!), fit: BoxFit.cover)
                    : DecorationImage(image: FileImage(File(imageUrl!)), fit: BoxFit.cover))
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

  const _InfoTab({this.lot, this.bean});

  void _showProcessInfoSheet(BuildContext context, String process) {
    // Basic local dictionary for process info
    final isUk = LocaleService.currentLocale == 'uk';
    String title = process;
    String description = isUk 
      ? 'Детальна інформація про цей метод обробки поки відсутня в нашому довіднику.'
      : 'Detailed information about this process is not yet available in our guide.';

    final pLower = process.toLowerCase();
    if (pLower.contains('wash') || pLower.contains('мит')) {
      title = isUk ? 'Митий метод (Washed)' : 'Washed Process';
      description = isUk 
        ? 'Плоди депульпують (знімають шкірку та частину м’якоті), після чого зерна ферментують у воді та ретельно промивають. Цей метод підкреслює чистоту смаку, кислотність та терруар.' 
        : 'The fruit is pulped, fermented in water, and then washed clean. This method highlights flavor clarity, acidity, and terroir characteristics.';
    } else if (pLower.contains('natural') || pLower.contains('натур')) {
      title = isUk ? 'Натуральний метод (Natural)' : 'Natural Process';
      description = isUk 
        ? 'Зерна сушать всередині цілої ягоди. Це надає каві виражену солодкість, насичене тіло та інтенсивні фруктові ноти.' 
        : 'The fruit is dried whole with the beans inside. This imparts heavy sweetness, a full body, and intense fruity notes to the coffee.';
    } else if (pLower.contains('honey') || pLower.contains('хані')) {
      title = isUk ? 'Метод Хані (Honey)' : 'Honey Process';
      description = isUk 
        ? 'Проміжний метод, де шкірку знімають, але залишають частину м’якоті (клейковини) під час сушіння. Кава виходить збалансованою та солодкою.' 
        : 'A middle ground where the skin is removed but some mucilage is left on the bean during drying. Results in a balanced and sweet cup.';
    } else if (pLower.contains('anaerobic') || pLower.contains('анаероб')) {
      title = isUk ? 'Анаеробний метод (Anaerobic)' : 'Anaerobic Process';
      description = isUk 
        ? 'Ферментація відбувається у герметичних ємностях без доступу кисню. Це дозволяє контролювати бактеріальні процеси, створюючи надзвичайно складні, часто "алкогольні" смакові профілі.' 
        : 'Fermentation takes place in sealed tanks without oxygen. This creates highly complex, sometimes boozy, and unique flavor profiles.';
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        padding: const EdgeInsets.all(24),
        borderRadius: 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              title.toUpperCase(),
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFC8A96E),
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white10),
            const SizedBox(height: 16),
            Text(
              description,
              style: GoogleFonts.outfit(
                fontSize: 14,
                height: 1.6,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
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
                trailing: (lot?.process ?? bean?.processMethod) != null ? GestureDetector(
                  onTap: () => _showProcessInfoSheet(context, lot?.process ?? bean?.processMethod ?? ''),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.5)),
                    ),
                    child: const Icon(Icons.info_outline_rounded, size: 10, color: Color(0xFFC8A96E)),
                  ),
                ) : null,
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
        if (lot != null && lot!.pricing.isNotEmpty) ...[
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
                _priceRow('250g', lot!.pricing['retail_250']?.toString(), lot!.pricing['wholesale_250']?.toString()),
                _priceRow('1kg', lot!.pricing['retail_1k']?.toString(), lot!.pricing['wholesale_1k']?.toString()),
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

  String _getLocalizedLabel(String key, bool isUk) {
    switch (key) {
      case 'bitterness': return isUk ? 'Гіркота' : 'Bitterness';
      case 'acidity': return isUk ? 'Кислотність' : 'Acidity';
      case 'sweetness': return isUk ? 'Солодкість' : 'Sweetness';
      case 'body': return isUk ? 'Тіло' : 'Body';
      case 'intensity': return isUk ? 'Насиченість' : 'Intensity';
      case 'aftertaste': return isUk ? 'Післясмак' : 'Aftertaste';
      default: return key.toUpperCase();
    }
  }
}

TableRow _priceRow(String weight, String? retail, String? wholesale) {
  if ((retail == null || retail == '---' || retail.isEmpty) &&
      (wholesale == null || wholesale == '---' || wholesale.isEmpty)) {
    return const TableRow(children: [SizedBox(), SizedBox(), SizedBox()]);
  }
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

class _SegmentedSensoryBar extends StatelessWidget {
  final String label;
  final double value;

  const _SegmentedSensoryBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.outfit(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Row(
                  children: List.generate(5, (index) {
                    final normalizedScore = (value / 10.0) * 5.0;
                    final isFilled = index < normalizedScore.round();
                    return Expanded(
                      child: Container(
                        height: 3,
                        margin: EdgeInsets.only(right: index == 4 ? 0 : 3),
                        decoration: BoxDecoration(
                          color: isFilled ? theme.colorScheme.primary : const Color(0xFFC8A96E).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 30,
                child: Text(
                  '${value.toInt()}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.outfit(fontSize: 12, color: Colors.white.withValues(alpha: 0.7), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
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

  const _InfoRow({required this.label, this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    final v = value;
    final t = trailing;
    return Padding(
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
              // ignore: use_null_aware_elements
              if (t != null) t,
            ],
          ),
        ],
      ),
    );
  }
}
