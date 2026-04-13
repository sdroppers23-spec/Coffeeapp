import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'app_database.dart';

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  static const String baseUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public';
  static const String articlesBucket = '$baseUrl/specialty-articles/';
  static const String farmersBucket = '$baseUrl/Farmers/';
  static const String methodsBucket = '$baseUrl/Methods/';
  static const String flagsBucket = '$baseUrl/Flags/';

  Future<void> seedAll({
    bool force = false,
    Function(String)? onProgress,
  }) async {
    onProgress?.call('Initializing database sync...');
    debugPrint('DB SEEDING: STARTING (FORCE=$force)...');

    if (force || await db.brandsIsEmpty()) {
      debugPrint('DB SEEDING: PERFORMING MANDATORY CLEANUP...');
      await db.transaction(() async {
        await (db.delete(db.localizedBeans)).go();
        await (db.delete(db.localizedBeanTranslations)).go();
        await (db.delete(db.localizedBrands)).go();
        await (db.delete(db.localizedBrandTranslations)).go();
        await (db.delete(db.brewingRecipes)).go();
        await (db.delete(db.specialtyArticles)).go();
        await (db.delete(db.localizedFarmers)).go();
      });
      debugPrint('DB SEEDING: CLEANUP COMPLETE.');
    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands(force: force);
    onProgress?.call('Seeding Farmers...');
    await _seedFarmers(force: force);
    onProgress?.call('Seeding Encyclopedia...');
    await _seedEncyclopedia(force: force);
    onProgress?.call('Seeding Catalog...');
    await _seedMadHeadsOrigins();
    await _seed3ChampsOrigins();
    
    try {
      onProgress?.call('Seeding Recommended Recipes...');
      await _seedRecommendedRecipes();
      onProgress?.call('Seeding Professional Recipes...');
      await _seedBrewingRecipes();

      onProgress?.call('All systems synchronized [STABLE]');
      debugPrint('DB SEEDING: ALL COMPLETED SUCCESSFULLY');
    } catch (e, st) {
      debugPrint('DB SEEDING FATAL ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Synchronization error: $e');
    }
  }

  Future<void> _seedBrands({bool force = false}) async {
    final isEmpty = await db.brandsIsEmpty();
    if (!isEmpty && !force) return;

    final List<Map<String, dynamic>> brandsToSeed = [
      {
        'main': LocalizedBrandsCompanion.insert(
          id: const Value(1),
          name: 'Mad Heads',
          logoUrl: Value('$articlesBucket/brands/mad_heads.png'),
          siteUrl: const Value('https://madheadscoffee.com/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
            languageCode: 'uk',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value('Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році.'),
            location: const Value('Київ, вул. Кирилівська 69'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
            languageCode: 'en',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value('Mad Heads Coffee is an independent Ukrainian roaster founded in 2017.'),
            location: const Value('Kyiv, Kyrylivska st. 69'),
          ),
        ],
      },
      {
        'main': LocalizedBrandsCompanion.insert(
          id: const Value(2),
          name: '3Champs',
          logoUrl: Value('$articlesBucket/brands/three_champs.png'),
          siteUrl: const Value('https://3champsroastery.com.ua/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 2,
            languageCode: 'uk',
            shortDesc: const Value('Спешелті обсмажка з акцентом на чистоту та яскравість смаку.'),
            fullDesc: const Value('3Champs Roastery — це команда професіоналів. Плодова 1.'),
            location: const Value('Kyiv, Plodova 1'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 2,
            languageCode: 'en',
            shortDesc: const Value('Specialty roastery with an emphasis on purity.'),
            fullDesc: const Value('Professional team based in Kyiv.'),
            location: const Value('Kyiv, Plodova 1'),
          ),
        ],
      },
    ];

    for (var item in brandsToSeed) {
      await db.smartUpsertBrand(
        item['main'] as LocalizedBrandsCompanion,
        item['trans'] as List<LocalizedBrandTranslationsCompanion>,
      );
    }
  }

  Future<void> _seedFarmers({bool force = false}) async {
    final isEmpty = await db.farmersIsEmpty();
    if (!isEmpty && !force) return;

    for (int i = 0; i < 10; i++) {
      final id = i + 1;
      final main = LocalizedFarmersCompanion.insert(
        id: Value(id),
        nameUk: Value('Фермер #$id'),
        imageUrl: Value('farmer_$id.png'),
        flagUrl: const Value('brazil.png'),
        descriptionHtmlUk: Value('Тут має бути опис досягнень та історії фермера $id'),
        regionUk: Value('Регіон $id'),
        countryUk: Value('Країна $id'),
        latitude: const Value(0.0),
        longitude: const Value(0.0),
        createdAt: Value(DateTime.now()),
      );

      final List<LocalizedFarmerTranslationsCompanion> translations = [
        LocalizedFarmerTranslationsCompanion.insert(
          farmerId: id,
          languageCode: 'en',
          name: Value('Farmer #$id'),
          descriptionHtml: Value('Farmer description and history #$id'),
          region: Value('Region $id'),
          country: Value('Country $id'),
        ),
      ];

      await db.smartUpsertFarmer(main, translations);
    }
    debugPrint('DB SEEDING: 10 placeholder farmers created.');
  }

  Future<void> _seedEncyclopedia({bool force = false}) async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty && !force) return;

    final titles = [
      'Specialty Coffee Basics',
      'Roasting Essentials',
      'Sensory Analysis',
      'Water for Coffee',
      'Espresso Physics',
      'Digital Transformation',
      'Sensory Analysis II',
      'Espresso Chemistry',
      'Farmer Stories',
      'Future of Coffee',
    ];

    final titlesUk = [
      'Основи Спешелті',
      'Основи Обсмажування',
      'Сенсорний Аналіз',
      'Вода для кави',
      'Фізика еспресо',
      'Диджиталізація',
      'Сенсорний Аналіз II',
      'Хімія еспресо',
      'Історії фермерів',
      'Майбутнє кави',
    ];

    for (int i = 0; i < 10; i++) {
      final id = i + 1;
      final main = SpecialtyArticlesCompanion.insert(
        id: Value(id),
        titleUk: Value(titlesUk[i]),
        imageUrl: Value('article_$id.png'),
        flagUrl: const Value('specialty_icon.png'),
        contentHtmlUk: Value('Тут має бути текст статті $id (HTML або Markdown)'),
        readTimeMin: Value(5 + i),
      );

      final List<SpecialtyArticleTranslationsCompanion> translations = [
        SpecialtyArticleTranslationsCompanion.insert(
          articleId: id,
          languageCode: 'en',
          title: Value(titles[i]),
          contentHtml: Value('Article content #$id in English'),
        ),
      ];

      await db.smartUpsertArticle(main, translations);
    }
    debugPrint('DB SEEDING: 10 placeholder articles created.');
  }

  Future<void> _seedBrewingRecipes() async {
    debugPrint('DB SEEDING: Populating 8 Brewing Methods...');
    
    final List<Map<String, dynamic>> recipes = [
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'v60',
          nameUk: const Value('V60 Пур-овер'),
          imageUrl: const Value('p_v60.png'),
          descriptionUk: const Value('Класичний метод для чистоти та солодкості.'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'v60', languageCode: 'en', name: const Value('V60 Pour Over'), description: const Value('Classic pour-over method for clarity and sweetness.')),
        ],
      },
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'chemex',
          nameUk: const Value('Чемекс'),
          imageUrl: const Value('p_chemex.png'),
          descriptionUk: const Value('Елегантний метод для найчистішого тіла напою.'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'chemex', languageCode: 'en', name: const Value('Chemex'), description: const Value('Elegant glass brewer for a clean, tea-like body.')),
        ],
      },
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'aeropress',
          nameUk: const Value('Аеропрес'),
          imageUrl: const Value('p_aeropress.png'),
          descriptionUk: const Value('Універсальний та портативний ручний прес.'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'aeropress', languageCode: 'en', name: const Value('AeroPress'), description: const Value('Versatile and portable pressure brewer.')),
        ],
      },
    ];

    for (var r in recipes) {
      await db.smartUpsertBrewingRecipe(
        r['main'] as BrewingRecipesCompanion,
        r['trans'] as List<BrewingRecipeTranslationsCompanion>,
      );
    }
  }

  Future<void> _seedRecommendedRecipes() async {
    await db.delete(db.recommendedRecipes).go();
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
          notes: const Value('Best with 4:6 method.'),
        ),
      );
    }
  }

  Future<void> _seedMadHeadsOrigins() async {
    final entries = [
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(101), brandId: const Value(1), countryEmoji: const Value('🇪🇹'), cupsScore: const Value(88.0)),
        [
          LocalizedBeanTranslationsCompanion.insert(beanId: 101, languageCode: 'uk', country: const Value('Ефіопія'), region: const Value('Guji'), varieties: const Value('Heirloom'), flavorNotes: Value(jsonEncode(['Персик', 'Жасмин', 'Цитрус'])), description: const Value('Класична мита Ефіопія з яскравим квітковим профілем.')),
          LocalizedBeanTranslationsCompanion.insert(beanId: 101, languageCode: 'en', country: const Value('Ethiopia'), region: const Value('Guji'), varieties: const Value('Heirloom'), flavorNotes: Value(jsonEncode(['Peach', 'Jasmine', 'Citrus'])), description: const Value('Classic washed Ethiopia.')),
        ],
      ),
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(102), brandId: const Value(1), countryEmoji: const Value('🇨🇴'), cupsScore: const Value(87.5)),
        [
          LocalizedBeanTranslationsCompanion.insert(beanId: 102, languageCode: 'uk', country: const Value('Колумбія'), region: const Value('Huila'), varieties: const Value('Caturra'), flavorNotes: Value(jsonEncode(['Шоколад', 'Червоне яблуко', 'Карамель'])), description: const Value('Збалансована Колумбія з солодким післясмаком.')),
          LocalizedBeanTranslationsCompanion.insert(beanId: 102, languageCode: 'en', country: const Value('Colombia'), region: const Value('Huila'), varieties: const Value('Caturra'), flavorNotes: Value(jsonEncode(['Chocolate', 'Red Apple', 'Caramel'])), description: const Value('Balanced Colombia.')),
        ],
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, e.transList);
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    final entries = [
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(201), brandId: const Value(2), countryEmoji: const Value('🇰🇪'), cupsScore: const Value(89.0)),
        [
          LocalizedBeanTranslationsCompanion.insert(beanId: 201, languageCode: 'uk', country: const Value('Кенія'), region: const Value('Nyeri'), varieties: const Value('SL28'), flavorNotes: Value(jsonEncode(['Чорна смородина', 'Томат', 'Грейпфрут'])), description: const Value('Яскрава Кенія з соковитою кислотністю.')),
          LocalizedBeanTranslationsCompanion.insert(beanId: 201, languageCode: 'en', country: const Value('Kenya'), region: const Value('Nyeri'), varieties: const Value('SL28'), flavorNotes: Value(jsonEncode(['Blackcurrant', 'Tomato', 'Grapefruit'])), description: const Value('Bright Kenya.')),
        ],
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, e.transList);
    }
  }
}

class _Entry {
  final LocalizedBeansCompanion main;
  final List<LocalizedBeanTranslationsCompanion> transList;
  _Entry(this.main, this.transList);
}
