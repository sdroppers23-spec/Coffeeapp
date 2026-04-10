import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import 'database_provider.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db, Supabase.instance.client);
});

class SyncService {
  final AppDatabase db;
  final SupabaseClient supabase;

  SyncService(this.db, [SupabaseClient? supabase])
      : supabase = supabase ?? Supabase.instance.client;

  Future<void> syncAll({
    bool clearLocal = false,
    Function(String)? onProgress,
  }) async {
    debugPrint('SYNC: Starting full synchronization (v17 Extended Localized)...');
    onProgress?.call('Connecting to cloud...');

    try {
      // 1. FETCH ALL DATA
      onProgress?.call('Downloading Brands...');
      final brandsData = await supabase.from('brands').select();
      
      onProgress?.call('Downloading Encyclopedia...');
      final encyclopediaData = await supabase.from('encyclopedia_entries').select();
      
      onProgress?.call('Downloading Recipes...');
      final recipesData = await supabase.from('recommended_recipes').select();

      onProgress?.call('Downloading Articles...');
      final articlesData = await supabase.from('specialty_articles').select();

      onProgress?.call('Downloading Patterns...');
      final patternsData = await supabase.from('latte_art_patterns').select();

      // 2. CLEAR AND INSERT
      await db.transaction(() async {
        if (clearLocal) {
          onProgress?.call('Clearing local tables...');
          await db.delete(db.recommendedRecipes).go();
          await db.delete(db.localizedBeanTranslations).go();
          await db.delete(db.localizedBeans).go();
          await db.delete(db.localizedBrandTranslations).go();
          await db.delete(db.localizedBrands).go();
          await db.delete(db.specialtyArticleTranslations).go();
          await db.delete(db.specialtyArticles).go();
          await db.delete(db.latteArtPatternTranslations).go();
          await db.delete(db.latteArtPatterns).go();
        }

        // Insert Brands
        onProgress?.call('Saving Brands (${brandsData.length})...');
        for (final item in brandsData) {
          final brandId = item['id'] as int;
          await db.insertBrand(LocalizedBrandsCompanion(
            id: Value(brandId),
            name: Value(item['name']),
            logoUrl: Value(item['logo_url']),
            siteUrl: Value(item['site_url']),
          ));
          await db.insertBrandTranslation(LocalizedBrandTranslationsCompanion(
            brandId: Value(brandId),
            languageCode: Value('uk'),
            shortDesc: Value(item['short_desc'] ?? ''),
            fullDesc: Value(item['full_desc'] ?? ''),
            location: Value(item['location'] ?? ''),
          ));
        }

        // Insert Encyclopedia (Beans)
        onProgress?.call('Saving Beans (${encyclopediaData.length})...');
        for (final item in encyclopediaData) {
          final beanId = item['id'] as int;
          await db.insertBean(LocalizedBeansCompanion(
            id: Value(beanId),
            brandId: Value(item['brand_id']),
            countryEmoji: Value(item['country_emoji']),
            altitudeMin: Value(item['altitude_min'] as int?),
            altitudeMax: Value(item['altitude_max'] as int?),
            lotNumber: Value(item['lot_number'] ?? ''),
            scaScore: Value(item['sca_score']?.toString() ?? '80'),
            cupsScore: Value((item['cups_score'] as num?)?.toDouble() ?? 82.0),
            sensoryJson: Value(item['sensory_json'] ?? '{}'),
            priceJson: Value(item['price_json'] ?? '{}'),
            plantationPhotosUrl: Value(item['plantation_photos_url'] ?? '[]'),
            harvestSeason: Value(item['harvest_season']),
            price: Value(item['price']),
            weight: Value(item['weight']),
            roastDate: Value(item['roast_date']),
            processingMethodsJson: Value(item['processing_methods_json'] ?? '[]'),
            isPremium: Value(item['is_premium'] ?? false),
            detailedProcessMarkdown: Value(item['detailed_process_markdown'] ?? ''),
            url: Value(item['url'] ?? ''),
            farm: Value(item['farm'] ?? ''),
            farmPhotosUrlCover: Value(item['farm_photos_url_cover']),
          ));

          await db.insertBeanTranslation(LocalizedBeanTranslationsCompanion(
            beanId: Value(beanId),
            languageCode: Value('uk'),
            country: Value(item['country'] ?? ''),
            region: Value(item['region'] ?? ''),
            varieties: Value(item['varieties'] ?? ''),
            flavorNotes: Value(item['flavor_notes'] ?? '[]'),
            processMethod: Value(item['process_method'] ?? ''),
            description: Value(item['description'] ?? ''),
            farmDescription: Value(item['farm_description'] ?? ''),
            roastLevel: Value(item['roast_level'] ?? ''),
          ));
        }

        // Insert Articles
        onProgress?.call('Saving Articles (${articlesData.length})...');
        for (final item in articlesData) {
          final artId = item['id'] as int;
          await db.insertArticle(SpecialtyArticlesCompanion(
            id: Value(artId),
            imageUrl: Value(item['image_url'] ?? ''),
            readTimeMin: Value(item['read_time_min'] ?? 5),
          ));
          await db.insertArticleTranslation(SpecialtyArticleTranslationsCompanion(
            articleId: Value(artId),
            languageCode: Value('uk'),
            title: Value(item['title'] ?? ''),
            subtitle: Value(item['subtitle'] ?? ''),
            contentHtml: Value(item['content_html'] ?? ''),
          ));
        }

        // Insert Patterns
        onProgress?.call('Saving Patterns (${patternsData.length})...');
        for (final item in patternsData) {
          final patId = item['id'] as int;
          await db.insertLatteArtPattern(LatteArtPatternsCompanion(
            id: Value(patId),
            difficulty: Value(item['difficulty'] ?? 1),
            stepsJson: Value(item['steps_json'] ?? '[]'),
          ));
          await db.insertLatteArtPatternTranslation(LatteArtPatternTranslationsCompanion(
            patternId: Value(patId),
            languageCode: Value('uk'),
            name: Value(item['name'] ?? ''),
            description: Value(item['description'] ?? ''),
            tipText: Value(item['tip_text'] ?? ''),
          ));
        }

        // Insert Recipes
        onProgress?.call('Saving Recipes (${recipesData.length})...');
        for (final item in recipesData) {
          await db.insertRecommendedRecipe(RecommendedRecipesCompanion(
            id: Value(item['id'] as int),
            lotId: Value(item['lot_id'] as int),
            methodKey: Value(item['method_key']),
            coffeeGrams: Value((item['coffee_grams'] as num?)?.toDouble() ?? 0.0),
            waterGrams: Value((item['water_grams'] as num?)?.toDouble() ?? 0.0),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 0.0),
            timeSec: Value(item['time_sec'] as int? ?? 0),
            rating: Value((item['rating'] as num?)?.toDouble() ?? 0.0),
            sensoryJson: Value(item['sensory_json'] ?? '{}'),
            notes: Value(item['notes'] ?? ''),
          ));
        }

        // Insert Sphere Regions
        onProgress?.call('Downloading Regions...');
        final regionsData = await supabase.from('sphere_regions').select();
        onProgress?.call('Saving Regions (${regionsData.length})...');
        if (clearLocal) {
          await db.delete(db.sphereRegionTranslations).go();
          await db.delete(db.sphereRegions).go();
        }
        for (final item in regionsData) {
          final regId = item['id'].toString();
          await db.insertSphereRegion(SphereRegionsCompanion(
            id: Value(regId),
            latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
            longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
            isActive: Value(item['is_active'] ?? true),
          ));
          await db.insertSphereRegionTranslation(SphereRegionTranslationsCompanion(
            regionId: Value(regId),
            languageCode: Value('uk'),
            name: Value(item['name'] ?? ''),
            description: Value(item['description'] ?? ''),
          ));
        }
      });

      debugPrint('SYNC: All systems synchronized [STABLE]');
      onProgress?.call('Sync completed successfully!');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e');
      rethrow;
    }
  }

  Future<void> syncLots(List<CoffeeLotsCompanion> lots) async {
    await db.syncLotsInTx(lots);
  }

  /// Trigger a full sync of all lots (legacy UI compatibility)
  Future<void> syncLots() async {
    await syncAll();
  }

  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    onProgress?.call('Pushing local data not supported in restricted v17 bridge.');
  }
}

  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    onProgress?.call('Pushing local data not supported in restricted v17 bridge.');
  }
}
