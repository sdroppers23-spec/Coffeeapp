import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for synchronizing user-managed coffee data.
/// Updated in v17 to support full cloud-to-local sync for Encyclopedia.
class SyncService {
  final AppDatabase db;
  final SupabaseClient? supabase;

  static const String bucketUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/';

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

      // 5. Sync User Content (Push to Cloud)
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
            final countryLower = (item['country_en'] as String? ?? 'unknown').toLowerCase().replaceAll(' ', '_');
            emoji = '${bucketUrl}flags/$countryLower.png';
            debugPrint('SYNC: Healed planet emoji for ID $id to flag photo: $emoji');
          }

          // 1. Prepare Bean Companion
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
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          // 2. Prepare Translations
          final List<LocalizedBeanTranslationsCompanion> translations = [];

          for (final lang in ['uk', 'en']) {
            translations.add(
              LocalizedBeanTranslationsCompanion(
                beanId: Value(id),
                languageCode: Value(lang),
                country: Value(item['country_$lang'] as String?),
                region: Value(item['region_$lang'] as String?),
                varieties: Value(item['varieties_$lang'] as String?),
                flavorNotes: Value(item['flavor_notes_$lang']?.toString() ?? '[]'),
                processMethod: Value(item['process_method_$lang'] as String?),
                description: Value(item['description_$lang'] as String?),
                farmDescription: Value(item['farm'] as String?), 
                roastLevel: Value(item['roast_level_$lang'] as String?),
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
  }

  /// Pulls farmer data from Supabase and updates local storage.
  /// Joining translations for accurate names as per stabilization requirement.
  Future<void> syncFarmers() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling farmers and translations from Supabase...');
      // Fetch main farmer records
      final farmersData = await supabase!.from('localized_farmers').select().order('id');
      // Fetch all translations
      final transData = await supabase!.from('localized_farmer_translations').select();
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in farmersData) {
        try {
          final id = item['id'] as int;
          
          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
            imageUrl = '$bucketUrl$imageUrl';
          }

          final farmer = LocalizedFarmersCompanion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            countryEmoji: Value(item['country_emoji'] as String?),
            latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
            longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
          );

          final List<LocalizedFarmerTranslationsCompanion> translations = [];
          
          // Filter translations for this farmer
          final farmerTrans = transData.where((t) => t['farmer_id'] == id);

          for (final lang in ['uk', 'en']) {
            final t = farmerTrans.firstWhere(
              (t) => t['language_code'] == lang,
              orElse: () => farmerTrans.isNotEmpty ? farmerTrans.first : {},
            );

            translations.add(
              LocalizedFarmerTranslationsCompanion(
                farmerId: Value(id),
                languageCode: Value(lang),
                name: Value(t['name'] as String?),
                region: Value(t['region'] as String?),
                description: Value(t['description'] as String?),
                story: Value(t['story'] as String?),
                country: Value(t['country'] as String?),
              ),
            );
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
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;

          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
            imageUrl = '$bucketUrl$imageUrl';
          }

          final article = SpecialtyArticlesCompanion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            readTimeMin: Value(item['read_time_min'] as int? ?? 5),
          );

          final List<SpecialtyArticleTranslationsCompanion> translations = [];
          for (final lang in ['uk', 'en']) {
            translations.add(
              SpecialtyArticleTranslationsCompanion(
                articleId: Value(id),
                languageCode: Value(lang),
                title: Value(item['title_$lang'] as String? ?? ''),
                subtitle: Value(item['subtitle_$lang'] as String? ?? ''),
                contentHtml: Value(item['content_html_$lang'] as String? ?? ''),
              ),
            );
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

  /// Clears local shared tables to force fresh sync.
  Future<void> _clearLocalSharedData() async {
    try {
      debugPrint('SYNC: Clearing local shared tables...');
      // Note: We use raw delete or drift delete statements
      await db.transaction(() async {
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedFarmerTranslations).go();
        await db.delete(db.localizedBeans).go();
        await db.delete(db.localizedBeanTranslations).go();
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
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
