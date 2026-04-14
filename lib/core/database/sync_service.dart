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
    Function(String, double)? onProgress,
  }) async {
    try {
      debugPrint('SYNC: Starting full synchronization...');
      onProgress?.call('Connecting to cloud...', 0.05);
      
      if (supabase == null) {
        onProgress?.call('Supabase not available, skipping cloud sync.', 1.0);
        return;
      }

      // 1. Version Guard (Cache Buster)
      if (force) {
        onProgress?.call('Clearing local cache...', 0.1);
        await _clearLocalSharedData();
      }

      // 2. Sequential Stable Sync
      onProgress?.call('Syncing Farmers...', 0.1);
      await syncFarmers();
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress?.call('Syncing Encyclopedia...', 0.3);
      await syncEncyclopedia();
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress?.call('Syncing Methods...', 0.5);
      await syncBrewingRecipes();
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress?.call('Syncing Articles...', 0.7);
      await syncArticles(onProgress: onProgress);
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress?.call('Syncing Brands...', 0.85);
      await syncBrands();
      await Future.delayed(const Duration(milliseconds: 300));
      
      // 7. Sync User Content (Push to Cloud) - Keep sequential at end to ensure deps
      onProgress?.call('Finalizing...', 0.98);
      await pushLocalUserContent();

      onProgress?.call('Cloud Connected', 1.0);
      debugPrint('SYNC: All systems synchronized [STABLE]');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e', 1.0);
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

      if (farmersData.isEmpty) {
        debugPrint('SYNC WARNING: Supabase returned 0 farmers. Check RLS or table content.');
        return;
      }

      // ONLY clear old farmers if we actually got new ones
      await db.transaction(() async {
        await db.delete(db.localizedFarmers).go();
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
            descriptionHtmlUk: Value(_cleanContent(descRaw.toString())),
            storyUk: Value(_cleanContent(storyRaw.toString())),
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
  Future<void> syncArticles({Function(String, double)? onProgress}) async {
    if (supabase == null) return;

    try {
      debugPrint('SYNC: Pulling articles from specialty_articles...');
      final data = await supabase!.from('specialty_articles').select().order('id');
      
      if (data.isEmpty) {
        debugPrint('SYNC: No articles found in cloud, skipping clear to prevent data loss.');
        return;
      }

      // Clear old articles locally only after successful fetch
      await db.transaction(() async {
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
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
            titleUk: Value(_cleanContent(item['title_uk'] as String? ?? item['title_en'] as String? ?? '')),
            subtitleUk: Value(_cleanContent(item['subtitle_uk'] as String? ?? '')),
            contentHtmlUk: Value(_cleanContent(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? '')),
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
               title: Value(_cleanContent(t['title'] as String?)),
               subtitle: Value(_cleanContent(t['subtitle'] as String?)),
               contentHtml: Value(_cleanContent(t['content_html'] as String?)),
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
      int successCount = 0;
      int errorCount = 0;
      
      final data = await supabase!.from('brewing_recipes').select();
      
      for (final item in data) {
        try {
          final key = item['method_key'] as String;
          debugPrint('SYNC: Processing brewing method: $key');

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
            imageUrl: Value(item['image_url'] as String? ?? ''),
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
              name: Value(t['name'] as String?),
              description: Value(t['description'] as String?),
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

  Future<void> pushLocalToCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  Future<void> pullFromCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  /// Removes technical keys and converts HTML to Markdown for better rendering.
  String _cleanContent(String? content) {
    if (content == null || content.isEmpty) return '';
    
    // 1. Remove technical keys like {p1}, [h2], etc.
    String cleaned = content
        .replaceAll(RegExp(r'\{[^}]+\}'), '')
        .replaceAll(RegExp(r'\[[^\]]+\]'), '');

    // 2. Convert common HTML tags to Markdown
    cleaned = cleaned
        .replaceAll(RegExp(r'<h1>', caseSensitive: false), '# ')
        .replaceAll(RegExp(r'</h1>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<h2>', caseSensitive: false), '## ')
        .replaceAll(RegExp(r'</h2>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<h3>', caseSensitive: false), '### ')
        .replaceAll(RegExp(r'</h3>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<h4>', caseSensitive: false), '#### ')
        .replaceAll(RegExp(r'</h4>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<h5>', caseSensitive: false), '##### ')
        .replaceAll(RegExp(r'</h5>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<h6>', caseSensitive: false), '###### ')
        .replaceAll(RegExp(r'</h6>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<p>', caseSensitive: false), '')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<strong>|<b>', caseSensitive: false), '**')
        .replaceAll(RegExp(r'</strong>|</b>', caseSensitive: false), '**')
        .replaceAll(RegExp(r'<em>|<i>|<em>|<i>', caseSensitive: false), '*')
        .replaceAll(RegExp(r'</em>|</i>|</em>|</i>', caseSensitive: false), '*')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '  \n')
        .replaceAll(RegExp(r'<li>', caseSensitive: false), '* ')
        .replaceAll(RegExp(r'</li>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<ul>|</ul>|<ol>|</ol>', caseSensitive: false), '\n');

    // 3. Final cleanup: remove residual multiple newlines/spaces
    return cleaned
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
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
        descriptionHtmlUk: Value(_cleanContent((item['description_html_uk'] ?? item['description_uk'] ?? item['description'] ?? '').toString())),
        storyUk: Value(_cleanContent((item['story_uk'] ?? item['story'] ?? '').toString())),
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
        titleUk: Value(_cleanContent(item['title_uk'] as String? ?? item['title_en'] as String? ?? '')),
        subtitleUk: Value(_cleanContent(item['subtitle_uk'] as String? ?? '')),
        contentHtmlUk: Value(_cleanContent(item['content_html_uk'] as String? ?? item['content_uk'] as String? ?? '')),
        imageUrl: Value(imageUrl),
        readTimeMin: Value(item['read_time_min'] as int? ?? 5),
      );

      final translationsData = await supabase!.from('specialty_article_translations').select().eq('article_id', id);
      final List<SpecialtyArticleTranslationsCompanion> translations = translationsData.map((t) => SpecialtyArticleTranslationsCompanion(
        articleId: Value(id),
        languageCode: Value(t['language_code'] as String),
        title: Value(_cleanContent(t['title'] as String?)),
        subtitle: Value(_cleanContent(t['subtitle'] as String?)),
        contentHtml: Value(_cleanContent(t['content_html'] as String?)),
      )).toList();

      await db.smartUpsertArticle(article, translations);
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
        descriptionUk: Value(item['description_uk'] as String? ?? item['description_en'] as String?),
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
        description: Value(t['description'] as String?),
        farmDescription: Value(t['farm_description'] as String?),
        roastLevel: Value(t['roast_level'] as String?),
      )).toList();

      await db.smartUpsertBean(bean, translations);
      debugPrint('SYNC: Real-time update success for Bean $id');
    } catch (e) {
      debugPrint('SYNC ERROR (Single Bean $id): $e');
    }
  }
}
