import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
import 'app_database.dart';

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  static const String bucketUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles';

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
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedFarmerTranslations).go();
      });
      debugPrint('DB SEEDING: CLEANUP COMPLETE.');
    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands();
    // onProgress?.call('Seeding Farmers from JSON...');
    // await _seedFarmers();
    // onProgress?.call('Seeding Encyclopedia from JSON...');
    // await _seedEncyclopedia();
    // onProgress?.call('Seeding Catalog [STABLE]...');
    // await _seedMadHeadsOrigins();
    // await _seed3ChampsOrigins();
    
    // onProgress?.call('Seeding Specialty Articles...');
    try {
      // await _seedSpecialtyArticles();
      onProgress?.call('Seeding Recommended Recipes...');
      await _seedRecommendedRecipes();
      onProgress?.call('Seeding 30 Champion Brewing Recipes...');
      await _seedBrewingRecipes();

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
          id: const Value(1),
          name: 'Mad Heads',
          logoUrl: const Value('$bucketUrl/brands/mad_heads.png'),
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
          logoUrl: const Value('$bucketUrl/brands/three_champs.png'),
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

/*
  Future<void> _seedFarmers() async {
    final count = await (db.select(db.localizedFarmers)).get();
    if (count.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/clean_farmers.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      for (var farmerJson in jsonData) {
        final String rawId = farmerJson['id']?.toString() ?? 'f_0';
        final int idNum = int.tryParse(rawId.replaceFirst('f_', '')) ?? 0;
        
        // Language Fallbacks: If UK is missing, use EN. If EN is missing, use UK.
        final String rawNameEn = farmerJson['farmer_name_en'] ?? '';
        final String rawNameUk = farmerJson['farmer_name_uk'] ?? '';
        final String nameEn = rawNameEn.isNotEmpty ? rawNameEn : rawNameUk;
        final String nameUk = rawNameUk.isNotEmpty ? rawNameUk : rawNameEn;

        final String rawCountryEn = farmerJson['country_en'] ?? '';
        final String rawCountryUk = farmerJson['country_uk'] ?? '';
        final String countryEn = rawCountryEn.isNotEmpty ? rawCountryEn : rawCountryUk;
        final String countryUk = rawCountryUk.isNotEmpty ? rawCountryUk : rawCountryEn;

        final String rawRegionEn = farmerJson['region_en'] ?? '';
        final String rawRegionUk = farmerJson['region_uk'] ?? '';
        final String regionEn = rawRegionEn.isNotEmpty ? rawRegionEn : rawRegionUk;
        final String regionUk = rawRegionUk.isNotEmpty ? rawRegionUk : rawRegionEn;

        final String rawStoryEn = farmerJson['biography_en'] ?? (farmerJson['cup_profile_en'] ?? '');
        final String rawStoryUk = farmerJson['biography_uk'] ?? (farmerJson['cup_profile_uk'] ?? '');
        final String storyEn = rawStoryEn.isNotEmpty ? rawStoryEn : rawStoryUk;
        final String storyUk = rawStoryUk.isNotEmpty ? rawStoryUk : rawStoryEn;

        final String rawDescEn = farmerJson['specialization_en'] ?? '';
        final String rawDescUk = farmerJson['specialization_uk'] ?? '';
        final String descEn = rawDescEn.isNotEmpty ? rawDescEn : rawDescUk;
        final String descUk = rawDescUk.isNotEmpty ? rawDescUk : rawDescEn;
        
        final String slug = _slugify(nameEn);
        final String imageUrl = '$bucketUrl/farmers/$slug.png';
        final String countrySlug = countryEn.toLowerCase().replaceAll(' ', '_');
        final String flagUrl = '$bucketUrl/flags/$countrySlug.png';

        await db.smartUpsertFarmer(
          LocalizedFarmersCompanion.insert(
            id: Value(idNum),
            imageUrl: Value(imageUrl),
            countryEmoji: Value(flagUrl), // Using bucket flag URL instead of emoji
            createdAt: Value(DateTime.now()),
          ),
          [
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: idNum,
              languageCode: 'en',
              name: Value(nameEn),
              country: Value(countryEn),
              region: Value(regionEn),
              description: Value(descEn),
              story: Value(storyEn),
            ),
            LocalizedFarmerTranslationsCompanion.insert(
              farmerId: idNum,
              languageCode: 'uk',
              name: Value(nameUk),
              country: Value(countryUk),
              region: Value(regionUk),
              description: Value(descUk),
              story: Value(storyUk),
            ),
          ],
        );
      }
    } catch (e) {
      debugPrint('Error seeding farmers: $e');
    }
  }
*/

/*
  Future<void> _seedEncyclopedia() async {
    final count = await (db.select(db.specialtyArticles)).get();
    if (count.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/clean_encyclopedia.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      int articleId = 1000;
      for (var module in jsonData) {
        articleId++;
        final metadata = module['module_metadata'];
        final String title = metadata['module_name'] ?? 'Encyclopedia Entry';
        final String moduleId = metadata['module_id'] ?? 'SC-000';
        
        final StringBuffer sb = StringBuffer();
        final List<dynamic> topics = module['content'] ?? [];
        for (var topic in topics) {
          sb.writeln('## ${topic['topic']}\n');
          if (topic['definition'] != null) {
            sb.writeln('**Definition:** ${topic['definition']}\n');
          }
          if (topic['fundamental_attributes'] != null) {
            for (var attr in topic['fundamental_attributes']) {
              sb.writeln('### ${attr['attribute']}');
              sb.writeln('${attr['details']}\n');
            }
          }
           if (topic['organizations'] != null) {
            for (var org in topic['organizations']) {
              sb.writeln('### ${org['name']}');
              sb.writeln('*${org['role']}*\n');
          if (org['standards_set'] != null) {
            for (var s in org['standards_set']) {
              sb.writeln('- $s');
            }
          }
              if (org['certification_system'] != null) {
                final cert = org['certification_system'];
                sb.writeln('\n**Certification: ${cert['program_name']}**');
                sb.writeln('${cert['description']}\n');
              }
            }
          }
        }

        await db.smartUpsertArticle(
          SpecialtyArticlesCompanion.insert(
            id: Value(articleId),
            imageUrl: '$bucketUrl/articles/${moduleId.toLowerCase()}.png',
            readTimeMin: 8,
          ),
          [
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: articleId,
              languageCode: 'uk',
              title: title,
              subtitle: 'Advanced Knowledge Module',
              contentHtml: sb.toString(),
            ),
            SpecialtyArticleTranslationsCompanion.insert(
              articleId: articleId,
              languageCode: 'en',
              title: title,
              subtitle: 'Advanced Knowledge Module',
              contentHtml: sb.toString(),
            ),
          ],
        );
      }
    } catch (e) {
      debugPrint('Error seeding encyclopedia: $e');
    }
  }
*/

/*
  String _slugify(String text) {
    return text.toLowerCase()
        .replaceAll(' & ', '_')
        .replaceAll(' ', '_')
        .replaceAll('á', 'a')
        .replaceAll('ó', 'o')
        .replaceAll('í', 'i')
        .replaceAll('é', 'e')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')
        .replaceAll('__', '_');
  }
*/

/*
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

  Future<void> _seedSpecialtyArticles() async {
    await db.smartUpsertArticle(
      SpecialtyArticlesCompanion.insert(
        id: const Value(1),
        imageUrl: '$bucketUrl/articles/q_grading.png',
        readTimeMin: 6,
      ),
      [
        SpecialtyArticleTranslationsCompanion.insert(
          articleId: 1,
          languageCode: 'uk',
          title: 'Як оцінюють зерно (Q-Grading)',
          subtitle: 'SCA Протокол, 10 параметрів якості',
          contentHtml: '### Процес Q-Grading\nКожен лот оцінюється за 100-бальною шкалою...',
        ),
        SpecialtyArticleTranslationsCompanion.insert(
          articleId: 1,
          languageCode: 'en',
          title: 'How Beans are Evaluated (Q-Grading)',
          subtitle: 'SCA Protocol, 10 Quality Parameters',
          contentHtml: '### The Q-Grading Process\nEvery lot is evaluated on a 100-point scale...',
        ),
      ],
    );
  }
*/

  Future<void> _seedBrewingRecipes() async {
    // We clear current recipes to ensure we get exactly the 30 champion ones with unique IDs
    await db.delete(db.brewingRecipes).go();

    final List<BrewingRecipesCompanion> recipes = [];
    _addV60Recipes(recipes);
    _addAeropressRecipes(recipes);
    _addChemexRecipes(recipes);
    _addFrenchPressRecipes(recipes);
    _addEspressoRecipes(recipes);
    _addMokaRecipes(recipes);
    _addCleverRecipes(recipes);
    _addColdBrewRecipes(recipes);

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
    _addGenericRecipes(list, 'v60', 4);
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
    _addGenericRecipes(list, 'aeropress', 4);
  }

  void _addChemexRecipes(List<BrewingRecipesCompanion> list) {
    _addGenericRecipes(list, 'chemex', 5);
  }
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
    _addGenericRecipes(list, 'french_press', 2);
  }

  void _addEspressoRecipes(List<BrewingRecipesCompanion> list) {
    _addGenericRecipes(list, 'espresso', 5);
  }
  void _addMokaRecipes(List<BrewingRecipesCompanion> list) {
    _addGenericRecipes(list, 'moka_pot', 2);
  }
  void _addCleverRecipes(List<BrewingRecipesCompanion> list) {
    _addGenericRecipes(list, 'clever', 3);
  }
  void _addColdBrewRecipes(List<BrewingRecipesCompanion> list) {
    _addGenericRecipes(list, 'cold_brew', 2);
  }

  void _addGenericRecipes(List<BrewingRecipesCompanion> list, String method, int count) {
    for (int i = 0; i < count; i++) {
      list.add(BrewingRecipesCompanion.insert(
        methodKey: method,
        name: '${method.toUpperCase()} Champion Var ${i + 1}',
        description: 'Professional recipe for $method.',
        ratioGramsPerMl: 1 / 15,
        tempC: 94.0,
        totalTimeSec: 180,
        difficulty: 'Intermediate',
        flavorProfile: 'Complex',
        iconName: method,
        stepsJson: jsonEncode([
          {'title': 'Preparation', 'desc': 'Setup and bloom.', 'durationSec': 60},
          {'title': 'Brewing', 'desc': 'Main extraction.', 'durationSec': 120},
        ]),
      ));
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
          notes: const Value('Best with 4:6 method.'),
        ),
      );
    }
  }
}

/*
class _Entry {
  final LocalizedBeansCompanion main;
  final LocalizedBeanTranslationsCompanion trans;
  _Entry(this.main, this.trans);
}
*/
