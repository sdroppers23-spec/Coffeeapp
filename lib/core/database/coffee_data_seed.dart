import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../config/flag_constants.dart';
import 'app_database.dart';

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
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedFarmerTranslations).go();
      });
      debugPrint('DB SEEDING: CLEANUP COMPLETE.');
    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands();
    onProgress?.call('Seeding Farmers [RECOVERY]...');
    await _seedFarmers();
    onProgress?.call('Seeding Encyclopedia...');
    await _seedEncyclopedia();
    onProgress?.call('Seeding Mad Heads Catalog...');
    await _seedMadHeadsOrigins();
    onProgress?.call('Seeding 3Champs Catalog [PREMIUM]...');
    await _seed3ChampsOrigins();
    onProgress?.call('Seeding Specialty Articles...');
    try {
      await _seedSpecialtyArticles();
      onProgress?.call('Seeding Recommended Recipes...');
      await _seedRecommendedRecipes();
      onProgress?.call('Seeding Brewing Recipes...');
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
          name: 'Mad Heads [STABLE]',
          logoUrl: const Value(
            'https://madheadscoffee.com/wp-content/uploads/2021/05/Logo_MH_Black-1.png',
          ),
          siteUrl: const Value('https://madheadscoffee.com/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
            languageCode: 'uk',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value(
              'Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році. '
              'Ми фокусуємось на пошуку унікальних мікролотів та інноваційних методах обробки.',
            ),
            location: const Value('Київ, вул. Кирилівська 69'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
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
          id: const Value(2),
          name: '3Champs [STABLE]',
          logoUrl: const Value(
            'https://3champsroastery.com.ua/images/logo.png',
          ),
          siteUrl: const Value('https://3champsroastery.com.ua/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 2,
            languageCode: 'uk',
            shortDesc: const Value(
              'Спешелті обсмажка з акцентом на чистоту та яскравість смаку.',
            ),
            fullDesc: const Value(
              '3Champs Roastery — це команда професіоналів. Плодова 1.',
            ),
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

  Future<void> _seedFarmers() async {
    final farmersToSeed = [
      _createFarmer(
        id: 1,
        nameEn: 'Wilton Benitez',
        nameUk: 'Вілтон Бенітез',
        farm: 'Granja Paraíso 92',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        region: 'Cauca',
        lat: 2.4448,
        lng: -76.6147,
        specEn: 'Thermal Shock, Bioreactor Fermentation, Ozone Sterilization',
        specUk: 'Термальний шок, ферментація в біореакторах, озонова стерилізація',
        bioUk: 'Хімік-технолог, який перетворив ферму на лабораторію. Використовує сталеві біореактори, додає специфічні штами дріжджів і використовує термальний шок для "запечатування" смаку.',
        imageUrl: 'https://images.unsplash.com/photo-1594488340110-38e55e5b850a?w=400&q=80',
      ),
      _createFarmer(
        id: 2,
        nameEn: 'Oscar & Francisca Chacón',
        nameUk: 'Оскар та Франциска Чакон',
        farm: 'Micromill Las Lajas',
        countryEn: 'Costa Rica',
        countryUk: 'Коста-Рика',
        region: 'Sabanilla de Alajuela',
        lat: 10.0768,
        lng: -84.2703,
        specEn: 'Black Diamond, Perla Negra, Honey Process',
        specUk: 'Black Diamond, Perla Negra, Хані обробки',
        bioUk: 'Піонери натуральної обробки в Коста-Риці. Створюють екстремально солодкі лоти. Perla Negra сушиться під плівкою вночі, а Black Diamond проходить надповільну ферментацію.',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      ),
      _createFarmer(
        id: 3,
        nameEn: 'Diego Samuel Bermúdez',
        nameUk: 'Дієго Самуель Бермудес',
        farm: 'Finca El Paraiso',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        region: 'Cauca',
        lat: 2.4448,
        lng: -76.6147,
        specEn: 'Double Anaerobic Fermentation, Eco-Enigma Drying',
        specUk: 'Подвійна анаеробна ферментація, Еко-Енігма сушіння',
        bioUk: 'Відомий своїм лотом "Red Plum". Використовує подвійну анаеробну ферментацію з додаванням власних лактобактерій.',
        imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&q=80',
      ),
      _createFarmer(
        id: 4,
        nameEn: 'Jamison Savage',
        nameUk: 'Джеймісон Севідж',
        farm: 'Finca Deborah',
        countryEn: 'Panama',
        countryUk: 'Панама',
        region: 'Volcan',
        lat: 8.7719,
        lng: -82.6341,
        specEn: 'Carbonic Maceration, Geisha cultivation',
        specUk: 'Вуглекислотна мацерація, вирощування Гейші',
        bioUk: 'Ферма на екстремальній висоті (понад 1900 м). Джеймісон першим застосував винну технологію вуглекислотної мацерації до кави сорту Гейша.',
        imageUrl: 'https://images.unsplash.com/photo-1542156822-6924d1a71ace?w=400&q=80',
      ),
      _createFarmer(
        id: 5,
        nameEn: 'Carlos & Felipe Arcila',
        nameUk: 'Карлос та Феліпе Арсіла',
        farm: 'Jardines del Eden',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        region: 'Quindio',
        lat: 4.5339,
        lng: -75.6811,
        specEn: 'Fruit Co-fermentation, Ice Fermentation',
        specUk: 'Фруктова ко-ферментація, крижана ферментація',
        bioUk: 'Брати-інноватори, які шокували індустрію інфузіями. Додають справжні фрукти та винні дріжджі прямо в танки.',
        imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&q=80',
      ),
      _createFarmer(
        id: 6,
        nameEn: 'Aida Batlle',
        nameUk: 'Аїда Батлл',
        farm: 'Finca Kilimanjaro',
        countryEn: 'El Salvador',
        countryUk: 'Сальвадор',
        region: 'Santa Ana',
        lat: 13.9781,
        lng: -89.5645,
        specEn: 'Cascara pioneer, Kenyan washed style',
        specUk: 'Піонерка каскари, мита обробка в кенійському стилі',
        bioUk: 'Королева спешелті в Сальвадорі. Вона першою почала використовувати кенійський метод подвійної ферментації в Центральній Америці.',
        imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&q=80',
      ),
      _createFarmer(
        id: 7,
        nameEn: 'Adam Overton & Rachel Samuel',
        nameUk: 'Адам Овертон та Рейчел Семюел',
        farm: 'Gesha Village',
        countryEn: 'Ethiopia',
        countryUk: 'Ефіопія',
        region: 'Bench Maji',
        lat: 6.4253,
        lng: 35.5806,
        specEn: 'Gori Gesha preservation, Honey process',
        specUk: 'Збереження сорту Gori Gesha, Хані обробка',
        bioUk: 'Створили культову ферму на батьківщині знаменитого сорту. Їхні лоти — це еталон справжньої ефіопської Гейші.',
        imageUrl: 'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?w=400&q=80',
      ),
      _createFarmer(
        id: 8,
        nameEn: 'Pepe Jijón',
        nameUk: 'Пепе Хіхон',
        farm: 'Finca Soledad',
        countryEn: 'Ecuador',
        countryUk: 'Еквадор',
        region: 'Intag Valley',
        lat: 0.3800,
        lng: -78.5000,
        specEn: 'Wave Fermentation, Biodynamic farming',
        specUk: 'Хвильова ферментація (Wave), біодинамічне землеробство',
        bioUk: 'Винайшов "Хвильову ферментацію", де температурні профілі змінюються циклами. Працює за принципами біодинаміки.',
        imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&q=80',
      ),
      _createFarmer(
        id: 9,
        nameEn: 'Alejo Castro',
        nameUk: 'Алехо Кастро',
        farm: 'Volcan Azul',
        countryEn: 'Costa Rica',
        countryUk: 'Коста-Рика',
        region: 'Alajuela',
        lat: 10.0163,
        lng: -84.2148,
        specEn: 'Rare varietal preservation, Anaerobic Natural',
        specUk: 'Збереження рідкісних сортів, Анаеробна натуральна',
        bioUk: 'Представник 5-го покоління. Місія — збереження тропічних лісів. Робить одні з найкращих анаеробних лотів.',
        imageUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&q=80',
      ),
      _createFarmer(
        id: 10,
        nameEn: 'Luis Norberto Pascoal',
        nameUk: 'Луїс Норберто Паскоаль',
        farm: 'Daterra',
        countryEn: 'Brazil',
        countryUk: 'Бразилія',
        region: 'Cerrado',
        lat: -18.9147,
        lng: -48.2754,
        specEn: 'Masterpieces (Aero, Anaerobic), B-Corp Sustainability',
        specUk: 'Masterpieces (Аеро, Анаеробні), B-Corp екологічність',
        bioUk: 'Daterra — гігант інновацій. Створюють лоти серії "Masterpieces" — унікальні експерименти з мацерацією.',
        imageUrl: 'https://images.unsplash.com/photo-1463453091185-61582044d556?w=400&q=80',
      ),
    ];

    for (var farmer in farmersToSeed) {
      await db.smartUpsertFarmer(
        farmer['main'] as LocalizedFarmersCompanion,
        farmer['trans'] as List<LocalizedFarmerTranslationsCompanion>,
      );
    }
  }

  Map<String, dynamic> _createFarmer({
    required int id,
    required String nameEn,
    required String nameUk,
    required String farm,
    required String countryEn,
    required String countryUk,
    required String region,
    required double lat,
    required double lng,
    required String specEn,
    required String specUk,
    required String bioUk,
    required String imageUrl,
  }) {
    return {
      'main': LocalizedFarmersCompanion.insert(
        id: Value(id),
        countryEmoji: Value(FlagConstants.getEmoji(countryEn)), // Using a helper if available, or just map manually
        latitude: Value(lat),
        longitude: Value(lng),
        imageUrl: Value(imageUrl),
        createdAt: Value(DateTime.now()),
      ),
      'trans': [
        LocalizedFarmerTranslationsCompanion.insert(
          farmerId: id,
          languageCode: 'en',
          name: Value(nameEn),
          region: Value(region),
          country: Value(countryEn),
          description: Value(specEn),
          story: Value(specEn), // Defaulting story to specialization for English
        ),
        LocalizedFarmerTranslationsCompanion.insert(
          farmerId: id,
          languageCode: 'uk',
          name: Value(nameUk),
          region: Value(region),
          country: Value(countryUk),
          description: Value(specUk),
          story: Value(bioUk),
        ),
      ],
    };
  }

  Future<void> _seedMadHeadsOrigins() async {
    const brandId = 1;
    await db.smartUpsertBean(
      LocalizedBeansCompanion.insert(
        id: const Value(1),
        brandId: const Value(brandId),
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
      [
        LocalizedBeanTranslationsCompanion.insert(
          beanId: 1,
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
        LocalizedBeanTranslationsCompanion.insert(
          beanId: 1,
          languageCode: 'en',
          country: const Value('TANZANIA - Utengule'),
          region: const Value('Utengule'),
          processMethod: const Value('Honey'),
          varieties: const Value('Bourbon'),
          description: const Value('Sweet and balanced lot from Tanzania.'),
          flavorNotes: Value(
            jsonEncode(['Peach', 'Green apple', 'Yellow plum', 'White tea']),
          ),
        ),
      ],
    );
  }

  Future<void> _seed3ChampsOrigins() async {
    const brandId = 2;
    final entries = [
      _create3ChampsEntry(
        id: 101,
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
      await db.smartUpsertBean(entry.main, [entry.trans]);
    }
  }

  _Entry3Champs _create3ChampsEntry({
    required int id,
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
        id: Value(id),
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
        beanId: id,
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
    await db.smartUpsertBean(
      LocalizedBeansCompanion.insert(
        id: const Value(501),
        countryEmoji: const Value('🇵🇦'),
        altitudeMin: const Value(1500),
        altitudeMax: const Value(1900),
        cupsScore: const Value(93.5),
      ),
      [
        LocalizedBeanTranslationsCompanion.insert(
          beanId: 501,
          languageCode: 'en',
          country: const Value('Panama (La Esmeralda)'),
          region: const Value('Boquete'),
          varieties: const Value('Gesha (Geisha)'),
          flavorNotes: Value(jsonEncode(['Jasmine', 'Bergamot'])),
          description: const Value('The coffee lot that shocked the world.'),
        ),
      ],
    );
  }

  Future<void> _seedSpecialtyArticles() async {
    await db.transaction(() async {
      final id = await db.insertArticle(
        SpecialtyArticlesCompanion.insert(
          imageUrl: 'https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=600&q=80',
          readTimeMin: 6,
        ),
      );
      await db.insertArticleTranslation(
        SpecialtyArticleTranslationsCompanion.insert(
          articleId: id,
          languageCode: 'uk',
          title: 'Як оцінюють зерно (Q-Grading)',
          subtitle: 'SCA Протокол, 10 параметрів якості',
          contentHtml: '<h3>Протокол SCA</h3><p>Оцінка від 80 балів.</p>',
        ),
      );
    });
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
