import 'dart:convert';
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
    bool clearLocal = false,
    Function(String)? onProgress,
  }) async {
    try {
      debugPrint('SYNC: Starting full synchronization...');
      onProgress?.call('Connecting to cloud...');

      if (supabase == null) {
        onProgress?.call('Supabase not available, skipping cloud sync.');
        return;
      }

      // 2. Sync Farmers
      onProgress?.call('Syncing Farmers...');
      await syncFarmers();

      // 3. Sync Articles
      onProgress?.call('Syncing Articles...');
      await syncArticles();

      // 4. Sync Encyclopedia (Lots)
      onProgress?.call('Syncing Encyclopedia Lots...');
      await syncEncyclopedia();

      onProgress?.call('Synchronization completed successfully!');
      debugPrint('SYNC: All systems synchronized [STABLE]');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e');
      rethrow;
    }
  }

  /// Pulls encyclopedia data from Supabase and updates local storage.
  /// Fetches from 'encyclopedia_entries' as per latest requirement.
  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling beans from encyclopedia_entries...');
      final data = await supabase!.from('encyclopedia_entries').select().order('id');
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;

          // 1. Prepare Bean Companion
          final bean = LocalizedBeansCompanion(
            id: Value(id),
            brandId: Value(item['brand_id'] as int?),
            countryEmoji: Value(item['country_emoji'] as String?),
            altitudeMin: Value(item['altitude_min'] as int?),
            altitudeMax: Value(item['altitude_max'] as int?),
            lotNumber: Value(item['lot_number'] as String? ?? ''),
            scaScore: Value('82+'), // Placeholder since we move to flags
            cupsScore: Value(double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0),
            sensoryJson: Value(item['sensory_json']?.toString() ?? '{}'),
            priceJson: Value(item['price_json']?.toString() ?? '{}'),
            harvestSeason: Value(item['harvest_season'] as String?),
            retailPrice: Value(item['price']?.toString()), // Mapping from 'price' column
            isPremium: Value(item['is_premium'] as bool? ?? false),
            isDecaf: Value(false), // encyclopedia_entries doesn't have is_decaf usually
            url: Value(item['url'] as String? ?? ''),
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          // 2. Prepare Translations (Map same data for all languages since encyclopedia_entries is singular)
          final List<LocalizedBeanTranslationsCompanion> translations = [];

          for (final lang in ['uk', 'en']) {
            translations.add(
              LocalizedBeanTranslationsCompanion(
                beanId: Value(id),
                languageCode: Value(lang),
                country: Value(item['country'] as String?),
                region: Value(item['region'] as String?),
                varieties: Value(item['varieties'] as String?),
                flavorNotes: Value(item['flavor_notes']?.toString() ?? '[]'),
                processMethod: Value(item['process_method'] as String?),
                description: Value(item['description'] as String?),
                farmDescription: Value(item['farm_description'] as String?),
                roastLevel: Value(item['roast_level'] as String?),
              ),
            );
          }

          // 3. Upsert into local DB
          await db.smartUpsertBean(bean, translations);
          successCount++;
        } catch (e) {
          debugPrint('SYNC ERROR for beam ID ${item['id']}: $e');
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
        .from('encyclopedia_entries')
        .stream(primaryKey: ['id'])
        .listen((data) {
          debugPrint('SYNC: Beans cloud data changed (encyclopedia_entries), triggering re-sync...');
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
  Future<void> syncFarmers() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling farmers from Supabase...');
      final data = await supabase!.from('localized_farmers').select().order('id');
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;
          
          // Image URL processing: if it contains 'specialty-articles', we keep it, 
          // but we ensure it's absolute. If it's just a filename, prepend bucket URL.
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
          for (final lang in ['uk', 'en']) {
            translations.add(
              LocalizedFarmerTranslationsCompanion(
                farmerId: Value(id),
                languageCode: Value(lang),
                name: Value(item['name_$lang'] as String?),
                region: Value(item['region_$lang'] as String?),
                description: Value(item['description_$lang'] as String?),
                story: Value(item['story_$lang'] as String?),
                country: Value(item['country_$lang'] as String?),
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

          await db.insertArticle(article);
          for (final t in translations) {
            await db.insertArticleTranslation(t);
          }
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

  /// Placeholder for pushing local changes to cloud.
  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  /// Pull cloud changes to local.
  Future<void> pullFromCloud({Function(String)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }
}
