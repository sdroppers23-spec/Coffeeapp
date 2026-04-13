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

    for (int i = 1; i <= 4; i++) {
      try {
        final jsonStr = await rootBundle.loadString('assets/data/Farmer$i.json');
        final data = jsonDecode(jsonStr);
        
        final String name = data['name'] ?? 'Unknown Farmer';
        final String photo = data['photo'] ?? 'farmer_${name.toLowerCase().replaceAll(' ', '_')}.png';
        final String loc = data['location'] ?? '';
        
        final country = loc.contains(',') ? loc.split(',').last.trim() : loc;

        await db.smartUpsertFarmer(
          LocalizedFarmersCompanion.insert(
            id: Value(i),
            imageUrl: Value('assets/images/$photo'),
            createdAt: Value(DateTime.now()),
          ),
          [
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: i,
              languageCode: 'uk',
              name: Value(data['name_uk'] ?? name),
              country: Value(data['location_uk']?.split(',').last.trim() ?? country),
              description: Value(data['specialization_uk'] ?? data['specialization'] ?? ''),
              story: Value(data['bio_uk'] ?? data['bio'] ?? ''),
            ),
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: i,
              languageCode: 'en',
              name: Value(name),
              country: Value(country),
              description: Value(data['specialization'] ?? ''),
              story: Value(data['bio'] ?? ''),
            ),
          ],
        );
      } catch (e) {
        debugPrint('Error seeding Farmer$i: $e');
      }
    }
  }

  Future<void> _seedEncyclopedia({bool force = false}) async {
    final isEmpty = await db.encyclopediaIsEmpty();
    if (!isEmpty && !force) return;

    await db.clearSpecialtyArticles();

    try {
      final jsonStr = await rootBundle.loadString('assets/data/clean_encyclopedia.json');
      final List<dynamic> dataList = jsonDecode(jsonStr);
      
      for (var data in dataList) {
        final int id = int.tryParse(data['module_metadata']?['module_id']?.toString() ?? data['id']?.toString() ?? '0') ?? 0;
        if (id == 0) continue;

        String content = '';
        if (data['content'] is List) {
          content = (data['content'] as List).map((e) => e['topic'] ?? '').join('\n\n');
        } else {
          content = data['content']?.toString() ?? '';
        }

        await db.smartUpsertArticle(
          SpecialtyArticlesCompanion.insert(
            id: Value(id),
            imageUrl: Value('assets/images/${data['imageUrl'] ?? 'encyclopedia_placeholder.png'}'),
            readTimeMin: const Value(5),
          ),
          [
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: id,
              languageCode: 'uk',
              title: Value(data['module_metadata']?['module_name'] ?? data['titleUk'] ?? ''),
              subtitle: Value(data['categoryUk'] ?? 'Освіта'),
              contentHtml: Value(content),
            ),
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: id,
              languageCode: 'en',
              title: Value(data['titleEn'] ?? ''),
              subtitle: Value(data['categoryEn'] ?? 'Education'),
              contentHtml: const Value('Coming soon...'),
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
        LocalizedBeanTranslationsCompanion.insert(beanId: 101, languageCode: 'uk', country: const Value('Ефіопія'), region: const Value('Guji'), varieties: const Value('Heirloom'), flavorNotes: Value(jsonEncode(['Peach', 'Jasmine'])), description: const Value('Класична мита Ефіопія.')),
      ),
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(102), brandId: const Value(1), countryEmoji: const Value('🇨🇴'), cupsScore: const Value(87.5)),
        LocalizedBeanTranslationsCompanion.insert(beanId: 102, languageCode: 'uk', country: const Value('Колумбія'), region: const Value('Huila'), varieties: const Value('Caturra'), flavorNotes: Value(jsonEncode(['Chocolate', 'Red Apple'])), description: const Value('Збалансована Колумбія.')),
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, [e.trans]);
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    final entries = [
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(201), brandId: const Value(2), countryEmoji: const Value('🇰🇪'), cupsScore: const Value(89.0)),
        LocalizedBeanTranslationsCompanion.insert(beanId: 201, languageCode: 'uk', country: const Value('Кенія'), region: const Value('Nyeri'), varieties: const Value('SL28'), flavorNotes: Value(jsonEncode(['Blackcurrant', 'Tomato'])), description: const Value('Яскрава Кенія.')),
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, [e.trans]);
    }
  }
}

class _Entry {
  final LocalizedBeansCompanion main;
  final LocalizedBeanTranslationsCompanion trans;
  _Entry(this.main, this.trans);
}
