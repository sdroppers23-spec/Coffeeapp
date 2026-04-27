import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
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


    if (force || await db.brandsIsEmpty()) {

      await db.transaction(() async {
        await (db.delete(db.localizedBeans)).go();
        await (db.delete(db.localizedBeanTranslations)).go();
        await (db.delete(db.localizedBrands)).go();
        await (db.delete(db.localizedBrandTranslations)).go();
        await (db.delete(db.brewingRecipes)).go();
        await (db.delete(db.specialtyArticles)).go();
        await (db.delete(db.localizedFarmers)).go();
      });

    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands(force: force);
    onProgress?.call('Seeding Farmers...');
    await _seedFarmers(force: force);
    onProgress?.call('Seeding Specialty Articles...');
    await _seedSpecialtyArticles(force: force);
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

    } catch (e) {
      onProgress?.call('Synchronization error: $e');
    }
  }

  Future<void> _seedBrands({bool force = false}) async {
    final isEmpty = await db.brandsIsEmpty();
    if (!isEmpty && !force) return;

    final List<Map<String, dynamic>> brandsToSeed = [];

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

    try {
      final jsonString = await rootBundle.loadString('assets/data/clean_farmers.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);

      for (final item in jsonList) {
        final farmer = LocalizedFarmersV2Companion(
          id: Value(int.tryParse(item['id'].toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0),
          imageUrl: Value(item['image_url_portrait'] as String? ?? ''),
        );

        final translations = [
          LocalizedFarmerTranslationsV2Companion(
            farmerId: farmer.id,
            languageCode: const Value('en'),
            name: Value(item['farmer_name_en'] as String? ?? ''),
            country: Value(item['country_en'] as String? ?? ''),
            region: Value(item['region_uk'] as String? ?? ''), // fallback
            story: Value(item['biography_uk'] as String? ?? ''), // fallback
          ),
          LocalizedFarmerTranslationsV2Companion(
            farmerId: farmer.id,
            languageCode: const Value('uk'),
            name: Value(item['farmer_name_uk'] as String? ?? ''),
            country: Value(item['country_uk'] as String? ?? ''),
            region: Value(item['region_uk'] as String? ?? ''),
            story: Value(item['biography_uk'] as String? ?? ''),
          ),
        ];

        await db.smartUpsertFarmerV2(farmer, translations);
      }
    } catch (e) {
      // Ignore if file missing
    }
  }

  Future<void> _seedSpecialtyArticles({bool force = false}) async {
    final isEmpty = await db.specialtyArticlesIsEmpty();
    if (!isEmpty && !force) return;

    try {
      final jsonString = await rootBundle.loadString('assets/data/specialty_encyclopedia.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List<dynamic> modules = data['modules'] as List<dynamic>? ?? [];

      for (var i = 0; i < modules.length; i++) {
        final module = modules[i];
        final List<dynamic> contentList = module['content'] as List<dynamic>? ?? [];
        
        for (var j = 0; j < contentList.length; j++) {
          final item = contentList[j];
          final topic = item['topic'] as String? ?? 'Topic $j';
          
          final article = SpecialtyArticlesV2Companion(
            id: Value(i * 100 + j),
            imageUrl: const Value(''),
            readTimeMin: const Value(5),
          );

          final translations = [
            SpecialtyArticleTranslationsV2Companion(
              articleId: article.id,
              languageCode: const Value('uk'),
              title: Value(topic),
              contentHtml: Value(jsonEncode(item)),
            ),
            SpecialtyArticleTranslationsV2Companion(
              articleId: article.id,
              languageCode: const Value('en'),
              title: Value(topic),
              contentHtml: Value(jsonEncode(item)),
            ),
          ];

          await db.smartUpsertArticleV2(article, translations);
        }
      }
    } catch (e) {
      // Ignore if missing
    }
  }

  Future<void> _seedEncyclopedia({bool force = false}) async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty && !force) return;

    // Provide a tiny fallback seed so it's not totally empty if cloud sync fails
    const bean = LocalizedBeansV2Companion(
      id: Value(1),
      scaScore: Value('88+'),
      cupsScore: Value(88.5),
      processingMethodsJson: Value('["Washed"]'),
    );

    final translations = [
      const LocalizedBeanTranslationsV2Companion(
        beanId: Value(1),
        languageCode: Value('uk'),
        country: Value('Ефіопія'),
        region: Value('Їргачеффе'),
        varieties: Value('Heirloom'),
        flavorNotes: Value('["Жасмин", "Бергамот", "Чорний чай"]'),
        processMethod: Value('Мита'),
        description: Value('Класична ефіопська кава з яскравим квітковим профілем.'),
      ),
      const LocalizedBeanTranslationsV2Companion(
        beanId: Value(1),
        languageCode: Value('en'),
        country: Value('Ethiopia'),
        region: Value('Yirgacheffe'),
        varieties: Value('Heirloom'),
        flavorNotes: Value('["Jasmine", "Bergamot", "Black Tea"]'),
        processMethod: Value('Washed'),
        description: Value('Classic Ethiopian coffee with a bright floral profile.'),
      ),
    ];

    await db.smartUpsertBeanV2(bean, translations);
  }

  Future<void> _seedBrewingRecipes() async {

    
    final List<Map<String, dynamic>> recipes = [
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'v60',
          imageUrl: const Value('p_v60.webp'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'v60', languageCode: 'en', name: const Value('V60 Pour Over'), description: const Value('Classic pour-over method for clarity and sweetness.')),
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'v60', languageCode: 'uk', name: const Value('V60 Пур-овер'), description: const Value('Класичний метод для чистоти та солодкості.')),
        ],
      },
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'chemex',
          imageUrl: const Value('p_chemex.webp'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'chemex', languageCode: 'en', name: const Value('Chemex'), description: const Value('Elegant glass brewer for a clean, tea-like body.')),
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'chemex', languageCode: 'uk', name: const Value('Чемекс'), description: const Value('Елегантний метод для найчистішого тіла напою.')),
        ],
      },
      {
        'main': BrewingRecipesCompanion.insert(
          methodKey: 'aeropress',
          imageUrl: const Value('p_aeropress.webp'),
        ),
        'trans': [
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'aeropress', languageCode: 'en', name: const Value('AeroPress'), description: const Value('Versatile and portable pressure brewer.')),
          BrewingRecipeTranslationsCompanion.insert(recipeKey: 'aeropress', languageCode: 'uk', name: const Value('Аеропрес'), description: const Value('Універсальний та портативний ручний прес.')),
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
    final entries = [];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, e.transList);
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    final entries = [];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, e.transList);
    }
  }
}
