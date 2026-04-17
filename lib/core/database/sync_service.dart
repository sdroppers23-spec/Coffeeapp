import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import '../utils/content_utils.dart';

/// Service responsible for synchronizing user-managed coffee data.
/// Updated in v17 to support full cloud-to-local sync for Encyclopedia.
class SyncService {
  final AppDatabase db;
  final SupabaseClient? supabase;

  // Stream for real-time progress tracking
  final _progressController = StreamController<double>.broadcast();
  Stream<double> get progressStream => _progressController.stream;

  // Stream to notify UI when a record was updated in real-time
  final _dataUpdateController = StreamController<void>.broadcast();
  Stream<void> get dataUpdateStream => _dataUpdateController.stream;

  static const String baseUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public';
  static const String articlesBucket = '$baseUrl/specialty-articles/';
  static const String methodsBucket = '$baseUrl/Methods/';
  static const String flagsBucket = '$baseUrl/Flags/';
  static const String farmersBucket = '$baseUrl/Farmers/';

  SyncService(this.db, [this.supabase]);

  void dispose() {
    _progressController.close();
    _dataUpdateController.close();
  }

  /// Synchronizes all systems.
  Future<void> syncAll({
    bool force = false,
    Function(String, double)? onProgress,
  }) async {
    try {
      debugPrint('SYNC: Starting full synchronization...');
      _progressController.add(0.05);
      onProgress?.call('Connecting to cloud...', 0.05);
      
      if (supabase == null) {
        _progressController.add(1.0);
        onProgress?.call('Supabase not available, skipping cloud sync.', 1.0);
        return;
      }

      // 1. Version Guard (Cache Buster)
      if (force) {
        onProgress?.call('Clearing local cache...', 0.1);
        _progressController.add(0.1);
        await _clearLocalSharedData();
      }

      // 2. Sequential Stable Sync with real progress updates
      onProgress?.call('Syncing Farmers...', 0.2);
      _progressController.add(0.2);
      await syncFarmers();
      await Future.delayed(const Duration(milliseconds: 200));
      
      onProgress?.call('Syncing Encyclopedia...', 0.4);
      _progressController.add(0.4);
      await syncEncyclopedia();
      await Future.delayed(const Duration(milliseconds: 200));
      
      onProgress?.call('Syncing Methods...', 0.6);
      _progressController.add(0.6);
      await syncBrewingRecipes();
      await Future.delayed(const Duration(milliseconds: 200));
      
      onProgress?.call('Syncing Articles...', 0.8);
      _progressController.add(0.8);
      await syncArticles(onProgress: onProgress);
      await Future.delayed(const Duration(milliseconds: 200));
      
      onProgress?.call('Syncing Brands...', 0.9);
      _progressController.add(0.9);
      await syncBrands();
      
      onProgress?.call('Syncing User Data...', 0.95);
      _progressController.add(0.95);
      // Push local changes (including deletions) BEFORE pulling to prevent restored deleted items
      await pushLocalUserContent(); 
      await pullUserContent();
      
      onProgress?.call('Finalizing...', 0.98);

      _progressController.add(1.0);
      onProgress?.call('Cloud Connected', 1.0);
      debugPrint('SYNC: All systems synchronized [STABLE]');
    } catch (e) {
      debugPrint('SYNC ERROR: $e');
      _progressController.add(0.0); // Reset or mark error
      onProgress?.call('Sync failed: $e', 1.0);
      rethrow;
    }
  }

  /// Pulls encyclopedia data from Supabase and updates local storage.
  /// Updated to use 'localized_beans' table for full localization support and healing.
  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Clearing local beans before pull...');
      await db.transaction(() async {
        debugPrint('SYNC: Clearing localizedBeanTranslations...');
        await (db.delete(db.localizedBeanTranslations)).go();
        debugPrint('SYNC: Clearing localizedBeans...');
        await (db.delete(db.localizedBeans)).go();
      });

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
            descriptionUk: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description_en'] as String? ?? '')),
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
                country: Value(ContentUtils.cleanCoffeeContent(t['country'] as String? ?? '')),
                region: Value(ContentUtils.cleanCoffeeContent(t['region'] as String? ?? '')),
                varieties: Value(ContentUtils.cleanCoffeeContent(t['varieties'] as String? ?? '')),
                flavorNotes: Value(t['flavor_notes']?.toString() ?? '[]'),
                processMethod: Value(ContentUtils.cleanCoffeeContent(t['process_method'] as String? ?? '')),
                description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
                farmDescription: Value(ContentUtils.cleanCoffeeContent(t['farm_description'] as String? ?? '')), 
                roastLevel: Value(ContentUtils.cleanCoffeeContent(t['roast_level'] as String? ?? '')),
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

  /// Sets up real-time subscriptions for all main content tables.
  void subscribeToRealtimeUpdates() {
    if (supabase == null) return;
    
    debugPrint('SYNC: Initializing real-time subscriptions...');

    // 1. Articles Channel
    supabase!
        .channel('public:specialty_articles')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'specialty_articles',
          callback: (payload) async {
            debugPrint('SYNC: Real-time event for Articles: ${payload.eventType}');
            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = payload.oldRecord['id'] as int;
              await (db.delete(db.specialtyArticles)..where((t) => t.id.equals(id))).go();
            } else {
              // INSERT or UPDATE
              final id = payload.newRecord['id'] as int;
              await syncSingleArticle(id);
            }
          },
        )
        .subscribe();

    // 2. Farmers Channel
    supabase!
        .channel('public:localized_farmers')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'localized_farmers',
          callback: (payload) async {
            debugPrint('SYNC: Real-time event for Farmers: ${payload.eventType}');
            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = payload.oldRecord['id'] as int;
              await (db.delete(db.localizedFarmers)..where((t) => t.id.equals(id))).go();
            } else {
              final id = payload.newRecord['id'] as int;
              await syncSingleFarmer(id);
            }
          },
        )
        .subscribe();

    // 3. Beans (Encyclopedia) Channel
    supabase!
        .channel('public:localized_beans')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'localized_beans',
          callback: (payload) async {
            debugPrint('SYNC: Real-time event for Beans: ${payload.eventType}');
            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = payload.oldRecord['id'] as int;
              await (db.delete(db.localizedBeans)..where((t) => t.id.equals(id))).go();
            } else {
              final id = payload.newRecord['id'] as int;
              await syncSingleBean(id);
            }
          },
        )
        .subscribe();

    // 4. Brewing Recipes Channel
    supabase!
        .channel('public:brewing_recipes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'brewing_recipes',
          callback: (payload) async {
            debugPrint('SYNC: Real-time event for Brewing Recipes: ${payload.eventType}');
            if (payload.eventType == PostgresChangeEvent.delete) {
              final key = payload.oldRecord['method_key'] as String;
              await (db.delete(db.brewingRecipes)..where((t) => t.methodKey.equals(key))).go();
            } else {
              final key = payload.newRecord['method_key'] as String;
              await syncSingleBrewingRecipe(key);
            }
          },
        )
        .subscribe();
  }

  /// Pulls farmer data from Supabase and updates local storage.
  /// Joining translations for accurate names as per stabilization requirement.
  Future<void> syncFarmers() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling farmers from Supabase...');

      // Fetch main farmer records
      final farmersData = await supabase!.from('localized_farmers').select().order('id');
      
      debugPrint('SYNC: Received ${farmersData.length} farmers from Supabase');

      // Clear old farmers locally (translations first to avoid FK issues)
      await db.transaction(() async {
        debugPrint('SYNC: Clearing localizedFarmerTranslations...');
        await (db.delete(db.localizedFarmerTranslations)).go();
        debugPrint('SYNC: Clearing localizedFarmers...');
        await (db.delete(db.localizedFarmers)).go();
      });
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in farmersData) {
        try {
          debugPrint('SYNC: Processing farmer ID: ${item['id']}');
          final id = item['id'] as int;
          
          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
            final fileName = imageUrl.split('/').last;
            imageUrl = '$farmersBucket$fileName';
          }

          // In "Main + Translation" architecture:
          // LocalizedFarmers main table holds UK content in nameUk, descriptionHtmlUk, etc.
          debugPrint('SYNC: Mapping farmer ID: $id (name: ${item['name_uk']})');

          // Use safe conversion to string to avoid casting errors if Supabase types differ
          final nameRaw = item['name_uk'] ?? item['name'] ?? '';
          final descRaw = item['description_html_uk'] ?? item['description_uk'] ?? item['description'] ?? '';
          final storyRaw = item['story_uk'] ?? item['story'] ?? '';
          final countryRaw = item['country_uk'] ?? item['country'] ?? '';
          final regionRaw = item['region_uk'] ?? item['region'] ?? '';
          final flagRaw = item['flag_url'] ?? item['country_emoji'] ?? '';

          final farmer = LocalizedFarmersCompanion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: Value(flagRaw.toString()),
            latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
            longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
            nameUk: Value(nameRaw.toString()),
            descriptionHtmlUk: Value(ContentUtils.cleanCoffeeContent(descRaw.toString())),
            storyUk: Value(ContentUtils.cleanCoffeeContent(storyRaw.toString())),
            regionUk: Value(regionRaw.toString()),
            countryUk: Value(countryRaw.toString()),
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
              name: Value(ContentUtils.cleanCoffeeContent(t['name'] as String? ?? '')),
              descriptionHtml: Value(ContentUtils.cleanCoffeeContent(t['description_html'] as String? ?? t['description'] as String? ?? '')),
              region: Value(t['region'] as String?),
              country: Value(t['country'] as String?),
              story: Value(ContentUtils.cleanCoffeeContent(t['story'] as String? ?? '')),
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
  Future<void> syncArticles({Function(String, double)? onProgress}) async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling articles from specialty_articles...');
      final data = await supabase!.from('specialty_articles').select().order('id');
      
      // Clear old articles locally after successful connection to Supabase

      // Clear old articles locally only after successful fetch
      await db.transaction(() async {
        debugPrint('SYNC: Clearing specialtyArticleTranslations...');
        await (db.delete(db.specialtyArticleTranslations)).go();
        debugPrint('SYNC: Clearing specialtyArticles...');
        await (db.delete(db.specialtyArticles)).go();
      });

      int successCount = 0;
      int errorCount = 0;
      final total = data.length;

      for (int i = 0; i < total; i++) {
        final item = data[i];
        final progress = 0.5 + (i / total * 0.5); // Articles are the second half of sync
        onProgress?.call('Syncing Articles...', progress);

        try {
          final id = item['id'] as int;
          debugPrint('SYNC: Processing article ID: $id');

          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
             final fileName = imageUrl.split('/').last;
             imageUrl = '$articlesBucket$fileName';
          }

          final article = SpecialtyArticlesCompanion(
            id: Value(id),
            titleUk: Value(ContentUtils.cleanCoffeeContent(item['title_uk'] as String? ?? item['title_en'] as String? ?? '')),
            subtitleUk: Value(ContentUtils.cleanCoffeeContent(item['subtitle_uk'] as String? ?? '')),
            contentHtmlUk: Value(ContentUtils.cleanCoffeeContent(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? '')),
            imageUrl: Value(imageUrl),
            readTimeMin: Value(item['read_time_min'] as int? ?? 5),
          );

          // Sync translations
          final translationsData = await supabase!
              .from('specialty_article_translations')
              .select()
              .eq('article_id', id);

          debugPrint('SYNC: Found ${translationsData.length} translations for article $id');

          final List<SpecialtyArticleTranslationsCompanion> translations = [];
          for (final t in translationsData) {
             translations.add(SpecialtyArticleTranslationsCompanion(
               articleId: Value(id),
               languageCode: Value(t['language_code'] as String),
                title: Value(ContentUtils.cleanCoffeeContent(t['title'] as String? ?? '')),
                subtitle: Value(ContentUtils.cleanCoffeeContent(t['subtitle'] as String? ?? '')),
                contentHtml: Value(ContentUtils.cleanCoffeeContent(t['content_html'] as String? ?? '')),
             ));
          }

          await db.smartUpsertArticle(article, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for article ID ${item['id']}: $e');
          errorCount++;
        }
      }
      debugPrint('SYNC: Articles total - SUCCESS: $successCount, ERRORS: $errorCount');
    } catch (e) {
      debugPrint('SYNC CRITICAL ERROR (Articles): $e');
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
  /// Pushes local user data (recipes and lots) to Supabase, including deletions.
  Future<void> pushLocalUserContent() async {
    if (supabase == null || supabase!.auth.currentUser == null) return;

    try {
      final userId = supabase!.auth.currentUser!.id;
      
      // 1. Sync Custom Recipes (Upsert & Delete)
      final recipesToSync = await (db.select(db.customRecipes)..where((t) => t.isSynced.equals(false))).get();
      for (final r in recipesToSync) {
        try {
          if (r.isDeletedLocal) {
            await supabase!.from('user_custom_recipes').delete().eq('id', r.id).eq('user_id', userId);
            await db.deleteCustomRecipe(r.id);
            debugPrint('SYNC: Deleted recipe ${r.id} from cloud');
          } else {
            await supabase!.from('user_custom_recipes').upsert({
              'id': r.id,
              'user_id': userId,
              'lot_id': r.lotId,
              'method_key': r.methodKey,
              'name': r.name,
              'coffee_grams': r.coffeeGrams,
              'total_water_ml': r.totalWaterMl,
              'grind_number': r.grindNumber,
              'comandante_clicks': r.comandanteClicks,
              'ek43_division': r.ek43Division,
              'total_pours': r.totalPours,
              'pour_schedule_json': r.pourScheduleJson,
              'brew_temp_c': r.brewTempC,
              'notes': r.notes,
              'rating': r.rating,
              'created_at': r.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });
            await (db.update(db.customRecipes)..where((t) => t.id.equals(r.id))).write(const CustomRecipesCompanion(isSynced: Value(true)));
          }
        } catch (e) {
          debugPrint('SYNC ERROR: Could not push recipe ${r.id}: $e');
        }
      }

      // 2. Sync Personal Coffee Lots (Upsert & Delete)
      final lotsToSync = await (db.select(db.coffeeLots)..where((t) => t.isSynced.equals(false))).get();
      for (final l in lotsToSync) {
        try {
          if (l.isDeletedLocal) {
            await supabase!.from('user_coffee_lots').delete().eq('id', l.id).eq('user_id', userId);
            await db.deleteLotPermanently(l.id);
            debugPrint('SYNC: Deleted lot ${l.id} from cloud');
          } else {
            await supabase!.from('user_coffee_lots').upsert({
              'id': l.id,
              'user_id': userId,
              'coffee_name': l.coffeeName,
              'roastery_name': l.roasteryName,
              'roastery_country': l.roasteryCountry,
              'origin_country': l.originCountry,
              'region': l.region,
              'altitude': l.altitude,
              'process': l.process,
              'roast_level': l.roastLevel,
              'roast_date': l.roastDate?.toIso8601String(),
              'opened_at': l.openedAt?.toIso8601String(),
              'weight': l.weight,
              'lot_number': l.lotNumber,
              'is_decaf': l.isDecaf,
              'farm': l.farm,
              'wash_station': l.washStation,
              'farmer': l.farmer,
              'varieties': l.varieties,
              'flavor_profile': l.flavorProfile,
              'sca_score': l.scaScore,
              'is_favorite': l.isFavorite,
              'is_archived': l.isArchived,
              'is_open': l.isOpen,
              'is_ground': l.isGround,
              'sensory_json': l.sensoryJson,
              'price_json': l.priceJson,
              'brand_id': l.brandId,
              'created_at': l.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });
            await (db.update(db.coffeeLots)..where((t) => t.id.equals(l.id))).write(const CoffeeLotsCompanion(isSynced: Value(true)));
          }
        } catch (e) {
          debugPrint('SYNC ERROR: Could not push lot ${l.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('SYNC ERROR (User Push): $e');
    }
  }

  /// Pulls user-specific lots and recipes from Supabase.
  Future<void> pullUserContent() async {
    if (supabase == null || supabase!.auth.currentUser == null) return;
    
    try {
      final userId = supabase!.auth.currentUser!.id;
      debugPrint('SYNC: Pulling user content for $userId');

      // 1. Pull Lots
      final lotsData = await supabase!.from('user_coffee_lots').select().eq('user_id', userId);
      for (final item in lotsData) {
        final id = item['id'] as String;
        
        // CHECK: If lot is deleted locally but not yet synced with cloud, do not pull it back
        final localLot = await db.findConflictLot(id);
        if (localLot != null && localLot.isDeletedLocal) {
          debugPrint('SYNC: Skipping pull for locally deleted lot $id');
          continue;
        }

        final lot = CoffeeLotsCompanion(
          id: Value(id),
          userId: Value(userId),
          coffeeName: Value(item['coffee_name'] as String?),
          roasteryName: Value(item['roastery_name'] as String?),
          roasteryCountry: Value(item['roastery_country'] as String?),
          originCountry: Value(item['origin_country'] as String?),
          region: Value(item['region'] as String?),
          altitude: Value(item['altitude'] as String?),
          process: Value(item['process'] as String?),
          roastLevel: Value(item['roast_level'] as String?),
          roastDate: Value(DateTime.tryParse(item['roast_date'] ?? '')),
          openedAt: Value(DateTime.tryParse(item['opened_at'] ?? '')),
          weight: Value(item['weight'] as String?),
          lotNumber: Value(item['lot_number'] as String?),
          isDecaf: Value(item['is_decaf'] as bool? ?? false),
          farm: Value(item['farm'] as String?),
          washStation: Value(item['wash_station'] as String?),
          farmer: Value(item['farmer'] as String?),
          varieties: Value(item['varieties'] as String?),
          flavorProfile: Value(item['flavor_profile'] as String?),
          scaScore: Value(item['sca_score'] as String?),
          isFavorite: Value(item['is_favorite'] as bool? ?? false),
          isArchived: Value(item['is_archived'] as bool? ?? false),
          isOpen: Value(item['is_open'] as bool? ?? false),
          isGround: Value(item['is_ground'] as bool? ?? false),
          sensoryJson: Value(item['sensory_json']?.toString() ?? '{}'),
          priceJson: Value(item['price_json']?.toString() ?? '{}'),
          brandId: Value(item['brand_id'] as int?),
          isSynced: const Value(true),
          createdAt: Value(DateTime.tryParse(item['created_at'] ?? '')),
          updatedAt: Value(DateTime.tryParse(item['updated_at'] ?? '')),
        );
        await db.into(db.coffeeLots).insertOnConflictUpdate(lot);
      }

      // 2. Pull Recipes
      final recipesData = await supabase!.from('user_custom_recipes').select().eq('user_id', userId);
      for (final item in recipesData) {
        final id = item['id'] as String;

        // CHECK: If recipe is deleted locally, skip pull
        final existing = await (db.select(db.customRecipes)..where((t) => t.id.equals(id))).getSingleOrNull();
        if (existing != null && existing.isDeletedLocal) {
          debugPrint('SYNC: Skipping pull for locally deleted recipe $id');
          continue;
        }

        final recipe = CustomRecipesCompanion(
          id: Value(id),
          userId: Value(userId),
          lotId: Value(item['lot_id'] as String?),
          methodKey: Value(item['method_key'] as String),
          name: Value(item['name'] as String),
          coffeeGrams: Value((item['coffee_grams'] as num).toDouble()),
          totalWaterMl: Value((item['total_water_ml'] as num).toDouble()),
          grindNumber: Value(item['grind_number'] as int? ?? 0),
          comandanteClicks: Value(item['comandante_clicks'] as int? ?? 0),
          ek43Division: Value(item['ek43_division'] as int? ?? 0),
          totalPours: Value(item['total_pours'] as int? ?? 1),
          pourScheduleJson: Value(item['pour_schedule_json']?.toString() ?? '[]'),
          brewTempC: Value((item['brew_temp_c'] as num?)?.toDouble() ?? 93.0),
          notes: Value(item['notes'] as String? ?? ''),
          rating: Value(item['rating'] as int? ?? 0),
          isSynced: const Value(true),
          createdAt: Value(DateTime.tryParse(item['created_at'] ?? '')),
          updatedAt: Value(DateTime.tryParse(item['updated_at'] ?? '')),
        );
        await db.into(db.customRecipes).insertOnConflictUpdate(recipe);
      }
      
      debugPrint('SYNC: User content pulled (${lotsData.length} lots, ${recipesData.length} recipes)');
    } catch (e) {
      debugPrint('SYNC ERROR (User Pull): $e');
    }
  }

  /// Pulls brewing recipes from Supabase.
  Future<void> syncBrewingRecipes() async {
    if (supabase == null) return;
    try {
      debugPrint('SYNC: Clearing local brewing recipes before pull...');
      await db.transaction(() async {
        debugPrint('SYNC: Clearing brewingRecipeTranslations...');
        await (db.delete(db.brewingRecipeTranslations)).go();
        debugPrint('SYNC: Clearing brewingRecipes...');
        await (db.delete(db.brewingRecipes)).go();
      });

      debugPrint('SYNC: Pulling methods from brewing_recipes...');
      int successCount = 0;
      int errorCount = 0;
      
      final data = await supabase!.from('brewing_recipes').select();
      
      for (final item in data) {
        try {
          final key = item['method_key'] as String;
          debugPrint('SYNC: Processing brewing method: $key');

          String methodImageUrl = item['image_url'] as String? ?? '';
          if (methodImageUrl.isNotEmpty && !methodImageUrl.startsWith('http') && !methodImageUrl.startsWith('assets/')) {
            methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
          }

          final companion = BrewingRecipesCompanion(
            methodKey: Value(key),
            nameUk: Value(item['name_uk'] as String? ?? item['name'] as String? ?? ''),
            descriptionUk: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description'] as String? ?? '')),
            ratioGramsPerMl: Value((item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
            difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
            flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
            iconName: Value(item['icon_name'] as String?),
            imageUrl: Value(methodImageUrl),
            stepsJson: Value(item['steps_json']?.toString() ?? '[]'),
          );

          // Get translations
          final transData = await supabase!
              .from('brewing_recipe_translations')
              .select()
              .eq('recipe_key', key);

          debugPrint('SYNC: Found ${transData.length} translations for method $key');

          final List<BrewingRecipeTranslationsCompanion> translations = [];
          for (final t in transData) {
            translations.add(BrewingRecipeTranslationsCompanion(
              recipeKey: Value(key),
              languageCode: Value(t['language_code'] as String),
              name: Value(ContentUtils.cleanCoffeeContent(t['name'] as String? ?? '')),
              description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
            ));
          }

          await db.smartUpsertBrewingRecipe(companion, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for method ${item['method_key']}: $e');
          errorCount++;
        }
      }
      debugPrint('SYNC: Brewing methods total - SUCCESS: $successCount, ERRORS: $errorCount');
    } catch (e) {
      debugPrint('SYNC CRITICAL ERROR (Brewing Recipes): $e');
    }
  }

  /// Pulls brands from Supabase.
  Future<void> syncBrands() async {
    if (supabase == null) return;
    try {
      debugPrint('SYNC: Clearing local brands before pull...');
      await db.transaction(() async {
        debugPrint('SYNC: Clearing localizedBrandTranslations...');
        await (db.delete(db.localizedBrandTranslations)).go();
        debugPrint('SYNC: Clearing localizedBrands...');
        await (db.delete(db.localizedBrands)).go();
      });

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
            shortDescUk: Value(ContentUtils.cleanCoffeeContent(item['short_desc_uk'] as String? ?? item['short_desc_en'] as String? ?? '')),
            fullDescUk: Value(ContentUtils.cleanCoffeeContent(item['full_desc_uk'] as String? ?? item['full_desc_en'] as String? ?? '')),
            locationUk: Value(ContentUtils.cleanCoffeeContent(item['location_uk'] as String? ?? item['location_en'] as String? ?? '')),
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

  Future<void> pushLocalToCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  Future<void> pullFromCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  /// Syncs a single farmer by ID.
  Future<void> syncSingleFarmer(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('localized_farmers').select().eq('id', id).maybeSingle();
      if (item == null) return;

      String imageUrl = item['image_url'] as String? ?? '';
      if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
        imageUrl = '$farmersBucket${imageUrl.split('/').last}';
      }

      final farmer = LocalizedFarmersCompanion(
        id: Value(id),
        imageUrl: Value(imageUrl),
        flagUrl: Value((item['flag_url'] ?? item['country_emoji'] ?? '').toString()),
        latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
        longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
        nameUk: Value((item['name_uk'] ?? item['name'] ?? '').toString()),
        descriptionHtmlUk: Value(ContentUtils.cleanCoffeeContent((item['description_html_uk'] ?? item['description_uk'] ?? item['description'] ?? '').toString())),
        storyUk: Value(ContentUtils.cleanCoffeeContent((item['story_uk'] ?? item['story'] ?? '').toString())),
        regionUk: Value((item['region_uk'] ?? item['region'] ?? '').toString()),
        countryUk: Value((item['country_uk'] ?? item['country'] ?? '').toString()),
      );

      final translationsData = await supabase!.from('localized_farmer_translations').select().eq('farmer_id', id);
      final List<LocalizedFarmerTranslationsCompanion> translations = translationsData.map((t) => LocalizedFarmerTranslationsCompanion(
        farmerId: Value(id),
        languageCode: Value(t['language_code'] as String),
        name: Value(t['name'] as String?),
        descriptionHtml: Value(t['description_html'] as String? ?? t['description'] as String?),
        region: Value(t['region'] as String?),
        country: Value(t['country'] as String?),
      )).toList();

      await db.smartUpsertFarmer(farmer, translations);
      _dataUpdateController.add(null);
      debugPrint('SYNC: Real-time update success for Farmer $id');
    } catch (e) {
      debugPrint('SYNC ERROR (Single Farmer $id): $e');
    }
  }

  /// Syncs a single article by ID.
  Future<void> syncSingleArticle(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('specialty_articles').select().eq('id', id).maybeSingle();
      if (item == null) return;

      String imageUrl = item['image_url'] as String? ?? '';
      if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
        imageUrl = '$articlesBucket${imageUrl.split('/').last}';
      }

      final article = SpecialtyArticlesCompanion(
        id: Value(id),
        titleUk: Value(ContentUtils.cleanCoffeeContent(item['title_uk'] as String? ?? item['title_en'] as String? ?? '')),
        subtitleUk: Value(ContentUtils.cleanCoffeeContent(item['subtitle_uk'] as String? ?? '')),
        contentHtmlUk: Value(ContentUtils.cleanCoffeeContent(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? '')),
        imageUrl: Value(imageUrl),
        readTimeMin: Value(item['read_time_min'] as int? ?? 5),
      );

      final translationsData = await supabase!.from('specialty_article_translations').select().eq('article_id', id);
      final List<SpecialtyArticleTranslationsCompanion> translations = translationsData.map((t) => SpecialtyArticleTranslationsCompanion(
        articleId: Value(id),
        languageCode: Value(t['language_code'] as String),
        title: Value(ContentUtils.cleanCoffeeContent(t['title'] as String? ?? '')),
        subtitle: Value(ContentUtils.cleanCoffeeContent(t['subtitle'] as String? ?? '')),
        contentHtml: Value(ContentUtils.cleanCoffeeContent(t['content_html'] as String? ?? '')),
      )).toList();

      await db.smartUpsertArticle(article, translations);
      _dataUpdateController.add(null);
      debugPrint('SYNC: Real-time update success for Article $id');
    } catch (e) {
      debugPrint('SYNC ERROR (Single Article $id): $e');
    }
  }

  /// Syncs a single bean by ID.
  Future<void> syncSingleBean(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('localized_beans').select().eq('id', id).maybeSingle();
      if (item == null) return;

      String emoji = item['country_emoji'] as String? ?? '';
      final planetEmojis = ['🌎', '🌍', '🌏', '🪐', '☄️', '🌌', 'planet', 'earth'];
      if (planetEmojis.contains(emoji.trim()) || emoji.isEmpty) {
        final countryLower = (item['country_uk'] as String? ?? item['country_en'] as String? ?? 'unknown').toLowerCase().replaceAll(' ', '_');
        emoji = '$flagsBucket$countryLower.png';
      }

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
        countryUk: Value(item['country_uk'] as String? ?? item['country_en'] as String?),
        regionUk: Value(item['region_uk'] as String? ?? item['region_en'] as String?),
        varietiesUk: Value(item['varieties_uk'] as String? ?? item['varieties_en'] as String?),
        flavorNotesUk: Value(item['flavor_notes_uk']?.toString() ?? item['flavor_notes_en']?.toString() ?? '[]'),
        processMethodUk: Value(item['process_method_uk'] as String? ?? item['process_method_en'] as String?),
        descriptionUk: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description_en'] as String? ?? '')),
        roastLevelUk: Value(item['roast_level_uk'] as String? ?? item['roast_level_en'] as String?),
        createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
      );

      final translationsData = await supabase!.from('localized_bean_translations').select().eq('bean_id', id);
      final List<LocalizedBeanTranslationsCompanion> translations = translationsData.map((t) => LocalizedBeanTranslationsCompanion(
        beanId: Value(id),
        languageCode: Value(t['language_code'] as String),
        country: Value(t['country'] as String?),
        region: Value(t['region'] as String?),
        varieties: Value(t['varieties'] as String?),
        flavorNotes: Value(t['flavor_notes']?.toString() ?? '[]'),
        processMethod: Value(t['process_method'] as String?),
        description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
        farmDescription: Value(ContentUtils.cleanCoffeeContent(t['farm_description'] as String? ?? '')),
        roastLevel: Value(t['roast_level'] as String?),
      )).toList();

      await db.smartUpsertBean(bean, translations);
      _dataUpdateController.add(null);
      debugPrint('SYNC: Real-time update success for Bean $id');
    } catch (e) {
      debugPrint('SYNC ERROR (Single Bean $id): $e');
    }
  }

  /// Syncs a single brewing recipe by key.
  Future<void> syncSingleBrewingRecipe(String key) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('brewing_recipes').select().eq('method_key', key).maybeSingle();
      if (item == null) return;

      String methodImageUrl = item['image_url'] as String? ?? '';
      if (methodImageUrl.isNotEmpty && !methodImageUrl.startsWith('http') && !methodImageUrl.startsWith('assets/')) {
        methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
      }

      final companion = BrewingRecipesCompanion(
        methodKey: Value(key),
        nameUk: Value(item['name_uk'] as String? ?? item['name'] as String? ?? ''),
        descriptionUk: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description'] as String? ?? '')),
        ratioGramsPerMl: Value((item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066),
        tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
        totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
        difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
        flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
        iconName: Value(item['icon_name'] as String?),
        imageUrl: Value(methodImageUrl),
        stepsJson: Value(item['steps_json']?.toString() ?? '[]'),
      );

      final transData = await supabase!.from('brewing_recipe_translations').select().eq('recipe_key', key);
      final List<BrewingRecipeTranslationsCompanion> translations = transData.map((t) => BrewingRecipeTranslationsCompanion(
        recipeKey: Value(key),
        languageCode: Value(t['language_code'] as String),
        name: Value(t['name'] as String?),
        description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
      )).toList();

      await db.smartUpsertBrewingRecipe(companion, translations);
      _dataUpdateController.add(null);
      debugPrint('SYNC: Real-time update success for Recipe $key');
    } catch (e) {
      debugPrint('SYNC ERROR (Single Recipe $key): $e');
    }
  }
}
