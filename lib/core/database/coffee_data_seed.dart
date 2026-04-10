import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'app_database.dart';
// Removed unused dtos.dart import

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  Future<void> seedAll({
    bool force = false,
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
    final isEmpty = await db.brandsIsEmpty();
    if (!isEmpty) return;

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
            brandId: 0,
            languageCode: 'uk',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value(
              'Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році. '
              'Ми фокусуємось на пошуку унікальних мікролотів та інноваційних методах обробки.',
            ),
            location: const Value('Київ, вул. Кирилівська 69'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 0,
            languageCode: 'en',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
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
            shortDesc: const Value(
              'Спешелті обсмажка з акцентом на чистоту та яскравість смаку.',
            ),
            fullDesc: const Value(
              '3Champs Roastery — це команда професіоналів. Плодова 1.',
            ),
            location: const Value('Kyiv, Plodova 1'),
          ),
        ],
      },
    ];

    for (var item in brandsToSeed) {
      final mainComp = item['main'] as LocalizedBrandsCompanion;
      final id = await db.insertBrand(mainComp);
      for (var trans
          in item['trans'] as List<LocalizedBrandTranslationsCompanion>) {
        await db.insertBrandTranslation(trans.copyWith(brandId: Value(id)));
      }
    }
  }

  Future<void> _seedMadHeadsOrigins() async {
    final allBrands = await db.getAllBrands('uk');
    final mh = allBrands.firstWhere(
      (b) => b.name == 'Mad Heads [STABLE]',
      orElse: () => throw Exception('Mad Heads brand not found'),
    );
    final brandId = mh.id;

    await db.deleteLotsForBrand(brandId);

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
    final allBrands = await db.getAllBrands('uk');
    final brand = allBrands.firstWhere(
      (b) => b.name == '3Champs [STABLE]',
      orElse: () => throw Exception('3Champs brand not found'),
    );
    final brandId = brand.id;

    await db.deleteLotsForBrand(brandId);

    final entries = [
      _create3ChampsEntry(
        brandId: brandId,
        countryCode: 'COLOMBIA 46 Filter',
        emoji: '🇨🇴',
        region: 'Las Moras (Huila)',
        process: 'Natural',
        varieties: 'Caturra, Castillo',
        notes: ['Pear', 'Kiwi', 'Marzipan'],
        desc: 'Складна кислотність, довгий ожиновий післясмак. Ціна (250г): 405₴ роздріб / 325₴ опт.',
        roast: 'Light',
        price: '405₴',
        weight: '250g',
        indicators: {
          'acidity': 4,
          'sweetness': 4,
          'bitterness': 1,
          'intensity': 4,
        },
        markdown: '### Етап 1: Селективний збір\n### Етап 2: Натуральна сушка на ліжках\n### Етап 3: Стабілізація вологості',
      ),
    ];

    for (var entry in entries) {
      final id = await db.insertBean(entry.main);
      await db.insertBeanTranslation(entry.trans.copyWith(beanId: Value(id)));
    }
  }

  _Entry3Champs _create3ChampsEntry({
    required int brandId,
    required String countryCode,
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
    return _Entry3Champs(
      LocalizedBeansCompanion.insert(
        brandId: Value(brandId),
        countryEmoji: Value(emoji),
        price: Value(price),
        weight: Value(weight),
        detailedProcessMarkdown: Value(markdown),
        sensoryJson: Value(
          jsonEncode({
            'indicators': indicators,
            'aroma': notes.join(', '),
            'bodyType': indicators['intensity']! > 3 ? 'Medium/Full' : 'Light',
          }),
        ),
      ),
      LocalizedBeanTranslationsCompanion.insert(
        beanId: 0,
        languageCode: 'uk',
        country: Value(countryCode),
        region: Value(region),
        processMethod: Value(process),
        varieties: Value(varieties),
        flavorNotes: Value(jsonEncode(notes)),
        description: Value(desc),
        roastLevel: Value(roast),
      ),
    );
  }

  Future<void> _seedBrewingRecipes() async {
    final existing = await db.getAllRecipes();
    if (existing.isNotEmpty) return;

    final recipes = [
      BrewingRecipesCompanion.insert(
        methodKey: 'v60',
        name: 'Hario V60',
        description: 'The V60 produces a clean, bright cup that highlights delicate floral and citrus notes.',
        ratioGramsPerMl: 1 / 15,
        tempC: 93.0,
        totalTimeSec: 165,
        difficulty: 'Intermediate',
        flavorProfile: 'Clean & Bright',
        iconName: 'v60',
        stepsJson: jsonEncode([
          {'title': 'Bloom', 'desc': 'Pour 30ml water. Wait 30s.', 'durationSec': 30},
          {'title': 'Brew', 'desc': 'Pour to 250ml in circles.', 'durationSec': 135},
        ]),
      ),
    ];

    for (var r in recipes) {
      await db.into(db.brewingRecipes).insert(r);
    }
  }

  Future<void> _seedEncyclopedia() async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty) return;

    final entries = [
      {
        'main': LocalizedBeansCompanion.insert(
          countryEmoji: const Value('🇵🇦'),
          altitudeMin: const Value(1500),
          altitudeMax: const Value(1900),
          cupsScore: const Value(93.5),
        ),
        'trans': LocalizedBeanTranslationsCompanion.insert(
          beanId: 0,
          languageCode: 'en',
          country: const Value('Panama (La Esmeralda)'),
          region: const Value('Boquete'),
          varieties: const Value('Gesha (Geisha)'),
          flavorNotes: Value(jsonEncode(['Jasmine', 'Bergamot'])),
          description: const Value('The coffee lot that shocked the world.'),
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

  Future<void> _seedLatteArtPatterns() async {
    final isEmpty = await db.patternsIsEmpty();
    if (!isEmpty) return;

    final patterns = [
      {
        'main': LatteArtPatternsCompanion.insert(
          difficulty: 1,
          stepsJson: jsonEncode([
            {'step': 1, 'instruction': 'Steam milk.'},
            {'step': 2, 'instruction': 'Pour heart.'},
          ]),
        ),
        'trans': LatteArtPatternTranslationsCompanion.insert(
          patternId: 0,
          languageCode: 'uk',
          name: 'Серце',
          description: 'Класичний малюнок.',
          tipText: 'Тримайте пітчер низько.',
        ),
      },
    ];

    for (var p in patterns) {
      final id = await db.insertLatteArtPattern(p['main'] as LatteArtPatternsCompanion);
      await db.insertLatteArtPatternTranslation(
        (p['trans'] as LatteArtPatternTranslationsCompanion).copyWith(
          patternId: Value(id),
        ),
      );
    }
  }

  Future<void> _seedSpecialtyArticles() async {
    final isEmpty = await db.specialtyArticlesIsEmpty();
    if (!isEmpty) return;

    final articles = [
      {
        'main': SpecialtyArticlesCompanion.insert(
          imageUrl: 'https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=600&q=80',
          readTimeMin: 6,
        ),
        'trans': SpecialtyArticleTranslationsCompanion.insert(
          articleId: 0,
          languageCode: 'uk',
          title: 'Як оцінюють зерно (Q-Grading)',
          subtitle: 'SCA Протокол, 10 параметрів якості',
          contentHtml: '<h3>Протокол SCA</h3><p>Оцінка від 80 балів.</p>',
        ),
      },
    ];

    for (var art in articles) {
      final id = await db.insertArticle(art['main'] as SpecialtyArticlesCompanion);
      await db.insertArticleTranslation(
        (art['trans'] as SpecialtyArticleTranslationsCompanion).copyWith(
          articleId: Value(id),
        ),
      );
    }
  }

  Future<void> _seedRecommendedRecipes() async {
    final allLots = await db.select(db.localizedBeans).get();
    if (allLots.isEmpty) return;

    for (var lot in allLots) {
      await db.insertRecommendedRecipe(
        RecommendedRecipesCompanion.insert(
          lotId: lot.id,
          methodKey: 'v60',
          coffeeGrams: 15.0,
          waterGrams: 250.0,
          tempC: 93.0,
          timeSec: 180,
          rating: 4.8,
          sensoryJson: const Value('{}'),
          notes: const Value('Standard V60 recipe.'),
        ),
      );
    }
  }
}

class _Entry3Champs {
  final LocalizedBeansCompanion main;
  final LocalizedBeanTranslationsCompanion trans;
  _Entry3Champs(this.main, this.trans);
}
