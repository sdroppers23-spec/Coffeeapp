import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for synchronizing user-managed coffee data.
/// Updated in v17 to support full cloud-to-local sync for Encyclopedia.
class SyncService {
  final AppDatabase db;
  final SupabaseClient? supabase;

  static const String baseUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public';
  static const String articlesBucket = '$baseUrl/specialty-articles/';
  static const String methodsBucket = '$baseUrl/Methods/';
  static const String flagsBucket = '$baseUrl/Flags/';
  static const String farmersBucket = '$baseUrl/Farmers/';

  SyncService(this.db, [this.supabase]);

  /// Synchronizes all systems.
  Future<void> syncAll({
    bool force = false,
    Function(String)? onProgress,
  }) async {
    try {
      debugPrint('SYNC: Starting full synchronization...');
      onProgress?.call('Connecting to cloud...');

      if (supabase == null) {
        onProgress?.call('Supabase not available, skipping cloud sync.');
        return;
      }

      // 1. Version Guard (Cache Buster)
      if (force) {
        onProgress?.call('Clearing local cache for stabilization...');
        await _clearLocalSharedData();
      }

      // 2. Sync Farmers
      onProgress?.call('Syncing Farmers...');
      await syncFarmers();

      // 3. Sync Articles
      onProgress?.call('Syncing Articles...');
      await syncArticles();

      // 4. Sync Encyclopedia (Lots)
      onProgress?.call('Updating Encyclopedia (Healing Flags)...');
      await syncEncyclopedia();

      // 5. Sync Brands
      onProgress?.call('Syncing Coffee Roasters...');
      await syncBrands();

      // 6. Sync Brewing Methods
      onProgress?.call('Syncing Brewing Methods...');
      await syncBrewingRecipes();

      // 7. Sync User Content (Push to Cloud)
      onProgress?.call('Pushing local recipes to cloud...');
      await pushLocalUserContent();

      onProgress?.call('Cloud Connected');
      debugPrint('SYNC: All systems synchronized [STABLE]');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e');
      rethrow;
    }
  }

  /// Pulls encyclopedia data from Supabase and updates local storage.
  /// Updated to use 'localized_beans' table for full localization support and healing.
  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling beans from localized_beans...');
      final data = await supabase!.from('localized_beans').select().order('id');
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;

          // Healing: Detect planets and replace with bucket flags
          String emoji = item['country_emoji'] as String? ?? '';
          final planetEmojis = ['🌎', '🌍', '🌏', '🪐', '☄️', '🌌', 'planet', 'earth'];
          if (planetEmojis.contains(emoji.trim()) || emoji.isEmpty) {
            final countryLower = (item['country_uk'] as String? ?? item['country_en'] as String? ?? 'unknown').toLowerCase().replaceAll(' ', '_');
            emoji = '$flagsBucket$countryLower.png';
            debugPrint('SYNC: Healed planet emoji for ID $id to flag photo: $emoji');
          }

          // 1. Prepare Bean Companion (Main Record with UK data)
          final bean = LocalizedBeansCompanion(
            id: Value(id),
            brandId: Value(item['brand_id'] as int?),
            countryEmoji: Value(emoji),
            altitudeMin: Value(item['altitude_min'] as int?),
            altitudeMax: Value(item['altitude_max'] as int?),
            lotNumber: Value(item['lot_number'] as String? ?? ''),
            scaScore: Value(item['sca_score']?.toString() ?? '82+'), 
            cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
            sensoryJson: Value(item['sensory_json']?.toString() ?? '{}'),
            priceJson: Value(item['price_json']?.toString() ?? '{}'),
            retailPrice: Value(item['retail_price']?.toString() ?? item['price']?.toString()),
            isPremium: Value(item['is_premium'] as bool? ?? false),
            isDecaf: Value(item['is_decaf'] as bool? ?? false),
            url: Value(item['url'] as String? ?? ''),
            // UK Direct Fields
            countryUk: Value(item['country_uk'] as String? ?? item['country_en'] as String?),
            regionUk: Value(item['region_uk'] as String? ?? item['region_en'] as String?),
            varietiesUk: Value(item['varieties_uk'] as String? ?? item['varieties_en'] as String?),
            flavorNotesUk: Value(item['flavor_notes_uk']?.toString() ?? item['flavor_notes_en']?.toString() ?? '[]'),
            processMethodUk: Value(item['process_method_uk'] as String? ?? item['process_method_en'] as String?),
            descriptionUk: Value(item['description_uk'] as String? ?? item['description_en'] as String?),
            roastLevelUk: Value(item['roast_level_uk'] as String? ?? item['roast_level_en'] as String?),
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          // 2. Prepare Translations (Fetches from translation table)
          final translationsData = await supabase!
              .from('localized_bean_translations')
              .select()
              .eq('bean_id', id);

          final List<LocalizedBeanTranslationsCompanion> translations = [];
          for (final t in translationsData) {
            translations.add(
              LocalizedBeanTranslationsCompanion(
                beanId: Value(id),
                languageCode: Value(t['language_code'] as String),
                country: Value(t['country'] as String?),
                region: Value(t['region'] as String?),
                varieties: Value(t['varieties'] as String?),
                flavorNotes: Value(t['flavor_notes']?.toString() ?? '[]'),
                processMethod: Value(t['process_method'] as String?),
                description: Value(t['description'] as String?),
                farmDescription: Value(t['farm_description'] as String?), 
                roastLevel: Value(t['roast_level'] as String?),
              ),
            );
          }

          // 3. Upsert into local DB
          await db.smartUpsertBean(bean, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for bean ID ${item['id']}: $e');
          errorCount++;
        }
      }
      debugPrint('SYNC: Encyclopedia synchronized ($successCount success, $errorCount errors)');
    } catch (e) {
      debugPrint('SYNC ERROR (Encyclopedia): $e');
      rethrow;
    }
  }

  /// Sets up a real-time subscription for Encyclopedia changes.
  void subscribeToEncyclopedia() {
    if (supabase == null) return;
    
    debugPrint('SYNC: Subscribing to Encyclopedia real-time changes...');
    supabase!
        .from('localized_beans')
        .stream(primaryKey: ['id'])
        .listen((data) {
          debugPrint('SYNC: Beans cloud data changed (localized_beans), triggering re-sync...');
          syncEncyclopedia().catchError((e) {
            debugPrint('SYNC ERROR after stream update (beans): $e');
          });
        });

    supabase!
        .from('localized_farmers')
        .stream(primaryKey: ['id'])
        .listen((data) {
          debugPrint('SYNC: Farmers cloud data changed, triggering re-sync...');
          syncFarmers().catchError((e) {
            debugPrint('SYNC ERROR after stream update (farmers): $e');
          });
        });

    supabase!
        .from('specialty_articles')
        .stream(primaryKey: ['id'])
        .listen((data) {
          debugPrint('SYNC: Articles cloud data changed, triggering re-sync...');
          syncArticles().catchError((e) {
            debugPrint('SYNC ERROR after stream update (articles): $e');
          });
        });
  }

  /// Pulls farmer data from Supabase and updates local storage.
  /// Joining translations for accurate names as per stabilization requirement.
  Future<void> syncFarmers() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling farmers and translations from Supabase...');
      
      // Clear old farmers locally
      await db.transaction(() async {
        await db.delete(db.localizedFarmers).go();
      });

      // Fetch main farmer records
      final farmersData = await supabase!.from('localized_farmers').select().order('id');
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in farmersData) {
        try {
          final id = item['id'] as int;
          
          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
            final fileName = imageUrl.split('/').last;
            imageUrl = '$farmersBucket$fileName';
          }

          // In "Main + Translation" architecture:
          // LocalizedFarmers main table holds UK content in nameUk, descriptionHtmlUk, etc.
          final farmer = LocalizedFarmersCompanion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: Value(item['flag_url'] as String? ?? item['country_emoji'] as String? ?? ''),
            latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
            longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
            nameUk: Value(item['name_uk'] as String? ?? item['name'] as String? ?? ''),
            descriptionHtmlUk: Value(item['description_uk'] as String? ?? item['description'] as String? ?? ''),
            regionUk: Value(item['region_uk'] as String? ?? item['region'] as String? ?? ''),
            countryUk: Value(item['country_uk'] as String? ?? item['country'] as String? ?? ''),
          );

          // We also fetch translations if any (e.g. 'en')
          final translationsData = await supabase!
              .from('localized_farmer_translations')
              .select()
              .eq('farmer_id', id);

          final List<LocalizedFarmerTranslationsCompanion> translations = [];
          for (final t in translationsData) {
            final lang = t['language_code'] as String;
            // Map legacy or current fields
            translations.add(LocalizedFarmerTranslationsCompanion(
              farmerId: Value(id),
              languageCode: Value(lang),
              name: Value(t['name'] as String?),
              descriptionHtml: Value(t['description_html'] as String? ?? t['description'] as String?),
              region: Value(t['region'] as String?),
              country: Value(t['country'] as String?),
            ));
          }

          await db.smartUpsertFarmer(farmer, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for farmer ID ${item['id']}: $e');
          errorCount++;
        }
      }
      debugPrint('SYNC: Farmers synchronized ($successCount success, $errorCount errors)');
    } catch (e) {
      debugPrint('SYNC ERROR (Farmers): $e');
      rethrow;
    }
  }

  /// Pulls specialty articles from Supabase.
  Future<void> syncArticles() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling articles from specialty_articles...');
      final data = await supabase!.from('specialty_articles').select().order('id');
      
      // Clear old articles locally
      await db.transaction(() async {
        await db.delete(db.specialtyArticles).go();
      });

      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;

          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
             final fileName = imageUrl.split('/').last;
             imageUrl = '$articlesBucket$fileName';
          }

          final article = SpecialtyArticlesCompanion(
            id: Value(id),
            titleUk: Value(item['title_uk'] as String? ?? item['title_en'] as String? ?? ''),
            subtitleUk: Value(item['subtitle_uk'] as String? ?? ''),
            contentHtmlUk: Value(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? ''),
            imageUrl: Value(imageUrl),
            readTimeMin: Value(item['read_time_min'] as int? ?? 5),
          );

          // Sync translations
          final translationsData = await supabase!
              .from('specialty_article_translations')
              .select()
              .eq('article_id', id);

          final List<SpecialtyArticleTranslationsCompanion> translations = [];
          for (final t in translationsData) {
             translations.add(SpecialtyArticleTranslationsCompanion(
               articleId: Value(id),
               languageCode: Value(t['language_code'] as String),
               title: Value(t['title'] as String?),
               subtitle: Value(t['subtitle'] as String?),
               contentHtml: Value(t['content_html'] as String?),
             ));
          }

          await db.smartUpsertArticle(article, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for article ID ${item['id']}: $e');
          errorCount++;
        }
      }
      debugPrint('SYNC: Articles synchronized ($successCount success, $errorCount errors)');
    } catch (e) {
      debugPrint('SYNC ERROR (Articles): $e');
      rethrow;
    }
  }

  /// Helper for manual lot synchronization if needed.
  Future<void> syncLots([List<CoffeeLotsCompanion>? lots]) async {
    if (lots != null && lots.isNotEmpty) {
      await db.syncLotsInTx(lots);
    }
  }

  /// Pushes local user data (recipes and lots) to Supabase.
  Future<void> pushLocalUserContent() async {
    if (supabase == null || supabase!.auth.currentUser == null) return;

    try {
      final userId = supabase!.auth.currentUser!.id;
      
      // 1. Sync Custom Recipes
      final recipes = await (db.select(db.customRecipes)..where((t) => t.isSynced.equals(false))).get();
      for (final r in recipes) {
        try {
          await supabase!.from('user_custom_recipes').upsert({
            'id': r.id,
            'user_id': userId,
            'method_key': r.methodKey,
            'name': r.name,
            'coffee_grams': r.coffeeGrams,
            'total_water_ml': r.totalWaterMl,
            'grind_number': r.grindNumber,
            'brew_temp_c': r.brewTempC,
            'notes': r.notes,
            'rating': r.rating,
            'created_at': r.createdAt?.toIso8601String(),
          });
          await (db.update(db.customRecipes)..where((t) => t.id.equals(r.id))).write(const CustomRecipesCompanion(isSynced: Value(true)));
        } catch (e) {
          debugPrint('SYNC ERROR: Could not push recipe ${r.id}: $e');
        }
      }

      // 2. Sync Personal Coffee Lots
      final lots = await (db.select(db.coffeeLots)..where((t) => t.isSynced.equals(false))).get();
      for (final l in lots) {
        try {
          await supabase!.from('user_coffee_lots').upsert({
            'id': l.id,
            'user_id': userId,
            'coffee_name': l.coffeeName,
            'roastery_name': l.roasteryName,
            'origin_country': l.originCountry,
            'region': l.region,
            'process': l.process,
            'roast_level': l.roastLevel,
            'is_decaf': l.isDecaf,
            'created_at': l.createdAt?.toIso8601String(),
          });
          await (db.update(db.coffeeLots)..where((t) => t.id.equals(l.id))).write(const CoffeeLotsCompanion(isSynced: Value(true)));
        } catch (e) {
          debugPrint('SYNC ERROR: Could not push lot ${l.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('SYNC ERROR (User Push): $e');
    }
  }

  /// Pulls brewing recipes from Supabase.
  Future<void> syncBrewingRecipes() async {
    if (supabase == null) return;
    try {
      debugPrint('SYNC: Pulling methods from brewing_recipes...');
      final data = await supabase!.from('brewing_recipes').select();
      
      for (final item in data) {
        try {
          final key = item['method_key'] as String;
          final companion = BrewingRecipesCompanion(
            methodKey: Value(key),
            nameUk: Value(item['name_uk'] as String? ?? item['name'] as String? ?? ''),
            descriptionUk: Value(item['description_uk'] as String? ?? item['description'] as String? ?? ''),
            ratioGramsPerMl: Value((item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
            difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
            flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
            iconName: Value(item['icon_name'] as String?),
            stepsJson: Value(item['steps_json']?.toString() ?? '[]'),
          );

          // Get translations
          final transData = await supabase!
              .from('brewing_recipe_translations')
              .select()
              .eq('recipe_key', key);

          final List<BrewingRecipeTranslationsCompanion> translations = [];
          for (final t in transData) {
            translations.add(BrewingRecipeTranslationsCompanion(
              recipeKey: Value(key),
              languageCode: Value(t['language_code'] as String),
              name: Value(t['name'] as String?),
              description: Value(t['description'] as String?),
            ));
          }

          await db.smartUpsertBrewingRecipe(companion, translations);
        } catch (e) {
          debugPrint('SYNC ERROR for method ${item['method_key']}: $e');
        }
      }
    } catch (e) {
      debugPrint('SYNC ERROR (Brewing Recipes): $e');
    }
  }

  /// Pulls brands from Supabase.
  Future<void> syncBrands() async {
    if (supabase == null) return;
    try {
      debugPrint('SYNC: Pulling brands from localized_brands...');
      final data = await supabase!.from('localized_brands').select();
      
      for (final item in data) {
        try {
          final id = item['id'] as int;
          final companion = LocalizedBrandsCompanion(
            id: Value(id),
            name: Value(item['name'] as String? ?? ''),
            logoUrl: Value(item['logo_url'] as String?),
            siteUrl: Value(item['site_url'] as String?),
            shortDescUk: Value(item['short_desc_uk'] as String? ?? item['short_desc_en'] as String? ?? ''),
            fullDescUk: Value(item['full_desc_uk'] as String? ?? item['full_desc_en'] as String? ?? ''),
            locationUk: Value(item['location_uk'] as String? ?? item['location_en'] as String? ?? ''),
          );

          // Get translations
          final transData = await supabase!
              .from('localized_brand_translations')
              .select()
              .eq('brand_id', id);

          final List<LocalizedBrandTranslationsCompanion> translations = [];
          for (final t in transData) {
             translations.add(LocalizedBrandTranslationsCompanion(
               brandId: Value(id),
               languageCode: Value(t['language_code'] as String),
               shortDesc: Value(t['short_desc'] as String?),
               fullDesc: Value(t['full_desc'] as String?),
               location: Value(t['location'] as String?),
             ));
          }

          await db.smartUpsertBrand(companion, translations);
        } catch (e) {
          debugPrint('SYNC ERROR for brand ID ${item['id']}: $e');
        }
      }
    } catch (e) {
      debugPrint('SYNC ERROR (Brands): $e');
    }
  }

  /// Clears local shared tables to force fresh sync.
  Future<void> _clearLocalSharedData() async {
    try {
      debugPrint('SYNC: Clearing local shared tables...');
      await db.transaction(() async {
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedBeans).go();
        await db.delete(db.localizedBeanTranslations).go();
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.localizedBrands).go();
        await db.delete(db.brewingRecipes).go();
      });
      debugPrint('SYNC: Local cache cleared.');
    } catch (e) {
      debugPrint('SYNC ERROR (Clear): $e');
    }
  }

  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  Future<void> pullFromCloud({Function(String)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }
}
