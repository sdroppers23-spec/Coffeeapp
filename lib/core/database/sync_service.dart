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

  SyncService(this.db, this.supabase);

  Future<void> syncAll({
    bool clearLocal = false,
    Function(String)? onProgress,
  }) async {
    debugPrint('SYNC: Starting full synchronization (clearLocal=$clearLocal)...');
    onProgress?.call('Connecting to cloud...');

    try {
      // 1. FETCH ALL DATA FIRST (Cloud-First Safety)
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

      if (brandsData.isEmpty && encyclopediaData.isEmpty) {
        throw Exception('Cloud database is empty. Sync aborted to protect local data.');
      }

      // 2. CLEAR AND INSERT IN ONE TRANSACTION
      await db.transaction(() async {
        if (clearLocal) {
          onProgress?.call('Clearing local tables...');
          await db.delete(db.recommendedRecipes).go();
          await db.delete(db.encyclopediaEntries).go();
          await db.delete(db.brands).go();
          await db.delete(db.specialtyArticles).go();
          await db.delete(db.latteArtPatterns).go();
        }

        // Insert Brands
        onProgress?.call('Saving Brands (${brandsData.length})...');
        for (final item in brandsData) {
          await db.insertBrand(BrandsCompanion(
            id: Value(item['id']),
            name: Value(item['name']),
            shortDesc: Value(item['short_desc'] ?? ''),
            fullDesc: Value(item['full_desc'] ?? ''),
            logoUrl: Value(item['logo_url'] ?? ''),
            siteUrl: Value(item['site_url'] ?? ''),
            location: Value(item['location'] ?? ''),
          ));
        }

        // Insert Encyclopedia
        onProgress?.call('Saving Encyclopedia (${encyclopediaData.length})...');
        for (final item in encyclopediaData) {
          await db.insertOrigin(EncyclopediaEntriesCompanion(
            id: Value(item['id']),
            countryEmoji: Value(item['country_emoji'] ?? '☕'),
            country: Value(item['country'] ?? 'Unknown'),
            region: Value(item['region'] ?? ''),
            altitudeMin: Value(item['altitude_min'] ?? 0),
            altitudeMax: Value(item['altitude_max'] ?? 0),
            varieties: Value(item['varieties'] ?? ''),
            flavorNotes: Value(item['flavor_notes'] ?? '[]'),
            processMethod: Value(item['process_method'] ?? ''),
            harvestSeason: Value(item['harvest_season'] ?? ''),
            cupsScore: Value((item['cups_score'] as num?)?.toDouble() ?? 0.0),
            description: Value(item['description'] ?? ''),
            farmDescription: Value(item['farm_description'] ?? ''),
            farmPhotosUrlCover: Value(item['farm_photos_url_cover'] ?? ''),
            plantationPhotosUrl: Value(item['plantation_photos_url'] ?? ''),
            processingMethodsJson: Value(item['processing_methods_json'] ?? '[]'),
            brandId: Value(item['brand_id']),
            sensoryJson: Value(item['sensory_json'] ?? '{}'),
            detailedProcessMarkdown: Value(item['detailed_process_markdown'] ?? ''),
            roastLevel: Value(item['roast_level'] ?? ''),
            weight: Value(item['weight'] ?? ''),
            price: Value(item['price'] ?? ''),
            roastDate: Value(item['roast_date'] ?? ''),
            lotNumber: Value(item['lot_number'] ?? ''),
            url: Value(item['url'] ?? ''),
            isPremium: Value(item['is_premium'] ?? false),
          ));
        }

        // Insert Articles
        onProgress?.call('Saving Articles (${articlesData.length})...');
        for (final item in articlesData) {
          await db.insertSpecialtyArticle(SpecialtyArticlesCompanion(
            id: Value(item['id']),
            title: Value(item['title'] ?? ''),
            subtitle: Value(item['subtitle'] ?? ''),
            contentHtml: Value(item['content_html'] ?? ''),
            imageUrl: Value(item['image_url'] ?? ''),
            readTimeMin: Value(item['read_time_min'] ?? 0),
          ));
        }

        // Insert Patterns
        onProgress?.call('Saving Patterns (${patternsData.length})...');
        for (final item in patternsData) {
          await db.insertPattern(LatteArtPatternsCompanion(
            id: Value(item['id']),
            name: Value(item['name'] ?? ''),
            difficulty: Value(item['difficulty'] ?? 1),
            description: Value(item['description'] ?? ''),
            tipText: Value(item['tip_text'] ?? ''),
            stepsJson: Value(item['steps_json'] ?? '[]'),
          ));
        }

        // Insert Recipes
        onProgress?.call('Saving Recipes (${recipesData.length})...');
        for (final item in recipesData) {
          await db.insertRecommendedRecipe(RecommendedRecipesCompanion(
            id: Value(item['id']),
            lotId: Value(item['lot_id']),
            methodKey: Value(item['method_key']),
            coffeeGrams: Value((item['coffee_grams'] as num?)?.toDouble() ?? 0.0),
            waterGrams: Value((item['water_grams'] as num?)?.toDouble() ?? 0.0),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 0.0),
            timeSec: Value(item['time_sec'] ?? 0),
            rating: Value((item['rating'] as num?)?.toDouble() ?? 0.0),
            sensoryJson: Value(item['sensory_json'] ?? '{}'),
            notes: Value(item['notes'] ?? ''),
          ));
        }
      });

      debugPrint('SYNC: All systems synchronized [STABLE]');
      onProgress?.call('Sync completed successfully [STABLE]');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e');
      rethrow;
    }
  }

  /// Pushes all local data from Drift to Supabase Cloud.
  /// USE WITH CAUTION: This will upsert all local items into the cloud.
  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    debugPrint('SYNC: Pushing local data to cloud...');
    onProgress?.call('Preparing local data...');

    try {
      // ... (push logic remains)
      final localBrands = await db.getAllBrands();
      onProgress?.call('Pushing ${localBrands.length} Brands...');
      for (final b in localBrands) {
        await supabase.from('brands').upsert({
          'id': b.id,
          'name': b.name,
          'short_desc': b.shortDesc,
          'full_desc': b.fullDesc,
          'logo_url': b.logoUrl,
          'site_url': b.siteUrl,
          'location': b.location,
        });
      }

      // 2. Push Encyclopedia Entries
      final localEntries = await db.getAllOrigins();
      onProgress?.call('Pushing ${localEntries.length} Lots...');
      for (final e in localEntries) {
        await supabase.from('encyclopedia_entries').upsert({
          'id': e.id,
          'brand_id': e.brandId,
          'country_emoji': e.countryEmoji,
          'country': e.country,
          'region': e.region,
          'altitude_min': e.altitudeMin,
          'altitude_max': e.altitudeMax,
          'varieties': e.varieties,
          'flavor_notes': e.flavorNotes,
          'process_method': e.processMethod,
          'harvest_season': e.harvestSeason,
          'cups_score': e.cupsScore,
          'description': e.description,
          'farm_description': e.farmDescription,
          'farm_photos_url_cover': e.farmPhotosUrlCover,
          'plantation_photos_url': e.plantationPhotosUrl,
          'processing_methods_json': e.processingMethodsJson,
          'sensory_json': e.sensoryJson,
          'roast_level': e.roastLevel,
          'weight': e.weight,
          'price': e.price,
          'roast_date': e.roastDate,
          'lot_number': e.lotNumber,
          'url': e.url,
          'is_premium': e.isPremium,
          'detailed_process_markdown': e.detailedProcessMarkdown,
        });
      }

      // 3. Push Recommended Recipes
      final localRecipes = await db.select(db.recommendedRecipes).get();
      onProgress?.call('Pushing ${localRecipes.length} Recipes...');
      for (final r in localRecipes) {
        await supabase.from('recommended_recipes').upsert({
          'id': r.id,
          'lot_id': r.lotId,
          'method_key': r.methodKey,
          'coffee_grams': r.coffeeGrams,
          'water_grams': r.waterGrams,
          'temp_c': r.tempC,
          'time_sec': r.timeSec,
          'rating': r.rating,
          'sensory_json': r.sensoryJson,
          'notes': r.notes,
        });
      }

      onProgress?.call('Cloud updated successfully! [STABLE]');
    } catch (e, st) {
      debugPrint('PUSH ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Push failed: $e');
      rethrow;
    }
  }
}
