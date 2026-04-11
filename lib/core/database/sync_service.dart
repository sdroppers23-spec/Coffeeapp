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

      // 1. Sync Encyclopedia (Origins/Beans)
      onProgress?.call('Syncing Encyclopedia (Lots)...');
      await syncEncyclopedia();

      // 2. Future: Sync Brands, Farmers, etc.
      // onProgress?.call('Syncing Brands & Farmers...');
      // await syncMetadata();

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
  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling beans from Supabase...');
      final data = await supabase!.from('localized_beans').select().order('id');
      
      int successCount = 0;
      int errorCount = 0;

      for (final item in data) {
        try {
          final id = item['id'] as int;

          // 1. Prepare Bean Companion
          final priceData = item['price_json'] as Map<String, dynamic>? ?? {};
          final retail1k = priceData['retail_1k']?.toString();
          final wholesale1k = priceData['wholesale_1k']?.toString();

          final bean = LocalizedBeansCompanion(
            id: Value(id),
            brandId: Value(item['brand_id'] as int?),
            countryEmoji: Value(item['country_emoji'] as String?),
            altitudeMin: Value(item['altitude_min'] as int?),
            altitudeMax: Value(item['altitude_max'] as int?),
            lotNumber: Value(item['lot_number'] as String? ?? ''),
            scaScore: Value(item['sca_score'] as String? ?? '82-84'),
            cupsScore: Value((item['cups_score'] as num?)?.toDouble() ?? 82.0),
            sensoryJson: Value(jsonEncode(item['sensory_json'] ?? {})),
            priceJson: Value(jsonEncode(item['price_json'] ?? {})),
            harvestSeason: Value(item['harvest_season'] as String?),
            retailPrice: Value(retail1k),
            wholesalePrice: Value(wholesale1k),
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
                // FIXED: Column name is 'varieties_uk' not 'variety_uk'
                varieties: Value(item['varieties_$lang'] as String?),
                flavorNotes: Value(jsonEncode(item['flavor_notes_$lang'] ?? [])),
                processMethod: Value(item['process_method_$lang'] as String?),
                description: Value(item['description_$lang'] as String?),
                farmDescription: Value(item['farm_description_$lang'] as String?),
                roastLevel: Value(item['roast_level_$lang'] as String?),
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
        .from('localized_beans')
        .stream(primaryKey: ['id'])
        .listen((data) {
          debugPrint('SYNC: Cloud data changed, triggering re-sync...');
          syncEncyclopedia().catchError((e) {
            debugPrint('SYNC ERROR after stream update: $e');
          });
        });
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
