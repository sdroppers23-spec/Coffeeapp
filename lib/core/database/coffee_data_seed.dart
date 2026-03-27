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
        await db.delete(db.encyclopediaEntries).go();
        await db.delete(db.brands).go();
        await db.delete(db.brewingRecipes).go();
        await db.delete(db.latteArtPatterns).go();
        await db.delete(db.specialtyArticles).go();
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
    final brandsToSeed = [
      BrandsCompanion(
        name: const Value('Mad Heads [STABLE]'),
        shortDesc: const Value('Stay Mad. Respect Quality.'),
        fullDesc: const Value(
          'Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році. '
          'Ми фокусуємось на пошуку унікальних мікролотів та інноваційних методах обробки. '
          'Наші ростери працюють щодня, щоб ви отримували максимально свіжу каву з прозорою історією походження.'
        ),
        siteUrl: const Value('https://madheadscoffee.com/'),
        location: const Value('Київ, вул. Кирилівська 69'),
        logoUrl: const Value('https://madheadscoffee.com/wp-content/uploads/2021/05/Logo_MH_Black-1.png'),
      ),
      BrandsCompanion(
        name: const Value('3Champs [STABLE]'),
        shortDesc: const Value('Спешелті обсмажка з акцентом на чистоту та яскравість смаку.'),
        fullDesc: const Value(
          '3Champs Roastery — це команда професіоналів, які прагнуть розкрити потенціал кожного зерна. Плодова 1 — це місце, де кава стає мистецтвом.'
        ),
        siteUrl: const Value('https://3champsroastery.com.ua/'),
        location: const Value('Kyiv, Plodova 1'),
        logoUrl: const Value('https://3champsroastery.com.ua/images/logo.png'),
      ),
      BrandsCompanion(
        name: const Value('Foundation'),
        shortDesc: const Value('Стабільність та прямі відносини.'),
        fullDesc: const Value(
          'Foundation Coffee Roasters — одна з найбільших спешелті обсмажок України.'
        ),
        siteUrl: const Value('https://foundation.ua/'),
        logoUrl: const Value('https://foundation.ua/assets/logo.png'),
      ),
    ];

    for (final brand in brandsToSeed) {
      final existing = await db.getAllBrands();
      if (!existing.any((b) => b.name == brand.name.value)) {
        debugPrint('DB SEEDING: Inserting brand ${brand.name.value}');
        await db.insertBrand(brand);
      } else {
        debugPrint('DB SEEDING: Brand ${brand.name.value} already exists');
      }
    }
  }

  Future<void> _seedMadHeadsOrigins() async {
    int? brandId;
    try {
      final allBrands = await db.getAllBrands();
      final mh = allBrands.cast<Brand?>().firstWhere(
        (b) => b?.name == 'Mad Heads [STABLE]',
        orElse: () => null,
      );
      brandId = mh?.id;
      debugPrint('DB SEEDING: Found Mad Heads [STABLE] ID: $brandId');
    } catch (e) {
      debugPrint('DB SEEDING ERROR looking for Mad Heads [STABLE]: $e');
    }

    if (brandId == null) {
      debugPrint('DB SEEDING WARNING: Mad Heads brandId is NULL. Skipping lots.');
      return;
    }

    await db.deleteLotsForBrand(brandId);
    debugPrint('DB SEEDING: Cleared lots for Mad Heads (ID: $brandId). Re-seeding...');

    final entries = [
      EncyclopediaEntriesCompanion(
        brandId: Value(brandId),
        countryEmoji: const Value('🇹🇿'),
        country: const Value('TANZANIA - Utengule'),
        region: const Value('Utengule'),
        altitudeMin: const Value(1600),
        altitudeMax: const Value(1600),
        harvestSeason: const Value('July – December'),
        processMethod: const Value('Honey'),
        varieties: const Value('Bourbon'),
        cupsScore: const Value(85.5),
        flavorNotes: Value(jsonEncode(['Peach', 'Green apple', 'Yellow plum', 'White tea'])),
        description: const Value('Солодкий та збалансований лот з Танзанії. Оброблений методом Honey, що додає медової солодкості та фруктової чистоти. Найкраще розкривається у фільтрі.'),
        sensoryJson: Value(jsonEncode({
          'indicators': {'acidity': 3, 'sweetness': 4, 'bitterness': 2, 'intensity': 3},
          'aroma': 'Квітково-фруктовий',
          'acidityType': 'Чиста, цитрусова',
          'bodyType': 'Середнє, гладке',
          'aftertaste': 'Медова солодкість'
        })),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'V60', 'desc': '16г кави; 260г води (98°C); 50г блум 30с; Загальний час: 2:30'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        brandId: Value(brandId),
        countryEmoji: const Value('🇨🇴'),
        country: const Value('COLOMBIA - Alto De Osos'),
        region: const Value('Alto De Osos'),
        altitudeMin: const Value(2000),
        altitudeMax: const Value(2000),
        harvestSeason: const Value('August – October'),
        processMethod: const Value('Natural'),
        varieties: const Value('Castillo'),
        cupsScore: const Value(89.5),
        flavorNotes: Value(jsonEncode(['Tea Rose Jam', 'Dried Banana', 'Dark Rum', 'Pomegranate', 'Pineapple'])),
        description: const Value('Витримана натуральна обробка з перевагами анаеробного смаку. Висока солодкість та складність, нотки тропічних фруктів та рому.'),
        sensoryJson: Value(jsonEncode({
          'indicators': {'acidity': 4, 'sweetness': 5, 'bitterness': 2, 'intensity': 4},
          'aroma': 'Тропічний, алкогольний',
          'acidityType': 'Яскрава, винна',
          'bodyType': 'Густе, сиропне',
          'aftertaste': 'Сухофрукти'
        })),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Espresso', 'desc': '18г кави; 26с; Вихід 40г (93°C)'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        brandId: Value(brandId),
        countryEmoji: const Value('🇮🇩'),
        country: const Value('INDONESIA - Frinsa Manis'),
        region: const Value('West Java'),
        altitudeMin: const Value(1400),
        altitudeMax: const Value(1700),
        harvestSeason: const Value('Year Round'),
        processMethod: const Value('Anaerobic Washed (4 days)'),
        varieties: const Value('Ateng Super, P88, Borbor, Andungsar'),
        cupsScore: const Value(87.5),
        flavorNotes: Value(jsonEncode(['Prunes', 'Dark Rum', 'Sun-dried banana', 'Brownie', 'Pineapple'])),
        description: const Value('Індонезія без землі. Тільки фрукти, ром та шоколадна насолода. Унікальна ферментація під водою протягом 4 днів.'),
        sensoryJson: Value(jsonEncode({
          'indicators': {'acidity': 2, 'sweetness': 4, 'bitterness': 3, 'intensity': 5},
          'aroma': 'Шоколадно-ромовий',
          'acidityType': 'Низька, м\'яка',
          'bodyType': 'Повне, обволікаюче',
          'aftertaste': 'Темний шоколад'
        })),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'V60', 'desc': '16г кави; 260г води (98°C); Загальний час 2:25'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        brandId: Value(brandId),
        countryEmoji: const Value('🇰🇪'),
        country: const Value('KENYA - Gichathaini'),
        region: const Value('Nyeri'),
        altitudeMin: const Value(1800),
        altitudeMax: const Value(1800),
        harvestSeason: const Value('October – December'),
        processMethod: const Value('Washed'),
        varieties: const Value('SL28, SL34'),
        cupsScore: const Value(88.0),
        flavorNotes: Value(jsonEncode(['Redcurrant', 'Tomato', 'Rhubarb', 'Pink Grapefruit'])),
        description: const Value('Яскрава та соковита Кенія з характерною смородиновою кислотністю та тривалим післясмаком. Справжній вибух фруктів.'),
        sensoryJson: Value(jsonEncode({
          'indicators': {'acidity': 5, 'sweetness': 3, 'bitterness': 2, 'intensity': 4},
          'aroma': 'Ягідний, цитрусовий',
          'acidityType': 'Дуже висока, соковита',
          'bodyType': 'Середнє, шовковисте',
          'aftertaste': 'Грейпфрут'
        })),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'V60', 'desc': '15г кави; 250г води (94°C); 45г блум; Загальний час 2:20'}
        ])),
      ),
    ];

    for (final e in entries) {
      await db.insertOrigin(e);
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    int? brandId;
    try {
      final allBrands = await db.getAllBrands();
      final brand = allBrands.cast<Brand?>().firstWhere(
        (b) => b?.name == '3Champs [STABLE]',
        orElse: () => null,
      );
      brandId = brand?.id;
    } catch (e) {
      debugPrint('DB SEEDING ERROR looking for 3Champs [STABLE]: $e');
    }

    if (brandId == null) return;

    await db.deleteLotsForBrand(brandId);
    
    final entries = [
      // ── FILTER COFFEE (LIGHT ROAST) ──────────────────────────────────────────
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 46 Filter',
        emoji: '🇨🇴',
        region: 'Las Moras (Huila)',
        process: 'Natural',
        varieties: 'Caturra, Castillo',
        notes: ['Pear', 'Kiwi', 'Marzipan'],
        desc: 'Складна кислотність, довгий ожиновий післясмак. Ціна (250г): 405₴ роздріб / 325₴ опт. Ціна (1кг): 1620₴ роздріб / 1300₴ опт.',
        roast: 'Light',
        price: '405₴',
        weight: '250g',
        indicators: {'acidity': 4, 'sweetness': 4, 'bitterness': 1, 'intensity': 4},
        markdown: '### Етап 1: Селективний збір\n### Етап 2: Натуральна сушка на ліжках (2-4 тижні)\n### Етап 3: Стабілізація вологості',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 31 Filter',
        emoji: '🇨🇴',
        region: 'Granja Paraiso 92',
        process: 'Thermal Shock',
        varieties: 'Chiroso',
        notes: ['Jasmine', 'Blueberry', 'Kiwi'],
        desc: 'Тривала яблучна кислотність. Ціна (250г): 485₴ роздріб / 405₴ опт. Ціна (1кг): 1940₴ роздріб / 1620₴ опт.',
        roast: 'Light',
        price: '485₴',
        weight: '250g',
        indicators: {'acidity': 5, 'sweetness': 4, 'bitterness': 1, 'intensity': 5},
        markdown: '### Етап 1: Анаеробна ферментація\n### Етап 2: Гарячий термальний шок (40°C)\n### Етап 3: Холодний термальний шок (12°C)\n### Етап 4: Контрольована сушка',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 45 Filter',
        emoji: '🇨🇴',
        region: 'Granja Paraiso 92',
        process: 'Thermal Shock',
        varieties: 'Red Bourbon',
        notes: ['Rose', 'Grapefruit', 'Biscuit'],
        desc: 'Квітковий лот з ніжним тілом. Ціна (250г): 485₴ роздріб / 405₴ опт. Ціна (1кг): 1940₴ роздріб / 1620₴ опт.',
        roast: 'Light',
        price: '485₴',
        weight: '250g',
        indicators: {'acidity': 4, 'sweetness': 5, 'bitterness': 1, 'intensity': 4},
        markdown: '### Етап 1: Анаеробна ферментація\n### Етап 2: Термальний шок для фіксації аромату\n### Етап 3: Дегідратація у механічних сушках',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'KENYA 20 Filter',
        emoji: '🇰🇪',
        region: 'Kirinyaga',
        process: 'Washed',
        varieties: 'SL28, SL34',
        notes: ['Red Berries', 'Honey', 'Orange'],
        desc: 'Яскрава ягідна класика. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {'acidity': 5, 'sweetness': 3, 'bitterness': 1, 'intensity': 4},
        markdown: '### Етап 1: Депульпація\n### Етап 2: Ферментація у танку\n### Етап 3: Промивка та сушка на ліжках',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'ETHIOPIA 37 Filter',
        emoji: '🇪🇹',
        region: 'Uraga (Guji)',
        process: 'Washed',
        varieties: 'Heirloom',
        notes: ['Lemon', 'Jasmine', 'Green tea'],
        desc: 'Чистий та елегантний чайний профіль. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {'acidity': 4, 'sweetness': 3, 'bitterness': 1, 'intensity': 3},
        markdown: '### Етап 1: Мокра обробка\n### Етап 2: Відмивка муселя\n### Етап 3: Повільна сушка',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'RWANDA 14 Filter',
        emoji: '🇷🇼',
        region: 'Coacambu',
        process: 'Natural',
        varieties: 'Red Bourbon',
        notes: ['Orange', 'Biscuit', 'Stone fruits'],
        desc: 'Збалансована та солодка натуральна Руанда. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {'acidity': 3, 'sweetness': 4, 'bitterness': 2, 'intensity': 4},
        markdown: '### Етап 1: Сортування ягід\n### Етап 2: Натуральна сушка\n### Етап 3: Халінг перед відправкою',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'INDONESIA 4 Filter',
        emoji: '🇮🇩',
        region: 'Frinza',
        process: 'Anaerobic Natural',
        varieties: 'S-Lini, Bor-Bor',
        notes: ['Orange', 'Blueberry', 'Rhubarb'],
        desc: 'Ціна (250г): 465₴ роздріб / 385₴ опт. Ціна (1кг): 1860₴ роздріб / 1540₴ опт.',
        roast: 'Light',
        price: '465₴',
        weight: '250g',
        indicators: {'acidity': 4, 'sweetness': 4, 'bitterness': 1, 'intensity': 5},
        markdown: '### Етап 1: Анаеробна ферментація 72г\n### Етап 2: Натуральна сушка',
      ),

      // ── ESPRESSO COFFEE (DARK ROAST) ─────────────────────────────────────────
      _create3ChampsEntry(
        brandId: brandId,
        country: 'ETHIOPIA 37 Espresso',
        emoji: '🇪🇹',
        region: 'Uraga (Guji)',
        process: 'Washed',
        varieties: 'Heirloom',
        notes: ['Peach', 'Jasmine', 'Apple'],
        desc: 'Еспресо-обсмажка класичної Ефіопії. Дуже солодка. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Dark',
        price: '420₴',
        weight: '250g',
        indicators: {'acidity': 3, 'sweetness': 5, 'bitterness': 2, 'intensity': 4},
        markdown: '### Етап 1: Мита обробка\n### Етап 2: Темне обсмажування під еспресо',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 46 Espresso',
        emoji: '🇨🇴',
        region: 'Las Moras',
        process: 'Natural',
        varieties: 'Caturra/Castillo',
        notes: ['Pear', 'Marzipan', 'Berries'],
        desc: 'Щільне тіло, ідеально для молочних напоїв. Ціна (250г): 405₴ роздріб / 325₴ опт. Ціна (1кг): 1620₴ роздріб / 1300₴ опт.',
        roast: 'Dark',
        price: '405₴',
        weight: '250g',
        indicators: {'acidity': 2, 'sweetness': 5, 'bitterness': 3, 'intensity': 5},
        markdown: '### Етап 1: Натуральна обробка\n### Етап 2: Розвинуте обсмажування',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'GUATEMALA 9 Espresso',
        emoji: '🇬🇹',
        region: 'Huehuetenango',
        process: 'Washed',
        varieties: 'Bourbon, Caturra',
        notes: ['Chocolate', 'Caramel', 'Nuts'],
        desc: 'Класичне еспресо з горіхово-шоколадним профілем. Ціна (250г): 370₴ роздріб / 290₴ опт. Ціна (1кг): 1480₴ роздріб / 1160₴ опт.',
        roast: 'Dark',
        price: '370₴',
        weight: '250g',
        indicators: {'acidity': 2, 'sweetness': 4, 'bitterness': 3, 'intensity': 4},
        markdown: '### Етап 1: Промивка\n### Етап 2: Обсмаження під еспресо',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'UGANDA 2 Espresso',
        emoji: '🇺🇬',
        region: 'Mount Elgon',
        process: 'Natural',
        varieties: 'SL14, SL28',
        notes: ['Brown Sugar', 'Dried Fruits'],
        desc: 'Бюджетний та дуже стабільний лот для кав\'ярні. Ціна (250г): 310₴ роздріб / 230₴ опт. Ціна (1кг): 1240₴ роздріб / 920₴ опт.',
        roast: 'Dark',
        price: '310₴',
        weight: '250g',
        indicators: {'acidity': 1, 'sweetness': 4, 'bitterness': 4, 'intensity': 5},
        markdown: '### Етап 1: Натуральна сушка\n### Етап 2: Темне еспресо обсмаження',
      ),
    ];

    for (final e in entries) {
      await db.insertOrigin(e);
    }
  }

  EncyclopediaEntriesCompanion _create3ChampsEntry({
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
    return EncyclopediaEntriesCompanion(
      brandId: Value(brandId),
      countryEmoji: Value(emoji),
      country: Value(country),
      region: Value(region),
      processMethod: Value(process),
      varieties: Value(varieties),
      flavorNotes: Value(jsonEncode(notes)),
      description: Value(desc),
      roastLevel: Value(roast),
      price: Value(price),
      weight: Value(weight),
      sensoryJson: Value(jsonEncode({
        'indicators': indicators,
        'aroma': notes.join(', '),
        'bodyType': indicators['intensity']! > 3 ? 'Medium/Full' : 'Light',
        'aftertaste': 'Long, sweet',
        'acidityType': indicators['acidity']! > 3 ? 'Bright' : 'Balanced',
      })),
      detailedProcessMarkdown: Value(markdown),
    );
  }


  // ────────────────────────────────────────────────────────────────────────────
  // ENCYCLOPEDIA (Existing)
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedBrewingRecipes() async {
    final existing = await db.getAllRecipes();
    if (existing.isNotEmpty) return;

    final recipes = [
      // ── V60 ────────────────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('v60'),
        name: const Value('Hario V60'),
        description: const Value(
          'The V60 produces a clean, bright cup that highlights delicate floral and citrus notes. '
          'The spiral ribs and large hole allow full control over flow rate and extraction.',
        ),
        ratioGramsPerMl: const Value(1 / 15),
        tempC: const Value(93.0),
        totalTimeSec: const Value(165),
        difficulty: const Value('Intermediate'),
        flavorProfile: const Value('Clean & Bright'),
        iconName: const Value('v60'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Grind & Heat',
            'desc': 'Grind 15 g coffee medium-fine. Bring water to 93°C. Place filter in V60 and rinse with hot water.',
            'durationSec': 30,
          },
          {
            'title': 'Bloom (0:00–0:30)',
            'desc': 'Add coffee. Pour 30 ml water in slow circles to wet all grounds. Let bloom for 30 s.',
            'durationSec': 30,
          },
          {
            'title': '1st Pour (0:30–0:50)',
            'desc': 'Pour slowly to 100 ml total in a spiral from centre out. Aim for gentle agitation.',
            'durationSec': 20,
          },
          {
            'title': '2nd Pour (0:50–1:10)',
            'desc': 'Continue to 170 ml. Maintain a steady thin stream.',
            'durationSec': 20,
          },
          {
            'title': '3rd Pour (1:10–1:30)',
            'desc': 'Pour to 225 ml. Keep stream consistent, avoid disturbing the coffee bed.',
            'durationSec': 20,
          },
          {
            'title': 'Final Pour (1:30–1:45)',
            'desc': 'Pour to 250 ml total. Let drain completely.',
            'durationSec': 15,
          },
          {
            'title': 'Drawdown (1:45–2:45)',
            'desc': 'Allow water to drain fully. Target total time max 2:45. Enjoy!',
            'durationSec': 60,
          },
        ])),
      ),

      // ── Chemex ─────────────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('chemex'),
        name: const Value('Chemex'),
        description: const Value(
          'Chemex uses a thick bonded filter that removes oils for an exceptionally clean, '
          'crisp cup. Great for lighter roasts with complex floral or fruity notes.',
        ),
        ratioGramsPerMl: const Value(1 / 15),
        tempC: const Value(93.0),
        totalTimeSec: const Value(165),
        difficulty: const Value('Intermediate'),
        flavorProfile: const Value('Elegant & Crisp'),
        iconName: const Value('chemex'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Rinse Filter',
            'desc': 'Place the folded Chemex filter (3 layers towards spout). Rinse with 200 ml hot water. Discard.',
            'durationSec': 30,
          },
          {
            'title': 'Add Coffee & Bloom (0:00–0:30)',
            'desc': 'Add 30 g coffee. Pour 60 ml water (93°C). Wait 30 s.',
            'durationSec': 30,
          },
          {
            'title': '1st Pour (0:30–1:00)',
            'desc': 'Pour slowly to 150 ml total in tight circles. Maintain gentle agitation.',
            'durationSec': 30,
          },
          {
            'title': '2nd Pour (1:00–1:30)',
            'desc': 'Pour to 300 ml. Try not to pour on filter paper edge.',
            'durationSec': 30,
          },
          {
            'title': '3rd Pour (1:30–1:50)',
            'desc': 'Pour to 450 ml. Maintain steady stream.',
            'durationSec': 20,
          },
          {
            'title': 'Drawdown (1:50–2:45)',
            'desc': 'Allow full drain. Target total max 2:45. Remove filter without touching the bottom.',
            'durationSec': 55,
          },
        ])),
      ),

      // ── Aeropress ──────────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('aeropress'),
        name: const Value('AeroPress'),
        description: const Value(
          'The AeroPress is a versatile, forgiving brewer. Pressure extraction produces a '
          'sweet, low-acidity concentrate. Great for travel and experimentation.',
        ),
        ratioGramsPerMl: const Value(1 / 14),
        tempC: const Value(80.0),
        totalTimeSec: const Value(150),
        difficulty: const Value('Beginner'),
        flavorProfile: const Value('Versatile & Bold'),
        iconName: const Value('aeropress'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Setup Inverted',
            'desc': 'Insert plunger to the 4 mark. Add rinsed paper filter to cap. Place on cup.',
            'durationSec': 20,
          },
          {
            'title': 'Add Coffee (0:00)',
            'desc': 'Add 17 g finely ground coffee (slightly coarser than espresso). Tare scale.',
            'durationSec': 10,
          },
          {
            'title': 'Bloom (0:10–0:40)',
            'desc': 'Pour 30 ml of 80°C water. Stir 10 times. Wait 30 s.',
            'durationSec': 30,
          },
          {
            'title': 'Fill (0:40–1:00)',
            'desc': 'Pour remaining water to 238 ml total. Stir gently 3 times.',
            'durationSec': 20,
          },
          {
            'title': 'Attach & Flip (1:00–1:20)',
            'desc': 'Attach cap. Carefully flip onto cup. Press slowly (30 s) until you hear a hiss.',
            'durationSec': 20,
          },
          {
            'title': 'Press (1:20–2:30)',
            'desc': 'Apply gentle, steady pressure. Stop when you hear a hiss — do not over-press.',
            'durationSec': 70,
          },
        ])),
      ),

      // ── French Press ───────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('french_press'),
        name: const Value('French Press'),
        description: const Value(
          'Full immersion and no paper filter = a rich, full-bodied cup with natural oils. '
          'Best suited for medium to dark roasts with chocolatey, nutty profiles.',
        ),
        ratioGramsPerMl: const Value(1 / 15),
        tempC: const Value(95.0),
        totalTimeSec: const Value(240),
        difficulty: const Value('Beginner'),
        flavorProfile: const Value('Full-Bodied & Rich'),
        iconName: const Value('french_press'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Preheat & Grind',
            'desc': 'Rinse French Press with hot water. Grind 30 g coffee coarsely (like sea salt).',
            'durationSec': 30,
          },
          {
            'title': 'Add Coffee & Pour (0:00)',
            'desc': 'Add coffee. Pour 95°C water to 450 ml in one go. Ensure all grounds are saturated.',
            'durationSec': 30,
          },
          {
            'title': 'Stir & Place Lid (0:30)',
            'desc': 'Stir top crust gently with a wooden spoon. Place lid — plunger up.',
            'durationSec': 15,
          },
          {
            'title': 'Steep (0:45–4:00)',
            'desc': 'Wait 3 minutes 15 seconds. Do not plunge yet.',
            'durationSec': 195,
          },
          {
            'title': 'Press & Pour (4:00)',
            'desc': 'Press plunger slowly and steadily. Pour immediately to a pre-warmed cup.',
            'durationSec': 30,
          },
        ])),
      ),

      // ── Espresso ───────────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('espresso'),
        name: const Value('Espresso'),
        description: const Value(
          'The foundation of most café drinks. Concentrated, syrupy and intense — '
          'with a golden crema. Demands precision in dose, grind and pressure.',
        ),
        ratioGramsPerMl: const Value(1 / 2),
        tempC: const Value(93.0),
        totalTimeSec: const Value(28),
        difficulty: const Value('Advanced'),
        flavorProfile: const Value('Intense & Syrupy'),
        iconName: const Value('espresso'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Dose & Distribute',
            'desc': 'Dose 18 g into portafilter. Use a distributor to level evenly.',
            'durationSec': 10,
          },
          {
            'title': 'Tamp',
            'desc': 'Tamp with ~15 kg pressure. Ensure perfectly level puck.',
            'durationSec': 5,
          },
          {
            'title': 'Lock & Pre-infuse',
            'desc': 'Lock portafilter. Start pre-infusion for 5 s at low pressure.',
            'durationSec': 5,
          },
          {
            'title': 'Extract (0:05–0:28)',
            'desc': 'Extract to 36 g of liquid in 23 s more (1:2 ratio). Target: 25–30 s total.',
            'durationSec': 23,
          },
          {
            'title': 'Evaluate Crema',
            'desc': 'Golden-hazel crema indicates proper extraction. Enjoy immediately.',
            'durationSec': 5,
          },
        ])),
      ),

      // ── Cold Brew ──────────────────────────────────────────────────────────
      BrewingRecipesCompanion(
        methodKey: const Value('cold_brew'),
        name: const Value('Cold Brew'),
        description: const Value(
          'Slow cold-water extraction over 12–24 hours produces a sweet, low-acidity concentrate '
          'with chocolate and caramel notes. Dilute 1:1 with water or milk to serve.',
        ),
        ratioGramsPerMl: const Value(1 / 8),
        tempC: const Value(4.0),
        totalTimeSec: const Value(57600), // 16 hours
        difficulty: const Value('Beginner'),
        flavorProfile: const Value('Sweet & Smooth'),
        iconName: const Value('cold_brew'),
        stepsJson: Value(jsonEncode([
          {
            'title': 'Grind Coarsely',
            'desc': 'Grind 100 g coffee very coarsely (like raw sugar). A coarser grind = less bitterness.',
            'durationSec': 60,
          },
          {
            'title': 'Combine',
            'desc': 'Add grounds to jar. Pour 800 ml cold filtered water. Stir gently to saturate.',
            'durationSec': 120,
          },
          {
            'title': 'Cover & Refrigerate',
            'desc': 'Cover with lid or cling film. Place in refrigerator.',
            'durationSec': 60,
          },
          {
            'title': 'Steep 12–24 h',
            'desc': '12 h = lighter & floral. 16 h = balanced. 24 h = intense concentrate.',
            'durationSec': 57600,
          },
        ])),
      ),
    ];

    for (final r in recipes) {
      await db.insertRecipe(r);
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // ENCYCLOPEDIA
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedEncyclopedia() async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty) return;

    final entries = [
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇪🇹'),
        country: const Value('Ethiopia (Worka Sakaro)'),
        region: const Value('Gedeb, Yirgacheffe'),
        altitudeMin: const Value(1990),
        altitudeMax: const Value(2190),
        varieties: const Value('Kurume (Heirloom)'),
        flavorNotes: Value(jsonEncode(['Jasmine', 'Peach', 'Earl Grey', 'Lemon Zest', 'Honey'])),
        processMethod: const Value('Washed'),
        harvestSeason: const Value('November – January'),
        cupsScore: const Value(88.5),
        description: const Value(
          'A classic, utterly transportive Ethiopian washed profile. Intense florality and delicate tea-like body '
          'that defines the pinnacle of Yirgacheffe terroir.',
        ),
        farmDescription: const Value('Washing Station: Worka Sakaro. Hundreds of local smallholder farmers deliver ripe cherries here. The incredibly slow drying process on raised beds (12-15 days) creates unmatched clarity.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&q=80'),
        plantationPhotosUrl: const Value('https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=600&q=80'),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Fully Washed', 'desc': 'Depulped, wet fermented for 36-48 hours, washed in channels, then dried on raised beds for 12-15 days. Yields clear floral notes.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇨🇴'),
        country: const Value('Colombia (El Paraiso)'),
        region: const Value('Piendamó, Cauca'),
        altitudeMin: const Value(1930),
        altitudeMax: const Value(1930),
        varieties: const Value('Castillo, Bourbon, Gesha'),
        flavorNotes: Value(jsonEncode(['Strawberry Yoghurt', 'Bubblegum', 'Lychee', 'Rose', 'Cinnamon'])),
        processMethod: const Value('Thermal Shock Anaerobic'),
        harvestSeason: const Value('Year Round (Mitaca & Main)'),
        cupsScore: const Value(89.7),
        description: const Value(
          'One of the most famous coffees in the modern specialty world, characterized by an explosion of artificial-seeming, intensely sweet fruit profiles derived from hyper-controlled processing.',
        ),
        farmDescription: const Value('Farmer: Diego Samuel Bermúdez. Finca El Paraíso uses advanced biotechnology, bioreactors for precise yeast fermentation, and a patented "thermal shock" washing process (hot then freezing water) to seal aroma compounds inside the bean.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1611162458324-aae1eb4129a4?w=600&q=80'),
        plantationPhotosUrl: const Value('https://images.unsplash.com/photo-1596524430615-b46475ddff6e?w=600&q=80'),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Double Anaerobic Thermal Shock', 'desc': 'First fermentation in cherry (48h at 18°C). Depulped, second fermentation in mucilage (96h at 19°C). Washed with 40°C water, then instantly rapidly cooled with 12°C water to seal pores.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇸🇻'),
        country: const Value('El Salvador (Kilimanjaro)'),
        region: const Value('Santa Ana Volcano'),
        altitudeMin: const Value(1500),
        altitudeMax: const Value(1720),
        varieties: const Value('Kenya SL-28, Bourbon'),
        flavorNotes: Value(jsonEncode(['Blackcurrant', 'Plum', 'Brown Sugar', 'Red Wine', 'Velvet'])),
        processMethod: const Value('Natural / Washed'),
        harvestSeason: const Value('December – March'),
        cupsScore: const Value(90.0),
        description: const Value(
          'A groundbreaking farm that brought Kenyan SL-28 varieties to Central America, creating a hybrid profile of intense African blackcurrant acidity with rich, thick Salvadoran chocolate body.',
        ),
        farmDescription: const Value('Farmer: Aída Batlle. Aída revolutionized coffee in El Salvador. Finca Kilimanjaro sits on the slopes of the Santa Ana volcano and is treated like a pristine vineyard, producing flawless Cup of Excellence winning lots.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1502462041640-b3d7e50d0662?w=600&q=80'),
        plantationPhotosUrl: const Value(''),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Slow Natural', 'desc': 'Cherries are dried intensely slowly on African beds, turned constantly to prevent any flawed fermentation, creating a clean, winey body.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇨🇷'),
        country: const Value('Costa Rica (Volcán Azul)'),
        region: const Value('West Valley'),
        altitudeMin: const Value(1500),
        altitudeMax: const Value(1700),
        varieties: const Value('San Isidro, Caturra, Gesha'),
        flavorNotes: Value(jsonEncode(['Mango', 'Honey', 'Milk Chocolate', 'Orange Zest'])),
        processMethod: const Value('Red Honey'),
        harvestSeason: const Value('November – March'),
        cupsScore: const Value(87.5),
        description: const Value(
          'An immaculate expression of the Costa Rican Honey process. Deeply sweet, coating mouthfeel, and vibrant tropical fruit acidity.',
        ),
        farmDescription: const Value('Farmer: Alejo Castro. The Castro family has been farming Volcán Azul for over 200 years. They protect vast areas of native rainforest alongside their coffee and frequently dominate the Costa Rica Cup of Excellence.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1498651036236-076136debc83?w=600&q=80'),
        plantationPhotosUrl: const Value(''),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Red / Black Honey', 'desc': 'Depulped but leaving 70-100% of the mucilage intact. Dried quickly initially to prevent mould, then slowly, resulting in heavy sweetness and fruit.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇵🇦'),
        country: const Value('Panama (La Esmeralda)'),
        region: const Value('Boquete'),
        altitudeMin: const Value(1500),
        altitudeMax: const Value(1900),
        varieties: const Value('Gesha (Geisha)'),
        flavorNotes: Value(jsonEncode(['Jasmine', 'Bergamot', 'Mandarin', 'Lemongrass', 'White Peach'])),
        processMethod: const Value('Washed / Natural'),
        harvestSeason: const Value('December – March'),
        cupsScore: const Value(93.5),
        description: const Value(
          'The coffee lot that shocked the world in 2004, introducing the Gesha varietal to the specialty market. Unparalleled floral elegance and tea-like transparency.',
        ),
        farmDescription: const Value('Farmer: The Peterson Family. Hacienda La Esmeralda effectively invented the modern super-specialty market when they separated the Geisha variety from their farm in Jaramillo. Their "Special" lots regularly break world auction records (\$1000+/lb).'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=600&q=80'),
        plantationPhotosUrl: const Value(''),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Washed', 'desc': 'Immaculate washed process designed exclusively to highlight the delicate Jasmine aromatics of the Gesha plant without any fermentation interference.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇨🇴'),
        country: const Value('Colombia (Paraiso 92)'),
        region: const Value('Piendamó, Cauca'),
        altitudeMin: const Value(1950),
        altitudeMax: const Value(1950),
        varieties: const Value('Sidra, Pink Bourbon, Caturra'),
        flavorNotes: Value(jsonEncode(['Mango', 'Passion Fruit', 'Yoghurt', 'Bubblegum'])),
        processMethod: const Value('Thermal Shock Aerobic/Anaerobic'),
        harvestSeason: const Value('May – July'),
        cupsScore: const Value(90.5),
        description: const Value('Wilton Benitez is a world-renowned coffee producer and chemical engineer known for his scientific approach to fermentation. His farm, Granja Paraiso 92, uses cutting-edge biotechnology to create hyper-flavorful coffees.'),
        farmDescription: const Value('Farmer: Wilton Benitez. Granja Paraiso 92 is a high-tech farm where every fermentation step is monitored. Wilton uses specialized yeast, bioreactors, and thermal shock washing to maximize the sensory potential of each lot.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1524350300060-d39f447a20ec?w=600&q=80'),
        plantationPhotosUrl: const Value('https://images.unsplash.com/photo-1502462041640-b3d7e50d0662?w=600&q=80'),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Thermal Shock', 'desc': 'Involves sudden temperature changes during washing (40°C then 12°C) to open and close the bean pores, trapping aroma compounds inside.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇲🇽'),
        country: const Value('Mexico (La Estancia)'),
        region: const Value('Veracruz'),
        altitudeMin: const Value(1350),
        altitudeMax: const Value(1350),
        varieties: const Value('Marsellesa, Gesha'),
        flavorNotes: Value(jsonEncode(['Chocolate', 'Roasted Almond', 'Red Apple', 'Caramel'])),
        processMethod: const Value('Honey / Natural'),
        harvestSeason: const Value('December – March'),
        cupsScore: const Value(87.2),
        description: const Value('Raul Alvarez is a prominent Mexican producer focusing on sustainable high-quality lots in the Veracruz region. His meticulous attention to drying protocols has put Mexico back on the specialty radar.'),
        farmDescription: const Value('Farmer: Raul Alvarez. Finca La Estancia is a model for modern Mexican specialty production, focusing on varietal separation and shade-grown practices that protect the local ecosystem.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=600&q=80'),
        plantationPhotosUrl: const Value(''),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'Black Honey', 'desc': 'Extended fermentation with 100% mucilage, dried slowly in shade to develop deep chocolate and winey notes.'}
        ])),
      ),
      EncyclopediaEntriesCompanion(
        countryEmoji: const Value('🇪🇹'),
        country: const Value('Ethiopia (Ture Waji)'),
        region: const Value('Guji, Shakiso'),
        altitudeMin: const Value(2100),
        altitudeMax: const Value(2350),
        varieties: const Value('Heirloom, 74110, 74112'),
        flavorNotes: Value(jsonEncode(['Peach', 'Bergamot', 'Jasmine Tea', 'Strawberry Candy'])),
        processMethod: const Value('Dry Process (Natural)'),
        harvestSeason: const Value('November – January'),
        cupsScore: const Value(91.5),
        description: const Value('Ture Waji, known as "The King of Guji", produces some of the most floral and complex natural coffees in the world at his Sookoo Coffee stations.'),
        farmDescription: const Value('Farmer: Ture Waji. Sookoo Coffee focuses on lot separation and precise drying. Ture teaches local farmers "green picking" (only ripe cherries) and uses high-altitude drying beds (2100m+) where cool winds ensure a slow, 20-day drying phase that produces exceptionally clean, vibrant cup profiles.'),
        farmPhotosUrlCover: const Value('https://images.unsplash.com/photo-1544483384-933e1ba4200c?w=600&q=80'),
        plantationPhotosUrl: const Value('https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600&q=80'),
        processingMethodsJson: Value(jsonEncode([
          {'name': 'High-Altitude Natural', 'desc': 'Cherries are dried for 15-20 days on raised beds. Constant rotation and thin layering ensure no "boozy" defects, only pure fruit and floral notes.'}
        ])),
      ),
    ];

    for (final e in entries) {
      await db.insertOrigin(e);
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // LATTE ART PATTERNS
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedLatteArtPatterns() async {
    final isEmpty = await db.patternsIsEmpty();
    if (!isEmpty) return;

    final patterns = [
      LatteArtPatternsCompanion(
        name: const Value('Heart'),
        difficulty: const Value(1),
        description: const Value('The classic latte art pattern. A great starting point for any barista.'),
        tipText: const Value('Pour at a medium height first, then lower the pitcher close to the surface to float milk and push the dot through.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Steam milk to 60–65°C with a silky, velvety texture. No large bubbles.'},
          {'step': 2, 'instruction': 'Fill cup to 1/3 with espresso. Tilt cup slightly towards you.'},
          {'step': 3, 'instruction': 'Pour from ~10 cm height into centre. Let white crema form a circle.'},
          {'step': 4, 'instruction': 'Lower pitcher to almost touching the milk surface.'},
          {'step': 5, 'instruction': 'Wiggle the pitcher slightly left-right while pouring to form a circle.'},
          {'step': 6, 'instruction': 'Pull pitcher forward through the white blob to form the heart point.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Tulip'),
        difficulty: const Value(2),
        description: const Value('Stacked milk layers create an elegant tulip silhouette — a café staple.'),
        tipText: const Value('Each "petal" is a separate pour that pushes the previous one back. Start with a high pour, then lower.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Prepare espresso. Steam milk to thick, creamy texture.'},
          {'step': 2, 'instruction': 'Tilt cup. High pour into centre — let crema whiten slightly.'},
          {'step': 3, 'instruction': 'Lower pitcher. Pour 1st blob near back of cup — stop once white appears.'},
          {'step': 4, 'instruction': 'Lift pitcher briefly, then pour 2nd blob slightly in front of 1st.'},
          {'step': 5, 'instruction': 'Repeat for 3rd smaller blob creating a stack of petals.'},
          {'step': 6, 'instruction': 'Pull forward through all three blobs in a straight line to finish.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Rosetta'),
        difficulty: const Value(3),
        description: const Value('The fern-leaf pattern that defines specialty coffee artistry. Requires wrist control.'),
        tipText: const Value('The side-to-side wiggle creates the leaf ribs. Move BACK (away from you) while wiggling, then pull forward fast.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Steam milk to glossy, paint-like texture. Very fine microfoam.'},
          {'step': 2, 'instruction': 'Tilt cup. Pour from height to pre-fill 1/3 and get crema flowing.'},
          {'step': 3, 'instruction': 'Lower pitcher to surface. Begin a rapid left-right wiggle.'},
          {'step': 4, 'instruction': 'Slowly move the pitcher BACKWARD (toward the far rim) while wiggling.'},
          {'step': 5, 'instruction': 'When near the far rim, stop wiggling and pull pitcher forward quickly toward you — this creates the stem.'},
          {'step': 6, 'instruction': 'Keep pouring until cup is full. Lift pitcher slightly to cut the line.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Phoenix Tail'),
        difficulty: const Value(4),
        description: const Value('An advanced pattern combining rosetta technique with circular pours to mimic a phoenix feather.'),
        tipText: const Value('Combine the rosetta base with a curved pour path rather than a straight line. Takes practice!'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Steam ultra-fine microfoam. Milk temperature 60°C max.'},
          {'step': 2, 'instruction': 'Pre-fill cup with espresso to 1/4.'},
          {'step': 3, 'instruction': 'Start a wide rosetta on one side of the cup with the wiggle technique.'},
          {'step': 4, 'instruction': 'Instead of pulling straight, curve the stem in an arc across the cup.'},
          {'step': 5, 'instruction': 'At the apex, flick the pitcher tip upward to create the "tail" flare.'},
          {'step': 6, 'instruction': 'Finish with a tiny circle at the head to complete the phoenix silhouette.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Leaf'),
        difficulty: const Value(3),
        description: const Value('A symmetrical leaf or fern with a central spine and paired ribs. Elegant and clean.'),
        tipText: const Value('Keep your wiggle tight and even. The spine line must be perfectly centered for a good leaf.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Steam milk to silky, thin microfoam.'},
          {'step': 2, 'instruction': 'Fill 1/4 of cup with high pour.'},
          {'step': 3, 'instruction': 'Lower pitcher. Begin a tight, even side-to-side wiggle.'},
          {'step': 4, 'instruction': 'Move pitcher backward (away) while wiggling symmetrically.'},
          {'step': 5, 'instruction': 'When you reach the far rim, reduce wiggle amplitude to form narrow tip.'},
          {'step': 6, 'instruction': 'Pull pitcher forward in a straight line for the central spine.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Swan'),
        difficulty: const Value(5),
        description: const Value('The pinnacle of latte art — a swan with a rosetta body and curved neck. Competition level.'),
        tipText: const Value('The neck is drawn last with a thin pour. Practise the body (rosetta) and head (circle) separately first.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Ultra-fine microfoam, as smooth as wet paint. Critical for this pattern.'},
          {'step': 2, 'instruction': 'Pre-fill 1/3 of cup from height.'},
          {'step': 3, 'instruction': 'Create a full rosetta on one side of the cup — this is the body.'},
          {'step': 4, 'instruction': 'On the opposite side, pour a small filled circle — the swan head.'},
          {'step': 5, 'instruction': 'Connect head to body with a thin, curved line — the neck with an S-curve.'},
          {'step': 6, 'instruction': 'Optionally add a small beak dot and eye with a cocktail stick.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Dragon'),
        difficulty: const Value(5),
        description: const Value('An elaborate multi-step design combining multiple rosettes and creative etching. Barista championship territory.'),
        tipText: const Value('Use a combination of poured layers and a toothpick for etching fine details like scales and claws.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Make espresso with a thick, stable crema. Prep silky microfoam.'},
          {'step': 2, 'instruction': 'Pour base — fill 2/3 of cup from height to set a dark crema canvas.'},
          {'step': 3, 'instruction': 'Pour a large rosetta as the dragon\'s scaled body in the centre.'},
          {'step': 4, 'instruction': 'Add a small round head blob at one end of the rosetta.'},
          {'step': 5, 'instruction': 'Use a toothpick to drag wings from the rosetta ribs.'},
          {'step': 6, 'instruction': 'Etch details: claws, flame, spine ridges with toothpick.'},
        ])),
      ),
      LatteArtPatternsCompanion(
        name: const Value('Free Pour Circle'),
        difficulty: const Value(1),
        description: const Value('The simplest pattern — a clean white circle on dark crema. Focus on milk texture here.'),
        tipText: const Value('Nail this before moving on. If you can\'t make a clean circle, your milk texture needs work.'),
        stepsJson: Value(jsonEncode([
          {'step': 1, 'instruction': 'Steam milk to 65°C. Texture should look like glossy liquid silk.'},
          {'step': 2, 'instruction': 'Swirl the pitcher to keep milk uniform — no separation.'},
          {'step': 3, 'instruction': 'Tilt cup. Pour from ~10 cm into the centre of the espresso.'},
          {'step': 4, 'instruction': 'Once cup is half-full, lower pitcher to milk surface.'},
          {'step': 5, 'instruction': 'Increase pour speed slightly — let white rise in a circle.'},
          {'step': 6, 'instruction': 'Lift pitcher to cut. Observe the white circle — crisp edge = good milk.'},
        ])),
      ),
    ];

    for (final pat in patterns) {
      await db.insertPattern(pat);
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // SPECIALTY ARTICLES (Education)
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> _seedSpecialtyArticles() async {
    final isEmpty = await db.specialtyArticlesIsEmpty();
    if (!isEmpty) return;

    final articles = [
      SpecialtyArticlesCompanion(
        title: const Value('Як оцінюють зерно (Q-Grading)'),
        subtitle: const Value('SCA Протокол, 10 параметрів якості та формування оцінки'),
        imageUrl: const Value('https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=600&q=80'),
        readTimeMin: const Value(6),
        contentHtml: const Value('''
          <h3>Протокол SCA (Specialty Coffee Association)</h3>
          <p>Щоб кава отримала статус "Спешелті", вона повинна набрати щонайменше <b>80 балів зі 100</b> за результатами офіційного капінгу (сліпої дегустації), що проводиться сертифікованими Q-грейдерами.</p>
          <br>
          <h3>Як відбувається капінг?</h3>
          <p>Кава обсмажується дуже світло. Робиться грубий помол. Кава заварюється прямо в чашці гарячою водою (93°C). Дегустатори "ламають шапку" кави ложкою для оцінки аромату, а потім сьорбають каву зі спеціальних ложок з розпиленням по всій порожнині рота.</p>
          <br>
          <h3>10 параметрів оцінки (кожен дає до 10 балів):</h3>
          <ol>
            <li><b>Fragrance/Aroma (Аромат меленої / завареної кави):</b> Інтенсивність та складність запаху.</li>
            <li><b>Flavor (Смак):</b> Головний характер кави. Чистий, яскравий, комплексний?</li>
            <li><b>Aftertaste (Післясмак):</b> Наскільки приємним є смак після того, як ви проковтнули каву. Короткий і гіркий знижує бал.</li>
            <li><b>Acidity (Кислотність):</b> Це не "кислятина", це якість кислотності. Яскрава яблучна, винна, лимонна кислотність додає свіжості.</li>
            <li><b>Body (Тіло):</b> Тактильне відчуття в роті. Водяниста (погано) чи сиропна, округла, вершкова (добре).</li>
            <li><b>Balance (Баланс):</b> Як кислотність, солодкість і тіло поєднуються між собою. Чи ніщо не "випирає"?</li>
            <li><b>Uniformity (Однорідність):</b> Оцінюється 5 чашок одного лота. Якщо 1 чашка гірша за інші на смак — мінус 2 бали.</li>
            <li><b>Clean Cup (Чистота чашки):</b> Відсутність негативних чи брудних землистих нот.</li>
            <li><b>Sweetness (Солодкість):</b> Природна солодкість кави. Не цукрова, а фруктова або карамельна.</li>
            <li><b>Overall (Загальне враження):</b> Особиста оцінка судді: наскільки кава йому сподобалась емоційно.</li>
          </ol>
          <br>
          <h3>Система Штрафів (Taints & Faults)</h3>
          <p>Якщо в каві є дефекти (фермент, пліснява, картопляна хвороба), бали сильно віднімаються. Лише кава без первинних дефектів зеленого зерна має право називатись Спешелті.</p>
          <p><b>Шкала:</b><br>80-84.99: Дуже хороша (Specialty)<br>85-89.99: Відмінна (Excellent)<br>90-100: Видатна (Outstanding - часто лоти переможців Cup of Excellence).</p>
        '''),
      ),
      SpecialtyArticlesCompanion(
        title: const Value('Всі існуючі методи обробки'),
        subtitle: const Value('Від митої класики до термошоку та анаеробу'),
        imageUrl: const Value('https://images.unsplash.com/photo-1524403831873-1002221b0126?w=600&q=80'),
        readTimeMin: const Value(8),
        contentHtml: const Value('''
          <h3>Чому обробка критично важлива?</h3>
          <p>Зерно, яке ми смажимо, — це кісточка всередині солодкої кавової ягоди. Завдання фермера: дістати кісточку і висушити її. Різні підходи до цього і є методами обробки. Ферментація під час сушіння змінює хімічний склад зерна, що безпосередньо формує його смак.</p>
          <br>
          <h3>1. Мита обробка (Washed)</h3>
          <img src="https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=800&q=80" width="100%">
          <p><b>Суть:</b> Ягоди пропускають через депульпатор (знімають шкірку та м'якоть). Зерна в липкому слизу (м'юсіляжі) кидають у басейни з водою на 12-48 годин. Бактерії з'їдають слиз. Потім зерно миють чистою водою і сушать.<br>
          <b>Профіль:</b> Максимально чистий смак, який розкриває генетику дерева і теруар. Висока, яскрава кислотність. Ноти квітів, цитрусів, чаю. Легке тіло.</p>
          <br>
          <h3>2. Натуральна обробка (Natural / Dry)</h3>
          <img src="https://images.unsplash.com/photo-1542612304-f58c403309f4?w=800&q=80" width="100%">
          <p><b>Суть:</b> Найдавніший метод. Зібрані червоні ягоди просто розкладають сушитись на бетонному патіо або африканських ліжках просто неба на 2-4 тижні. Ягода засихає як ізюм, віддаючи всі цукри зерну всередині. Лише потім висохлу кірку лущитимуть.<br>
          <b>Профіль:</b> Висока інтенсивна солодкість, важке густе тіло. Яскраві ноти полуниці, чорниці, джему, часто з "алкогольними" винними відтінками.</p>
          <br>
          <h3>3. Напівмита / Хані (Honey)</h3>
          <img src="https://images.unsplash.com/photo-1506377711774-84616239bc7a?w=800&q=80" width="100%">
          <p><b>Суть:</b> Шкірку знімають депульпатором, але липкий солодкий м'юсіляж залишають на зерні і прямо так сушать. Залежно від кількості залишеного слизу розрізняють: Білий (найменше), Жовтий, Червоний, та Чорний (найбільше слизу і найдовша сушка) Хані.<br>
          <b>Профіль:</b> Баланс. Не така кисла як мита, але чистіша за натуральну. Класичний присмак карамелі, меду та тростиннового цукру.</p>
          <br>
          <h3>4. Вет-хал (Wet Hulled / Giling Basah)</h3>
          <p><b>Суть:</b> Унікальний індонезійський метод. Через високу вологість зерно лущать від пачменту (оболонки) коли воно ще вологе (~30%), і досушують "голим" зеленим.<br>
          <b>Профіль:</b> Низька кислотність, дуже важке тіло, землисті і спецієві нотки: кедр, тютюн, перець.</p>
          <br>
          <h3>5. Анаеробна Ферментація (Anaerobic)</h3>
          <img src="https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&q=80" width="100%">
          <p><b>Суть:</b> Цілі ягоди або депульповані зерна поміщають у герметичні бочки / танки, звідки відкачують кисень на 48–120 годин. Без кисню починають працювати зовсім інші бактерії (молочнокислі тощо), формуючи нові складні кислоти.<br>
          <b>Профіль:</b> Дуже незвичний, фанкі. Кориця, бабл-гам, тропічні фрукти (ананас, манго), молочний шоколад, йогурт.</p>
          <br>
          <h3>6. Карбонічна мацерація (Carbonic Maceration)</h3>
          <p><b>Суть:</b> Запозичено з виноробства (Божоле). Ягоди кладуть у танк і закачують туди вуглекислий газ, витісняючи кисень під тиском. Ягода починає частково бродити зсередини ферментами самої ягоди, а не дріжджами.<br>
          <b>Профіль:</b> Надзвичайна чистота і яскравість ягід рожевого кольору, виноград, винна кислотність.</p>
          <br>
          <h3>7. Термошок (Thermal Shock) та Ко-ферментація</h3>
          <p><b>Суть:</b> Зерно миють спочатку водою 40°C, щоб розширити пори і ввібрати продукти анаеробної ферментації, а потім різко обдають водою 12°C, щоб "закрити" їх. Ко-ферментація: додавання фруктів (наприклад манго або персика) під час бочкової ферментації.<br>
          <b>Профіль:</b> Вибух. Кава може смакувати буквально як персиковий сік або полуничний йогурт. Радикально штучно-солодкий профіль на який скаржаться багато пуристів, але він підкорив сучасний ринок.</p>
        '''),
      ),
      SpecialtyArticlesCompanion(
        title: const Value('Золоті Стандарти Заварювання (SCA)'),
        subtitle: const Value('TDS, Екстракція та як приготувати ідеальну чашку'),
        imageUrl: const Value('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&q=80'),
        readTimeMin: const Value(10),
        contentHtml: const Value('''
          <h3>Що таке ініціатива "Gold Cup"?</h3>
          <p>SCA розробила науковий стандарт для заварювання фільтр-кави, який базується на двох головних показниках: <b>Екстракція (Extraction Yield)</b> та <b>Міцність (TDS)</b>.</p>
          <br>
          <h3>1. Екстракція (Extraction %): 18–22%</h3>
          <p>Це відсоток кавових речовин, які ми вимили з меленого зерна у воду.<br>
          - <b>Менше 18% (Under-extracted):</b> Кава буде солоною, трав\'янистою та порожньою.<br>
          - <b>Більше 22% (Over-extracted):</b> Кава буде гіркою, терпкою та сухою на язиці.<br>
          Золота середина (18-22%) забезпечує баланс солодкого та кислого.</p>
          <br>
          <h3>2. Міцність (TDS): 1.15% – 1.45%</h3>
          <p>TDS (Total Dissolved Solids) показує концентрацію кави. Це відсоток саме кави у вашій чашці порівняно з водою.<br>
          - 1.15% — це легке, чайне тіло.<br>
          - 1.45% — це насичене, інтенсивне тіло.</p>
          <br>
          <h3>Класичний Brew Control Chart</h3>
          <p>Для досягнення цих показників використовується стандартне співвідношення (Ratio): <b>60 грамів кави на 1 літр води</b> (або 1:16.6).</p>
          <br>
          <h3>Вимоги до води (Water Standards):</h3>
          <ul>
            <li><b>Колір/Запах:</b> Відсутні.</li>
            <li><b>Загальна мінералізація (TDS):</b> 75–175 ppm (ідеально 150).</li>
            <li><b>Кальцієва жорсткість:</b> 17–85 мг/л.</li>
            <li><b>pH:</b> 6.5 – 7.5.</li>
          </ul>
          <p>Проста фільтрована вода часто занадто м\'яка, а вода з-під крана — занадто жорстка. Спешелті-кав\'ярні використовують системи зворотного осмосу з подальшою мінералізацією.</p>
          <br>
          <h3>Температура та час заварювання:</h3>
          <p>Стандарт передбачає контакт кави з водою температурою <b>92°C – 96°C</b>. Час залежить від методу: для пуроверів це зазвичай 2.5 – 3.5 хвилини.</p>
        '''),
      ),
    ];

    for (final art in articles) {
      await db.insertSpecialtyArticle(art);
    }
  }

  Future<void> _seedRecommendedRecipes() async {
    // Always delete and re-seed recipes to keep them updated
    await db.delete(db.recommendedRecipes).go();

    final allLots = await db.getAllOrigins();
    if (allLots.isEmpty) {
      debugPrint('DB SEEDING: No lots found for recommended recipes.');
      return;
    }

    for (final lot in allLots) {
      final process = lot.processMethod.toLowerCase();
      
      // Adjust V60 params based on processing method
      final double coffeeG;
      final double waterG;
      final double tempC;
      final int timeSec;
      final String grindNote;
      final Map<String, int> sensory;
      final String notes;

      if (process.contains('natural') || process.contains('натур')) {
        coffeeG = 15.0; waterG = 250.0; tempC = 91.0; timeSec = 195;
        grindNote = '24 clicks Comandante / medium-coarse';
        sensory = {'sweetness': 5, 'acidity': 3, 'body': 4, 'balance': 4, 'aroma': 5, 'aftertaste': 4};
        notes = 'Natural process: lower temp (91°C) to avoid over-extraction of fruity sugars. Bloom 50ml / 45s. Pour slowly in 3 stages.';
      } else if (process.contains('anaerobic') || process.contains('анаероб')) {
        coffeeG = 15.0; waterG = 250.0; tempC = 90.0; timeSec = 210;
        grindNote = '23 clicks Comandante / medium-coarse';
        sensory = {'sweetness': 5, 'acidity': 4, 'body': 4, 'balance': 4, 'aroma': 5, 'aftertaste': 5};
        notes = 'Anaerobic: use 90°C to tame fermentation intensity. Slow bloom 60s. Pull sweet, complex notes slowly.';
      } else if (process.contains('thermal') || process.contains('термал')) {
        coffeeG = 15.0; waterG = 250.0; tempC = 90.0; timeSec = 200;
        grindNote = '22 clicks Comandante / medium';
        sensory = {'sweetness': 5, 'acidity': 5, 'body': 3, 'balance': 4, 'aroma': 5, 'aftertaste': 5};
        notes = 'Thermal Shock: keep temp at 90°C to preserve the volatile aroma compounds. Bloom 45ml / 40s. 3 pours.';
      } else if (process.contains('honey') || process.contains('хані')) {
        coffeeG = 15.5; waterG = 240.0; tempC = 92.0; timeSec = 190;
        grindNote = '22 clicks Comandante / medium';
        sensory = {'sweetness': 5, 'acidity': 3, 'body': 4, 'balance': 5, 'aroma': 4, 'aftertaste': 4};
        notes = 'Honey process: slightly higher dose for caramel sweetness. Bloom 45ml / 35s. 2 main pours.';
      } else {
        // Default: Washed
        coffeeG = 15.0; waterG = 250.0; tempC = 93.0; timeSec = 180;
        grindNote = '21 clicks Comandante / medium-fine';
        sensory = {'sweetness': 3, 'acidity': 5, 'body': 3, 'balance': 4, 'aroma': 4, 'aftertaste': 4};
        notes = 'Washed: use 93°C to extract full acidity and clarity. Bloom 45ml / 30s. 3 equal pours.';
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

