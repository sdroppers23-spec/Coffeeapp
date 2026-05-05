import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'package:flutter/foundation.dart';
import '../utils/content_utils.dart';

enum SyncResult { success, error }

class SyncService {
  final AppDatabase db;
  final SupabaseClient? supabase;

  // Stream for real-time progress tracking
  final _progressController = StreamController<double>.broadcast();
  Stream<double> get progressStream => _progressController.stream;

  // Stream to notify UI when a record was updated in real-time
  final _dataUpdateController = StreamController<void>.broadcast();
  Stream<void> get dataUpdateStream => _dataUpdateController.stream;

  final _isSyncingNotifier = ValueNotifier<bool>(false);
  ValueListenable<bool> get isSyncing => _isSyncingNotifier;

  final _lastSyncResultNotifier = ValueNotifier<SyncResult?>(null);
  ValueListenable<SyncResult?> get lastSyncResult => _lastSyncResultNotifier;

  StreamSubscription? _autoSyncSub;

  bool get _isPushing => _isSyncingNotifier.value;
  set _isPushing(bool value) => _isSyncingNotifier.value = value;

  static const String baseUrl =
      'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public';
  static const String articlesBucket = '$baseUrl/specialty-articles/';
  static const String methodsBucket = '$baseUrl/Methods/';
  static const String flagsBucket = '$baseUrl/Flags/';
  static const String farmersBucket = '$baseUrl/Farmers/';

  SyncService(this.db, [this.supabase]);

  void dispose() {
    _autoSyncSub?.cancel();
    _progressController.close();
    _dataUpdateController.close();
  }

  /// Starts listening to local database changes to trigger automatic cloud push.
  void startAutoSync() {
    _autoSyncSub?.cancel();
    // Listen for changes in user-managed tables
    _autoSyncSub = db.tableUpdates().listen((updates) {
      final relevantTables = {
        'user_lot_recipes',
        'encyclopedia_recipes',
        'alternative_recipes',
        'coffee_lots',
        'fermentation_logs',
        'user_roasters',
        'localized_brands',
      };

      final updatedTables = updates.map((u) => u.table).toSet();
      final hasRelevantUpdate = updatedTables.any(
        (t) => relevantTables.contains(t),
      );

      if (hasRelevantUpdate) {
        debugPrint(
          '🔄 SyncService: Local changes detected in $updatedTables, scheduling push...',
        );
        _debounceSync();
      }
    });
  }

  Timer? _debounceTimer;
  void _debounceSync() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      pushLocalUserContent();
    });
  }

  /// Synchronizes all systems.
  Future<void> syncAll({
    bool force = false,
    Function(String, double)? onProgress,
  }) async {
    if (_isPushing) {
      debugPrint('SyncService: Sync already in progress, skipping...');
      return;
    }
    _isPushing = true;

    try {
      _progressController.add(0.05);
      onProgress?.call('Connecting to cloud...', 0.05);

      if (supabase == null) {
        _progressController.add(1.0);
        onProgress?.call('Supabase not available, skipping cloud sync.', 1.0);
        _lastSyncResultNotifier.value = SyncResult.error;
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
      try {
        await syncBrands();
      } catch (e) {
        debugPrint('SyncService: Error syncing brands: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));

      onProgress?.call('Syncing Farmers...', 0.3);
      _progressController.add(0.3);
      try {
        await syncFarmers();
      } catch (e) {
        debugPrint('SyncService: Error syncing farmers: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));

      onProgress?.call('Syncing Encyclopedia...', 0.5);
      _progressController.add(0.5);
      try {
        await syncEncyclopedia();
      } catch (e) {
        debugPrint('SyncService: Error syncing encyclopedia: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));

      onProgress?.call('Syncing Methods...', 0.7);
      _progressController.add(0.7);
      try {
        await syncAlternativeBrewing();
      } catch (e) {
        debugPrint('SyncService: Error syncing methods: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));

      onProgress?.call('Syncing Articles...', 0.85);
      _progressController.add(0.85);
      try {
        await syncArticles();
      } catch (e) {
        debugPrint('SyncService: Error syncing articles: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));

      onProgress?.call('Syncing User Data...', 0.95);
      _progressController.add(0.95);
      try {
        // Push local changes (including deletions) BEFORE pulling
        // We pass internal = true to bypass the _isPushing guard
        await pushLocalUserContent(onProgress: onProgress, internal: true);
        await syncUserRoasters();
        await pullUserContent(onProgress: onProgress);
      } catch (e) {
        debugPrint('SyncService: Error syncing user data: $e');
      }

      onProgress?.call('Finalizing...', 0.98);
      _progressController.add(1.0);
      onProgress?.call('Cloud Connected', 1.0);
    } catch (e) {
      debugPrint('SyncService: Global sync error: $e');
      _progressController.add(1.0);
      onProgress?.call('Sync failed: $e', 1.0);
      _lastSyncResultNotifier.value = SyncResult.error;
    } finally {
      if (_lastSyncResultNotifier.value != SyncResult.error) {
        _lastSyncResultNotifier.value = SyncResult.success;
      }
      _isPushing = false;
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
              await (db.delete(
                db.specialtyArticles,
              )..where((t) => t.id.equals(id))).go();
              await (db.delete(
                db.specialtyArticlesV2,
              )..where((t) => t.id.equals(id))).go();
            } else {
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
              await (db.delete(
                db.localizedFarmers,
              )..where((t) => t.id.equals(id))).go();
              await (db.delete(
                db.localizedFarmersV2,
              )..where((t) => t.id.equals(id))).go();
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
              await (db.delete(
                db.localizedBeansV2,
              )..where((t) => t.id.equals(id))).go();
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
              await (db.delete(
                db.brewingRecipes,
              )..where((t) => t.methodKey.equals(key))).go();
              await (db.delete(
                db.brewingRecipesV2,
              )..where((t) => t.methodKey.equals(key))).go();
            } else {
              final key = payload.newRecord['method_key'] as String;
              await syncSingleBrewingRecipe(key);
            }
          },
        )
        .subscribe();

    supabase!
        .channel('public:brewing_recipe_translations')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'brewing_recipe_translations',
          callback: (payload) async {
            final key =
                (payload.newRecord['recipe_key'] ??
                        payload.oldRecord['recipe_key'])
                    as String;
            await syncSingleBrewingRecipe(key);
          },
        )
        .subscribe();

    // 5. Brands Channel
    supabase!
        .channel('public:brands')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'brands',
          callback: (payload) async {
            if (payload.eventType == PostgresChangeEvent.delete) {
              final id = (payload.oldRecord['id'] as num).toInt();
              await (db.delete(
                db.localizedBrands,
              )..where((t) => t.id.equals(id))).go();
            } else {
              final id = (payload.newRecord['id'] as num).toInt();
              await syncSingleBrand(id);
            }
          },
        )
        .subscribe();

    supabase!
        .channel('public:localized_brand_translations')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'localized_brand_translations',
          callback: (payload) async {
            final id =
                (payload.newRecord['brand_id'] ??
                        payload.oldRecord['brand_id'] ??
                        0)
                    as int;
            if (id > 0) await syncSingleBrand(id);
          },
        )
        .subscribe();

    // 6. Alternative Brewing Channel
    supabase!
        .channel('public:alternative_brewing')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'alternative_brewing',
          callback: (payload) async {
            await syncAlternativeBrewing();
          },
        )
        .subscribe();

    supabase!
        .channel('public:alternative_brewing_translations')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'alternative_brewing_translations',
          callback: (payload) async {
            await syncAlternativeBrewing();
          },
        )
        .subscribe();
  }

  /// Pulls farmer data from Supabase and updates local storage.
  /// Joining translations for accurate names as per stabilization requirement.
  Future<void> syncFarmers() async {
    if (supabase == null) return;

    try {
      final data = await supabase!
          .from('localized_farmers')
          .select()
          .order('id')
          .timeout(const Duration(seconds: 30));
      final remoteIds = data
          .map((item) => (item['id'] as num).toInt())
          .toList();

      // 2. Fetch translations
      final allTranslationsData = await supabase!
          .from('localized_farmer_translations')
          .select()
          .inFilter('farmer_id', remoteIds);

      // Group translations by farmer_id
      final Map<int, List<Map<String, dynamic>>> translationMap = {};
      for (final t in allTranslationsData) {
        final fId = (t['farmer_id'] as num).toInt();
        translationMap.putIfAbsent(fId, () => []).add(t);
      }

      for (final item in data) {
        try {
          final id = (item['id'] as num).toInt();

          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty &&
              !imageUrl.startsWith('http') &&
              !imageUrl.startsWith('assets/')) {
            imageUrl = '$farmersBucket${imageUrl.split('/').last}';
          }

          final farmer = LocalizedFarmersV2Companion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: Value(
              (item['flag_url'] ?? item['country_emoji'] ?? '').toString(),
            ),
            latitude: Value((item['latitude'] as num?)?.toDouble()),
            longitude: Value((item['longitude'] as num?)?.toDouble()),
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          final List<LocalizedFarmerTranslationsV2Companion> translations = [];
          final transData = translationMap[id] ?? [];

          for (final t in transData) {
            translations.add(
              LocalizedFarmerTranslationsV2Companion(
                farmerId: Value(id),
                languageCode: Value(t['language_code'] as String),
                name: Value(t['name'] as String?),
                descriptionHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    (t['description_html'] ?? t['description'] ?? '')
                        .toString(),
                  ),
                ),
                story: Value(
                  ContentUtils.cleanCoffeeContent(
                    (t['story'] ?? '').toString(),
                  ),
                ),
                region: Value((t['region'] ?? '').toString()),
                country: Value((t['country'] ?? '').toString()),
              ),
            );
          }

          // Fallback to main table fields for 'uk' and 'en' if missing
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(
              LocalizedFarmerTranslationsV2Companion(
                farmerId: Value(id),
                languageCode: const Value('uk'),
                name: Value(item['name_uk'] as String? ?? ''),
                descriptionHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['description_html_uk'] as String? ?? '',
                  ),
                ),
                story: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['story_uk'] as String? ?? '',
                  ),
                ),
                region: Value(item['region_uk'] as String? ?? ''),
                country: Value(item['country_uk'] as String? ?? ''),
              ),
            );
          }

          if (!translations.any((t) => t.languageCode.value == 'en')) {
            final nameEn = item['name_en'] as String?;
            final descEn =
                (item['description_html_en'] ?? item['description_en'])
                    as String?;
            final storyEn = (item['story_en'] ?? item['story']) as String?;
            final regionEn = item['region_en'] as String?;
            final countryEn = item['country_en'] as String?;

            translations.add(
              LocalizedFarmerTranslationsV2Companion(
                farmerId: Value(id),
                languageCode: const Value('en'),
                name: Value(
                  nameEn ?? item['name_uk'] as String? ?? 'Unknown Farmer',
                ),
                descriptionHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    descEn ?? item['description_html_uk'] as String? ?? '',
                  ),
                ),
                story: Value(
                  ContentUtils.cleanCoffeeContent(
                    storyEn ?? item['story_uk'] as String? ?? '',
                  ),
                ),
                region: Value(regionEn ?? item['region_uk'] as String? ?? ''),
                country: Value(
                  countryEn ?? item['country_uk'] as String? ?? '',
                ),
              ),
            );
          }

          await db.smartUpsertFarmerV2(farmer, translations);
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(
            db.localizedFarmerTranslationsV2,
          )..where((t) => t.farmerId.isIn(remoteIds).not())).go();
          await (db.delete(
            db.localizedFarmersV2,
          )..where((t) => t.id.isIn(remoteIds).not())).go();
        });
      }
    } catch (e) {
      debugPrint('SyncService: General sync error: $e');
    }
  }

  /// Pulls specialty articles from Supabase.
  Future<void> syncArticles() async {
    if (supabase == null) return;

    try {
      final data = await supabase!
          .from('specialty_articles')
          .select()
          .order('id')
          .timeout(const Duration(seconds: 30));
      final remoteIds = data
          .map((item) => (item['id'] as num).toInt())
          .toList();

      // 2. Fetch translations
      final allTranslationsData = await supabase!
          .from('specialty_article_translations')
          .select()
          .inFilter('article_id', remoteIds);

      // Group translations by article_id
      final Map<int, List<Map<String, dynamic>>> translationMap = {};
      for (final t in allTranslationsData) {
        final aId = (t['article_id'] as num).toInt();
        translationMap.putIfAbsent(aId, () => []).add(t);
      }

      for (int i = 0; i < data.length; i++) {
        final item = data[i];
        try {
          final id = (item['id'] as num).toInt();

          String imageUrl = item['image_url'] as String? ?? '';
          if (imageUrl.isNotEmpty &&
              !imageUrl.startsWith('http') &&
              !imageUrl.startsWith('assets/')) {
            imageUrl = '$articlesBucket${imageUrl.split('/').last}';
          }

          final article = SpecialtyArticlesV2Companion(
            id: Value(id),
            imageUrl: Value(imageUrl),
            flagUrl: const Value(''),
            readTimeMin: Value((item['read_time_min'] as num?)?.toInt() ?? 5),
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          final List<SpecialtyArticleTranslationsV2Companion> translations = [];
          final transData = translationMap[id] ?? [];

          for (final t in transData) {
            translations.add(
              SpecialtyArticleTranslationsV2Companion(
                articleId: Value(id),
                languageCode: Value(t['language_code'] as String),
                title: Value(
                  ContentUtils.cleanCoffeeContent(t['title'] as String? ?? ''),
                ),
                subtitle: Value(
                  ContentUtils.cleanCoffeeContent(
                    t['subtitle'] as String? ?? '',
                  ),
                ),
                contentHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    t['content_html'] as String? ?? '',
                  ),
                ),
              ),
            );
          }

          // Fallback to main table fields for 'uk' and 'en' if missing
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(
              SpecialtyArticleTranslationsV2Companion(
                articleId: Value(id),
                languageCode: const Value('uk'),
                title: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['title_uk'] as String? ?? '',
                  ),
                ),
                subtitle: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['subtitle_uk'] as String? ?? '',
                  ),
                ),
                contentHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['content_html_uk'] as String? ?? '',
                  ),
                ),
              ),
            );
          }

          if (!translations.any((t) => t.languageCode.value == 'en')) {
            translations.add(
              SpecialtyArticleTranslationsV2Companion(
                articleId: Value(id),
                languageCode: const Value('en'),
                title: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['title_uk'] as String? ?? '',
                  ),
                ),
                subtitle: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['subtitle_uk'] as String? ?? '',
                  ),
                ),
                contentHtml: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['content_html_uk'] as String? ?? '',
                  ),
                ),
              ),
            );
          }

          await db.smartUpsertArticleV2(article, translations);
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(
            db.specialtyArticleTranslationsV2,
          )..where((t) => t.articleId.isIn(remoteIds).not())).go();
          await (db.delete(
            db.specialtyArticlesV2,
          )..where((t) => t.id.isIn(remoteIds).not())).go();
        });
      }
    } catch (e) {
      debugPrint('SyncService: General sync error: $e');
    }
  }

  /// Helper for manual lot synchronization if needed.
  Future<void> syncLots([List<CoffeeLotsCompanion>? lots]) async {
    if (lots != null && lots.isNotEmpty) {
      await db.syncLotsInTx(lots);
    }
  }

  List<dynamic> _safeParsePours(String jsonString) {
    try {
      if (jsonString.isEmpty || jsonString == '[]') return [];
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (_) {
      return [];
    }
  }

  dynamic _safeJsonDecode(String? source) {
    if (source == null || source.isEmpty || source == '{}' || source == '[]') {
      return source?.startsWith('[') == true ? [] : {};
    }
    try {
      return jsonDecode(source);
    } catch (_) {
      return source.startsWith('[') ? [] : {};
    }
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      if (value.isEmpty) return null;
      // Try to parse standard ISO or other formats
      return DateTime.tryParse(value);
    }
    return null;
  }

  /// Pulls user roasters from Supabase.
  Future<void> syncUserRoasters() async {
    if (supabase == null || supabase!.auth.currentUser == null) return;
    final userId = supabase!.auth.currentUser!.id;

    try {
      final response = await supabase!
          .from('user_roasters')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response != null) {
        final List<dynamic> data = response['data'] as List<dynamic>? ?? [];
        final dataJson = jsonEncode(data);

        await db.saveUserRoastersRecord(
          UserRoastersCompanion(
            userId: Value(userId),
            dataJson: Value(dataJson),
            isSynced: const Value(true),
          ),
        );
        debugPrint('SyncService: User roasters pulled from cloud');
      }
    } catch (e) {
      debugPrint('SyncService: Error syncing user roasters: $e');
    }
  }

  /// Pushes local user data (recipes and lots) to Supabase, including deletions.
  Future<void> pushLocalUserContent({
    Function(String, double)? onProgress,
    bool internal = false,
  }) async {
    if (supabase == null || supabase!.auth.currentUser == null) {
      debugPrint('SyncService: No user or supabase, skipping push.');
      return;
    }
    if (!internal && _isPushing) {
      debugPrint('SyncService: Push already in progress, skipping...');
      return;
    }

    if (!internal) _isPushing = true;
    debugPrint('SyncService: Starting cloud push...');

    try {
      final userId = supabase!.auth.currentUser!.id;
      debugPrint('SyncService: userId is $userId');

      // 1. Sync User Brands (Upsert & Delete)
      onProgress?.call('Pushing Brands...', 0.91);
      final brandsToSync = await (db.select(
        db.localizedBrands,
      )..where((t) => t.isSynced.equals(false))).get();
      for (final b in brandsToSync) {
        try {
          if (b.isDeletedLocal) {
            debugPrint('SyncService: Deleting brand from cloud: ${b.id}');
            await supabase!
                .from('user_brands')
                .delete()
                .eq('id', b.id)
                .eq('user_id', userId)
                .timeout(const Duration(seconds: 15));

            await (db.delete(
              db.localizedBrands,
            )..where((t) => t.id.equals(b.id))).go();
            debugPrint('SyncService: Brand deleted permanently: ${b.id}');
          } else {
            await supabase!
                .from('user_brands')
                .upsert({
                  'id': b.id,
                  'user_id': userId,
                  'name': b.name,
                  'logo_url': b.logoUrl,
                  'site_url': b.siteUrl,
                  'updated_at': DateTime.now().toIso8601String(),
                })
                .timeout(const Duration(seconds: 15));

            final translations = await (db.select(
              db.localizedBrandTranslations,
            )..where((t) => t.brandId.equals(b.id))).get();

            for (final t in translations) {
              await supabase!
                  .from('user_brand_translations')
                  .upsert({
                    'brand_id': t.brandId,
                    'language_code': t.languageCode,
                    'short_desc': t.shortDesc,
                    'full_desc': t.fullDesc,
                    'location': t.location,
                  })
                  .timeout(const Duration(seconds: 15));
            }

            await (db.update(db.localizedBrands)
                  ..where((t) => t.id.equals(b.id)))
                .write(const LocalizedBrandsCompanion(isSynced: Value(true)));
            debugPrint('SyncService: Brand synced to cloud: ${b.id}');
          }
        } catch (e) {
          debugPrint('SyncService: Error syncing brand ${b.id}: $e');
        }
      }

      // 2. Sync Personal Coffee Lots (Upsert & Delete)
      onProgress?.call('Pushing Lots...', 0.92);
      final lotsToSync = await (db.select(
        db.coffeeLots,
      )..where((t) => t.isSynced.equals(false))).get();
      debugPrint('SyncService: Found ${lotsToSync.length} lots to sync.');
      for (final l in lotsToSync) {
        debugPrint(
          'SyncService: Processing lot ${l.id}, isDeletedLocal: ${l.isDeletedLocal}',
        );
        try {
          if (l.isDeletedLocal) {
            debugPrint('SyncService: Deleting lot from cloud: ${l.id}');
            await supabase!
                .from('user_coffee_lots')
                .delete()
                .eq('id', l.id)
                .eq('user_id', userId)
                .timeout(const Duration(seconds: 15));
            await db.markLotSynced(l.id);
            debugPrint('SyncService: Lot deletion synced to cloud: ${l.id}');
          } else {
            final data = {
              'id': l.id,
              'user_id': userId,
              'coffee_name': l.coffeeName,
              'roastery_name': l.roasteryName,
              'roastery_country': l.roasteryCountry,
              'roastery_city': l.roasteryCity,
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
              'retail_price': l.retailPrice,
              'wholesale_price': l.wholesalePrice,
              'is_favorite': l.isFavorite,
              'is_archived': l.isArchived,
              'is_open': l.isOpen,
              'is_ground': l.isGround,
              'user_roaster_id': l.userRoasterId,
              'sensory_json': _safeJsonDecode(l.sensoryJson),
              'price_json': _safeJsonDecode(l.priceJson),
              'image_url': l.imageUrl,
              'created_at': l.createdAt?.toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            };

            debugPrint('SyncService: Pushing lot ${l.id} to cloud...');
            await supabase!
                .from('user_coffee_lots')
                .upsert(data)
                .timeout(const Duration(seconds: 15));
            await db.markLotSynced(l.id);
            debugPrint(
              'SyncService: Lot synced to cloud successfully: ${l.id}',
            );
          }
        } catch (e) {
          debugPrint('SyncService: CRITICAL Error syncing lot ${l.id}: $e');
        }
      }

      // 3. Sync Lot Recipes (Upsert & Delete)
      onProgress?.call('Pushing Recipes...', 0.93);
      final lotRecipesToSync = await (db.select(
        db.userLotRecipes,
      )..where((t) => t.isSynced.equals(false))).get();
      for (final r in lotRecipesToSync) {
        try {
          if (r.isDeletedLocal) {
            await supabase!
                .from('user_lot_recipes')
                .delete()
                .eq('id', r.id)
                .eq('user_id', userId)
                .timeout(const Duration(seconds: 15));
            await db.markUserLotRecipeSynced(r.id);
            debugPrint('SyncService: Deleted lot recipe ${r.id} from cloud');
          } else {
            final data = {
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
              'pour_schedule_json': _safeParsePours(r.pourScheduleJson),
              'brew_temp_c': r.brewTempC,
              'notes': r.notes,
              'rating': r.rating,
              'created_at': r.createdAt?.toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
              'extraction_time_seconds': r.extractionTimeSeconds,
              'difficulty': r.difficulty,
              'content_html': r.contentHtml,
              'custom_method_name': r.customMethodName,
            };

            await supabase!
                .from('user_lot_recipes')
                .upsert(data)
                .timeout(const Duration(seconds: 15));
            await db.markUserLotRecipeSynced(r.id);
            debugPrint('SyncService: Pushed lot recipe ${r.id}');
          }
        } catch (e) {
          debugPrint('SyncService: Error syncing lot recipe ${r.id}: $e');
        }
      }

      // 4. Sync Encyclopedia Recipes (Upsert & Delete)
      onProgress?.call('Pushing Encyclopedia...', 0.94);
      final encRecipesToSync = await (db.select(
        db.encyclopediaRecipes,
      )..where((t) => t.isSynced.equals(false))).get();
      for (final r in encRecipesToSync) {
        try {
          if (r.isDeletedLocal) {
            await supabase!
                .from('user_encyclopedia_recipes')
                .delete()
                .eq('id', r.id)
                .eq('user_id', userId)
                .timeout(const Duration(seconds: 15));
            await db.markEncyclopediaRecipeSynced(r.id);
            debugPrint(
              'SyncService: Deleted encyclopedia recipe ${r.id} from cloud',
            );
          } else {
            final data = {
              'id': r.id,
              'user_id': userId,
              'lot_id': r.beanId,
              'method_key': r.methodKey,
              'name': r.name,
              'coffee_grams': r.coffeeGrams,
              'total_water_ml': r.totalWaterMl,
              'grind_number': r.grindNumber,
              'comandante_clicks': r.comandanteClicks,
              'ek43_division': r.ek43Division,
              'total_pours': r.totalPours,
              'pour_schedule_json': _safeParsePours(r.pourScheduleJson),
              'brew_temp_c': r.brewTempC,
              'notes': r.notes,
              'rating': r.rating,
              'created_at': r.createdAt?.toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
              'extraction_time_seconds': r.extractionTimeSeconds,
              'difficulty': r.difficulty,
              'content_html': r.contentHtml,
              'custom_method_name': r.customMethodName,
            };

            await supabase!
                .from('user_encyclopedia_recipes')
                .upsert(data)
                .timeout(const Duration(seconds: 15));
            await db.markEncyclopediaRecipeSynced(r.id);
            debugPrint('SyncService: Pushed encyclopedia recipe ${r.id}');
          }
        } catch (e) {
          debugPrint(
            'SyncService: Error syncing encyclopedia recipe ${r.id}: $e',
          );
        }
      }

      // 5. Sync Alternative Recipes (Upsert & Delete)
      onProgress?.call('Pushing Alternative...', 0.95);
      final altRecipesToSync = await (db.select(
        db.alternativeRecipes,
      )..where((t) => t.isSynced.equals(false))).get();
      for (final r in altRecipesToSync) {
        try {
          if (r.isDeletedLocal) {
            await supabase!
                .from('user_alternative_recipes')
                .delete()
                .eq('id', r.id)
                .eq('user_id', userId);
            await db.markAlternativeRecipeSynced(r.id);
            debugPrint(
              'SyncService: Deleted alternative recipe ${r.id} from cloud',
            );
          } else {
            final data = {
              'id': r.id,
              'user_id': userId,
              'method_key': r.methodKey,
              'name': r.name,
              'coffee_grams': r.coffeeGrams,
              'total_water_ml': r.totalWaterMl,
              'grind_number': r.grindNumber,
              'comandante_clicks': r.comandanteClicks,
              'ek43_division': r.ek43Division,
              'total_pours': r.totalPours,
              'pour_schedule_json': _safeParsePours(r.pourScheduleJson),
              'brew_temp_c': r.brewTempC,
              'notes': r.notes,
              'rating': r.rating,
              'created_at': r.createdAt?.toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
              'extraction_time_seconds': r.extractionTimeSeconds,
              'difficulty': r.difficulty,
              'content_html': r.contentHtml,
              'custom_method_name': r.customMethodName,
            };

            await supabase!
                .from('user_alternative_recipes')
                .upsert(data)
                .timeout(const Duration(seconds: 15));
            await db.markAlternativeRecipeSynced(r.id);
            debugPrint('SyncService: Pushed alternative recipe ${r.id}');
          }
        } catch (e) {
          debugPrint(
            'SyncService: Error syncing alternative recipe ${r.id}: $e',
          );
        }
      }

      // 6. Sync User Roasters (Consolidated JSON)
      onProgress?.call('Pushing Roasters...', 0.96);
      final roastersRecord = await db.getUserRoastersRecord(userId);
      if (roastersRecord != null && !roastersRecord.isSynced) {
        try {
          final data = jsonDecode(roastersRecord.dataJson);
          await supabase!
              .from('user_roasters')
              .upsert({
                'user_id': userId,
                'data': data,
                'updated_at': DateTime.now().toIso8601String(),
              })
              .timeout(const Duration(seconds: 15));

          await db.saveUserRoastersRecord(
            UserRoastersCompanion(
              userId: Value(userId),
              isSynced: const Value(true),
            ),
          );
          debugPrint('SyncService: User roasters pushed to cloud');
        } catch (e) {
          debugPrint('SyncService: Error pushing user roasters: $e');
        }
      }
    } catch (e) {
      debugPrint('SyncService: Fatal error in pushLocalUserContent: $e');
      if (!internal) _lastSyncResultNotifier.value = SyncResult.error;
    } finally {
      if (!internal) {
        _isPushing = false;
        if (_lastSyncResultNotifier.value != SyncResult.error) {
          _lastSyncResultNotifier.value = SyncResult.success;
        }
      }
    }
  }

  /// Pulls user-specific lots and recipes from Supabase.
  Future<void> pullUserContent({Function(String, double)? onProgress}) async {
    if (supabase == null || supabase!.auth.currentUser == null) {
      return;
    }

    try {
      final userId = supabase!.auth.currentUser!.id;

      // 1. Pull Lots
      onProgress?.call('Pulling Lots...', 0.96);

      final lotsData = await supabase!
          .from('user_coffee_lots')
          .select()
          .eq('user_id', userId)
          .timeout(const Duration(seconds: 30));

      debugPrint('SyncService: Pulled ${lotsData.length} lots from cloud');

      for (final item in lotsData) {
        try {
          final id = item['id'] as String;

          // CHECK: If lot is deleted locally OR has unsynced changes, do not pull it back from cloud
          final localLot = await db.findConflictLot(id);
          if (localLot != null &&
              (localLot.isDeletedLocal || !localLot.isSynced)) {
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
            roastDate: Value(_parseDateTime(item['roast_date'])),
            openedAt: Value(_parseDateTime(item['opened_at'])),
            weight: Value(item['weight'] as String?),
            lotNumber: Value(item['lot_number'] as String?),
            isDecaf: Value(item['is_decaf'] as bool? ?? false),
            farm: Value(item['farm'] as String?),
            washStation: Value(item['wash_station'] as String?),
            farmer: Value(item['farmer'] as String?),
            varieties: Value(item['varieties'] as String?),
            flavorProfile: Value(item['flavor_profile'] as String?),
            scaScore: Value(item['sca_score'] as String?),
            retailPrice: Value(item['retail_price'] as String?),
            wholesalePrice: Value(item['wholesale_price'] as String?),
            isFavorite: Value(item['is_favorite'] as bool? ?? false),
            isArchived: Value(item['is_archived'] as bool? ?? false),
            isOpen: Value(item['is_open'] as bool? ?? false),
            isGround: Value(item['is_ground'] as bool? ?? false),
            userRoasterId: Value(item['user_roaster_id'] as String?),
            sensoryJson: Value(
              item['sensory_json'] != null
                  ? jsonEncode(item['sensory_json'])
                  : '{}',
            ),
            priceJson: Value(
              item['price_json'] != null
                  ? jsonEncode(item['price_json'])
                  : '{}',
            ),
            imageUrl: Value(item['image_url'] as String?),
            createdAt: Value(DateTime.tryParse(item['created_at'] ?? '')),
            updatedAt: Value(DateTime.now()),
            isSynced: const Value(true),
          );

          await db.insertUserLot(lot);
        } catch (e) {
          debugPrint('SyncService: Error importing remote lot: $e');
        }
      }

      // 2. Recipes (User Lots)
      onProgress?.call('Pulling Recipes...', 0.97);

      final remoteRecipes = await supabase!
          .from('user_lot_recipes')
          .select()
          .eq('user_id', userId)
          .timeout(const Duration(seconds: 30));

      for (final item in remoteRecipes) {
        try {
          final id = item['id'] as String;

          final localRecipe = await db.findConflictRecipe(id);
          if (localRecipe != null &&
              (localRecipe.isDeletedLocal || !localRecipe.isSynced)) {
            continue;
          }

          await db.insertCustomRecipe(
            UserLotRecipesCompanion(
              id: Value(id),
              userId: Value(item['user_id'] as String),
              lotId: Value(item['lot_id'] as String?),
              methodKey: Value(item['method_key'] as String? ?? 'v60'),
              name: Value(item['name'] as String? ?? 'Recipe'),
              coffeeGrams: Value(
                (item['coffee_grams'] as num?)?.toDouble() ?? 0.0,
              ),
              totalWaterMl: Value(
                (item['total_water_ml'] as num?)?.toDouble() ?? 0.0,
              ),
              grindNumber: Value((item['grind_number'] as num?)?.toInt() ?? 0),
              comandanteClicks: Value(
                (item['comandante_clicks'] as num?)?.toInt() ?? 0,
              ),
              ek43Division: Value(
                (item['ek43_division'] as num?)?.toInt() ?? 0,
              ),
              totalPours: Value((item['total_pours'] as num?)?.toInt() ?? 1),
              pourScheduleJson: Value(
                item['pour_schedule_json'] != null
                    ? jsonEncode(item['pour_schedule_json'])
                    : '[]',
              ),
              brewTempC: Value(
                (item['brew_temp_c'] as num?)?.toDouble() ?? 93.0,
              ),
              notes: Value(item['notes'] as String? ?? ''),
              rating: Value((item['rating'] as num?)?.toInt() ?? 0),
              extractionTimeSeconds: Value(
                (item['extraction_time_seconds'] as num?)?.toInt(),
              ),
              difficulty: Value(item['difficulty'] as String?),
              contentHtml: Value(item['content_html'] as String?),
              customMethodName: Value(
                item['custom_method_name'] as String? ?? '',
              ),
              updatedAt: Value(DateTime.now()),
              isSynced: const Value(true),
            ),
          );
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      // 3. Recipes (Encyclopedia)
      onProgress?.call('Pulling Encyclopedia...', 0.98);

      final remoteEncRecipes = await supabase!
          .from('user_encyclopedia_recipes')
          .select()
          .eq('user_id', userId)
          .timeout(const Duration(seconds: 30));

      for (final item in remoteEncRecipes) {
        try {
          final id = item['id'] as String;

          final localRecipe = await db.findConflictEncyclopediaRecipe(id);
          if (localRecipe != null &&
              (localRecipe.isDeletedLocal || !localRecipe.isSynced)) {
            continue;
          }

          await db.upsertEncyclopediaRecipe(
            EncyclopediaRecipesCompanion(
              id: Value(id),
              userId: Value(item['user_id'] as String),
              beanId: Value((item['lot_id'] as num?)?.toInt()),
              methodKey: Value(item['method_key'] as String? ?? 'v60'),
              name: Value(item['name'] as String? ?? 'Recipe'),
              coffeeGrams: Value(
                (item['coffee_grams'] as num?)?.toDouble() ?? 0.0,
              ),
              totalWaterMl: Value(
                (item['total_water_ml'] as num?)?.toDouble() ?? 0.0,
              ),
              grindNumber: Value((item['grind_number'] as num?)?.toInt() ?? 0),
              comandanteClicks: Value(
                (item['comandante_clicks'] as num?)?.toInt() ?? 0,
              ),
              ek43Division: Value(
                (item['ek43_division'] as num?)?.toInt() ?? 0,
              ),
              totalPours: Value((item['total_pours'] as num?)?.toInt() ?? 1),
              pourScheduleJson: Value(
                item['pour_schedule_json'] != null
                    ? jsonEncode(item['pour_schedule_json'])
                    : '[]',
              ),
              brewTempC: Value(
                (item['brew_temp_c'] as num?)?.toDouble() ?? 93.0,
              ),
              notes: Value(item['notes'] as String? ?? ''),
              rating: Value((item['rating'] as num?)?.toInt() ?? 0),
              extractionTimeSeconds: Value(
                (item['extraction_time_seconds'] as num?)?.toInt(),
              ),
              difficulty: Value(item['difficulty'] as String?),
              contentHtml: Value(item['content_html'] as String?),
              customMethodName: Value(
                item['custom_method_name'] as String? ?? '',
              ),
              updatedAt: Value(DateTime.now()),
              isSynced: const Value(true),
            ),
          );
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      // 4. Recipes (Alternative)
      onProgress?.call('Pulling Alternative...', 0.99);

      final remoteAltRecipes = await supabase!
          .from('user_alternative_recipes')
          .select()
          .eq('user_id', userId)
          .timeout(const Duration(seconds: 30));

      for (final item in remoteAltRecipes) {
        try {
          final id = item['id'] as String;

          final localRecipe = await db.findConflictAlternativeRecipe(id);
          if (localRecipe != null &&
              (localRecipe.isDeletedLocal || !localRecipe.isSynced)) {
            continue;
          }

          await db.upsertAlternativeRecipe(
            AlternativeRecipesCompanion(
              id: Value(id),
              userId: Value(item['user_id'] as String),
              methodKey: Value(item['method_key'] as String? ?? 'v60'),
              name: Value(item['name'] as String? ?? 'Recipe'),
              coffeeGrams: Value(
                (item['coffee_grams'] as num?)?.toDouble() ?? 0.0,
              ),
              totalWaterMl: Value(
                (item['total_water_ml'] as num?)?.toDouble() ?? 0.0,
              ),
              grindNumber: Value((item['grind_number'] as num?)?.toInt() ?? 0),
              comandanteClicks: Value(
                (item['comandante_clicks'] as num?)?.toInt() ?? 0,
              ),
              ek43Division: Value(
                (item['ek43_division'] as num?)?.toInt() ?? 0,
              ),
              totalPours: Value((item['total_pours'] as num?)?.toInt() ?? 1),
              pourScheduleJson: Value(
                item['pour_schedule_json'] != null
                    ? jsonEncode(item['pour_schedule_json'])
                    : '[]',
              ),
              brewTempC: Value(
                (item['brew_temp_c'] as num?)?.toDouble() ?? 93.0,
              ),
              notes: Value(item['notes'] as String? ?? ''),
              rating: Value((item['rating'] as num?)?.toInt() ?? 0),
              extractionTimeSeconds: Value(
                (item['extraction_time_seconds'] as num?)?.toInt(),
              ),
              difficulty: Value(item['difficulty'] as String?),
              contentHtml: Value(item['content_html'] as String?),
              customMethodName: Value(
                item['custom_method_name'] as String? ?? '',
              ),
              updatedAt: Value(DateTime.now()),
              isSynced: const Value(true),
            ),
          );
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      // 5. User Roasters
      onProgress?.call('Pulling Roasters...', 1.0);
      try {
        final roastersData = await supabase!
            .from('user_roasters')
            .select()
            .eq('user_id', userId)
            .maybeSingle()
            .timeout(const Duration(seconds: 15));

        if (roastersData != null) {
          final localRoasters = await db.getUserRoastersRecord(userId);
          if (localRoasters == null || localRoasters.isSynced) {
            await db.saveUserRoastersRecord(
              UserRoastersCompanion(
                userId: Value(userId),
                dataJson: Value(jsonEncode(roastersData['data'])),
                isSynced: const Value(true),
              ),
            );
            debugPrint('SyncService: User roasters pulled from cloud');
          }
        }
      } catch (e) {
        debugPrint('SyncService: Error pulling user roasters: $e');
      }
    } catch (e) {
      debugPrint('SyncService: General sync error: $e');
    }
  }

  Future<void> syncBrewingRecipes() async {
    if (supabase == null) return;
    try {
      final data = await supabase!
          .from('brewing_recipes')
          .select()
          .timeout(const Duration(seconds: 30));

      final translationsData = await supabase!
          .from('brewing_recipe_translations')
          .select()
          .timeout(const Duration(seconds: 30));

      final remoteKeys = data
          .map((item) => item['method_key'] as String)
          .toList();

      // Group translations by recipe_key
      final Map<String, List<Map<String, dynamic>>> translationMap = {};
      for (final t in translationsData) {
        final key = t['recipe_key'] as String;
        translationMap.putIfAbsent(key, () => []).add(t);
      }

      for (final item in data) {
        try {
          final key = item['method_key'] as String;

          String methodImageUrl = item['image_url'] as String? ?? '';
          if (methodImageUrl.isNotEmpty &&
              !methodImageUrl.startsWith('http') &&
              !methodImageUrl.startsWith('assets/')) {
            methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
          }

          final recipeV1 = BrewingRecipesCompanion(
            methodKey: Value(key),
            imageUrl: Value(methodImageUrl),
            ratioGramsPerMl: Value(
              (item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066,
            ),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value(
              (item['total_time_sec'] as num?)?.toInt() ?? 180,
            ),
            difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
            flavorProfile: Value(
              item['flavor_profile'] as String? ?? 'Balanced',
            ),
            iconName: Value(item['icon_name'] as String?),
            stepsJson: Value(
              item['steps_json'] is List
                  ? jsonEncode(item['steps_json'])
                  : (item['steps_json']?.toString() ?? '[]'),
            ),
          );

          final recipeV2 = BrewingRecipesV2Companion(
            methodKey: Value(key),
            imageUrl: Value(methodImageUrl),
            ratioGramsPerMl: Value(
              (item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066,
            ),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value(
              (item['total_time_sec'] as num?)?.toInt() ?? 180,
            ),
            difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
            flavorProfile: Value(
              item['flavor_profile'] as String? ?? 'Balanced',
            ),
            iconName: Value(item['icon_name'] as String?),
            stepsJson: Value(
              item['steps_json'] is List
                  ? jsonEncode(item['steps_json'])
                  : (item['steps_json']?.toString() ?? '[]'),
            ),
          );

          final List<BrewingRecipeTranslationsCompanion> translationsV1 = [];
          final List<BrewingRecipeTranslationsV2Companion> translationsV2 = [];
          final transData = translationMap[key] ?? [];

          for (final t in transData) {
            final lang = t['language_code'] as String;
            final name = t['name'] as String?;
            final desc = ContentUtils.cleanCoffeeContent(
              t['description'] as String? ?? '',
            );

            translationsV1.add(
              BrewingRecipeTranslationsCompanion(
                recipeKey: Value(key),
                languageCode: Value(lang),
                name: Value(name),
                description: Value(desc),
              ),
            );

            translationsV2.add(
              BrewingRecipeTranslationsV2Companion(
                recipeKey: Value(key),
                languageCode: Value(lang),
                name: Value(name),
                description: Value(desc),
              ),
            );
          }

          // Add 'uk' fallback if missing
          if (!translationsV1.any((t) => t.languageCode.value == 'uk')) {
            final name =
                item['name_uk'] as String? ?? item['name'] as String? ?? key;
            final desc = ContentUtils.cleanCoffeeContent(
              item['description_uk'] as String? ??
                  item['description'] as String? ??
                  '',
            );

            translationsV1.add(
              BrewingRecipeTranslationsCompanion(
                recipeKey: Value(key),
                languageCode: const Value('uk'),
                name: Value(name),
                description: Value(desc),
              ),
            );
            translationsV2.add(
              BrewingRecipeTranslationsV2Companion(
                recipeKey: Value(key),
                languageCode: const Value('uk'),
                name: Value(name),
                description: Value(desc),
              ),
            );
          }

          await db.smartUpsertBrewingRecipe(recipeV1, translationsV1);
          await db.smartUpsertBrewingRecipeV2(recipeV2, translationsV2);
        } catch (e) {
          debugPrint('SyncService: Error processing brewing recipe: $e');
        }
      }

      if (remoteKeys.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(
            db.brewingRecipeTranslationsV2,
          )..where((t) => t.recipeKey.isIn(remoteKeys).not())).go();
          await (db.delete(
            db.brewingRecipesV2,
          )..where((t) => t.methodKey.isIn(remoteKeys).not())).go();
          await (db.delete(
            db.brewingRecipeTranslations,
          )..where((t) => t.recipeKey.isIn(remoteKeys).not())).go();
          await (db.delete(
            db.brewingRecipes,
          )..where((t) => t.methodKey.isIn(remoteKeys).not())).go();
        });
      }
    } catch (e) {
      debugPrint('SyncService: General brewing recipes sync error: $e');
    }
  }

  /// Pulls alternative brewing methods from Supabase.
  Future<void> syncAlternativeBrewing() async {
    if (supabase == null) return;
    try {
      final data = await supabase!
          .from('alternative_brewing')
          .select()
          .timeout(const Duration(seconds: 30));
      final translationsData = await supabase!
          .from('alternative_brewing_translations')
          .select()
          .timeout(const Duration(seconds: 30));

      final remoteKeys = data
          .map((item) => item['method_key'] as String)
          .toList();

      // Group translations by recipe_key
      final Map<String, List<Map<String, dynamic>>> translationMap = {};
      for (final t in translationsData) {
        final key = t['recipe_key'] as String;
        translationMap.putIfAbsent(key, () => []).add(t);
      }

      for (final item in data) {
        try {
          final key = item['method_key'] as String;

          String methodImageUrl = item['image_url'] as String? ?? '';
          if (methodImageUrl.isNotEmpty &&
              !methodImageUrl.startsWith('http') &&
              !methodImageUrl.startsWith('assets/')) {
            methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
          }

          final recipe = AlternativeBrewingCompanion(
            methodKey: Value(key),
            imageUrl: Value(methodImageUrl),
            ratioGramsPerMl: Value(
              (item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066,
            ),
            tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
            totalTimeSec: Value(
              (item['total_time_sec'] as num?)?.toInt() ?? 180,
            ),
            difficulty: Value(_normalizeDifficulty(item['difficulty'])),
            flavorProfile: Value(
              item['flavor_profile'] as String? ?? 'Balanced',
            ),
            iconName: Value(item['icon_name'] as String?),
            category: Value(item['category'] as String? ?? 'filter'),
            contentHtml: Value(item['content_html'] as String?),
            weight: Value((item['weight'] as num?)?.toDouble()),
            coffeeGrams: Value((item['coffee_grams'] as num?)?.toDouble()),
            nameUk: Value(item['name_uk'] as String?),
            sortOrder: Value((item['sort_order'] as num?)?.toInt() ?? 0),
            isHiden: Value(item['is_hiden'] as bool? ?? false),
            stepsJson: Value(
              item['steps_json'] is List
                  ? jsonEncode(item['steps_json'])
                  : (item['steps_json']?.toString() ?? '[]'),
            ),
            isSynced: const Value(true),
            isDeletedLocal: const Value(false),
            updatedAt: Value(
              DateTime.tryParse(item['updated_at'] as String? ?? ''),
            ),
          );

          final translations = (translationMap[key] ?? []).map((t) {
            return AlternativeBrewingTranslationsCompanion(
              recipeKey: Value(key),
              languageCode: Value(t['language_code'] as String),
              name: Value(t['name'] as String?),
              description: Value(t['description'] as String?),
              contentHtml: Value(t['content_html'] as String?),
            );
          }).toList();

          // Add 'uk' fallback if missing
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(
              AlternativeBrewingTranslationsCompanion(
                recipeKey: Value(key),
                languageCode: const Value('uk'),
                name: Value(
                  item['name_uk'] as String? ?? item['name'] as String?,
                ),
                description: Value(
                  item['description_uk'] as String? ??
                      item['description'] as String?,
                ),
                contentHtml: Value(
                  item['content_html_uk'] as String? ??
                      item['content_html'] as String?,
                ),
              ),
            );
          }

          await db.smartUpsertAlternativeBrewing(recipe, translations);
        } catch (e) {
          // Silent fail
        }
      }

      // Cleanup local records not in remote
      if (remoteKeys.isNotEmpty) {
        await db.transaction(() async {
          await (db.delete(
            db.alternativeBrewingTranslations,
          )..where((t) => t.recipeKey.isIn(remoteKeys).not())).go();
          await (db.delete(
            db.alternativeBrewing,
          )..where((t) => t.methodKey.isIn(remoteKeys).not())).go();
        });
      }
      _dataUpdateController.add(null);
    } catch (e) {
      // Silent fail
    }
  }

  /// Pulls brands from Supabase.
  Future<void> syncBrands() async {
    if (supabase == null) return;
    try {
      // 1. Fetch all brands - try 'brands' table as it's the primary source in cloud
      var data = await supabase!
          .from('brands')
          .select()
          .timeout(const Duration(seconds: 30));
      if (data.isEmpty) {
        data = await supabase!
            .from('localized_brands')
            .select()
            .timeout(const Duration(seconds: 30));
      }

      final remoteIds = data
          .map((item) => (item['id'] as num).toInt())
          .toList();
      debugPrint('SyncService: Found ${data.length} brands in cloud');

      if (remoteIds.isEmpty) {
        debugPrint('SyncService: No brands found in cloud, skipping.');
        return;
      }

      // 2. Fetch all translations in one go

      final allTranslations = await supabase!
          .from('localized_brand_translations')
          .select()
          .inFilter('brand_id', remoteIds)
          .timeout(const Duration(seconds: 30));

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
            translations.add(
              LocalizedBrandTranslationsCompanion(
                brandId: Value(id),
                languageCode: Value(t['language_code'] as String),
                shortDesc: Value(t['short_desc'] as String?),
                fullDesc: Value(t['full_desc'] as String?),
                location: Value(t['location'] as String?),
              ),
            );
          }

          // Add 'uk' fallback if missing
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(
              LocalizedBrandTranslationsCompanion(
                brandId: Value(id),
                languageCode: const Value('uk'),
                shortDesc: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['short_desc'] as String? ??
                        item['short_desc_uk'] as String? ??
                        item['short_desc_en'] as String? ??
                        '',
                  ),
                ),
                fullDesc: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['full_desc'] as String? ??
                        item['full_desc_uk'] as String? ??
                        item['full_desc_en'] as String? ??
                        '',
                  ),
                ),
                location: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['location'] as String? ??
                        item['location_uk'] as String? ??
                        item['location_en'] as String? ??
                        '',
                  ),
                ),
              ),
            );
          }

          // Add 'en' fallback if missing
          if (!translations.any((t) => t.languageCode.value == 'en')) {
            translations.add(
              LocalizedBrandTranslationsCompanion(
                brandId: Value(id),
                languageCode: const Value('en'),
                shortDesc: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['short_desc'] as String? ??
                        item['short_desc_en'] as String? ??
                        item['short_desc_uk'] as String? ??
                        '',
                  ),
                ),
                fullDesc: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['full_desc'] as String? ??
                        item['full_desc_en'] as String? ??
                        item['full_desc_uk'] as String? ??
                        '',
                  ),
                ),
                location: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['location'] as String? ??
                        item['location_en'] as String? ??
                        item['location_uk'] as String? ??
                        '',
                  ),
                ),
              ),
            );
          }

          await db.smartUpsertBrand(companion, translations);
        } catch (e) {
          debugPrint('SyncService: Error processing item: $e');
        }
      }

      if (remoteIds.isNotEmpty) {
        await db.transaction(() async {
          // Only delete brands that ARE NOT user-specific (userId is null) and are NOT in the remote list
          final brandsToDelete =
              await (db.select(db.localizedBrands)..where(
                    (t) => t.id.isIn(remoteIds).not() & t.userId.isNull(),
                  ))
                  .get();
          final idsToDelete = brandsToDelete.map((b) => b.id).toList();

          if (idsToDelete.isNotEmpty) {
            await (db.delete(
              db.localizedBrandTranslations,
            )..where((t) => t.brandId.isIn(idsToDelete))).go();
            await (db.delete(
              db.localizedBrands,
            )..where((t) => t.id.isIn(idsToDelete))).go();
          }
        });
      }
    } catch (e) {
      debugPrint('SyncService: General sync error: $e');
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
      debugPrint('SyncService: General sync error: $e');
    }
  }

  Future<void> pushLocalToCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  Future<void> pullFromCloud({Function(String, double)? onProgress}) async {
    await syncAll(onProgress: onProgress);
  }

  /// Syncs a single farmer by ID (handles both V1 and V2).
  Future<void> syncSingleFarmer(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!
          .from('localized_farmers')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (item == null) return;

      String imageUrl = item['image_url'] as String? ?? '';
      if (imageUrl.isNotEmpty &&
          !imageUrl.startsWith('http') &&
          !imageUrl.startsWith('assets/')) {
        imageUrl = '$farmersBucket${imageUrl.split('/').last}';
      }

      // 1. Fetch translations
      final translationsData = await supabase!
          .from('localized_farmer_translations')
          .select()
          .eq('farmer_id', id);

      // --- V1 Sync ---
      final farmerV1 = LocalizedFarmersCompanion(
        id: Value(id),
        imageUrl: Value(imageUrl),
        flagUrl: Value(
          (item['flag_url'] ?? item['country_emoji'] ?? '').toString(),
        ),
        latitude: Value((item['latitude'] as num?)?.toDouble() ?? 0.0),
        longitude: Value((item['longitude'] as num?)?.toDouble() ?? 0.0),
      );

      final List<LocalizedFarmerTranslationsCompanion>
      translationsV1 = translationsData
          .map(
            (t) => LocalizedFarmerTranslationsCompanion(
              farmerId: Value(id),
              languageCode: Value(t['language_code'] as String),
              name: Value(t['name'] as String?),
              descriptionHtml: Value(
                ContentUtils.cleanCoffeeContent(
                  (t['description_html'] ?? t['description'] ?? '').toString(),
                ),
              ),
              region: Value(t['region'] as String?),
              country: Value(t['country'] as String?),
              story: Value(
                ContentUtils.cleanCoffeeContent(t['story'] as String? ?? ''),
              ),
            ),
          )
          .toList();

      // Add 'uk' fallback for V1 if missing
      if (!translationsV1.any((t) => t.languageCode.value == 'uk')) {
        translationsV1.add(
          LocalizedFarmerTranslationsCompanion(
            farmerId: Value(id),
            languageCode: const Value('uk'),
            name: Value((item['name_uk'] ?? item['name'] ?? '').toString()),
            descriptionHtml: Value(
              ContentUtils.cleanCoffeeContent(
                (item['description_html_uk'] ??
                        item['description_uk'] ??
                        item['description'] ??
                        '')
                    .toString(),
              ),
            ),
            story: Value(
              ContentUtils.cleanCoffeeContent(
                (item['story_uk'] ?? item['story'] ?? '').toString(),
              ),
            ),
            region: Value(
              (item['region_uk'] ?? item['region'] ?? '').toString(),
            ),
            country: Value(
              (item['country_uk'] ?? item['country'] ?? '').toString(),
            ),
          ),
        );
      }

      await db.smartUpsertFarmer(farmerV1, translationsV1);

      // --- V2 Sync ---
      final farmerV2 = LocalizedFarmersV2Companion(
        id: Value(id),
        imageUrl: Value(imageUrl),
        flagUrl: Value(
          (item['flag_url'] ?? item['country_emoji'] ?? '').toString(),
        ),
        latitude: Value((item['latitude'] as num?)?.toDouble()),
        longitude: Value((item['longitude'] as num?)?.toDouble()),
        createdAt: Value(
          item['created_at'] != null
              ? DateTime.tryParse(item['created_at'] as String)
              : null,
        ),
      );

      final List<LocalizedFarmerTranslationsV2Companion>
      translationsV2 = translationsData
          .map(
            (t) => LocalizedFarmerTranslationsV2Companion(
              farmerId: Value(id),
              languageCode: Value(t['language_code'] as String),
              name: Value(t['name'] as String?),
              descriptionHtml: Value(
                ContentUtils.cleanCoffeeContent(
                  (t['description_html'] ?? t['description'] ?? '').toString(),
                ),
              ),
              region: Value(t['region'] as String?),
              country: Value(t['country'] as String?),
              story: Value(
                ContentUtils.cleanCoffeeContent(t['story'] as String? ?? ''),
              ),
            ),
          )
          .toList();

      // Add 'uk' fallback for V2 if missing
      if (!translationsV2.any((t) => t.languageCode.value == 'uk')) {
        translationsV2.add(
          LocalizedFarmerTranslationsV2Companion(
            farmerId: Value(id),
            languageCode: const Value('uk'),
            name: Value((item['name_uk'] ?? item['name'] ?? '').toString()),
            descriptionHtml: Value(
              ContentUtils.cleanCoffeeContent(
                (item['description_html_uk'] ??
                        item['description_uk'] ??
                        item['description'] ??
                        '')
                    .toString(),
              ),
            ),
            story: Value(
              ContentUtils.cleanCoffeeContent(
                (item['story_uk'] ?? item['story'] ?? '').toString(),
              ),
            ),
            region: Value(
              (item['region_uk'] ?? item['region'] ?? '').toString(),
            ),
            country: Value(
              (item['country_uk'] ?? item['country'] ?? '').toString(),
            ),
          ),
        );
      }

      await db.smartUpsertFarmerV2(farmerV2, translationsV2);

      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint('SyncService: General sync error in syncSingleFarmer: $e');
    }
  }

  /// Syncs a single article by ID.
  /// Syncs a single article by ID (handles both V1 and V2).
  Future<void> syncSingleArticle(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!
          .from('specialty_articles')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (item == null) return;

      String imageUrl = item['image_url'] as String? ?? '';
      if (imageUrl.isNotEmpty &&
          !imageUrl.startsWith('http') &&
          !imageUrl.startsWith('assets/')) {
        imageUrl = '$articlesBucket${imageUrl.split('/').last}';
      }

      // Fetch translations
      final translationsData = await supabase!
          .from('specialty_article_translations')
          .select()
          .eq('article_id', id);

      // --- V1 Sync ---
      final articleV1 = SpecialtyArticlesCompanion(
        id: Value(id),
        imageUrl: Value(imageUrl),
        readTimeMin: Value((item['read_time_min'] as num?)?.toInt() ?? 5),
      );

      final List<SpecialtyArticleTranslationsCompanion>
      translationsV1 = translationsData
          .map(
            (t) => SpecialtyArticleTranslationsCompanion(
              articleId: Value(id),
              languageCode: Value(t['language_code'] as String),
              title: Value(
                ContentUtils.cleanCoffeeContent(t['title'] as String? ?? ''),
              ),
              subtitle: Value(
                ContentUtils.cleanCoffeeContent(t['subtitle'] as String? ?? ''),
              ),
              contentHtml: Value(
                ContentUtils.cleanCoffeeContent(
                  t['content_html'] as String? ?? '',
                ),
              ),
            ),
          )
          .toList();

      // Add 'uk' fallback for V1 if missing
      if (!translationsV1.any((t) => t.languageCode.value == 'uk')) {
        translationsV1.add(
          SpecialtyArticleTranslationsCompanion(
            articleId: Value(id),
            languageCode: const Value('uk'),
            title: Value(
              ContentUtils.cleanCoffeeContent(
                item['title_uk'] as String? ??
                    item['title_en'] as String? ??
                    '',
              ),
            ),
            subtitle: Value(
              ContentUtils.cleanCoffeeContent(
                item['subtitle_uk'] as String? ?? '',
              ),
            ),
            contentHtml: Value(
              ContentUtils.cleanCoffeeContent(
                item['content_html_uk'] as String? ??
                    item['content_uk'] as String? ??
                    '',
              ),
            ),
          ),
        );
      }

      await db.smartUpsertArticle(articleV1, translationsV1);

      // --- V2 Sync ---
      final articleV2 = SpecialtyArticlesV2Companion(
        id: Value(id),
        imageUrl: Value(imageUrl),
        flagUrl: const Value(''),
        readTimeMin: Value((item['read_time_min'] as num?)?.toInt() ?? 5),
        createdAt: Value(
          item['created_at'] != null
              ? DateTime.tryParse(item['created_at'] as String)
              : null,
        ),
      );

      final List<SpecialtyArticleTranslationsV2Companion>
      translationsV2 = translationsData
          .map(
            (t) => SpecialtyArticleTranslationsV2Companion(
              articleId: Value(id),
              languageCode: Value(t['language_code'] as String),
              title: Value(
                ContentUtils.cleanCoffeeContent(t['title'] as String? ?? ''),
              ),
              subtitle: Value(
                ContentUtils.cleanCoffeeContent(t['subtitle'] as String? ?? ''),
              ),
              contentHtml: Value(
                ContentUtils.cleanCoffeeContent(
                  t['content_html'] as String? ?? '',
                ),
              ),
            ),
          )
          .toList();

      // Add 'uk' fallback for V2 if missing
      if (!translationsV2.any((t) => t.languageCode.value == 'uk')) {
        final titleUk = item['title_uk'] as String?;
        final contentUk =
            (item['content_html_uk'] ?? item['content_uk']) as String?;

        if (titleUk != null || contentUk != null) {
          translationsV2.add(
            SpecialtyArticleTranslationsV2Companion(
              articleId: Value(id),
              languageCode: const Value('uk'),
              title: Value(ContentUtils.cleanCoffeeContent(titleUk ?? '')),
              subtitle: Value(
                ContentUtils.cleanCoffeeContent(
                  item['subtitle_uk'] as String? ?? '',
                ),
              ),
              contentHtml: Value(
                ContentUtils.cleanCoffeeContent(contentUk ?? ''),
              ),
            ),
          );
        }
      }

      // Add 'en' fallback for V2 if missing to ensure innerJoin works
      if (!translationsV2.any((t) => t.languageCode.value == 'en')) {
        final titleEn = item['title_en'] as String?;
        final contentEn =
            (item['content_html_en'] ?? item['content_en']) as String?;
        final subtitleEn = item['subtitle_en'] as String?;

        // Even if En fields are missing, we create a record to avoid disappearing articles in En mode
        // But we prefer English fields if they exist in the main entry
        translationsV2.add(
          SpecialtyArticleTranslationsV2Companion(
            articleId: Value(id),
            languageCode: const Value('en'),
            title: Value(
              ContentUtils.cleanCoffeeContent(
                titleEn ?? item['title'] as String? ?? 'Untitled',
              ),
            ),
            subtitle: Value(
              ContentUtils.cleanCoffeeContent(
                subtitleEn ?? item['subtitle'] as String? ?? '',
              ),
            ),
            contentHtml: Value(
              ContentUtils.cleanCoffeeContent(
                contentEn ?? item['content_html'] as String? ?? '',
              ),
            ),
          ),
        );
      }

      await db.smartUpsertArticleV2(articleV2, translationsV2);

      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint('SyncService: General sync error in syncSingleArticle: $e');
    }
  }

  Future<void> syncEncyclopedia() async {
    if (supabase == null) return;
    debugPrint('SyncService: Starting Encyclopedia sync...');
    try {
      // 1. Fetch main entries
      final data = await supabase!
          .from('encyclopedia_entries')
          .select()
          .timeout(const Duration(seconds: 30));
      debugPrint(
        'SyncService: Supabase returned ${data.length} encyclopedia entries',
      );

      final remoteIds = data
          .map((item) => (item['id'] as num).toInt())
          .toList();
      debugPrint('SyncService: Remote IDs: $remoteIds');

      if (remoteIds.isEmpty) {
        debugPrint(
          'SyncService: No remote encyclopedia entries found, skipping.',
        );
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
            cupsScore: Value(
              double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0,
            ),
            sensoryJson: Value(
              item['sensory_json'] != null
                  ? jsonEncode(item['sensory_json'])
                  : '{}',
            ),
            priceJson: Value(
              item['price_json'] != null
                  ? jsonEncode(item['price_json'])
                  : '{}',
            ),
            plantationPhotosUrl: Value(
              _safeJson(item['plantation_photos_url']),
            ),
            harvestSeason: Value(item['harvest_season'] as String? ?? ''),
            price: Value(item['price'] as String? ?? ''),
            weight: Value(item['weight'] as String? ?? ''),
            roastDate: Value(item['roast_date'] as String? ?? ''),
            processingMethodsJson: Value(
              _safeJson(item['processing_methods_json']),
            ),
            isPremium: Value(item['is_premium'] as bool? ?? false),
            detailedProcessMarkdown: Value(
              item['detailed_process_markdown'] as String? ?? '',
            ),
            url: Value(item['url'] as String? ?? ''),
            farmerId: Value((item['farmer_id'] as num?)?.toInt()),
            isDecaf: Value(item['is_decaf'] as bool? ?? false),
            farm: Value(item['farm'] as String?),
            farmPhotosUrlCover: Value(item['farm_photos_url_cover'] as String?),
            washStation: Value(item['wash_station'] as String?),
            retailPrice: Value(item['retail_price']?.toString()),
            wholesalePrice: Value(item['wholesale_price']?.toString()),
            flagUrl: Value(item['image_url'] as String? ?? ''),
            radarJson: Value(
              item['radar_json'] != null
                  ? jsonEncode(item['radar_json'])
                  : '{}',
            ),
            createdAt: Value(
              item['created_at'] != null
                  ? DateTime.tryParse(item['created_at'] as String)
                  : null,
            ),
          );

          final List<LocalizedBeanTranslationsV2Companion> translations = [];
          final transData = translationMap[id] ?? [];

          // Add existing translations from cloud
          for (final t in transData) {
            translations.add(
              LocalizedBeanTranslationsV2Companion(
                beanId: Value(id),
                languageCode: Value(t['language_code'] as String),
                country: Value(t['country'] as String?),
                region: Value(t['region'] as String?),
                varieties: Value(t['varieties'] as String?),
                flavorNotes: Value(_safeJson(t['flavor_notes'])),
                processMethod: Value(t['process_method'] as String?),
                description: Value(
                  ContentUtils.cleanCoffeeContent(
                    t['description'] as String? ?? '',
                  ),
                ),
                farmDescription: Value(
                  ContentUtils.cleanCoffeeContent(
                    t['farm_description'] as String? ?? '',
                  ),
                ),
                roastLevel: Value(t['roast_level'] as String?),
              ),
            );
          }

          // FALLBACK logic: if 'uk' or 'en' is missing, use the main table (which has Ukrainian data)
          if (!translations.any((t) => t.languageCode.value == 'uk')) {
            translations.add(
              LocalizedBeanTranslationsV2Companion(
                beanId: Value(id),
                languageCode: const Value('uk'),
                country: Value(item['country'] as String? ?? 'Unknown'),
                region: Value(item['region'] as String? ?? ''),
                varieties: Value(item['varieties'] as String? ?? ''),
                flavorNotes: Value(_safeJson(item['flavor_notes'])),
                processMethod: Value(item['process_method'] as String? ?? ''),
                description: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['description'] as String? ?? '',
                  ),
                ),
                farmDescription: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['farm_description'] as String? ?? '',
                  ),
                ),
                roastLevel: Value(item['roast_level'] as String? ?? ''),
              ),
            );
          }

          if (!translations.any((t) => t.languageCode.value == 'en')) {
            translations.add(
              LocalizedBeanTranslationsV2Companion(
                beanId: Value(id),
                languageCode: const Value('en'),
                country: Value(item['country'] as String? ?? 'Unknown'),
                region: Value(item['region'] as String? ?? ''),
                varieties: Value(item['varieties'] as String? ?? ''),
                flavorNotes: Value(_safeJson(item['flavor_notes'])),
                processMethod: Value(item['process_method'] as String? ?? ''),
                description: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['description'] as String? ?? '',
                  ),
                ),
                farmDescription: Value(
                  ContentUtils.cleanCoffeeContent(
                    item['farm_description'] as String? ?? '',
                  ),
                ),
                roastLevel: Value(item['roast_level'] as String? ?? ''),
              ),
            );
          }

          await db.smartUpsertBeanV2(bean, translations);
          successCount++;
        } catch (e) {
          debugPrint(
            'SyncService: Error mapping encyclopedia entry ${item['id']}: $e',
          );
        }
      }

      // 3. Cleanup deleted
      await db.transaction(() async {
        await (db.delete(
          db.localizedBeanTranslationsV2,
        )..where((t) => t.beanId.isIn(remoteIds).not())).go();
        await (db.delete(
          db.localizedBeansV2,
        )..where((t) => t.id.isIn(remoteIds).not())).go();
      });

      debugPrint(
        'SyncService: Encyclopedia sync complete. Successfully synced $successCount entries.',
      );
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
      final item = await supabase!
          .from('encyclopedia_entries')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (item == null) return;

      final bean = LocalizedBeansV2Companion(
        id: Value(id),
        brandId: Value((item['brand_id'] as num?)?.toInt()),
        countryEmoji: Value(item['country_emoji'] as String? ?? ''),
        altitudeMin: Value((item['altitude_min'] as num?)?.toInt()),
        altitudeMax: Value((item['altitude_max'] as num?)?.toInt()),
        lotNumber: Value(item['lot_number'] as String? ?? ''),
        scaScore: Value(item['sca_score']?.toString() ?? '82+'),
        cupsScore: Value(
          double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0,
        ),
        sensoryJson: Value(
          item['sensory_json'] != null
              ? jsonEncode(item['sensory_json'])
              : '{}',
        ),
        priceJson: Value(
          item['price_json'] != null ? jsonEncode(item['price_json']) : '{}',
        ),
        plantationPhotosUrl: Value(_safeJson(item['plantation_photos_url'])),
        harvestSeason: Value(item['harvest_season'] as String? ?? ''),
        price: Value(item['price'] as String? ?? ''),
        weight: Value(item['weight'] as String? ?? ''),
        roastDate: Value(item['roast_date'] as String? ?? ''),
        processingMethodsJson: Value(
          _safeJson(item['processing_methods_json']),
        ),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        detailedProcessMarkdown: Value(
          item['detailed_process_markdown'] as String? ?? '',
        ),
        url: Value(item['url'] as String? ?? ''),
        farmerId: Value((item['farmer_id'] as num?)?.toInt()),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        farm: Value(item['farm'] as String?),
        farmPhotosUrlCover: Value(item['farm_photos_url_cover'] as String?),
        washStation: Value(item['wash_station'] as String?),
        retailPrice: Value(item['retail_price']?.toString()),
        wholesalePrice: Value(item['wholesale_price']?.toString()),
        flagUrl: Value(item['image_url'] as String? ?? ''),
        radarJson: Value(
          item['radar_json'] != null ? jsonEncode(item['radar_json']) : '{}',
        ),
        createdAt: Value(
          item['created_at'] != null
              ? DateTime.tryParse(item['created_at'] as String)
              : null,
        ),
      );

      final List<LocalizedBeanTranslationsV2Companion> translations = [];
      final transData = await supabase!
          .from('localized_bean_translations')
          .select()
          .eq('bean_id', id);

      for (final t in transData) {
        translations.add(
          LocalizedBeanTranslationsV2Companion(
            beanId: Value(id),
            languageCode: Value(t['language_code'] as String),
            country: Value(t['country'] as String?),
            region: Value(t['region'] as String?),
            varieties: Value(t['varieties'] as String?),
            flavorNotes: Value(_safeJson(t['flavor_notes'])),
            processMethod: Value(t['process_method'] as String?),
            description: Value(
              ContentUtils.cleanCoffeeContent(
                t['description'] as String? ?? '',
              ),
            ),
            farmDescription: Value(
              ContentUtils.cleanCoffeeContent(
                t['farm_description'] as String? ?? '',
              ),
            ),
            roastLevel: Value(t['roast_level'] as String?),
          ),
        );
      }

      // Fallback
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(
          LocalizedBeanTranslationsV2Companion(
            beanId: Value(id),
            languageCode: const Value('uk'),
            country: Value(item['country'] as String? ?? 'Unknown'),
            region: Value(item['region'] as String? ?? ''),
            varieties: Value(item['varieties'] as String? ?? ''),
            flavorNotes: Value(_safeJson(item['flavor_notes'])),
            processMethod: Value(item['process_method'] as String? ?? ''),
            description: Value(
              ContentUtils.cleanCoffeeContent(
                item['description'] as String? ?? '',
              ),
            ),
            farmDescription: Value(
              ContentUtils.cleanCoffeeContent(
                item['farm_description'] as String? ?? '',
              ),
            ),
            roastLevel: Value(item['roast_level'] as String? ?? ''),
          ),
        );
      }

      if (!translations.any((t) => t.languageCode.value == 'en')) {
        translations.add(
          LocalizedBeanTranslationsV2Companion(
            beanId: Value(id),
            languageCode: const Value('en'),
            country: Value(item['country'] as String? ?? 'Unknown'),
            region: Value(item['region'] as String? ?? ''),
            varieties: Value(item['varieties'] as String? ?? ''),
            flavorNotes: Value(_safeJson(item['flavor_notes'])),
            processMethod: Value(item['process_method'] as String? ?? ''),
            description: Value(
              ContentUtils.cleanCoffeeContent(
                item['description'] as String? ?? '',
              ),
            ),
            farmDescription: Value(
              ContentUtils.cleanCoffeeContent(
                item['farm_description'] as String? ?? '',
              ),
            ),
            roastLevel: Value(item['roast_level'] as String? ?? ''),
          ),
        );
      }

      await db.smartUpsertBeanV2(bean, translations);
      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint(
        'SyncService: Error in syncSingleEncyclopediaEntryV2 ($id): $e',
      );
    }
  }

  /// Syncs a single bean by ID.
  Future<void> syncSingleBean(int id) async {
    if (supabase == null) return;
    try {
      final item = await supabase!
          .from('encyclopedia_entries')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (item == null) return;

      String emoji = item['country_emoji'] as String? ?? '';
      final planetEmojis = [
        '🌎',
        '🌍',
        '🌏',
        '🪐',
        '☄️',
        '🌌',
        'planet',
        'earth',
      ];
      if (planetEmojis.contains(emoji.trim()) || emoji.isEmpty) {
        final countryLower =
            (item['country_uk'] as String? ??
                    item['country_en'] as String? ??
                    'unknown')
                .toLowerCase()
                .replaceAll(' ', '_');
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
        cupsScore: Value(
          double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0,
        ),
        sensoryJson: Value(
          item['sensory_json'] != null
              ? jsonEncode(item['sensory_json'])
              : '{}',
        ),
        priceJson: Value(
          item['price_json'] != null ? jsonEncode(item['price_json']) : '{}',
        ),
        retailPrice: Value(
          item['retail_price']?.toString() ?? item['price']?.toString(),
        ),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        url: Value(item['url'] as String? ?? ''),
        createdAt: Value(
          item['created_at'] != null
              ? DateTime.tryParse(item['created_at'] as String)
              : null,
        ),
      );

      final translationsData = await supabase!
          .from('localized_bean_translations')
          .select()
          .eq('bean_id', id);
      final List<LocalizedBeanTranslationsCompanion> translations =
          translationsData
              .map(
                (t) => LocalizedBeanTranslationsCompanion(
                  beanId: Value(id),
                  languageCode: Value(t['language_code'] as String),
                  country: Value(t['country'] as String?),
                  region: Value(t['region'] as String?),
                  varieties: Value(t['varieties'] as String?),
                  flavorNotes: Value(t['flavor_notes']?.toString() ?? '[]'),
                  processMethod: Value(t['process_method'] as String?),
                  description: Value(
                    ContentUtils.cleanCoffeeContent(
                      t['description'] as String? ?? '',
                    ),
                  ),
                  farmDescription: Value(
                    ContentUtils.cleanCoffeeContent(
                      t['farm_description'] as String? ?? '',
                    ),
                  ),
                  roastLevel: Value(t['roast_level'] as String?),
                ),
              )
              .toList();

      // Add 'uk' if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(
          LocalizedBeanTranslationsCompanion(
            beanId: Value(id),
            languageCode: const Value('uk'),
            country: Value(
              item['country_uk'] as String? ?? item['country_en'] as String?,
            ),
            region: Value(
              item['region_uk'] as String? ?? item['region_en'] as String?,
            ),
            varieties: Value(
              item['varieties_uk'] as String? ??
                  item['varieties_en'] as String?,
            ),
            flavorNotes: Value(
              item['flavor_notes_uk']?.toString() ??
                  item['flavor_notes_en']?.toString() ??
                  '[]',
            ),
            processMethod: Value(
              item['process_method_uk'] as String? ??
                  item['process_method_en'] as String?,
            ),
            description: Value(
              ContentUtils.cleanCoffeeContent(
                item['description_uk'] as String? ??
                    item['description_en'] as String? ??
                    '',
              ),
            ),
            roastLevel: Value(
              item['roast_level_uk'] as String? ??
                  item['roast_level_en'] as String?,
            ),
          ),
        );
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
        cupsScore: Value(
          double.tryParse(item['cups_score']?.toString() ?? '82.0') ?? 82.0,
        ),
        sensoryJson: Value(
          item['sensory_json'] != null
              ? jsonEncode(item['sensory_json'])
              : '{}',
        ),
        priceJson: Value(
          item['price_json'] != null ? jsonEncode(item['price_json']) : '{}',
        ),
        retailPrice: Value(
          item['retail_price']?.toString() ?? item['price']?.toString(),
        ),
        isPremium: Value(item['is_premium'] as bool? ?? false),
        isDecaf: Value(item['is_decaf'] as bool? ?? false),
        url: Value(item['url'] as String? ?? ''),
        createdAt: Value(
          item['created_at'] != null
              ? DateTime.tryParse(item['created_at'] as String)
              : null,
        ),
      );

      final List<LocalizedBeanTranslationsV2Companion> translationsV2 =
          translations
              .map(
                (t) => LocalizedBeanTranslationsV2Companion(
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
                ),
              )
              .toList();

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
      final item = await supabase!
          .from('brewing_recipes')
          .select()
          .eq('method_key', key)
          .maybeSingle();
      if (item == null) return;

      String methodImageUrl = item['image_url'] as String? ?? '';
      if (methodImageUrl.isNotEmpty &&
          !methodImageUrl.startsWith('http') &&
          !methodImageUrl.startsWith('assets/')) {
        methodImageUrl = '$methodsBucket${methodImageUrl.split('/').last}';
      }

      final recipeV1 = BrewingRecipesCompanion(
        methodKey: Value(key),
        imageUrl: Value(methodImageUrl),
        ratioGramsPerMl: Value(
          (item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066,
        ),
        tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
        totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
        difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
        flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
        iconName: Value(item['icon_name'] as String?),
        stepsJson: Value(
          item['steps_json'] is List
              ? jsonEncode(item['steps_json'])
              : (item['steps_json']?.toString() ?? '[]'),
        ),
      );

      final recipeV2 = BrewingRecipesV2Companion(
        methodKey: Value(key),
        imageUrl: Value(methodImageUrl),
        ratioGramsPerMl: Value(
          (item['ratio_grams_per_ml'] as num?)?.toDouble() ?? 0.066,
        ),
        tempC: Value((item['temp_c'] as num?)?.toDouble() ?? 93.0),
        totalTimeSec: Value((item['total_time_sec'] as num?)?.toInt() ?? 180),
        difficulty: Value(item['difficulty'] as String? ?? 'Intermediate'),
        flavorProfile: Value(item['flavor_profile'] as String? ?? 'Balanced'),
        iconName: Value(item['icon_name'] as String?),
        stepsJson: Value(
          item['steps_json'] is List
              ? jsonEncode(item['steps_json'])
              : (item['steps_json']?.toString() ?? '[]'),
        ),
      );

      final transData = await supabase!
          .from('brewing_recipe_translations')
          .select()
          .eq('recipe_key', key);

      final List<BrewingRecipeTranslationsCompanion> translationsV1 = [];
      final List<BrewingRecipeTranslationsV2Companion> translationsV2 = [];

      for (final t in transData) {
        final lang = t['language_code'] as String;
        final name = t['name'] as String?;
        final desc = ContentUtils.cleanCoffeeContent(
          t['description'] as String? ?? '',
        );

        translationsV1.add(
          BrewingRecipeTranslationsCompanion(
            recipeKey: Value(key),
            languageCode: Value(lang),
            name: Value(name),
            description: Value(desc),
          ),
        );

        translationsV2.add(
          BrewingRecipeTranslationsV2Companion(
            recipeKey: Value(key),
            languageCode: Value(lang),
            name: Value(name),
            description: Value(desc),
          ),
        );
      }

      // Add 'uk' if missing
      if (!translationsV1.any((t) => t.languageCode.value == 'uk')) {
        final name =
            item['name_uk'] as String? ?? item['name'] as String? ?? key;
        final desc = ContentUtils.cleanCoffeeContent(
          item['description_uk'] as String? ??
              item['description'] as String? ??
              '',
        );

        translationsV1.add(
          BrewingRecipeTranslationsCompanion(
            recipeKey: Value(key),
            languageCode: const Value('uk'),
            name: Value(name),
            description: Value(desc),
          ),
        );
        translationsV2.add(
          BrewingRecipeTranslationsV2Companion(
            recipeKey: Value(key),
            languageCode: const Value('uk'),
            name: Value(name),
            description: Value(desc),
          ),
        );
      }

      await db.smartUpsertBrewingRecipe(recipeV1, translationsV1);
      await db.smartUpsertBrewingRecipeV2(recipeV2, translationsV2);
      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint('SyncService: Error in syncSingleBrewingRecipe ($key): $e');
    }
  }

  /// Syncs a single brand by ID.
  Future<void> syncSingleBrand(int id) async {
    if (supabase == null) return;
    try {
      var item = await supabase!
          .from('brands')
          .select()
          .eq('id', id)
          .maybeSingle();
      item ??= await supabase!
          .from('localized_brands')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (item == null) return;

      final translationsData = await supabase!
          .from('localized_brand_translations')
          .select()
          .eq('brand_id', id);

      final companion = LocalizedBrandsCompanion(
        id: Value(id),
        name: Value(item['name'] as String? ?? ''),
        logoUrl: Value(item['logo_url'] as String?),
        siteUrl: Value(item['site_url'] as String?),
      );

      final List<LocalizedBrandTranslationsCompanion> translations =
          translationsData
              .map(
                (t) => LocalizedBrandTranslationsCompanion(
                  brandId: Value(id),
                  languageCode: Value(t['language_code'] as String),
                  shortDesc: Value(t['short_desc'] as String?),
                  fullDesc: Value(t['full_desc'] as String?),
                  location: Value(t['location'] as String?),
                ),
              )
              .toList();

      // Add 'uk' fallback if missing
      if (!translations.any((t) => t.languageCode.value == 'uk')) {
        translations.add(
          LocalizedBrandTranslationsCompanion(
            brandId: Value(id),
            languageCode: const Value('uk'),
            shortDesc: Value(
              ContentUtils.cleanCoffeeContent(
                item['short_desc_uk'] as String? ??
                    item['short_desc'] as String? ??
                    '',
              ),
            ),
            fullDesc: Value(
              ContentUtils.cleanCoffeeContent(
                item['full_desc_uk'] as String? ??
                    item['full_desc'] as String? ??
                    '',
              ),
            ),
            location: Value(
              ContentUtils.cleanCoffeeContent(
                item['location_uk'] as String? ??
                    item['location'] as String? ??
                    '',
              ),
            ),
          ),
        );
      }

      await db.smartUpsertBrand(companion, translations);
      _dataUpdateController.add(null);
    } catch (e) {
      debugPrint('SyncService: Error in syncSingleBrand ($id): $e');
    }
  }

  /// Converts any difficulty representation to canonical numeric string '1'–'5'.
  String _normalizeDifficulty(dynamic raw) {
    final s = (raw?.toString() ?? '').toLowerCase().trim();
    switch (s) {
      case '1':
      case 'easy':
      case 'beginner':
        return '1';
      case '2':
      case 'medium':
      case 'intermediate':
        return '2';
      case '3':
      case 'hard':
      case 'advanced':
        return '3';
      case '4':
      case 'expert':
        return '4';
      case '5':
      case 'master':
        return '5';
      default:
        final n = int.tryParse(s);
        if (n != null && n >= 1 && n <= 5) return n.toString();
        return '2'; // default to intermediate
    }
  }
}
