import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'package:flutter/foundation.dart';
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

      onProgress?.call('Syncing Brands...', 0.2);
      _progressController.add(0.2);
      await syncBrands();
      await Future.delayed(const Duration(milliseconds: 200));


      onProgress?.call('Syncing Farmers...', 0.3);
      _progressController.add(0.3);
      await syncFarmers();
      await Future.delayed(const Duration(milliseconds: 200));
      

      onProgress?.call('Syncing Encyclopedia...', 0.5);
      _progressController.add(0.5);
      await syncEncyclopedia();
      await Future.delayed(const Duration(milliseconds: 200));
      

      onProgress?.call('Syncing Methods...', 0.7);
      _progressController.add(0.7);
      await syncBrewingRecipes();
      await Future.delayed(const Duration(milliseconds: 200));
      

      onProgress?.call('Syncing Articles...', 0.85);
      _progressController.add(0.85);
      await syncArticles();
      await Future.delayed(const Duration(milliseconds: 200));
      

      onProgress?.call('Syncing User Data...', 0.95);
      _progressController.add(0.95);
      // Push local changes (including deletions) BEFORE pulling to prevent restored deleted items
      await pushLocalUserContent(); 
      await pullUserContent();
      
      onProgress?.call('Finalizing...', 0.98);

      _progressController.add(1.0);
      onProgress?.call('Cloud Connected', 1.0);

    } catch (e) {

      _progressController.add(0.0); 
      onProgress?.call('Sync failed: $e', 1.0);
      rethrow;
    }
  }
  
  /// Migrates local guest data to the authenticated user's account.
  Future<void> claimGuestData(String newUserId) async {
    await db.claimGuestData(newUserId);
  }


  /// Sets up real-time subscriptions for all main content tables.
  void subscribeToRealtimeUpdates() {
    if (supabase == null) return;
    


    // 1. Articles Channel
    supabase!
        .channel('public:specialty_articles')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'specialty_articles',
          callback: (payload) async {

            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = (payload.oldRecord['id'] as num).toInt();
              await (db.delete(db.specialtyArticles)..where((t) => t.id.equals(id))).go();
            } else {
              // INSERT or UPDATE
              final id = (payload.newRecord['id'] as num).toInt();
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

            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = (payload.oldRecord['id'] as num).toInt();
              await (db.delete(db.localizedFarmers)..where((t) => t.id.equals(id))).go();
            } else {
              final id = (payload.newRecord['id'] as num).toInt();
              await syncSingleFarmer(id);
            }
          },
        )
        .subscribe();

    // 3. Encyclopedia (Coffee Lots) Channel
    supabase!
        .channel('public:encyclopedia_entries')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'encyclopedia_entries',
          callback: (payload) async {

            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = (payload.oldRecord['id'] as num).toInt();
              await (db.delete(db.localizedBeansV2)..where((t) => t.id.equals(id))).go();
            } else {
              final id = (payload.newRecord['id'] as num).toInt();
              await syncSingleEncyclopediaEntryV2(id);
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

      final data = await supabase!.from('localized_farmers').select().order('id');
      final remoteIds = data.map((item) => (item['id'] as num).toInt()).toList();

      for (final item in data) {
        try {
          final id = (item['id'] as num).toInt();
          
          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
            imageUrl = '$farmersBucket${imageUrl.split('/').last}';
          }

          final farmer = LocalizedFarmersV2Companion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: Value((item['flag_url'] ?? item['country_emoji'] ?? '').toString()),
            latitude: Value((item['latitude'] as num?)?.toDouble()),
            longitude: Value((item['longitude'] as num?)?.toDouble()),
            createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
          );

          // localized_farmers has data in _uk fields directly — translation table is empty in Supabase
          final List<LocalizedFarmerTranslationsV2Companion> translations = [
            LocalizedFarmerTranslationsV2Companion(
              farmerId: Value(id),
              languageCode: const Value('en'),
              name: Value(item['name_uk'] as String? ?? ''),
              descriptionHtml: Value(ContentUtils.cleanCoffeeContent(item['description_html_uk'] as String? ?? '')),
              story: Value(ContentUtils.cleanCoffeeContent(item['story_uk'] as String? ?? '')),
              region: Value(item['region_uk'] as String? ?? ''),
              country: Value(item['country_uk'] as String? ?? ''),
            ),
            LocalizedFarmerTranslationsV2Companion(
              farmerId: Value(id),
              languageCode: const Value('uk'),
              name: Value(item['name_uk'] as String? ?? ''),
              descriptionHtml: Value(ContentUtils.cleanCoffeeContent(item['description_html_uk'] as String? ?? '')),
              story: Value(ContentUtils.cleanCoffeeContent(item['story_uk'] as String? ?? '')),
              region: Value(item['region_uk'] as String? ?? ''),
              country: Value(item['country_uk'] as String? ?? ''),
            ),
          ];

          await db.smartUpsertFarmerV2(farmer, translations);
        } catch (e) {
      // Production silent fail
    }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(db.localizedFarmerTranslationsV2)..where((t) => t.farmerId.isIn(remoteIds).not())).go();
          await (db.delete(db.localizedFarmersV2)..where((t) => t.id.isIn(remoteIds).not())).go();
        });
      }
    } catch (e) {
      // Production silent fail
    }
  }

  /// Pulls specialty articles from Supabase.
  Future<void> syncArticles() async {
    if (supabase == null) return;

    try {

      final data = await supabase!.from('specialty_articles').select().order('id');
      final remoteIds = data.map((item) => (item['id'] as num).toInt()).toList();

      for (int i = 0; i < data.length; i++) {
        final item = data[i];
        try {
          final id = (item['id'] as num).toInt();
          
          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
            imageUrl = '$articlesBucket${imageUrl.split('/').last}';
          }

          final article = SpecialtyArticlesV2Companion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: const Value(''),
            readTimeMin: Value((item['read_time_min'] as num?)?.toInt() ?? 5),
            createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
          );

          // specialty_article_translations is empty in Supabase — read _uk fields directly from main row
          final List<SpecialtyArticleTranslationsV2Companion> translations = [
            SpecialtyArticleTranslationsV2Companion(
              articleId: Value(id),
              languageCode: const Value('en'),
              title: Value(ContentUtils.cleanCoffeeContent(item['title_uk'] as String? ?? '')),
              subtitle: Value(ContentUtils.cleanCoffeeContent(item['subtitle_uk'] as String? ?? '')),
              contentHtml: Value(ContentUtils.cleanCoffeeContent(item['content_html_uk'] as String? ?? '')),
            ),
            SpecialtyArticleTranslationsV2Companion(
              articleId: Value(id),
              languageCode: const Value('uk'),
              title: Value(ContentUtils.cleanCoffeeContent(item['title_uk'] as String? ?? '')),
              subtitle: Value(ContentUtils.cleanCoffeeContent(item['subtitle_uk'] as String? ?? '')),
              contentHtml: Value(ContentUtils.cleanCoffeeContent(item['content_html_uk'] as String? ?? '')),
            ),
          ];

          await db.smartUpsertArticleV2(article, translations);
        } catch (e) {
      // Production silent fail
    }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(db.specialtyArticleTranslationsV2)..where((t) => t.articleId.isIn(remoteIds).not())).go();
          await (db.delete(db.specialtyArticlesV2)..where((t) => t.id.isIn(remoteIds).not())).go();
        });
      }
    } catch (e) {
      // Production silent fail
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
            debugPrint('SyncService: Deleting recipe from cloud: ${r.id}');
            await supabase!.from('user_custom_recipes').delete().eq('id', r.id).eq('user_id', userId);
            await (db.update(db.customRecipes)..where((t) => t.id.equals(r.id))).write(const CustomRecipesCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Recipe deletion synced to cloud: ${r.id}');
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
              'pour_schedule_json': jsonDecode(r.pourScheduleJson),
              'brew_temp_c': r.brewTempC,
              'notes': r.notes,
              'rating': r.rating,
              'created_at': r.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
              'recipe_type': r.recipeType,
            });
            await (db.update(db.customRecipes)..where((t) => t.id.equals(r.id))).write(const CustomRecipesCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Recipe synced to cloud: ${r.id}');
          }
        } catch (e) {
          debugPrint('SyncService: Error syncing recipe ${r.id}: $e');
        }
      }

      // 2. Sync Personal Coffee Lots (Upsert & Delete)
      final lotsToSync = await (db.select(db.coffeeLots)..where((t) => t.isSynced.equals(false))).get();
      for (final l in lotsToSync) {
        try {
          if (l.isDeletedLocal) {
            debugPrint('SyncService: Deleting lot from cloud: ${l.id}');
            await supabase!.from('user_coffee_lots').delete().eq('id', l.id).eq('user_id', userId);
            await (db.update(db.coffeeLots)..where((t) => t.id.equals(l.id))).write(const CoffeeLotsCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Lot deletion synced to cloud: ${l.id}');
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
              'sensory_json': jsonDecode(l.sensoryJson),
              'price_json': jsonDecode(l.priceJson),
              'brand_id': l.brandId,
              'image_url': l.imageUrl,
              'created_at': l.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });
            await (db.update(db.coffeeLots)..where((t) => t.id.equals(l.id))).write(const CoffeeLotsCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Lot synced to cloud: ${l.id}');
          }
        } catch (e) {
          debugPrint('SyncService: Error syncing lot ${l.id}: $e');
        }
      }
      
      // 3. Sync User Brands (Upsert & Delete)
      final brandsToSync = await (db.select(db.localizedBrands)..where((t) => t.isSynced.equals(false))).get();
      for (final b in brandsToSync) {
        try {
          if (b.isDeletedLocal) {
            debugPrint('SyncService: Deleting brand from cloud: ${b.id}');
            await supabase!.from('user_brands').delete().eq('id', b.id).eq('user_id', userId);
            await (db.delete(db.localizedBrands)..where((t) => t.id.equals(b.id))).go();
            await (db.delete(db.localizedBrandTranslations)..where((t) => t.brandId.equals(b.id))).go();
            debugPrint('SyncService: Brand deleted permanently from local: ${b.id}');
          } else {
            await supabase!.from('user_brands').upsert({
              'id': b.id,
              'user_id': userId,
              'name': b.name,
              'logo_url': b.logoUrl,
              'site_url': b.siteUrl,
              'created_at': b.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
            });

            final translations = await (db.select(db.localizedBrandTranslations)..where((t) => t.brandId.equals(b.id))).get();
            for (final t in translations) {
               await supabase!.from('user_brand_translations').upsert({
                 'brand_id': t.brandId,
                 'language_code': t.languageCode,
                 'short_desc': t.shortDesc,
                 'full_desc': t.fullDesc,
                 'location': t.location,
               });
            }

            await (db.update(db.localizedBrands)..where((t) => t.id.equals(b.id))).write(const LocalizedBrandsCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Brand synced to cloud: ${b.id}');
          }
        } catch (e) {
          debugPrint('SyncService: Error syncing brand ${b.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('SyncService: Fatal error in pushLocalUserContent: $e');
    }
  }

  /// Pulls user-specific lots and recipes from Supabase.
  Future<void> pullUserContent() async {
    if (supabase == null || supabase!.auth.currentUser == null) {

      return;
    }
    
    try {
      final userId = supabase!.auth.currentUser!.id;


      // 1. Pull Lots

      final lotsData = await supabase!.from('user_coffee_lots').select().eq('user_id', userId);

      
      for (final item in lotsData) {
        try {
          final id = item['id'] as String;
          
          // CHECK: If lot is deleted locally OR has unsynced changes, do not pull it back from cloud
          final localLot = await db.findConflictLot(id);
          if (localLot != null && (localLot.isDeletedLocal || !localLot.isSynced)) {

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
            sensoryJson: Value(item['sensory_json'] != null ? jsonEncode(item['sensory_json']) : '{}'),
            priceJson: Value(item['price_json'] != null ? jsonEncode(item['price_json']) : '{}'),
            brandId: Value((item['brand_id'] as num?)?.toInt()),
            imageUrl: Value(item['image_url'] as String?),
            updatedAt: Value(DateTime.now()),
            isSynced: const Value(true),
          );

          await db.insertUserLot(lot);
        } catch (e) {
      // Production silent fail
    }
      }

      // 2. Recipes

      final remoteRecipes = await supabase!
          .from('user_custom_recipes')
          .select()
          .eq('user_id', userId);
      

      for (final item in remoteRecipes) {
        try {
          final id = item['id'] as String;
          
          // CHECK: If recipe is deleted locally OR has unsynced changes, do not pull it back from cloud
          final localRecipe = await db.findConflictRecipe(id);
          if (localRecipe != null && (localRecipe.isDeletedLocal || !localRecipe.isSynced)) {
            continue;
          }

          await db.insertCustomRecipe(CustomRecipesCompanion(
            id: Value(id),
            userId: Value(item['user_id'] as String),
            lotId: Value(item['lot_id'] as String?),
            methodKey: Value(item['method_key'] as String? ?? 'v60'),
            name: Value(item['name'] as String? ?? 'Recipe'),
            coffeeGrams: Value((item['coffee_grams'] as num?)?.toDouble() ?? 0.0),
            totalWaterMl: Value((item['total_water_ml'] as num?)?.toDouble() ?? 0.0),
            grindNumber: Value((item['grind_number'] as num?)?.toInt() ?? 0),
            comandanteClicks: Value((item['comandante_clicks'] as num?)?.toInt() ?? 0),
            ek43Division: Value((item['ek43_division'] as num?)?.toInt() ?? 0),
            totalPours: Value((item['total_pours'] as num?)?.toInt() ?? 1),
            pourScheduleJson: Value(item['pour_schedule_json']?.toString() ?? '[]'),
            brewTempC: Value((item['brew_temp_c'] as num?)?.toDouble() ?? 93.0),
            notes: Value(item['notes'] as String? ?? ''),
            rating: Value((item['rating'] as num?)?.toInt() ?? 0),
            updatedAt: Value(DateTime.now()),
            isSynced: const Value(true),
          ));
        } catch (e) {
      // Production silent fail
    }
      }

    } catch (e) {
      // Production silent fail
    }
  }

  Future<void> syncBrewingRecipes() async {
    if (supabase == null) return;
    try {

      final data = await supabase!.from('brewing_recipes').select();
      final remoteKeys = data.map((item) => item['method_key'] as String).toList();
      
      for (final item in data) {
        try {
          final key = item['method_key'] as String;
          
          String methodImageUrl = item['image_url'] as String? ?? '';
          if (methodImageUrl.isNotEmpty && !methodImageUrl.startsWith('http') && !methodImageUrl.startsWith('assets/')) {
            methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
          }

          final recipe = BrewingRecipesV2Companion(
            methodKey: Value(key),
            imageUrl: Value(methodImageUrl),
            ratioGramsPerMl: Value((item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
            difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
            flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
            iconName: Value(item['icon_name'] as String?),
            stepsJson: Value(item['steps_json'] is List ? jsonEncode(item['steps_json']) : (item['steps_json']?.toString() ?? '[]')),
          );

          // brewing_recipe_translations is empty in Supabase — use name_uk/description_uk from main table
          final translations = [
             BrewingRecipeTranslationsV2Companion(
                recipeKey: Value(key),
                languageCode: const Value('en'),
                name: Value(item['name_uk'] as String? ?? item['name'] as String? ?? key),
                description: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description'] as String? ?? '')),
             ),
             BrewingRecipeTranslationsV2Companion(
                recipeKey: Value(key),
                languageCode: const Value('uk'),
                name: Value(item['name_uk'] as String? ?? item['name'] as String? ?? key),
                description: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description'] as String? ?? '')),
             ),
          ];

          await db.smartUpsertBrewingRecipeV2(recipe, translations);
        } catch (e) {
      // Production silent fail
    }
      }

      if (remoteKeys.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(db.brewingRecipeTranslationsV2)..where((t) => t.recipeKey.isIn(remoteKeys).not())).go();
          await (db.delete(db.brewingRecipesV2)..where((t) => t.methodKey.isIn(remoteKeys).not())).go();
        });
      }
    } catch (e) {
      // Production silent fail
    }
  }

  /// Pulls brands from Supabase.
  Future<void> syncBrands() async {
    if (supabase == null) return;
    try {

      // 1. Fetch all brands - try 'brands' table as it's the primary source in cloud
      var data = await supabase!.from('brands').select();
      if (data.isEmpty) {
        data = await supabase!.from('localized_brands').select();
      }
      
      final remoteIds = data.map((item) => (item['id'] as num).toInt()).toList();
      debugPrint('SyncService: Found ${data.length} brands in cloud');
      
      if (remoteIds.isEmpty) {
        debugPrint('SyncService: No brands found in cloud, skipping.');
        return;
      }

      // 2. Fetch all translations in one go

      final allTranslations = await supabase!
          .from('localized_brand_translations')
          .select()
          .inFilter('brand_id', remoteIds);

      // Group translations by brand_id
      final Map<int, List<Map<String, dynamic>>> translationMap = {};
      for (final t in allTranslations) {
        final bId = (t['brand_id'] as num).toInt();
        translationMap.putIfAbsent(bId, () => []).add(t);
      }

      for (final item in data) {
        try {
          final id = (item['id'] as num).toInt();
          final companion = LocalizedBrandsCompanion(
            id: Value(id),
            name: Value(item['name'] as String? ?? ''),
            logoUrl: Value(item['logo_url'] as String?),
            siteUrl: Value(item['site_url'] as String?),
          );

          final List<LocalizedBrandTranslationsCompanion> translations = [];
          final transData = translationMap[id] ?? [];

          for (final t in transData) {
             translations.add(LocalizedBrandTranslationsCompanion(
               brandId: Value(id),
               languageCode: Value(t['language_code'] as String),
               shortDesc: Value(t['short_desc'] as String?),
               fullDesc: Value(t['full_desc'] as String?),
               location: Value(t['location'] as String?),
             ));
          }

          // Add 'uk' fallback if missing
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
             translations.add(LocalizedBrandTranslationsCompanion(
               brandId: Value(id),
               languageCode: const Value('uk'),
               shortDesc: Value(ContentUtils.cleanCoffeeContent(item['short_desc'] as String? ?? item['short_desc_uk'] as String? ?? item['short_desc_en'] as String? ?? '')),
               fullDesc: Value(ContentUtils.cleanCoffeeContent(item['full_desc'] as String? ?? item['full_desc_uk'] as String? ?? item['full_desc_en'] as String? ?? '')),
               location: Value(ContentUtils.cleanCoffeeContent(item['location'] as String? ?? item['location_uk'] as String? ?? item['location_en'] as String? ?? '')),
             ));
          }
          
          // Add 'en' fallback if missing
          if (!translations.any((t) => t.languageCode.value == 'en')) {
             translations.add(LocalizedBrandTranslationsCompanion(
               brandId: Value(id),
               languageCode: const Value('en'),
               shortDesc: Value(ContentUtils.cleanCoffeeContent(item['short_desc'] as String? ?? item['short_desc_en'] as String? ?? item['short_desc_uk'] as String? ?? '')),
               fullDesc: Value(ContentUtils.cleanCoffeeContent(item['full_desc'] as String? ?? item['full_desc_en'] as String? ?? item['full_desc_uk'] as String? ?? '')),
               location: Value(ContentUtils.cleanCoffeeContent(item['location'] as String? ?? item['location_en'] as String? ?? item['location_uk'] as String? ?? '')),
             ));
          }

          await db.smartUpsertBrand(companion, translations);
        } catch (e) {
      // Production silent fail
    }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          // Only delete brands that ARE NOT user-specific (userId is null) and are NOT in the remote list
          final brandsToDelete = await (db.select(db.localizedBrands)..where((t) => t.id.isIn(remoteIds).not() & t.userId.isNull())).get();
          final idsToDelete = brandsToDelete.map((b) => b.id).toList();
          
          if (idsToDelete.isNotEmpty) {
            await (db.delete(db.localizedBrandTranslations)..where((t) => t.brandId.isIn(idsToDelete))).go();
            await (db.delete(db.localizedBrands)..where((t) => t.id.isIn(idsToDelete))).go();
          }
        });
      }
    } catch (e) {
      // Production silent fail
    }
  }

  /// Clears local shared tables to force fresh sync.
  Future<void> _clearLocalSharedData() async {
    try {

      await db.transaction(() async {
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedBeans).go();
        await db.delete(db.localizedBeanTranslations).go();
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.localizedBrands).go();
        await db.delete(db.brewingRecipes).go();
      });

    } catch (e) {
      // Production silent fail
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
      );

      final translationsData = await supabase!.from('localized_farmer_translations').select().eq('farmer_id', id);
      final List<LocalizedFarmerTranslationsCompanion> translations = translationsData.map((t) => LocalizedFarmerTranslationsCompanion(
        farmerId: Value(id),
        languageCode: Value(t['language_code'] as String),
        name: Value(t['name'] as String?),
        descriptionHtml: Value(t['description_html'] as String? ?? t['description'] as String?),
        region: Value(t['region'] as String?),
        country: Value(t['country'] as String?),
        story: Value(ContentUtils.cleanCoffeeContent(t['story'] as String? ?? '')),
      )).toList();

      // Add 'uk' if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(LocalizedFarmerTranslationsCompanion(
          farmerId: Value(id),
          languageCode: const Value('uk'),
          name: Value((item['name_uk'] ?? item['name'] ?? '').toString()),
          descriptionHtml: Value(ContentUtils.cleanCoffeeContent((item['description_html_uk'] ?? item['description_uk'] ?? item['description'] ?? '').toString())),
          story: Value(ContentUtils.cleanCoffeeContent((item['story_uk'] ?? item['story'] ?? '').toString())),
          region: Value((item['region_uk'] ?? item['region'] ?? '').toString()),
          country: Value((item['country_uk'] ?? item['country'] ?? '').toString()),
        ));
      }

      await db.smartUpsertFarmer(farmer, translations);
      _dataUpdateController.add(null);

    } catch (e) {
      // Production silent fail
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
        imageUrl: Value(imageUrl),
        readTimeMin: Value((item['read_time_min'] as num?)?.toInt() ?? 5),
      );

      final translationsData = await supabase!.from('specialty_article_translations').select().eq('article_id', id);
      final List<SpecialtyArticleTranslationsCompanion> translations = translationsData.map((t) => SpecialtyArticleTranslationsCompanion(
        articleId: Value(id),
        languageCode: Value(t['language_code'] as String),
        title: Value(ContentUtils.cleanCoffeeContent(t['title'] as String? ?? '')),
        subtitle: Value(ContentUtils.cleanCoffeeContent(t['subtitle'] as String? ?? '')),
        contentHtml: Value(ContentUtils.cleanCoffeeContent(t['content_html'] as String? ?? '')),
      )).toList();

      // Add 'uk' if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(SpecialtyArticleTranslationsCompanion(
          articleId: Value(id),
          languageCode: const Value('uk'),
          title: Value(ContentUtils.cleanCoffeeContent(item['title_uk'] as String? ?? item['title_en'] as String? ?? '')),
          subtitle: Value(ContentUtils.cleanCoffeeContent(item['subtitle_uk'] as String? ?? '')),
          contentHtml: Value(ContentUtils.cleanCoffeeContent(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? '')),
        ));
      }

      await db.smartUpsertArticle(article, translations);
      _dataUpdateController.add(null);

    } catch (e) {
      // Production silent fail
    }
  }

  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;
    debugPrint('SyncService: Starting Encyclopedia sync...');
    try {
      // 1. Fetch main entries
      final data = await supabase!.from('encyclopedia_entries').select();
      debugPrint('SyncService: Supabase returned ${data.length} encyclopedia entries');
      
      final remoteIds = data.map((item) => (item['id'] as num).toInt()).toList();
      debugPrint('SyncService: Remote IDs: $remoteIds');

      if (remoteIds.isEmpty) {
        debugPrint('SyncService: No remote encyclopedia entries found, skipping.');
        return;
      }

      // 2. Fetch all translations (even if empty in Supabase for now)
      final allTranslationsData = await supabase!
          .from('localized_bean_translations')
          .select()
          .inFilter('bean_id', remoteIds);
      
      // Group translations by bean_id
      final Map<int, List<Map<String, dynamic>>> translationMap = {};
      for (final t in allTranslationsData) {
        final bId = (t['bean_id'] as num).toInt();
        translationMap.putIfAbsent(bId, () => []).add(t);
      }

      int successCount = 0;
      for (var item in data) {
        try {
          final int id = (item['id'] as num).toInt();

          final bean = LocalizedBeansV2Companion(
            id: Value(id),
            brandId: Value((item['brand_id'] as num?)?.toInt()),
            countryEmoji: Value(item['country_emoji'] as String? ?? ''),
            altitudeMin: Value((item['altitude_min'] as num?)?.toInt()),
            altitudeMax: Value((item['altitude_max'] as num?)?.toInt()),
            lotNumber: Value(item['lot_number'] as String? ?? ''),
            scaScore: Value(item['sca_score']?.toString() ?? '82+'),
            cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
            sensoryJson: Value(item['sensory_json'] != null ? jsonEncode(item['sensory_json']) : '{}'),
            priceJson: Value(item['price_json'] != null ? jsonEncode(item['price_json']) : '{}'),
            plantationPhotosUrl: Value(_safeJson(item['plantation_photos_url'])),
            harvestSeason: Value(item['harvest_season'] as String? ?? ''),
            price: Value(item['price'] as String? ?? ''),
            weight: Value(item['weight'] as String? ?? ''),
            roastDate: Value(item['roast_date'] as String? ?? ''),
            processingMethodsJson: Value(_safeJson(item['processing_methods_json'])),
            isPremium: Value(item['is_premium'] as bool? ?? false),
            detailedProcessMarkdown: Value(item['detailed_process_markdown'] as String? ?? ''),
            url: Value(item['url'] as String? ?? ''),
            farmerId: Value((item['farmer_id'] as num?)?.toInt()),
            isDecaf: Value(item['is_decaf'] as bool? ?? false),
            farm: Value(item['farm'] as String?),
            farmPhotosUrlCover: Value(item['farm_photos_url_cover'] as String?),
            washStation: Value(item['wash_station'] as String?),
            retailPrice: Value(item['retail_price']?.toString()),
            wholesalePrice: Value(item['wholesale_price']?.toString()),
            flagUrl: Value(item['image_url'] as String? ?? ''),
            radarJson: Value(item['radar_json'] != null ? jsonEncode(item['radar_json']) : '{}'),
            createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
          );

          final List<LocalizedBeanTranslationsV2Companion> translations = [];
          final transData = translationMap[id] ?? [];

          // Add existing translations from cloud
          for (final t in transData) {
            translations.add(LocalizedBeanTranslationsV2Companion(
              beanId: Value(id),
              languageCode: Value(t['language_code'] as String),
              country: Value(t['country'] as String?),
              region: Value(t['region'] as String?),
              varieties: Value(t['varieties'] as String?),
              flavorNotes: Value(_safeJson(t['flavor_notes'])),
              processMethod: Value(t['process_method'] as String?),
              description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
              farmDescription: Value(ContentUtils.cleanCoffeeContent(t['farm_description'] as String? ?? '')),
              roastLevel: Value(t['roast_level'] as String?),
            ));
          }

          // FALLBACK logic: if 'uk' or 'en' is missing, use the main table (which has Ukrainian data)
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(LocalizedBeanTranslationsV2Companion(
              beanId: Value(id),
              languageCode: const Value('uk'),
              country: Value(item['country'] as String? ?? 'Unknown'),
              region: Value(item['region'] as String? ?? ''),
              varieties: Value(item['varieties'] as String? ?? ''),
              flavorNotes: Value(_safeJson(item['flavor_notes'])),
              processMethod: Value(item['process_method'] as String? ?? ''),
              description: Value(ContentUtils.cleanCoffeeContent(item['description'] as String? ?? '')),
              farmDescription: Value(ContentUtils.cleanCoffeeContent(item['farm_description'] as String? ?? '')),
              roastLevel: Value(item['roast_level'] as String? ?? ''),
            ));
          }

          if (!translations.any((t) => t.languageCode.value == 'en')) {
            translations.add(LocalizedBeanTranslationsV2Companion(
              beanId: Value(id),
              languageCode: const Value('en'),
              country: Value(item['country'] as String? ?? 'Unknown'),
              region: Value(item['region'] as String? ?? ''),
              varieties: Value(item['varieties'] as String? ?? ''),
              flavorNotes: Value(_safeJson(item['flavor_notes'])),
              processMethod: Value(item['process_method'] as String? ?? ''),
              description: Value(ContentUtils.cleanCoffeeContent(item['description'] as String? ?? '')),
              farmDescription: Value(ContentUtils.cleanCoffeeContent(item['farm_description'] as String? ?? '')),
              roastLevel: Value(item['roast_level'] as String? ?? ''),
            ));
          }

          await db.smartUpsertBeanV2(bean, translations);
          successCount++;
        } catch (e) {
          debugPrint('SyncService: Error mapping encyclopedia entry ${item['id']}: $e');
        }
      }

      // 3. Cleanup deleted
      await db.transaction(() async {
        await (db.delete(db.localizedBeanTranslationsV2)..where((t) => t.beanId.isIn(remoteIds).not())).go();
        await (db.delete(db.localizedBeansV2)..where((t) => t.id.isIn(remoteIds).not())).go();
      });

      debugPrint('SyncService: Encyclopedia sync complete. Successfully synced $successCount entries.');
    } catch (e) {
      debugPrint('SyncService: Fatal error in syncEncyclopedia: $e');
    }
  }

  String _safeJson(dynamic val, [String fallback = '[]']) {
    if (val == null) return fallback;
    if (val is String) {
      // Check if it's actually JSON
      try {
        jsonDecode(val);
        return val;
      } catch (_) {
        // Not JSON, wrap it as a single element array if it's a non-empty string
        if (val.isEmpty) return fallback;
        return jsonEncode([val]);
      }
    }
    return jsonEncode(val);
  }

  /// Syncs a single encyclopedia entry by ID.
  Future<void> syncSingleEncyclopediaEntryV2(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('encyclopedia_entries').select().eq('id', id).maybeSingle();
      if (item == null) return;

      final bean = LocalizedBeansV2Companion(
        id: Value(id),
        brandId: Value((item['brand_id'] as num?)?.toInt()),
        countryEmoji: Value(item['country_emoji'] as String? ?? ''),
        altitudeMin: Value((item['altitude_min'] as num?)?.toInt()),
        altitudeMax: Value((item['altitude_max'] as num?)?.toInt()),
        lotNumber: Value(item['lot_number'] as String? ?? ''),
        scaScore: Value(item['sca_score']?.toString() ?? '82+'),
        cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
        sensoryJson: Value(item['sensory_json'] != null ? jsonEncode(item['sensory_json']) : '{}'),
        priceJson: Value(item['price_json'] != null ? jsonEncode(item['price_json']) : '{}'),
        plantationPhotosUrl: Value(_safeJson(item['plantation_photos_url'])),
        harvestSeason: Value(item['harvest_season'] as String? ?? ''),
        price: Value(item['price'] as String? ?? ''),
        weight: Value(item['weight'] as String? ?? ''),
        roastDate: Value(item['roast_date'] as String? ?? ''),
        processingMethodsJson: Value(_safeJson(item['processing_methods_json'])),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        detailedProcessMarkdown: Value(item['detailed_process_markdown'] as String? ?? ''),
        url: Value(item['url'] as String? ?? ''),
        farmerId: Value((item['farmer_id'] as num?)?.toInt()),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        farm: Value(item['farm'] as String?),
        farmPhotosUrlCover: Value(item['farm_photos_url_cover'] as String?),
        washStation: Value(item['wash_station'] as String?),
        retailPrice: Value(item['retail_price']?.toString()),
        wholesalePrice: Value(item['wholesale_price']?.toString()),
        flagUrl: Value(item['image_url'] as String? ?? ''),
        radarJson: Value(item['radar_json'] != null ? jsonEncode(item['radar_json']) : '{}'),
        createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
      );

      final List<LocalizedBeanTranslationsV2Companion> translations = [];
      final transData = await supabase!.from('localized_bean_translations').select().eq('bean_id', id);

      for (final t in transData) {
        translations.add(LocalizedBeanTranslationsV2Companion(
          beanId: Value(id),
          languageCode: Value(t['language_code'] as String),
          country: Value(t['country'] as String?),
          region: Value(t['region'] as String?),
          varieties: Value(t['varieties'] as String?),
          flavorNotes: Value(_safeJson(t['flavor_notes'])),
          processMethod: Value(t['process_method'] as String?),
          description: Value(ContentUtils.cleanCoffeeContent(t['description'] as String? ?? '')),
          farmDescription: Value(ContentUtils.cleanCoffeeContent(t['farm_description'] as String? ?? '')),
          roastLevel: Value(t['roast_level'] as String?),
        ));
      }

      // Fallback
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(LocalizedBeanTranslationsV2Companion(
          beanId: Value(id),
          languageCode: const Value('uk'),
          country: Value(item['country'] as String? ?? 'Unknown'),
          region: Value(item['region'] as String? ?? ''),
          varieties: Value(item['varieties'] as String? ?? ''),
          flavorNotes: Value(_safeJson(item['flavor_notes'])),
          processMethod: Value(item['process_method'] as String? ?? ''),
          description: Value(ContentUtils.cleanCoffeeContent(item['description'] as String? ?? '')),
          farmDescription: Value(ContentUtils.cleanCoffeeContent(item['farm_description'] as String? ?? '')),
          roastLevel: Value(item['roast_level'] as String? ?? ''),
        ));
      }

      if (!translations.any((t) => t.languageCode.value == 'en')) {
        translations.add(LocalizedBeanTranslationsV2Companion(
          beanId: Value(id),
          languageCode: const Value('en'),
          country: Value(item['country'] as String? ?? 'Unknown'),
          region: Value(item['region'] as String? ?? ''),
          varieties: Value(item['varieties'] as String? ?? ''),
          flavorNotes: Value(_safeJson(item['flavor_notes'])),
          processMethod: Value(item['process_method'] as String? ?? ''),
          description: Value(ContentUtils.cleanCoffeeContent(item['description'] as String? ?? '')),
          farmDescription: Value(ContentUtils.cleanCoffeeContent(item['farm_description'] as String? ?? '')),
          roastLevel: Value(item['roast_level'] as String? ?? ''),
        ));
      }

      await db.smartUpsertBeanV2(bean, translations);
      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint('SyncService: Error in syncSingleEncyclopediaEntryV2 ($id): $e');
    }
  }

  /// Syncs a single bean by ID.
  Future<void> syncSingleBean(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!.from('encyclopedia_entries').select().eq('id', id).maybeSingle();
      if (item == null) return;

      String emoji = item['country_emoji'] as String? ?? '';
      final planetEmojis = ['🌎', '🌍', '🌏', '🪐', '☄️', '🌌', 'planet', 'earth'];
      if (planetEmojis.contains(emoji.trim()) || emoji.isEmpty) {
        final countryLower = (item['country_uk'] as String? ?? item['country_en'] as String? ?? 'unknown').toLowerCase().replaceAll(' ', '_');
        emoji = '$flagsBucket$countryLower.png';
      }

      final bean = LocalizedBeansCompanion(
        id: Value(id),
        brandId: Value((item['brand_id'] as num?)?.toInt()),
        countryEmoji: Value(emoji),
        altitudeMin: Value((item['altitude_min'] as num?)?.toInt()),
        altitudeMax: Value((item['altitude_max'] as num?)?.toInt()),
        lotNumber: Value(item['lot_number'] as String? ?? ''),
        scaScore: Value(item['sca_score']?.toString() ?? '82+'),
        cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
        sensoryJson: Value(item['sensory_json'] != null ? jsonEncode(item['sensory_json']) : '{}'),
        priceJson: Value(item['price_json'] != null ? jsonEncode(item['price_json']) : '{}'),
        retailPrice: Value(item['retail_price']?.toString() ?? item['price']?.toString()),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        url: Value(item['url'] as String? ?? ''),
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

      // Add 'uk' if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
         translations.add(LocalizedBeanTranslationsCompanion(
          beanId: Value(id),
          languageCode: const Value('uk'),
          country: Value(item['country_uk'] as String? ?? item['country_en'] as String?),
          region: Value(item['region_uk'] as String? ?? item['region_en'] as String?),
          varieties: Value(item['varieties_uk'] as String? ?? item['varieties_en'] as String?),
          flavorNotes: Value(item['flavor_notes_uk']?.toString() ?? item['flavor_notes_en']?.toString() ?? '[]'),
          processMethod: Value(item['process_method_uk'] as String? ?? item['process_method_en'] as String?),
          description: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description_en'] as String? ?? '')),
          roastLevel: Value(item['roast_level_uk'] as String? ?? item['roast_level_en'] as String?),
        ));
      }

      await db.smartUpsertBean(bean, translations);
      
      // Update V2 for consistency
      final beanV2 = LocalizedBeansV2Companion(
        id: Value(id),
        brandId: Value((item['brand_id'] as num?)?.toInt()),
        countryEmoji: Value(emoji),
        altitudeMin: Value((item['altitude_min'] as num?)?.toInt()),
        altitudeMax: Value((item['altitude_max'] as num?)?.toInt()),
        lotNumber: Value(item['lot_number'] as String? ?? ''),
        scaScore: Value(item['sca_score']?.toString() ?? '82+'),
        cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
        sensoryJson: Value(item['sensory_json'] != null ? jsonEncode(item['sensory_json']) : '{}'),
        priceJson: Value(item['price_json'] != null ? jsonEncode(item['price_json']) : '{}'),
        retailPrice: Value(item['retail_price']?.toString() ?? item['price']?.toString()),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        url: Value(item['url'] as String? ?? ''),
        createdAt: Value(item['created_at'] != null ? DateTime.tryParse(item['created_at'] as String) : null),
      );

      final List<LocalizedBeanTranslationsV2Companion> translationsV2 = translations.map((t) => LocalizedBeanTranslationsV2Companion(
        beanId: Value(id),
        languageCode: t.languageCode,
        country: t.country,
        region: t.region,
        varieties: t.varieties,
        flavorNotes: t.flavorNotes,
        processMethod: t.processMethod,
        description: t.description,
        farmDescription: t.farmDescription,
        roastLevel: t.roastLevel,
      )).toList();

      await db.smartUpsertBeanV2(beanV2, translationsV2);
      _dataUpdateController.add(null);

    } catch (e) {
      debugPrint('SyncService: Error in syncSingleBean ($id): $e');
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

      // Add 'uk' if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(BrewingRecipeTranslationsCompanion(
          recipeKey: Value(key),
          languageCode: const Value('uk'),
          name: Value(item['name_uk'] as String? ?? item['name'] as String? ?? ''),
          description: Value(ContentUtils.cleanCoffeeContent(item['description_uk'] as String? ?? item['description'] as String? ?? '')),
        ));
      }

      await db.smartUpsertBrewingRecipe(companion, translations);
      _dataUpdateController.add(null);

    } catch (e) {
      // Production silent fail
    }
  }
}
