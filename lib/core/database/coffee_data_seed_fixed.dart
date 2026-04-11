import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'app_database.dart';

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  Future<void> seedAll({
    bool force = true,
    Function(String)? onProgress,
  }) async {
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
    final List<Map<String, dynamic>> brandsToSeed = [
      {
        'main': LocalizedBrandsCompanion.insert(
          name: 'Mad Heads [STABLE]',
          logoUrl: const Value(
            'https://madheadscoffee.com/wp-content/uploads/2021/05/Logo_MH_Black-1.png',
          ),
          siteUrl: const Value('https://madheadscoffee.com/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 0, // Placeholder
            languageCode: 'uk',
            fullDesc: const Value(
              'Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році. '
              'Ми фокусуюсь на пошуку унікальних мікролотів та інноваційних методах обробки.',
            ),
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            location: const Value('Київ, вул. Кирилівська 69'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 0,
            languageCode: 'en',
            fullDesc: const Value(
              'Mad Heads Coffee is an independent Ukrainian roaster founded in 2017.',
            ),
            location: const Value('Kyiv, Kyrylivska st. 69'),
          ),
        ],
      },
      {
        'main': LocalizedBrandsCompanion.insert(
          name: '3Champs [STABLE]',
          logoUrl: const Value(
            'https://3champsroastery.com.ua/images/logo.png',
          ),
          siteUrl: const Value('https://3champsroastery.com.ua/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 0,
            languageCode: 'uk',
            fullDesc: const Value(
              '3Champs Roastery — це команда професіоналів. Плодова 1.',
            ),
            shortDesc: const Value(
              'Спешелті обсмажка з акцентом на чистоту та яскравість смаку.',
            ),
            location: const Value('Kyiv, Plodova 1'),
          ),
        ],
      },
    ];

    for (var item in brandsToSeed) {
      final mainComp = item['main'] as LocalizedBrandsCompanion;
      final existing = await db.getAllBrands();
      if (!existing.any((b) => b.name == mainComp.name.value)) {
        final id = await db.insertBrand(mainComp);
        for (var trans
            in item['trans'] as List<LocalizedBrandTranslationsCompanion>) {
          await db.insertBrandTranslation(trans.copyWith(brandId: Value(id)));
        }
      }
    }
  }

  Future<void> _seedMadHeadsOrigins() async {
    int? brandId;
    final allBrands = await db.getAllBrands();
    final mh = allBrands.firstWhere(
      (b) => b.name == 'Mad Heads [STABLE]',
      orElse: () => throw Exception('Brand not found'),
    );
    brandId = mh.id;

    await db.deleteUserLotsByBrand(brandId);

    final entries = [
      {
        'main': LocalizedBeansCompanion.insert(
          brandId: Value(brandId),
          countryEmoji: const Value('🇹🇿'),
          altitudeMin: const Value(1600),
          altitudeMax: const Value(1600),
          cupsScore: const Value(85.5),
          sensoryJson: Value(
            jsonEncode({
              'indicators': {
                'acidity': 3,
                'sweetness': 4,
                'bitterness': 2,
                'intensity': 3,
              },
              'aroma': 'Квітково-фруктовий',
              'acidityType': 'Чиста, цитрусова',
              'bodyType': 'Середнє, гладке',
              'aftertaste': 'Медова солодкість',
            }),
          ),
        ),
        'trans': LocalizedBeanTranslationsCompanion.insert(
          beanId: 0,
          languageCode: 'uk',
          country: const Value('TANZANIA - Utengule'),
          region: const Value('Utengule'),
          processMethod: const Value('Honey'),
          varieties: const Value('Bourbon'),
          description: const Value('Солодкий та збалансований лот з Танзанії.'),
          flavorNotes: Value(
            jsonEncode(['Peach', 'Green apple', 'Yellow plum', 'White tea']),
          ),
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
          description: const Value('Витримана натуральна обробка.'),
        ),
      },
    ];

    for (var entry in entries) {
      final id = await db.insertBean(entry['main'] as LocalizedBeansCompanion);
      await db.insertBeanTranslation(
        (entry['trans'] as LocalizedBeanTranslationsCompanion).copyWith(
          beanId: Value(id),
        ),
      );
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    int? brandId;
    try {
      final allBrands = await db.getAllBrands();
      final brand = allBrands.firstWhere(
        (b) => b.name == '3Champs [STABLE]',
        orElse: () => throw Exception('Brand not found'),
      );
      brandId = brand.id;
    } catch (e) {
      debugPrint('DB SEEDING ERROR looking for 3Champs [STABLE]: $e');
    }

    if (brandId == null) return;

    await db.deleteUserLotsByBrand(brandId);

    final entries = [
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 46 Filter',
        emoji: '🇨🇴',
        region: 'Las Moras (Huila)',
        process: 'Natural',
        varieties: 'Caturra, Castillo',
        notes: ['Pear', 'Kiwi', 'Marzipan'],
        desc:
            'Складна кислотність, довгий ожиновий післясмак. Ціна (250г): 405₴ роздріб / 325₴ опт. Ціна (1кг): 1620₴ роздріб / 1300₴ опт.',
        roast: 'Light',
        price: '405₴',
        weight: '250g',
        indicators: {
          'acidity': 4,
          'sweetness': 4,
          'bitterness': 1,
          'intensity': 4,
        },
        markdown:
            '### Етап 1: Селективний збір\n### Етап 2: Натуральна сушка на ліжках (2-4 тижні)\n### Етап 3: Стабілізація вологості',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 31 Filter',
        emoji: '🇨🇴',
        region: 'Granja Paraiso 92',
        process: 'Thermal Shock',
        varieties: 'Chiroso',
        notes: ['Jasmine', 'Blueberry', 'Kiwi'],
        desc:
            'Тривала яблучна кислотність. Ціна (250г): 485₴ роздріб / 405₴ опт. Ціна (1кг): 1940₴ роздріб / 1620₴ опт.',
        roast: 'Light',
        price: '485₴',
        weight: '250g',
        indicators: {
          'acidity': 5,
          'sweetness': 4,
          'bitterness': 1,
          'intensity': 5,
        },
        markdown:
            '### Етап 1: Анаеробна ферментація\n### Етап 2: Гарячий термальний шок (40°C)\n### Етап 3: Холодний термальний шок (12°C)\n### Етап 4: Контрольована сушка',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 45 Filter',
        emoji: '🇨🇴',
        region: 'Granja Paraiso 92',
        process: 'Thermal Shock',
        varieties: 'Red Bourbon',
        notes: ['Rose', 'Grapefruit', 'Biscuit'],
        desc:
            'Квітковий лот з ніжним тілом. Ціна (250г): 485₴ роздріб / 405₴ опт. Ціна (1кг): 1940₴ роздріб / 1620₴ опт.',
        roast: 'Light',
        price: '485₴',
        weight: '250g',
        indicators: {
          'acidity': 4,
          'sweetness': 5,
          'bitterness': 1,
          'intensity': 4,
        },
        markdown:
            '### Етап 1: Анаеробна ферментація\n### Етап 2: Термальний шок для фіксації аромату\n### Етап 3: Дегідратація у механічних сушках',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'KENYA 20 Filter',
        emoji: '🇰🇪',
        region: 'Kirinyaga',
        process: 'Washed',
        varieties: 'SL28, SL34',
        notes: ['Red Berries', 'Honey', 'Orange'],
        desc:
            'Яскрава ягідна класика. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {
          'acidity': 5,
          'sweetness': 3,
          'bitterness': 1,
          'intensity': 4,
        },
        markdown:
            '### Етап 1: Депульпація\n### Етап 2: Ферментація у танку\n### Етап 3: Промивка та сушка на ліжках',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'ETHIOPIA 37 Filter',
        emoji: '🇪🇹',
        region: 'Uraga (Guji)',
        process: 'Washed',
        varieties: 'Heirloom',
        notes: ['Lemon', 'Jasmine', 'Green tea'],
        desc:
            'Чистий та елегантний чайний профіль. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {
          'acidity': 4,
          'sweetness': 3,
          'bitterness': 1,
          'intensity': 3,
        },
        markdown:
            '### Етап 1: Мокра обробка\n### Етап 2: Відмивка муселя\n### Етап 3: Повільна сушка',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'RWANDA 14 Filter',
        emoji: '🇷🇼',
        region: 'Coacambu',
        process: 'Natural',
        varieties: 'Red Bourbon',
        notes: ['Orange', 'Biscuit', 'Stone fruits'],
        desc:
            'Збалансована та солодка натуральна Руанда. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Light',
        price: '420₴',
        weight: '250g',
        indicators: {
          'acidity': 3,
          'sweetness': 4,
          'bitterness': 2,
          'intensity': 4,
        },
        markdown:
            '### Етап 1: Сортування ягід\n### Етап 2: Натуральна сушка\n### Етап 3: Халінг перед відправкою',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'INDONESIA 4 Filter',
        emoji: '🇮🇩',
        region: 'Frinza',
        process: 'Anaerobic Natural',
        varieties: 'S-Lini, Bor-Bor',
        notes: ['Orange', 'Blueberry', 'Rhubarb'],
        desc:
            'Ціна (250г): 465₴ роздріб / 385₴ опт. Ціна (1кг): 1860₴ роздріб / 1540₴ опт.',
        roast: 'Light',
        price: '465₴',
        weight: '250g',
        indicators: {
          'acidity': 4,
          'sweetness': 4,
          'bitterness': 1,
          'intensity': 5,
        },
        markdown:
            '### Етап 1: Анаеробна ферментація 72г\n### Етап 2: Натуральна сушка',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'ETHIOPIA 37 Espresso',
        emoji: '🇪🇹',
        region: 'Uraga (Guji)',
        process: 'Washed',
        varieties: 'Heirloom',
        notes: ['Peach', 'Jasmine', 'Apple'],
        desc:
            'Еспресо-обсмажка класичної Ефіопії. Дуже солодка. Ціна (250г): 420₴ роздріб / 340₴ опт. Ціна (1кг): 1680₴ роздріб / 1360₴ опт.',
        roast: 'Dark',
        price: '420₴',
        weight: '250g',
        indicators: {
          'acidity': 3,
          'sweetness': 5,
          'bitterness': 2,
          'intensity': 4,
        },
        markdown:
            '### Етап 1: Мита обробка\n### Етап 2: Темне обсмажування під еспресо',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'COLOMBIA 46 Espresso',
        emoji: '🇨🇴',
        region: 'Las Moras',
        process: 'Natural',
        varieties: 'Caturra/Castillo',
        notes: ['Pear', 'Marzipan', 'Berries'],
        desc:
            'Щільне тіло, ідеально для молочних напоїв. Ціна (250г): 405₴ роздріб / 325₴ опт. Ціна (1кг): 1620₴ роздріб / 1300₴ опт.',
        roast: 'Dark',
        price: '405₴',
        weight: '250g',
        indicators: {
          'acidity': 2,
          'sweetness': 5,
          'bitterness': 3,
          'intensity': 5,
        },
        markdown:
            '### Етап 1: Натуральна обробка\n### Етап 2: Розвинуте обсмажування',
      ),
      _create3ChampsEntry(
        brandId: brandId,
        country: 'GUATEMALA 9 Espresso',
        emoji: '🇬🇹',
        region: 'Huehuetenango',
        process: 'Washed',
        varieties: 'Bourbon, Caturra',
        notes: ['Chocolate', 'Caramel', 'Nuts'],
        desc:
            'Класичне еспресо з горіхово-шоколадним профілем. Ціна (250г): 370₴ роздріб / 290₴ опт. Ціна (1кг): 1480₴ роздріб / 1160₴ опт.',
        roast: 'Dark',
        price: '370₴',
        weight: '250g',
        indicators: {
          'acidity': 2,
          'sweetness': 4,
          'bitterness': 3,
          'intensity': 4,
        },
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
        desc:
            'Бюджетний та дуже стабільний лот для кав\'ярні. Ціна (250г): 310₴ роздріб / 230₴ опт. Ціна (1кг): 1240₴ роздріб / 920₴ опт.',
        roast: 'Dark',
        price: '310₴',
        weight: '250g',
        indicators: {
          'acidity': 1,
          'sweetness': 4,
          'bitterness': 4,
          'intensity': 5,
        },
        markdown:
            '### Етап 1: Натуральна сушка\n### Етап 2: Темне еспресо обсмаження',
      ),
    ];

    for (final e in entries) {
      final id = await db.insertBean(e.main);
      await db.insertBeanTranslation(e.trans.copyWith(beanId: Value(id)));
    }
  }

  _Entry3Champs _create3ChampsEntry({
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
    final main = LocalizedBeansCompanion.insert(
      brandId: Value(brandId),
      countryEmoji: Value(emoji),
      sensoryJson: Value(
        jsonEncode({
          'indicators': indicators,
          'aroma': notes.join(', '),
          'bodyType': (indicators['intensity'] ?? 0) > 3 ? 'Medium/Full' : 'Light',
          'aftertaste': 'Long, sweet',
          'acidityType': (indicators['acidity'] ?? 0) > 3 ? 'Bright' : 'Balanced',
        }),
      ),
      price: Value(price),
      weight: Value(weight),
      detailedProcessMarkdown: Value(markdown),
    );

    final trans = LocalizedBeanTranslationsCompanion.insert(
      beanId: 0, // Placeholder
      languageCode: 'uk',
      country: Value(country),
      region: Value(region),
      processMethod: Value(process),
      varieties: Value(varieties),
      flavorNotes: Value(jsonEncode(notes)),
      description: Value(desc),
      roastLevel: Value(roast),
    );

    return _Entry3Champs(main, trans);
  }

  Future<void> _seedBrewingRecipes() async {
    final existing = await db.getAllRecipes();
    if (existing.isNotEmpty) return;

    final recipes = [
      BrewingRecipesCompanion(
        methodKey: const Value('v60'),
        name: const Value('Hario V60'),
        description: const Value(
          'The V60 produces a clean, bright cup that highlights delicate floral and citrus notes.',
        ),
        ratioGramsPerMl: const Value(1 / 15),
        tempC: const Value(93.0),
        totalTimeSec: const Value(165),
        difficulty: const Value('Intermediate'),
        flavorProfile: const Value('Clean & Bright'),
        iconName: const Value('v60'),
        stepsJson: Value(
          jsonEncode([
            {
              'title': 'Grind & Heat',
              'desc': 'Grind 15 g coffee medium-fine. Heat water to 93°C.',
              'durationSec': 30,
            },
          ]),
        ),
      ),
      BrewingRecipesCompanion(
        methodKey: const Value('chemex'),
        name: const Value('Chemex'),
        description: const Value(
          'Chemex uses a thick bonded filter that removes oils for an exceptionally clean cup.',
        ),
        ratioGramsPerMl: const Value(1 / 15),
        tempC: const Value(93.0),
        totalTimeSec: const Value(165),
        difficulty: const Value('Intermediate'),
        flavorProfile: const Value('Elegant & Crisp'),
        iconName: const Value('chemex'),
        stepsJson: Value(jsonEncode([])),
      ),
    ];

    for (final r in recipes) {
      await db.into(db.brewingRecipes).insert(r);
    }
  }

  Future<void> _seedEncyclopedia() async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty) return;

    final entries = [
      LocalizedBeansCompanion.insert(
        countryEmoji: const Value('🇪🇹'),
        cupsScore: const Value(88.5),
      ),
    ];

    for (final e in entries) {
      final id = await db.insertBean(e);
      // Also seed translation for encyclopedia
      await db.insertBeanTranslation(
        LocalizedBeanTranslationsCompanion.insert(
          beanId: id,
          languageCode: 'en',
          country: const Value('Ethiopia (Worka Sakaro)'),
          region: const Value('Gedeb, Yirgacheffe'),
          varieties: const Value('Kurume (Heirloom)'),
          flavorNotes: Value(jsonEncode(['Jasmine', 'Peach', 'Earl Grey'])),
          processMethod: const Value('Washed'),
          description: const Value('A classic Ethiopian washed profile.'),
        ),
      );
    }
  }

  Future<void> _seedSpecialtyArticles() async {
    final isEmpty = await db.specialtyArticlesIsEmpty();
    if (!isEmpty) return;

    final articles = [
      _ArticleSeed(
        base: SpecialtyArticlesCompanion.insert(
          imageUrl: 'https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=600&q=80',
          readTimeMin: 6,
        ),
        trans: SpecialtyArticleTranslationsCompanion.insert(
          articleId: 0,
          languageCode: 'uk',
          title: 'Як оцінюють зерно (Q-Grading)',
          subtitle: 'SCA Протокол, 10 параметрів якості та формування оцінки',
          contentHtml: '<h3>Протокол SCA</h3><p>Основи оцінки спешелті кави.</p>',
        ),
      ),
    ];

    for (final art in articles) {
      final id = await db.insertArticle(art.base);
      await db.insertArticleTranslation(
        art.trans.copyWith(articleId: Value(id)),
      );
    }
  }

  Future<void> _seedRecommendedRecipes() async {
    final allLots = await db.getAllBeans('uk');
    for (final lot in allLots) {
      await db.insertRecommendedRecipe(
        RecommendedRecipesCompanion(
          lotId: Value(lot.id),
          methodKey: const Value('v60'),
          coffeeGrams: const Value(15.0),
          waterGrams: const Value(250.0),
          tempC: const Value(93.0),
          timeSec: const Value(180),
          rating: const Value(4.8),
          sensoryJson: Value(jsonEncode({})),
          notes: const Value('Default recipe for this lot.'),
        ),
      );
    }
  }
}

class _ArticleSeed {
  final SpecialtyArticlesCompanion base;
  final SpecialtyArticleTranslationsCompanion trans;
  _ArticleSeed({required this.base, required this.trans});
}

class _Entry3Champs {
  final LocalizedBeansCompanion main;
  final LocalizedBeanTranslationsCompanion trans;
  _Entry3Champs(this.main, this.trans);
}
