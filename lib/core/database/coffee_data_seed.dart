import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
        await (db.delete(db.specialtyArticleTranslations)).go();
        await (db.delete(db.localizedFarmers)).go();
        await (db.delete(db.localizedFarmerTranslations)).go();
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
    final isEmpty = await db.localizedFarmersIsEmpty();
    if (!isEmpty && !force) return;

    try {
      final jsonStr = await rootBundle.loadString('assets/data/Farmers.json');
      final List<dynamic> farmersList = jsonDecode(jsonStr);

      for (var data in farmersList) {
        final idStr = data['id']?.toString() ?? '';
        final int id = int.tryParse(idStr.replaceAll('f_', '')) ?? 0;
        if (id == 0) continue;

        final String name = data['farmer_name_en'] ?? 'Unknown Farmer';
        final String photo = data['image_url_portrait']?.split('/').last ?? 'farmer_placeholder.png';
        
        // Farmer bio and processing methods joined into a rich story
        final String biographyUk = data['biography_uk'] ?? '';
        final List<dynamic> methods = data['processing_methods'] ?? [];
        final String methodsText = methods.map((m) => "### ${m['method_name_uk']}\n${m['description_uk']}").join('\n\n');
        
        final String fullStoryUk = "$biographyUk\n\n## Методи обробки\n\n$methodsText";

        await db.smartUpsertFarmer(
          LocalizedFarmersCompanion.insert(
            id: Value(id),
            imageUrl: Value('assets/images/$photo'),
            createdAt: Value(DateTime.now()),
          ),
          [
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: id,
              languageCode: 'uk',
              name: Value(data['farmer_name_uk'] ?? name),
              country: Value(data['country_uk'] ?? ''),
              description: Value(data['specialization_uk'] ?? ''),
              story: Value(fullStoryUk),
            ),
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: id,
              languageCode: 'en',
              name: Value(name),
              country: Value(data['country_en'] ?? ''),
              description: Value(data['specialization_en'] ?? 'Specialty Coffee Producer'),
              story: Value(data['biography_en'] ?? 'Biography content coming soon...'),
            ),
          ],
        );
      }
    } catch (e) {
      debugPrint('Error seeding Farmers: $e');
    }
  }

  String _generateMarkdownContent(Map<String, dynamic> data) {
    final sb = StringBuffer();

    // 1. Definition section
    if (data['definition'] != null) {
      if (data['definition'] is Map) {
         sb.writeln('## Визначення');
         final def = data['definition'] as Map;
         def.forEach((key, value) {
            sb.writeln('**$key**: $value\n');
         });
      } else {
         sb.writeln('## Визначення\n${data['definition']}\n');
      }
    }

    // 2. Fundamental Attributes
    if (data['fundamental_attributes'] != null && data['fundamental_attributes'] is List) {
       sb.writeln('## Фундаментальні атрибути');
       for (var attr in (data['fundamental_attributes'] as List)) {
         sb.writeln('* **${attr['attribute']}**: ${attr['details']}');
       }
       sb.writeln('');
    }

    // 3. Main Content Blocks
    if (data['content'] != null && data['content'] is List) {
      for (var block in (data['content'] as List)) {
        if (block['topic'] != null) sb.writeln('### ${block['topic']}');
        if (block['details'] != null) sb.writeln('${block['details']}\n');
      }
    }

    // 4. Organizations
    if (data['organizations'] != null && data['organizations'] is List) {
       sb.writeln('## Провідні організації');
       for (var org in (data['organizations'] as List)) {
         sb.writeln('* **${org['name']}**: ${org['role']}');
       }
       sb.writeln('');
    }

    // 5. Additional data like models, scores, etc.
    if (data['models_and_scales'] != null) {
      sb.writeln('## Моделі та шкали\n${data['models_and_scales']}\n');
    }

    return sb.toString();
  }

  Future<void> _seedEncyclopedia({bool force = false}) async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty && !force) return;

    await db.clearSpecialtyArticles();

    try {
      final jsonStr = await rootBundle.loadString('assets/data/clean_encyclopedia.json');
      final List<dynamic> dataList = jsonDecode(jsonStr);
      
      for (var data in dataList) {
        final String modIdStr = data['module_metadata']?['module_id']?.toString() ?? '0';
        final int id = int.tryParse(modIdStr.replaceAll('SC-', '')) ?? 0;
        if (id == 0) continue;

        // Assets mapping: SC-001 -> encyclopedia_module_1_...
        // We'll follow a heuristic based on ID
        final String assetName = 'encyclopedia_module_${id}_cover.png';

        final String richMarkdown = _generateMarkdownContent(data);

        await db.smartUpsertArticle(
          SpecialtyArticlesCompanion.insert(
            id: Value(id),
            imageUrl: Value('assets/images/$assetName'),
            readTimeMin: Value(3 + (id % 5)),
          ),
          [
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: id,
              languageCode: 'uk',
              title: Value(data['module_metadata']?['module_name'] ?? 'Стаття спешелті'),
              subtitle: Value(data['module_metadata']?['category'] ?? 'Освіта'),
              contentHtml: Value(richMarkdown),
            ),
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: id,
              languageCode: 'en',
              title: Value(data['module_metadata']?['module_name_en'] ?? 'Specialty Article'),
              subtitle: Value(data['category_en'] ?? 'Education'),
              contentHtml: const Value('Rich English content coming soon...'),
            ),
          ],
        );
      }
    } catch (e) {
      debugPrint('Error seeding Encyclopedia: $e');
    }
  }

  Future<void> _seedBrewingRecipes() async {
    await db.delete(db.brewingRecipes).go();

    final List<BrewingRecipesCompanion> recipes = [];
    _addV60Recipes(recipes);
    _addAeropressRecipes(recipes);
    _addChemexRecipes(recipes);
    _addFrenchPressRecipes(recipes);
    _addEspressoRecipes(recipes);
    _addCleverRecipes(recipes);
    _addColdBrewRecipes(recipes);
    _addSiphonRecipes(recipes);

    for (var r in recipes) {
      await db.into(db.brewingRecipes).insert(r, mode: InsertMode.insertOrReplace);
    }
  }

  void _addV60Recipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'v60',
      name: 'Tetsu Kasuya 4:6 Method',
      description: 'World Brewers Cup 2016 Winning Recipe.',
      ratioGramsPerMl: 20 / 300,
      tempC: 92.0,
      totalTimeSec: 210,
      difficulty: 'Advanced',
      flavorProfile: 'Balanced & Sweet',
      iconName: 'v60',
      stepsJson: jsonEncode([
        {'title': 'Bloom', 'desc': 'Pour 50g. Wait 45s.', 'durationSec': 45},
        {'title': '2nd Pour', 'desc': 'Pour 70g. Wait until 1:30.', 'durationSec': 45},
        {'title': '3rd Pour', 'desc': 'Pour 60g. Wait until 2:15.', 'durationSec': 45},
        {'title': '4th Pour', 'desc': 'Pour 60g. Wait until 3:00.', 'durationSec': 45},
        {'title': 'Final Pour', 'desc': 'Pour 60g. Total 300g.', 'durationSec': 30},
      ]),
    ));
  }

  void _addAeropressRecipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'aeropress',
      name: 'Tim Wendelboe Ritual',
      description: 'Simple and consistent inverted method.',
      ratioGramsPerMl: 14 / 200,
      tempC: 95.0,
      totalTimeSec: 120,
      difficulty: 'Easy',
      flavorProfile: 'Elegant',
      iconName: 'aeropress',
      stepsJson: jsonEncode([
        {'title': 'Immersion', 'desc': 'Add coffee and water. Stir 3 times.', 'durationSec': 60},
        {'title': 'Flip & Press', 'desc': 'Flip and press for 30s.', 'durationSec': 60},
      ]),
    ));
  }

  void _addChemexRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'chemex');
  void _addFrenchPressRecipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'french_press',
      name: 'James Hoffmann French Press',
      description: 'The "No Press" method.',
      ratioGramsPerMl: 30 / 500,
      tempC: 95.0,
      totalTimeSec: 600,
      difficulty: 'Easy',
      flavorProfile: 'Full Body',
      iconName: 'french_press',
      stepsJson: jsonEncode([
        {'title': 'Steep', 'desc': 'Wait 4 minutes.', 'durationSec': 240},
        {'title': 'Clean', 'desc': 'Remove foam.', 'durationSec': 60},
        {'title': 'Wait', 'desc': 'Wait 5 more minutes.', 'durationSec': 300},
      ]),
    ));
  }

  void _addEspressoRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'espresso');
  void _addCleverRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'clever');
  void _addColdBrewRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'cold_brew');
  void _addSiphonRecipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'siphon',
      name: 'Classical Siphon Ritual',
      description: 'Elegant vacuum brewing for maximum clarity.',
      ratioGramsPerMl: 20 / 300,
      tempC: 94.0,
      totalTimeSec: 180,
      difficulty: 'Advanced',
      flavorProfile: 'Bright & Tea-like',
      iconName: 'siphon',
      stepsJson: jsonEncode([
        {'title': 'Preparation', 'desc': 'Boil water in the lower flask.', 'durationSec': 60},
        {'title': 'Immersion', 'desc': 'Attach upper chamber, add coffee.', 'durationSec': 60},
        {'title': 'Draw Down', 'desc': 'Remove heat, wait for filtration.', 'durationSec': 60},
      ]),
    ));
  }

  void _addGenericRecipes(List<BrewingRecipesCompanion> list, String method) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: method,
      name: '${method.toUpperCase()} Classic Recipe',
      description: 'Standard starting recipe for $method.',
      ratioGramsPerMl: 1 / 15,
      tempC: 94.0,
      totalTimeSec: 180,
      difficulty: 'Intermediate',
      flavorProfile: 'Balanced',
      iconName: method,
      stepsJson: jsonEncode([
        {'title': 'Preparation', 'desc': 'Setup and bloom.', 'durationSec': 60},
        {'title': 'Brewing', 'desc': 'Main extraction.', 'durationSec': 120},
      ]),
    ));
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
