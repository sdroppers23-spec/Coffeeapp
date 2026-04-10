import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'app_database.dart';

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  Future<void> seedAll({bool force = true, Function(String)? onProgress}) async {
    onProgress?.call('Initializing database sync...');
    debugPrint('DB SEEDING: STARTING (FORCE=$force)...');

    if (force) {
      debugPrint('DB SEEDING: PERFORMING MANDATORY CLEANUP...');
      await db.transaction(() async {
        await db.delete(db.localizedBeans).go();
        await db.delete(db.localizedBeanTranslations).go();
        await db.delete(db.localizedBrands).go();
        await db.delete(db.localizedBrandTranslations).go();
        await db.delete(db.brewingRecipes).go();
        await db.delete(db.latteArtPatterns).go();
        await db.delete(db.latteArtPatternTranslations).go();
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedFarmerTranslations).go();
      });
      debugPrint('DB SEEDING: CLEANUP COMPLETE.');
    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands();
    onProgress?.call('Seeding Brewing Recipes...');
    await _seedBrewingRecipes();
    onProgress?.call('Seeding Encyclopedia...');
    await _seedEncyclopedia();
    onProgress?.call('Seeding Mad Heads Catalog...');
    await _seedMadHeadsOrigins();
    onProgress?.call('Seeding 3Champs Catalog...');
    await _seed3ChampsOrigins();
    onProgress?.call('Seeding Latte Art...');
    await _seedLatteArtPatterns();
    onProgress?.call('Seeding Specialty Articles...');
    try {
      await _seedSpecialtyArticles();
      onProgress?.call('Seeding Recommended Recipes...');
      await _seedRecommendedRecipes();
      onProgress?.call('All systems synchronized [STABLE]');
      debugPrint('DB SEEDING: ALL COMPLETED SUCCESSFULLY');
    } catch (e, st) {
      debugPrint('DB SEEDING FATAL ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Synchronization error: $e');
    }
  }

  Future<void> _seedBrands() async {
    final existing = await db.getAllBrands('uk');
    if (existing.isNotEmpty) return;

    // Mad Heads
    final madHeadsId = await db.insertBrand(LocalizedBrandsCompanion.insert(
      name: 'Mad Heads [STABLE]',
      logoUrl: const Value('https://madheadscoffee.com/wp-content/uploads/2021/05/Logo_MH_Black-1.png'),
      siteUrl: const Value('https://madheadscoffee.com/'),
    ));
    await db.insertBrandTranslation(LocalizedBrandTranslationsCompanion.insert(
      brandId: madHeadsId,
      languageCode: 'uk',
      shortDesc: const Value('Stay Mad. Respect Quality.'),
      fullDesc: const Value(
        'Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році. '
        'Ми фокусуємось на пошуку унікальних мікролотів та інноваційних методах обробки.',
      ),
      location: const Value('Київ, вул. Кирилівська 69'),
    ));
    await db.insertBrandTranslation(LocalizedBrandTranslationsCompanion.insert(
      brandId: madHeadsId,
      languageCode: 'en',
      shortDesc: const Value('Stay Mad. Respect Quality.'),
      fullDesc: const Value('Mad Heads Coffee is an independent Ukrainian roaster founded in 2017.'),
      location: const Value('Kyiv, Kyrylivska st. 69'),
    ));

    // 3Champs
    final champsId = await db.insertBrand(LocalizedBrandsCompanion.insert(
      name: '3Champs [STABLE]',
      logoUrl: const Value('https://3champsroastery.com.ua/images/logo.png'),
      siteUrl: const Value('https://3champsroastery.com.ua/'),
    ));
    await db.insertBrandTranslation(LocalizedBrandTranslationsCompanion.insert(
      brandId: champsId,
      languageCode: 'uk',
      shortDesc: const Value('Спешелті обсмажка з акцентом на чистоту та яскравість смаку.'),
      fullDesc: const Value('3Champs Roastery — це команда професіоналів. Плодова 1.'),
      location: const Value('Kyiv, Plodova 1'),
    ));
    await db.insertBrandTranslation(LocalizedBrandTranslationsCompanion.insert(
      brandId: champsId,
      languageCode: 'en',
      shortDesc: const Value('Specialty roastery focused on clarity and brightness.'),
      fullDesc: const Value('3Champs Roastery is a team of coffee professionals based in Kyiv.'),
      location: const Value('Kyiv, Plodova 1'),
    ));
  }

  Future<void> _seedMadHeadsOrigins() async {
    final allBrands = await db.getAllBrands('uk');
    final mh = allBrands.where((b) => b.name == 'Mad Heads [STABLE]').firstOrNull;
    final brandId = mh?.id;
    if (brandId == null) return;

    final entries = [
      {
        'main': LocalizedBeansCompanion.insert(
          brandId: Value(brandId),
          countryEmoji: const Value('🇹🇿'),
          altitudeMin: const Value(1600),
          altitudeMax: const Value(1600),
          cupsScore: const Value(85.5),
          sensoryJson: Value(jsonEncode({
            'indicators': {'acidity': 3, 'sweetness': 4, 'bitterness': 2, 'intensity': 3},
            'aroma': 'Квітково-фруктовий',
            'acidityType': 'Чиста, цитрусова',
            'bodyType': 'Середнє, гладке',
            'aftertaste': 'Медова солодкість'
          })),
        ),
        'trans': LocalizedBeanTranslationsCompanion.insert(
          beanId: 0,
          languageCode: 'uk',
          country: const Value('TANZANIA - Utengule'),
          region: const Value('Utengule'),
          processMethod: const Value('Honey'),
          varieties: const Value('Bourbon'),
          description: const Value('Солодкий та збалансований лот з Танзанії.'),
          flavorNotes: Value(jsonEncode(['Peach', 'Green apple', 'Yellow plum', 'White tea'])),
        ),
      },
      {
        'main': LocalizedBeansCompanion.insert(
          brandId: Value(brandId),
          countryEmoji: const Value('🇨🇴'),
          altitudeMin: const Value(2000),
          altitudeMax: const Value(2000),
          cupsScore: const Value(89.5),
        ),
        'trans': LocalizedBeanTranslationsCompanion.insert(
          beanId: 0,
          languageCode: 'uk',
          country: const Value('COLOMBIA - Alto De Osos'),
          region: const Value('Alto De Osos'),
          processMethod: const Value('Natural'),
          varieties: const Value('Castillo'),
          description: const Value('Яскравий мікролот з Колумбії.'),
          flavorNotes: Value(jsonEncode(['Red berries', 'Wine', 'Dark chocolate'])),
        ),
      },
    ];

    for (final e in entries) {
      final id = await db.insertBean(e['main'] as LocalizedBeansCompanion);
      await db.insertBeanTranslation(
          (e['trans'] as LocalizedBeanTranslationsCompanion).copyWith(beanId: Value(id)));
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    final allBrands = await db.getAllBrands('uk');
    final brand = allBrands.where((b) => b.name == '3Champs [STABLE]').firstOrNull;
    final brandId = brand?.id;
    if (brandId == null) return;

    final entries = [
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 46 Filter',
        emoji: '🇨🇴',
        region: 'Las Moras (Huila)',
        process: 'Natural',
        varieties: 'Caturra, Castillo',
        notes: ['Pear', 'Kiwi', 'Marzipan'],
        desc: 'Складна кислотність, довгий ожиновий післясмак.',
        roast: 'Light',
        price: '405₴',
        weight: '250g',
        indicators: {'acidity': 4, 'sweetness': 4, 'bitterness': 1, 'intensity': 4},
        markdown: '### Етап 1: Селективний збір\n### Етап 2: Натуральна сушка на ліжках',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'UGANDA Mount Elgon espresso',
        emoji: '🇺🇬',
        region: 'Mount Elgon',
        process: 'Natural',
        varieties: 'SL14, SL28',
        notes: ['Brown Sugar', 'Dried Fruits'],
        desc: "Бюджетний та дуже стабільний лот для кав'ярні.",
        roast: 'Dark',
        price: '310₴',
        weight: '250g',
        indicators: {'acidity': 1, 'sweetness': 4, 'bitterness': 4, 'intensity': 5},
        markdown: '### Етап 1: Натуральна сушка\n### Етап 2: Темне еспресо обсмаження',
      ),
    ];

    for (final e in entries) {
      final id = await db.insertBean(e['main'] as LocalizedBeansCompanion);
      await db.insertBeanTranslation(
          (e['trans'] as LocalizedBeanTranslationsCompanion).copyWith(beanId: Value(id)));
    }
  }

  Map<String, dynamic> _create3ChampsEntry({
    required int brandId,
    required String country,
    required String emoji,
    required String region,
    required String process,
    required String varieties,
    required List<String> notes,
    required String desc,
    required String roast,
    required String price,
    required String weight,
    required Map<String, int> indicators,
    required String markdown,
  }) {
    return {
      'main': LocalizedBeansCompanion.insert(
        brandId: Value(brandId),
        countryEmoji: Value(emoji),
        sensoryJson: Value(jsonEncode({
          'indicators': indicators,
          'aroma': notes.join(', '),
          'bodyType': (indicators['intensity'] ?? 0) > 3 ? 'Medium/Full' : 'Light',
          'aftertaste': 'Long, sweet',
          'acidityType': (indicators['acidity'] ?? 0) > 3 ? 'Bright' : 'Balanced',
        })),
        detailedProcessMarkdown: Value(markdown),
        price: Value(price),
        weight: Value(weight),
      ),
      'trans': LocalizedBeanTranslationsCompanion.insert(
        beanId: 0,
        languageCode: 'uk',
        country: Value(country),
        region: Value(region),
        processMethod: Value(process),
        varieties: Value(varieties),
        flavorNotes: Value(jsonEncode(notes)),
        description: Value(desc),
        roastLevel: Value(roast),
      ),
    };
  }

  Future<void> _seedBrewingRecipes() async {
    final existing = await db.getAllRecipes();
    if (existing.isNotEmpty) return;

    final recipes = [
      // ── V60 ────────────────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'v60',
        name: 'Hario V60',
        description:
            'The V60 produces a clean, bright cup that highlights delicate floral and citrus notes. '
            'The spiral ribs and large hole allow full control over flow rate and extraction.',
        ratioGramsPerMl: 1 / 15,
        tempC: 93.0,
        totalTimeSec: 165,
        difficulty: 'Intermediate',
        flavorProfile: 'Clean & Bright',
        iconName: 'v60',
        stepsJson: jsonEncode([
          {'title': 'Grind & Heat', 'desc': 'Grind 15 g coffee medium-fine. Bring water to 93°C. Rinse filter.', 'durationSec': 30},
          {'title': 'Bloom (0:00–0:30)', 'desc': 'Pour 30 ml water in slow circles. Let bloom for 30 s.', 'durationSec': 30},
          {'title': '1st Pour (0:30–0:50)', 'desc': 'Pour slowly to 100 ml total in a spiral.', 'durationSec': 20},
          {'title': '2nd Pour (0:50–1:10)', 'desc': 'Continue to 170 ml. Maintain a steady thin stream.', 'durationSec': 20},
          {'title': '3rd Pour (1:10–1:30)', 'desc': 'Pour to 225 ml.', 'durationSec': 20},
          {'title': 'Final Pour (1:30–1:45)', 'desc': 'Pour to 250 ml total. Let drain completely.', 'durationSec': 15},
          {'title': 'Drawdown (1:45–2:45)', 'desc': 'Allow water to drain fully. Enjoy!', 'durationSec': 60},
        ]),
      ),
      // ── Chemex ─────────────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'chemex',
        name: 'Chemex',
        description: 'Chemex uses a thick bonded filter for an exceptionally clean, crisp cup.',
        ratioGramsPerMl: 1 / 15,
        tempC: 93.0,
        totalTimeSec: 165,
        difficulty: 'Intermediate',
        flavorProfile: 'Elegant & Crisp',
        iconName: 'chemex',
        stepsJson: jsonEncode([
          {'title': 'Rinse Filter', 'desc': 'Place folded Chemex filter. Rinse with 200 ml hot water. Discard.', 'durationSec': 30},
          {'title': 'Add Coffee & Bloom (0:00–0:30)', 'desc': 'Add 30 g coffee. Pour 60 ml water (93°C). Wait 30 s.', 'durationSec': 30},
          {'title': '1st Pour (0:30–1:00)', 'desc': 'Pour slowly to 150 ml total.', 'durationSec': 30},
          {'title': '2nd Pour (1:00–1:30)', 'desc': 'Pour to 300 ml.', 'durationSec': 30},
          {'title': '3rd Pour (1:30–1:50)', 'desc': 'Pour to 450 ml.', 'durationSec': 20},
          {'title': 'Drawdown (1:50–2:45)', 'desc': 'Allow full drain. Remove filter.', 'durationSec': 55},
        ]),
      ),
      // ── AeroPress ──────────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'aeropress',
        name: 'AeroPress',
        description: 'The AeroPress is a versatile, forgiving brewer producing sweet, low-acidity concentrate.',
        ratioGramsPerMl: 1 / 14,
        tempC: 80.0,
        totalTimeSec: 150,
        difficulty: 'Beginner',
        flavorProfile: 'Versatile & Bold',
        iconName: 'aeropress',
        stepsJson: jsonEncode([
          {'title': 'Setup Inverted', 'desc': 'Insert plunger to the 4 mark. Add rinsed paper filter to cap.', 'durationSec': 20},
          {'title': 'Add Coffee (0:00)', 'desc': 'Add 17 g finely ground coffee. Tare scale.', 'durationSec': 10},
          {'title': 'Bloom (0:10–0:40)', 'desc': 'Pour 30 ml of 80°C water. Stir 10 times. Wait 30 s.', 'durationSec': 30},
          {'title': 'Fill (0:40–1:00)', 'desc': 'Pour remaining water to 238 ml total. Stir gently 3 times.', 'durationSec': 20},
          {'title': 'Attach & Flip (1:00–1:20)', 'desc': 'Attach cap. Carefully flip onto cup.', 'durationSec': 20},
          {'title': 'Press (1:20–2:30)', 'desc': 'Apply gentle, steady pressure. Stop when you hear a hiss.', 'durationSec': 70},
        ]),
      ),
      // ── French Press ───────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'french_press',
        name: 'French Press',
        description: 'Full immersion and no paper filter = a rich, full-bodied cup with natural oils.',
        ratioGramsPerMl: 1 / 15,
        tempC: 95.0,
        totalTimeSec: 240,
        difficulty: 'Beginner',
        flavorProfile: 'Full-Bodied & Rich',
        iconName: 'french_press',
        stepsJson: jsonEncode([
          {'title': 'Preheat & Grind', 'desc': 'Rinse French Press. Grind 30 g coffee coarsely.', 'durationSec': 30},
          {'title': 'Add Coffee & Pour (0:00)', 'desc': 'Add coffee. Pour 95°C water to 450 ml.', 'durationSec': 30},
          {'title': 'Stir & Place Lid (0:30)', 'desc': 'Stir top crust gently. Place lid — plunger up.', 'durationSec': 15},
          {'title': 'Steep (0:45–4:00)', 'desc': 'Wait 3 minutes 15 seconds. Do not plunge yet.', 'durationSec': 195},
          {'title': 'Press & Pour (4:00)', 'desc': 'Press plunger slowly. Pour immediately.', 'durationSec': 30},
        ]),
      ),
      // ── Espresso ───────────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'espresso',
        name: 'Espresso',
        description: 'The foundation of most café drinks. Concentrated, syrupy and intense — with a golden crema.',
        ratioGramsPerMl: 1 / 2,
        tempC: 93.0,
        totalTimeSec: 28,
        difficulty: 'Advanced',
        flavorProfile: 'Intense & Syrupy',
        iconName: 'espresso',
        stepsJson: jsonEncode([
          {'title': 'Dose & Distribute', 'desc': 'Dose 18 g into portafilter. Use a distributor to level evenly.', 'durationSec': 10},
          {'title': 'Tamp', 'desc': 'Tamp with ~15 kg pressure. Ensure perfectly level puck.', 'durationSec': 5},
          {'title': 'Lock & Pre-infuse', 'desc': 'Lock portafilter. Start pre-infusion for 5 s at low pressure.', 'durationSec': 5},
          {'title': 'Extract (0:05–0:28)', 'desc': 'Extract to 36 g of liquid in 23 s more (1:2 ratio).', 'durationSec': 23},
          {'title': 'Evaluate Crema', 'desc': 'Golden-hazel crema indicates proper extraction. Enjoy immediately.', 'durationSec': 5},
        ]),
      ),
      // ── Cold Brew ──────────────────────────────────────────────────────────
      BrewingRecipesCompanion.insert(
        methodKey: 'cold_brew',
        name: 'Cold Brew',
        description: 'Slow cold-water extraction over 12–24 hours produces a sweet, low-acidity concentrate.',
        ratioGramsPerMl: 1 / 8,
        tempC: 4.0,
        totalTimeSec: 57600,
        difficulty: 'Beginner',
        flavorProfile: 'Sweet & Smooth',
        iconName: 'cold_brew',
        stepsJson: jsonEncode([
          {'title': 'Grind Coarsely', 'desc': 'Grind 100 g coffee very coarsely (like raw sugar).', 'durationSec': 60},
          {'title': 'Combine', 'desc': 'Add grounds to jar. Pour 800 ml cold filtered water. Stir gently.', 'durationSec': 120},
          {'title': 'Cover & Refrigerate', 'desc': 'Cover with lid or cling film. Place in refrigerator.', 'durationSec': 60},
          {'title': 'Steep 12–24 h', 'desc': '12 h = lighter & floral. 16 h = balanced. 24 h = intense.', 'durationSec': 57600},
        ]),
      ),
    ];

    for (final r in recipes) {
      await db.into(db.brewingRecipes).insertOnConflictUpdate(r);
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // ENCYCLOPEDIA (Origins)
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedEncyclopedia() async {
    final existing = await db.getAllOrigins();
    if (existing.isNotEmpty) return;

    final entries = [
      _createOriginEntry(
        country: 'Ethiopia (Worka Sakaro)',
        emoji: '🇪🇹',
        region: 'Gedeb, Yirgacheffe',
        altitudeMin: 1990,
        altitudeMax: 2190,
        varieties: 'Kurume (Heirloom)',
        process: 'Washed',
        desc: 'A classic, utterly transportive Ethiopian washed profile.',
        notes: ['Jasmine', 'Peach', 'Earl Grey', 'Lemon Zest', 'Honey'],
        score: 88.5,
      ),
      _createOriginEntry(
        country: 'El Salvador (Finca Kilimanjaro)',
        emoji: '🇸🇻',
        region: 'Santa Ana',
        altitudeMin: 1500,
        altitudeMax: 1720,
        varieties: 'Kenya SL-28, Bourbon',
        process: 'Natural / Washed',
        desc: 'Intense African blackcurrant acidity with rich, thick Salvadoran chocolate body.',
        notes: ['Blackcurrant', 'Plum', 'Brown Sugar', 'Red Wine', 'Velvet'],
        score: 90.0,
      ),
      _createOriginEntry(
        country: 'Costa Rica (Volcán Azul)',
        emoji: '🇨🇷',
        region: 'West Valley',
        altitudeMin: 1500,
        altitudeMax: 1700,
        varieties: 'San Isidro, Caturra, Gesha',
        process: 'Red Honey',
        desc: 'Deeply sweet, coating mouthfeel, and vibrant tropical fruit acidity.',
        notes: ['Mango', 'Honey', 'Milk Chocolate', 'Orange Zest'],
        score: 87.5,
      ),
      _createOriginEntry(
        country: 'Panama (La Esmeralda)',
        emoji: '🇵🇦',
        region: 'Boquete',
        altitudeMin: 1500,
        altitudeMax: 1900,
        varieties: 'Gesha (Geisha)',
        process: 'Washed / Natural',
        desc: 'Unparalleled floral elegance and tea-like transparency.',
        notes: ['Jasmine', 'Bergamot', 'Mandarin', 'Lemongrass', 'White Peach'],
        score: 93.5,
      ),
    ];

    for (final e in entries) {
      final id = await db.insertBean(e['main'] as LocalizedBeansCompanion);
      await db.insertBeanTranslation(
          (e['trans'] as LocalizedBeanTranslationsCompanion).copyWith(beanId: Value(id)));
    }
  }

  Map<String, dynamic> _createOriginEntry({
    required String country,
    required String emoji,
    required String region,
    required int altitudeMin,
    required int altitudeMax,
    required String varieties,
    required String process,
    required String desc,
    required List<String> notes,
    required double score,
  }) {
    return {
      'main': LocalizedBeansCompanion.insert(
        countryEmoji: Value(emoji),
        altitudeMin: Value(altitudeMin),
        altitudeMax: Value(altitudeMax),
        cupsScore: Value(score),
      ),
      'trans': LocalizedBeanTranslationsCompanion.insert(
        beanId: 0,
        languageCode: 'en',
        country: Value(country),
        region: Value(region),
        processMethod: Value(process),
        varieties: Value(varieties),
        flavorNotes: Value(jsonEncode(notes)),
        description: Value(desc),
      )
    };
  }

  // ────────────────────────────────────────────────────────────────────────────
  // LATTE ART PATTERNS
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedLatteArtPatterns() async {
    final existing = await db.getAllLatteArtPatterns();
    if (existing.isNotEmpty) return;

    final patterns = [
      {
        'main': LatteArtPatternsCompanion.insert(
          difficulty: const Value(1),
          stepsJson: jsonEncode([
            {'step': 1, 'instruction': 'Відпарте молоко до 60–65°C...'},
            {'step': 2, 'instruction': 'Наповніть чашку на 1/3 еспресо...'},
          ]),
        ),
        'trans': LatteArtPatternTranslationsCompanion.insert(
          patternId: 0,
          languageCode: 'uk',
          name: 'Серце (Heart)',
          description: 'Класичний візерунок лате-арту.',
          tipText: 'Починайте лити з висоти...',
        )
      },
      {
        'main': LatteArtPatternsCompanion.insert(
          difficulty: const Value(2),
          stepsJson: jsonEncode([
            {'step': 1, 'instruction': 'Готуємо еспресо...'},
          ]),
        ),
        'trans': LatteArtPatternTranslationsCompanion.insert(
          patternId: 0,
          languageCode: 'uk',
          name: 'Тюльпан (Tulip)',
          description: 'Елегантний силует тюльпана.',
          tipText: 'Кожна "пелюстка" - це окремий рух...',
        )
      },
    ];

    for (final p in patterns) {
      final id = await db.insertLatteArtPattern(p['main'] as LatteArtPatternsCompanion);
      await db.insertLatteArtPatternTranslation((p['trans'] as LatteArtPatternTranslationsCompanion).copyWith(patternId: Value(id)));
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // SPECIALTY ARTICLES
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedSpecialtyArticles() async {
    final existing = await db.getAllSpecialtyArticles();
    if (existing.isNotEmpty) return;

    final articles = [
      {
        'main': SpecialtyArticlesCompanion.insert(
          imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=800&q=80',
          readTimeMin: 7,
        ),
        'trans': SpecialtyArticleTranslationsCompanion.insert(
          articleId: 0,
          languageCode: 'uk',
          title: 'Основи обробки кави',
          subtitle: 'Від ягоди до зерна: як формується смак',
          contentHtml: '<h3>1. Мита обробка (Washed)</h3>...',
        )
      },
    ];

    for (final a in articles) {
      final id = await db.insertSpecialtyArticle(a['main'] as SpecialtyArticlesCompanion);
      await db.insertSpecialtyArticleTranslation((a['trans'] as SpecialtyArticleTranslationsCompanion).copyWith(articleId: Value(id)));
    }
  }

  Future<void> _seedRecommendedRecipes() async {
    await db.delete(db.recommendedRecipes).go();
    final allLots = await db.getAllOrigins();
    if (allLots.isEmpty) return;

    for (final lot in allLots) {
      final String grindNote;
      final Map<String, int> sensory;
      final String notes;

      if (process.contains('natural') || process.contains('натур')) {
        coffeeG = 15.0; waterG = 250.0; tempC = 91.0; timeSec = 195;
        grindNote = '24 clicks Comandante / medium-coarse';
        sensory = {'sweetness': 5, 'acidity': 3, 'body': 4, 'balance': 4, 'aroma': 5, 'aftertaste': 4};
        notes = 'Natural process: lower temp (91°C) to avoid over-extraction of fruity sugars.';
      } else if (process.contains('anaerobic') || process.contains('анаероб')) {
        coffeeG = 15.0; waterG = 250.0; tempC = 90.0; timeSec = 210;
        grindNote = '23 clicks Comandante / medium-coarse';
        sensory = {'sweetness': 5, 'acidity': 4, 'body': 4, 'balance': 4, 'aroma': 5, 'aftertaste': 5};
        notes = 'Anaerobic: use 90°C to tame fermentation intensity.';
      } else if (process.contains('honey') || process.contains('хані')) {
        coffeeG = 15.5; waterG = 240.0; tempC = 92.0; timeSec = 190;
        grindNote = '22 clicks Comandante / medium';
        sensory = {'sweetness': 5, 'acidity': 3, 'body': 4, 'balance': 5, 'aroma': 4, 'aftertaste': 4};
        notes = 'Honey process: slightly higher dose for caramel sweetness.';
      } else {
        // Default: Washed
        coffeeG = 15.0; waterG = 250.0; tempC = 93.0; timeSec = 180;
        grindNote = '21 clicks Comandante / medium-fine';
        sensory = {'sweetness': 3, 'acidity': 5, 'body': 3, 'balance': 4, 'aroma': 4, 'aftertaste': 4};
        notes = 'Washed: use 93°C to extract full acidity and clarity.';
      }

      await db.insertRecommendedRecipe(RecommendedRecipesCompanion(
        lotId: Value(lot.id),
        methodKey: const Value('v60'),
        coffeeGrams: Value(coffeeG),
        waterGrams: Value(waterG),
        tempC: Value(tempC),
        timeSec: Value(timeSec),
        rating: const Value(4.8),
        sensoryJson: Value(jsonEncode(sensory)),
        notes: Value('$grindNote. $notes'),
      ));

      debugPrint('DB SEEDING: V60 recipe seeded for lot [${lot.id}] ${lot.country} (${lot.processMethod})');
    }

    debugPrint('DB SEEDING: Recommended Recipes seeded for ${allLots.length} lots.');
  }
}
