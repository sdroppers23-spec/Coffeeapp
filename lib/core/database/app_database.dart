import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'connection/connection.dart';
import 'tables.dart';
import 'dtos.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    LocalizedBeans,
    LocalizedBeanTranslations,
    LocalizedBrands,
    LocalizedBrandTranslations,
    LocalizedFarmers,
    LocalizedFarmerTranslations,
    SphereRegions,
    SphereRegionTranslations,
    SpecialtyArticles,
    SpecialtyArticleTranslations,
    CoffeeLots,
    FermentationLogs,
    BrewingRecipes,
    BrewingRecipeTranslations,
    RecommendedRecipes,
    UserLotRecipes,
    EncyclopediaRecipes,
    AlternativeRecipes,
    // V2 Tables
    LocalizedFarmersV2,
    LocalizedFarmerTranslationsV2,
    SpecialtyArticlesV2,
    SpecialtyArticleTranslationsV2,
    LocalizedBeansV2,
    LocalizedBeanTranslationsV2,
    BrewingRecipeTranslationsV2,
    BrewingRecipesV2,
    AlternativeBrewing,
    AlternativeBrewingTranslations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 49;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 29) {
        // Migration for story columns in Farmers
        await transaction(() async {
          // recreate farmers or just add column, but recreation is safer for this state
          await customStatement('DROP TABLE IF EXISTS localized_farmers;');
          await customStatement(
            'DROP TABLE IF EXISTS localized_farmer_translations;',
          );

          await m.createTable(localizedFarmers);
          await m.createTable(localizedFarmerTranslations);

          // Force recreation of articles/beans/recipes to ensure they are consistent after parallel sync failures
          await customStatement('DROP TABLE IF EXISTS specialty_articles;');
          await customStatement(
            'DROP TABLE IF EXISTS specialty_article_translations;',
          );
          await customStatement('DROP TABLE IF EXISTS localized_beans;');
          await customStatement('DROP TABLE IF EXISTS brewing_recipes;');

          await m.createTable(specialtyArticles);
          await m.createTable(specialtyArticleTranslations);
          await m.createTable(localizedBeans);
          await m.createTable(brewingRecipes);
        });
      }
      if (from < 31) {
        // v31: Add advanced recipe columns
        // NOTE: Table renamed to userLotRecipes in v48
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.recipeType);
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.brewRatio);
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.grinderName);
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.microns);
      }
      if (from < 32) {
        // v32: Add sync flags to brands
        await _safeAddColumn(m, localizedBrands, localizedBrands.isSynced);
        await _safeAddColumn(
          m,
          localizedBrands,
          localizedBrands.isDeletedLocal,
        );
      }
      if (from < 33) {
        // v33: Add favorite/archive support for brands
        await _safeAddColumn(m, localizedBrands, localizedBrands.isFavorite);
        await _safeAddColumn(m, localizedBrands, localizedBrands.isArchived);
      }
      if (from < 34) {
        // v34: Create V2 tables
        await m.createTable(localizedFarmersV2);
        await m.createTable(localizedFarmerTranslationsV2);
        await m.createTable(specialtyArticlesV2);
        await m.createTable(specialtyArticleTranslationsV2);
        await m.createTable(localizedBeansV2);
        await m.createTable(localizedBeanTranslationsV2);
        await m.createTable(brewingRecipesV2);
        await m.createTable(brewingRecipeTranslationsV2);
      }
      if (from < 35) {
        // v35: Add flagUrl to encyclopedia beans
        await _safeAddColumn(m, localizedBeansV2, localizedBeansV2.flagUrl);
      }
      if (from < 36) {
        // v35: Add radarJson to encyclopedia beans
        await _safeAddColumn(m, localizedBeansV2, localizedBeansV2.radarJson);
      }
      if (from < 37) {
        await _safeAddColumn(
          m,
          localizedBeansV2,
          localizedBeansV2.userPriceJson,
        );
      }
      if (from < 38) {
        // v38: Add category column to brewing recipes
        await _safeAddColumn(m, brewingRecipes, brewingRecipes.category);
        await _safeAddColumn(m, brewingRecipesV2, brewingRecipesV2.category);
      }
      if (from < 39) {
        // v39: Add extractionTimeSeconds to custom recipes
        // NOTE: Table renamed to userLotRecipes in v48
        await _safeAddColumn(
          m,
          userLotRecipes,
          userLotRecipes.extractionTimeSeconds,
        );
      }
      if (from < 40) {
        // v40: Add isFavorite and isArchived to custom recipes
        // NOTE: Table renamed to userLotRecipes in v48
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.isFavorite);
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.isArchived);
      }
      if (from < 41) {
        // v41: Add difficulty to custom recipes
        // NOTE: Table renamed to userLotRecipes in v48
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.difficulty);
      }
      if (from < 42) {
        // v42: Create AlternativeBrewing tables
        await m.createTable(alternativeBrewing);
        await m.createTable(alternativeBrewingTranslations);
      }
      if (from < 43) {
        // v43: Add new columns to AlternativeBrewing
        await _safeAddColumn(m, alternativeBrewing, alternativeBrewing.nameUk);
        await _safeAddColumn(
          m,
          alternativeBrewing,
          alternativeBrewing.sortOrder,
        );
        await _safeAddColumn(m, alternativeBrewing, alternativeBrewing.isHiden);
        await _safeAddColumn(m, alternativeBrewing, alternativeBrewing.weight);
        await _safeAddColumn(
          m,
          alternativeBrewing,
          alternativeBrewing.coffeeGrams,
        );
      }
      if (from < 44) {
        // v44: Add contentHtml to CustomRecipes
        // NOTE: Table renamed to userLotRecipes in v48
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.contentHtml);
      }
      if (from < 45) {
        // v45: Add contentHtml to brewing method translations (raw SQL — TextColumn type mismatch with _safeAddColumn)
        try {
          await customStatement(
            'ALTER TABLE brewing_recipe_translations ADD COLUMN content_html TEXT;',
          );
        } catch (_) {}
        try {
          await customStatement(
            'ALTER TABLE brewing_recipe_translations_v2 ADD COLUMN content_html TEXT;',
          );
        } catch (_) {}
      }
      if (from < 46) {
        // v46: Add contentHtml to AlternativeBrewingTranslations
        try {
          await customStatement(
            'ALTER TABLE alternative_brewing_translations ADD COLUMN content_html TEXT;',
          );
        } catch (_) {}
      }
      if (from < 47) {
        // v47: Add contentHtml to AlternativeBrewing main table
        try {
          await customStatement(
            'ALTER TABLE alternative_brewing ADD COLUMN content_html TEXT;',
          );
        } catch (_) {}
      }
      if (from < 48) {
        // v48: Rename CustomRecipes and add Encyclopedia/Alternative tables
        debugPrint('AppDatabase: Migrating to v48...');
        try {
          await customStatement('ALTER TABLE custom_recipes RENAME TO user_lot_recipes;');
          debugPrint('AppDatabase: Renamed custom_recipes to user_lot_recipes');
        } catch (e) {
          debugPrint('AppDatabase: Could not rename table (maybe already renamed?): $e');
          // If table doesn't exist or already renamed, ensure it exists
          await m.createTable(userLotRecipes);
        }
        await m.createTable(encyclopediaRecipes);
        await m.createTable(alternativeRecipes);
        debugPrint('AppDatabase: Migration to v48 completed');
      }
      if (from < 49) {
        // v49: Add customMethodName to all recipe tables
        await _safeAddColumn(m, userLotRecipes, userLotRecipes.customMethodName);
        await _safeAddColumn(m, encyclopediaRecipes, encyclopediaRecipes.customMethodName);
        await _safeAddColumn(m, alternativeRecipes, alternativeRecipes.customMethodName);
        debugPrint('AppDatabase: Migration to v49 completed');
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  // ── Specialty Articles ───────────────────────────────────────────────────────

  Future<bool> encyclopediaIsEmpty() async =>
      (await select(localizedBeansV2).get()).isEmpty;

  Future<bool> farmersIsEmpty() async =>
      (await select(localizedFarmersV2).get()).isEmpty;

  Future<bool> specialtyArticlesIsEmpty() async =>
      (await select(specialtyArticlesV2).get()).isEmpty;

  // ── Farmers ──────────────────────────────────────────────────────────────────
  // ── Farmers (Wide Table) ───────────────────────────────────────────────────
  /// Reads from V2 table (populated by SyncService V2).
  Future<List<LocalizedFarmerDto>> getAllFarmers(String lang) =>
      getAllFarmersV2(lang);

  // ── V2 Methods ──────────────────────────────────────────────────────────────

  Future<List<LocalizedFarmerDto>> getAllFarmersV2(String lang) async {
    final query = select(localizedFarmersV2).join([
      leftOuterJoin(
        localizedFarmerTranslationsV2,
        localizedFarmerTranslationsV2.farmerId.equalsExp(
              localizedFarmersV2.id,
            ) &
            localizedFarmerTranslationsV2.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      final f = row.readTable(localizedFarmersV2);
      final t = row.readTableOrNull(localizedFarmerTranslationsV2);

      return LocalizedFarmerDto(
        id: f.id,
        imageUrl: f.imageUrl,
        flagUrl: f.flagUrl,
        name: t?.name ?? 'Unknown',
        region: t?.region ?? '',
        country: t?.country ?? '',
        descriptionHtml: t?.descriptionHtml ?? '',
        story: t?.story ?? '',
        latitude: f.latitude,
        longitude: f.longitude,
        createdAt: f.createdAt,
      );
    }).toList();
  }

  Future<void> smartUpsertFarmerV2(
    LocalizedFarmersV2Companion f,
    List<LocalizedFarmerTranslationsV2Companion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedFarmersV2, [f]);
      batch.insertAllOnConflictUpdate(
        localizedFarmerTranslationsV2,
        translations,
      );
    });
  }

  Future<List<SpecialtyArticleDto>> getAllArticlesV2(String lang) async {
    final query = select(specialtyArticlesV2).join([
      leftOuterJoin(
        specialtyArticleTranslationsV2,
        specialtyArticleTranslationsV2.articleId.equalsExp(
              specialtyArticlesV2.id,
            ) &
            specialtyArticleTranslationsV2.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      final a = row.readTable(specialtyArticlesV2);
      final t = row.readTableOrNull(specialtyArticleTranslationsV2);

      return SpecialtyArticleDto(
        id: a.id,
        title: t?.title ?? 'Untitled',
        subtitle: t?.subtitle ?? '',
        imageUrl: a.imageUrl,
        flagUrl: a.flagUrl,
        contentHtml: t?.contentHtml ?? '',
        readTimeMin: a.readTimeMin,
      );
    }).toList();
  }

  Future<void> smartUpsertArticleV2(
    SpecialtyArticlesV2Companion a,
    List<SpecialtyArticleTranslationsV2Companion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(specialtyArticlesV2, [a]);
      batch.insertAllOnConflictUpdate(
        specialtyArticleTranslationsV2,
        translations,
      );
    });
  }

  Future<List<LocalizedBeanDto>> getEncyclopediaV2(String lang) async {
    final query = select(localizedBeansV2).join([
      leftOuterJoin(
        localizedBeanTranslationsV2,
        localizedBeanTranslationsV2.beanId.equalsExp(localizedBeansV2.id) &
            localizedBeanTranslationsV2.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) => _mapBeanV2Row(row, lang)).toList();
  }

  // Alias methods for compatibility
  Future<List<LocalizedBeanDto>> getAllBeans(String lang) =>
      getEncyclopediaV2(lang);
  Future<List<LocalizedBeanDto>> getAllEncyclopediaEntries(String lang) =>
      getEncyclopediaV2(lang);

  LocalizedBeanDto _mapBeanV2Row(TypedResult row, String lang) {
    final bean = row.readTable(localizedBeansV2);
    final trans = row.readTableOrNull(localizedBeanTranslationsV2);

    final sensoryRaw = _parseJson(bean.sensoryJson);
    final Map<String, dynamic> flattenedSensory = {};
    if (sensoryRaw.containsKey('indicators')) {
      final indicators = sensoryRaw['indicators'];
      if (indicators is Map<String, dynamic>) {
        flattenedSensory.addAll(indicators);
      }
    }
    flattenedSensory.addAll(sensoryRaw);

    return LocalizedBeanDto(
      id: bean.id,
      brandId: bean.brandId,
      countryEmoji: bean.countryEmoji,
      altitudeMin: bean.altitudeMin,
      altitudeMax: bean.altitudeMax,
      lotNumber: bean.lotNumber,
      scaScore: bean.scaScore,
      cupsScore: bean.cupsScore,
      sensoryPoints: flattenedSensory,
      pricing: _parseJson(bean.priceJson),
      plantationPhotos: _parseList<String>(bean.plantationPhotosUrl),
      isPremium: bean.isPremium,
      detailedProcess: bean.detailedProcessMarkdown,
      url: bean.url,
      farmerId: bean.farmerId,
      isDecaf: bean.isDecaf,
      farm: bean.farm,
      farmPhotosUrlCover: bean.farmPhotosUrlCover,
      washStation: bean.washStation,
      retailPrice: bean.retailPrice,
      wholesalePrice: bean.wholesalePrice,
      harvestSeason: bean.harvestSeason,
      price: bean.price,
      weight: bean.weight,
      roastDate: bean.roastDate,
      processingMethodsJson: bean.processingMethodsJson,
      country: trans?.country ?? 'Unknown',
      region: trans?.region ?? '',
      varieties: trans?.varieties ?? '',
      flavorNotes: _parseList<String>(trans?.flavorNotes ?? '[]'),
      description: trans?.description ?? '',
      farmDescription: trans?.farmDescription ?? '',
      roastLevel: trans?.roastLevel ?? '',
      processMethod: trans?.processMethod ?? '',
      isFavorite: bean.isFavorite,
      isArchived: false,
      flagUrl: bean.flagUrl,
      radarPoints: _parseJson(
        bean.radarJson,
      ).map((k, v) => MapEntry(k, (v as num).toDouble())),
      userPricing: _parseJson(bean.userPriceJson),
      createdAt: bean.createdAt,
    );
  }

  Future<void> smartUpsertBeanV2(
    LocalizedBeansV2Companion bean,
    List<LocalizedBeanTranslationsV2Companion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedBeansV2, [bean]);
      batch.insertAllOnConflictUpdate(
        localizedBeanTranslationsV2,
        translations,
      );
    });
  }

  Future<void> smartUpsertBrewingRecipeV2(
    BrewingRecipesV2Companion recipe,
    List<BrewingRecipeTranslationsV2Companion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(brewingRecipesV2, [recipe]);
      batch.insertAllOnConflictUpdate(
        brewingRecipeTranslationsV2,
        translations,
      );
    });
  }

  Future<List<BrewingRecipeDto>> getAllBrewingRecipesV2(String lang) async {
    final query = select(brewingRecipesV2).join([
      leftOuterJoin(
        brewingRecipeTranslationsV2,
        brewingRecipeTranslationsV2.recipeKey.equalsExp(
              brewingRecipesV2.methodKey,
            ) &
            brewingRecipeTranslationsV2.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      final recipe = row.readTable(brewingRecipesV2);
      final translation = row.readTableOrNull(brewingRecipeTranslationsV2);

      return BrewingRecipeDto(
        id: recipe.id,
        methodKey: recipe.methodKey,
        name: translation?.name ?? 'Unknown',
        description: translation?.description ?? '',
        imageUrl: recipe.imageUrl,
        ratioGramsPerMl: recipe.ratioGramsPerMl,
        tempC: recipe.tempC,
        totalTimeSec: recipe.totalTimeSec,
        difficulty: recipe.difficulty,
        stepsJson: recipe.stepsJson,
        flavorProfile: recipe.flavorProfile,
        iconName: recipe.iconName,
        category: recipe.category,
        contentHtml: row.read(brewingRecipeTranslationsV2.contentHtml) ?? '',
      );
    }).toList();
  }

  Future<void> smartUpsertAlternativeBrewing(
    AlternativeBrewingCompanion recipe,
    List<AlternativeBrewingTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insert(
        alternativeBrewing,
        recipe,
        onConflict: DoUpdate(
          (old) => recipe,
          target: [alternativeBrewing.methodKey],
        ),
      );
      batch.insertAllOnConflictUpdate(
        alternativeBrewingTranslations,
        translations,
      );
    });
  }

  Future<List<AlternativeBrewingDto>> getAllAlternativeBrewing(
    String lang,
  ) async {
    final query =
        select(alternativeBrewing).join([
            leftOuterJoin(
              alternativeBrewingTranslations,
              alternativeBrewingTranslations.recipeKey.equalsExp(
                    alternativeBrewing.methodKey,
                  ) &
                  alternativeBrewingTranslations.languageCode.equals(lang),
            ),
          ])
          ..where(
            alternativeBrewing.isHiden.equals(false) &
                alternativeBrewing.isDeletedLocal.equals(false),
          )
          ..orderBy([OrderingTerm.asc(alternativeBrewing.sortOrder)]);

    final rows = await query.get();
    return rows.map((row) {
      final recipe = row.readTable(alternativeBrewing);
      final translation = row.readTableOrNull(alternativeBrewingTranslations);

      return AlternativeBrewingDto(
        id: recipe.id,
        methodKey: recipe.methodKey,
        name: recipe.nameUk?.isNotEmpty == true
            ? recipe.nameUk!
            : (translation?.name ?? 'Unknown'),
        description: translation?.description ?? '',
        contentHtml: translation?.contentHtml?.isNotEmpty == true
            ? translation!.contentHtml!
            : (recipe.contentHtml ?? ''),
        imageUrl: recipe.imageUrl ?? '',
        ratioGramsPerMl: recipe.ratioGramsPerMl,
        tempC: recipe.tempC,
        totalTimeSec: recipe.totalTimeSec,
        difficulty: recipe.difficulty,
        stepsJson: recipe.stepsJson,
        flavorProfile: recipe.flavorProfile,
        iconName: recipe.iconName,
        category: recipe.category,
        weight: recipe.weight,
        coffeeGrams: recipe.coffeeGrams,
        nameUk: recipe.nameUk,
        sortOrder: recipe.sortOrder,
        isHiden: recipe.isHiden,
      );
    }).toList();
  }

  // ── Brands ───────────────────────────────────────────────────────────────────
  Future<List<LocalizedBrandDto>> getAllBrands(
    String userId, [
    String lang = 'uk',
  ]) async {
    final query =
        select(localizedBrands).join([
          leftOuterJoin(
            localizedBrandTranslations,
            localizedBrandTranslations.brandId.equalsExp(localizedBrands.id) &
                localizedBrandTranslations.languageCode.equals(lang),
          ),
        ])..where(
          (localizedBrands.userId.equals(userId) |
                  localizedBrands.userId.isNull()) &
              localizedBrands.isDeletedLocal.equals(false),
        );

    final rows = await query.get();
    return rows.map((row) {
      final brand = row.readTable(localizedBrands);
      final translation = row.readTableOrNull(localizedBrandTranslations);

      return LocalizedBrandDto(
        id: brand.id,
        name: brand.name,
        logoUrl: brand.logoUrl ?? '',
        siteUrl: brand.siteUrl ?? '',
        shortDesc: translation?.shortDesc ?? '',
        fullDesc: translation?.fullDesc ?? '',
        location: translation?.location ?? '',
        isFavorite: brand.isFavorite,
        isArchived: brand.isArchived,
      );
    }).toList();
  }

  Future<LocalizedBrandDto?> getBrandById(int id, String lang) async {
    final query = select(localizedBrands).join([
      leftOuterJoin(
        localizedBrandTranslations,
        localizedBrandTranslations.brandId.equalsExp(localizedBrands.id) &
            localizedBrandTranslations.languageCode.equals(lang),
      ),
    ])..where(localizedBrands.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final brand = row.readTable(localizedBrands);
    final translation = row.readTableOrNull(localizedBrandTranslations);

    return LocalizedBrandDto(
      id: brand.id,
      name: brand.name,
      logoUrl: brand.logoUrl ?? '',
      siteUrl: brand.siteUrl ?? '',
      shortDesc: translation?.shortDesc ?? '',
      fullDesc: translation?.fullDesc ?? '',
      location: translation?.location ?? '',
      isFavorite: brand.isFavorite,
      isArchived: brand.isArchived,
    );
  }

  Future<void> smartUpsertFarmer(
    LocalizedFarmersCompanion farmer,
    List<LocalizedFarmerTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedFarmers, [farmer]);
      batch.insertAllOnConflictUpdate(localizedFarmerTranslations, translations);
    });
  }

  Future<void> smartUpsertBrand(
    LocalizedBrandsCompanion brand,
    List<LocalizedBrandTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedBrands, [brand]);
      batch.insertAllOnConflictUpdate(localizedBrandTranslations, translations);
    });
  }

  Future<int> addBrand(
    String userId,
    String name,
    String location,
    String shortDesc,
  ) async {
    final res = await into(localizedBrands).insert(
      LocalizedBrandsCompanion.insert(
        userId: Value(userId),
        name: name,
        createdAt: Value(DateTime.now()),
        isSynced: const Value(false),
      ),
    );

    await insertBrandTranslation(
      LocalizedBrandTranslationsCompanion.insert(
        brandId: res,
        languageCode: 'uk',
        shortDesc: Value(shortDesc),
        location: Value(location),
      ),
    );
    return res;
  }

  Future<int> insertBrand(LocalizedBrandsCompanion b) =>
      into(localizedBrands).insertOnConflictUpdate(b);

  Future<int> insertBrandTranslation(LocalizedBrandTranslationsCompanion t) =>
      into(localizedBrandTranslations).insertOnConflictUpdate(t);

  Future<int> upsertLocalizedBrand(LocalizedBrandsCompanion b) =>
      insertBrand(b);

  Future<int> upsertLocalizedBrandTranslation(
    LocalizedBrandTranslationsCompanion t,
  ) => insertBrandTranslation(t);

  Future<bool> brandsIsEmpty() async {
    final countExp = localizedBrands.id.count();
    final query = selectOnly(localizedBrands)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return (result ?? 0) == 0;
  }

  Future<bool> farmersV2IsEmpty() async {
    final countExp = localizedFarmersV2.id.count();
    final query = selectOnly(localizedFarmersV2)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return (result ?? 0) == 0;
  }

  Future<LocalizedBrandTranslation?> getBrandTranslation(
    int brandId,
    String lang,
  ) =>
      (select(localizedBrandTranslations)..where(
            (t) => t.brandId.equals(brandId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

  Future<int> deleteBrand(int id) =>
      (update(localizedBrands)..where((t) => t.id.equals(id))).write(
        const LocalizedBrandsCompanion(
          isDeletedLocal: Value(true),
          isSynced: Value(false),
        ),
      );

  Future<void> toggleBrandFavorite(int id, bool val) async {
    await (update(localizedBrands)..where((t) => t.id.equals(id))).write(
      LocalizedBrandsCompanion(
        isFavorite: Value(val),
        isSynced: const Value(false),
      ),
    );
  }

  Future<void> toggleBrandArchive(int id, bool val) async {
    await (update(localizedBrands)..where((t) => t.id.equals(id))).write(
      LocalizedBrandsCompanion(
        isArchived: Value(val),
        isSynced: const Value(false),
      ),
    );
  }

  // Helper methods to clear data
  Future<void> clearFarmers() async {
    await delete(localizedFarmers).go();
  }

  Future<void> clearSpecialtyArticles() async {
    await delete(specialtyArticles).go();
  }

  // ── Origins / Beans ──────────────────────────────────────────────────────────
  Future<List<LocalizedBeanDto>> getAllOrigins(String lang) =>
      getEncyclopediaV2(lang);

  /// Watches V2 table (populated by SyncService V2).
  Stream<List<LocalizedBeanDto>> watchAllEncyclopediaEntries(String lang) {
    // Join with translations, fall back to "en" if current lang is not found
    final query = select(localizedBeansV2).join([
      leftOuterJoin(
        localizedBeanTranslationsV2,
        localizedBeanTranslationsV2.beanId.equalsExp(localizedBeansV2.id) &
            localizedBeanTranslationsV2.languageCode.equals(lang),
      ),
    ]);

    return query.watch().map((rows) {
      debugPrint(
        'AppDatabase: watchAllEncyclopediaEntries found ${rows.length} rows for lang $lang',
      );
      if (rows.isNotEmpty) {
        final first = rows.first.readTable(localizedBeansV2);
        debugPrint('AppDatabase: Sample row ID: ${first.id}');
      }
      return rows.map((row) => _mapBeanV2Row(row, lang)).toList();
    });
  }

  Future<List<LocalizedBeanDto>> getBeansByBrand(
    int brandId,
    String lang,
  ) async {
    final query = select(localizedBeans).join([
      leftOuterJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id) &
            localizedBeanTranslations.languageCode.equals(lang),
      ),
    ])..where(localizedBeans.brandId.equals(brandId));

    final rows = await query.get();
    return rows.map((row) => _mapBeanRow(row, lang)).toList();
  }

  Future<void> smartUpsertBean(
    LocalizedBeansCompanion bean,
    List<LocalizedBeanTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedBeans, [bean]);
      batch.insertAllOnConflictUpdate(localizedBeanTranslations, translations);
    });
  }

  Future<int> insertBean(LocalizedBeansCompanion b) =>
      into(localizedBeans).insertOnConflictUpdate(b);

  Future<int> insertOrigin(LocalizedBeansCompanion b) => insertBean(b);

  Future<int> insertBeanTranslation(LocalizedBeanTranslationsCompanion t) =>
      into(localizedBeanTranslations).insertOnConflictUpdate(t);

  Future<int> upsertLocalizedBean(LocalizedBeansCompanion b) => insertBean(b);

  Future<int> upsertLocalizedBeanTranslation(
    LocalizedBeanTranslationsCompanion t,
  ) => into(localizedBeanTranslations).insertOnConflictUpdate(t);

  Future<LocalizedBeanDto?> getBeanById(int id, String lang) async {
    final query = select(localizedBeansV2).join([
      leftOuterJoin(
        localizedBeanTranslationsV2,
        localizedBeanTranslationsV2.beanId.equalsExp(localizedBeansV2.id) &
            localizedBeanTranslationsV2.languageCode.equals(lang),
      ),
    ])..where(localizedBeansV2.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapBeanV2Row(row, lang);
  }

  Stream<LocalizedBeanDto?> watchBeanById(int id, String lang) {
    final query = select(localizedBeansV2).join([
      leftOuterJoin(
        localizedBeanTranslationsV2,
        localizedBeanTranslationsV2.beanId.equalsExp(localizedBeansV2.id) &
            localizedBeanTranslationsV2.languageCode.equals(lang),
      ),
    ])..where(localizedBeansV2.id.equals(id));

    return query.watchSingleOrNull().map(
      (row) => row != null ? _mapBeanV2Row(row, lang) : null,
    );
  }

  Future<LocalizedBeanTranslation?> getBeanTranslation(
    int beanId,
    String lang,
  ) =>
      (select(localizedBeanTranslations)..where(
            (t) => t.beanId.equals(beanId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

  Future<void> toggleFavorite(int beanId, bool isFavorite) async {
    await into(localizedBeansV2).insertOnConflictUpdate(
      LocalizedBeansV2Companion(
        id: Value(beanId),
        isFavorite: Value(isFavorite),
      ),
    );
  }

  Stream<Set<int>> watchFavoriteIds() {
    final query = selectOnly(localizedBeansV2)
      ..addColumns([localizedBeansV2.id])
      ..where(localizedBeansV2.isFavorite.equals(true));
    return query.watch().map(
      (rows) => rows.map((r) => r.read(localizedBeansV2.id)!).toSet(),
    );
  }

  LocalizedBeanDto _mapBeanRow(TypedResult row, String lang) {
    final bean = row.readTable(localizedBeans);
    final translation = row.readTableOrNull(localizedBeanTranslations);

    return LocalizedBeanDto(
      id: bean.id,
      brandId: bean.brandId,
      countryEmoji: bean.countryEmoji,
      altitudeMin: bean.altitudeMin,
      altitudeMax: bean.altitudeMax,
      lotNumber: bean.lotNumber,
      scaScore: bean.scaScore,
      cupsScore: bean.cupsScore,
      sensoryPoints: _parseJson(bean.sensoryJson),
      pricing: _parseJson(bean.priceJson),
      plantationPhotos: _parseList<String>(bean.plantationPhotosUrl),
      isPremium: bean.isPremium,
      detailedProcess: bean.detailedProcessMarkdown,
      url: bean.url,
      farmerId: bean.farmerId,
      isDecaf: bean.isDecaf,
      farm: bean.farm,
      farmPhotosUrlCover: bean.farmPhotosUrlCover,
      washStation: bean.washStation,
      retailPrice: bean.retailPrice,
      wholesalePrice: bean.wholesalePrice,
      harvestSeason: bean.harvestSeason,
      price: bean.price,
      weight: bean.weight,
      roastDate: bean.roastDate,
      processingMethodsJson: bean.processingMethodsJson,
      country: translation?.country ?? '',
      region: translation?.region ?? '',
      varieties: translation?.varieties ?? '',
      flavorNotes: _parseList<String>(translation?.flavorNotes ?? '[]'),
      description: translation?.description ?? '',
      farmDescription: translation?.farmDescription ?? '',
      roastLevel: translation?.roastLevel ?? '',
      processMethod: translation?.processMethod ?? '',
      isFavorite: bean.isFavorite,
      createdAt: bean.createdAt,
    );
  }

  // ── Smart Upsert & Conflicts ────────────────────────────────────────────────
  // ── Recommended Recipes ──────────────────────────────────────────────────────
  Future<List<RecommendedRecipeDto>> getRecommendedRecipesForLot(
    int lotId,
  ) async {
    final query = select(recommendedRecipes)
      ..where((t) => t.lotId.equals(lotId));
    final rows = await query.get();
    return rows
        .map(
          (r) => RecommendedRecipeDto(
            id: r.id,
            lotId: r.lotId,
            methodKey: r.methodKey,
            coffeeGrams: r.coffeeGrams,
            waterGrams: r.waterGrams,
            tempC: r.tempC,
            timeSec: r.timeSec,
            rating: r.rating,
            sensoryPoints: _parseJson(r.sensoryJson),
            notes: r.notes,
          ),
        )
        .toList();
  }

  Future<List<RecommendedRecipeDto>> getRecommendedRecipesForMethod(
    String methodKey,
  ) async {
    final query = select(recommendedRecipes)
      ..where((t) => t.methodKey.equals(methodKey));
    final rows = await query.get();
    return rows
        .map(
          (r) => RecommendedRecipeDto(
            id: r.id,
            lotId: r.lotId,
            methodKey: r.methodKey,
            coffeeGrams: r.coffeeGrams,
            waterGrams: r.waterGrams,
            tempC: r.tempC,
            timeSec: r.timeSec,
            rating: r.rating,
            sensoryPoints: _parseJson(r.sensoryJson),
            notes: r.notes,
          ),
        )
        .toList();
  }

  Future<int> insertRecommendedRecipe(RecommendedRecipesCompanion r) =>
      into(recommendedRecipes).insertOnConflictUpdate(r);

  Future<int> upsertRecommendedRecipe(RecommendedRecipesCompanion r) =>
      insertRecommendedRecipe(r);

  Future<int> insertRecipe(RecommendedRecipesCompanion r) =>
      insertRecommendedRecipe(r);

  // ── Articles ────────────────────────────────────────────────────────────────
  // ── Articles (Wide Table) ──────────────────────────────────────────────────
  Future<void> smartUpsertArticle(
    SpecialtyArticlesCompanion article,
    List<SpecialtyArticleTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(specialtyArticles, [article]);
      batch.insertAllOnConflictUpdate(
        specialtyArticleTranslations,
        translations,
      );
    });
  }

  /// Reads from V2 table (populated by SyncService V2).
  Future<List<SpecialtyArticleDto>> getAllArticles(String lang) =>
      getAllArticlesV2(lang);

  Future<int> deleteBeansForBrand(int brandId) =>
      (delete(localizedBeans)..where((t) => t.brandId.equals(brandId))).go();

  // ── Sphere Regions ───────────────────────────────────────────────────────────
  Future<List<SphereRegionDto>> getAllSphereRegions(String lang) async {
    final query = select(sphereRegions).join([
      innerJoin(
        sphereRegionTranslations,
        sphereRegionTranslations.regionId.equalsExp(sphereRegions.id),
      ),
    ])..where(sphereRegionTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) {
      final region = row.readTable(sphereRegions);
      final translation = row.readTable(sphereRegionTranslations);
      return SphereRegionDto(
        id: region.id,
        key: region.key,
        name: translation.name,
        description: translation.description ?? '',
        imageUrl: '', // Default if needed
        latitude: region.latitude,
        longitude: region.longitude,
        markerColor: region.markerColor,
        isActive: region.isActive,
      );
    }).toList();
  }

  Future<int> insertSphereRegion(SphereRegionsCompanion r) =>
      into(sphereRegions).insertOnConflictUpdate(r);

  Future<int> insertSphereRegionTranslation(
    SphereRegionTranslationsCompanion t,
  ) => into(sphereRegionTranslations).insertOnConflictUpdate(t);

  Future<SphereRegionTranslation?> getSphereRegionTranslation(
    String regionId,
    String lang,
  ) =>
      (select(sphereRegionTranslations)..where(
            (t) => t.regionId.equals(regionId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

  // ── User Data (Private) ──────────────────────────────────────────────────────
  Future<List<CoffeeLotDto>> getAllUserLots(String userId) async {
    final query = select(coffeeLots)
      ..where((t) => t.userId.equals(userId) & t.isDeletedLocal.equals(false));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Future<List<CoffeeLotDto>> getUserLots(String userId) =>
      getAllUserLots(userId);

  Future<List<CoffeeLotDto>> getLotsForBrand(int brandId) async {
    final query = select(
      coffeeLots,
    )..where((t) => t.brandId.equals(brandId) & t.isDeletedLocal.equals(false));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Stream<List<CoffeeLotDto>> watchUserLots(String userId) {
    final query = select(coffeeLots)..where((t) => t.userId.equals(userId) & t.isDeletedLocal.equals(false));
    return query.watch().map((rows) => rows.map((r) => _mapLotRow(r)).toList());
  }

  Future<List<CoffeeLotDto>> getAllCoffeeLots() async {
    final query = select(coffeeLots)
      ..where((t) => t.isDeletedLocal.equals(false));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Future<CoffeeLotDto?> findConflictLot(String id) async {
    final row = await (select(
      coffeeLots,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _mapLotRow(row) : null;
  }

  Future<UserLotRecipe?> findConflictRecipe(String id) async {
    return await (select(
      userLotRecipes,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<EncyclopediaRecipe?> findConflictEncyclopediaRecipe(String id) async {
    return await (select(
      encyclopediaRecipes,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<AlternativeRecipe?> findConflictAlternativeRecipe(String id) async {
    return await (select(
      alternativeRecipes,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> upsertUserLot(CoffeeLotsCompanion lot) {
    // Always mark as unsynced so the next push will pick it up
    final markedLot = lot.copyWith(
      isSynced: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
    return into(coffeeLots).insertOnConflictUpdate(markedLot);
  }

  Future<int> deleteUserLot(String id) async {
    return (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      const CoffeeLotsCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );
  }

  Future<int> deleteLotPermanently(String id) =>
      (delete(coffeeLots)..where((t) => t.id.equals(id))).go();

  Future<void> markLotSynced(String id) async {
    await (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      const CoffeeLotsCompanion(isSynced: Value(true)),
    );
  }

  Future<void> markUserLotRecipeSynced(String id) async {
    await (update(userLotRecipes)..where((t) => t.id.equals(id))).write(
      const UserLotRecipesCompanion(isSynced: Value(true)),
    );
  }

  Future<void> markEncyclopediaRecipeSynced(String id) async {
    await (update(encyclopediaRecipes)..where((t) => t.id.equals(id))).write(
      const EncyclopediaRecipesCompanion(isSynced: Value(true)),
    );
  }

  Future<void> markAlternativeRecipeSynced(String id) async {
    await (update(alternativeRecipes)..where((t) => t.id.equals(id))).write(
      const AlternativeRecipesCompanion(isSynced: Value(true)),
    );
  }

  Future<void> syncLotsInTx(List<CoffeeLotsCompanion> lots) {
    return transaction(() async {
      for (final lot in lots) {
        await into(coffeeLots).insertOnConflictUpdate(lot);
      }
    });
  }

  Future<int> insertUserLot(CoffeeLotsCompanion lot) =>
      into(coffeeLots).insertOnConflictUpdate(lot);

  Future<void> toggleLotFavorite(String id, bool val) async {
    await (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      CoffeeLotsCompanion(isFavorite: Value(val), isSynced: const Value(false)),
    );
  }

  Future<void> toggleLotArchive(String id, bool val) async {
    await (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      CoffeeLotsCompanion(isArchived: Value(val), isSynced: const Value(false)),
    );
  }

  Future<CoffeeLotDto?> getLotById(String id) async {
    final query = select(coffeeLots)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _mapLotRow(row) : null;
  }

  Stream<CoffeeLotDto?> watchLotById(String id) {
    final query = select(coffeeLots)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row != null ? _mapLotRow(row) : null,
    );
  }

  CoffeeLotDto _mapLotRow(CoffeeLot r) {
    return CoffeeLotDto(
      id: r.id,
      userId: r.userId,
      roasteryName: r.roasteryName,
      roasteryCountry: r.roasteryCountry,
      coffeeName: r.coffeeName,
      originCountry: r.originCountry,
      region: r.region,
      altitude: r.altitude,
      process: r.process,
      roastLevel: r.roastLevel,
      roastDate: r.roastDate,
      openedAt: r.openedAt,
      weight: r.weight,
      lotNumber: r.lotNumber,
      isDecaf: r.isDecaf,
      farm: r.farm,
      washStation: r.washStation,
      farmer: r.farmer,
      varieties: r.varieties,
      flavorProfile: r.flavorProfile,
      scaScore: r.scaScore,
      isFavorite: r.isFavorite,
      isArchived: r.isArchived,
      isOpen: r.isOpen,
      isGround: r.isGround,
      createdAt: r.createdAt,
      sensoryPoints: _parseJson(r.sensoryJson),
      pricing: _parseJson(r.priceJson),
      brandId: r.brandId,
      isDeletedLocal: r.isDeletedLocal,
      isSynced: r.isSynced,
      imageUrl: r.imageUrl,
    );
  }

  Future<List<CustomRecipeDto>> getAllCustomRecipes() async {
    final rows = await (select(
      userLotRecipes,
    )..where((t) => t.isDeletedLocal.equals(false))).get();
    return rows.map((r) => _mapUserLotRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForMethod(
    String methodKey,
  ) async {
    final rows =
        await (select(userLotRecipes)..where(
              (t) =>
                  t.methodKey.equals(methodKey) &
                  t.isDeletedLocal.equals(false),
            ))
            .get();
    return rows.map((r) => _mapUserLotRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForLot(String lotId) async {
    final rows =
        await (select(userLotRecipes)..where(
              (t) => t.lotId.equals(lotId) & t.isDeletedLocal.equals(false),
            ))
            .get();
    return rows.map((r) => _mapUserLotRecipe(r)).toList();
  }

  Stream<List<CustomRecipeDto>> watchUserLotRecipesForLot(String lotId) {
    return (select(userLotRecipes)
          ..where(
            (t) => t.lotId.equals(lotId) & t.isDeletedLocal.equals(false),
          ))
        .watch()
        .map((rows) => rows.map((r) => CustomRecipeDto.fromUserLot(r)).toList());
  }

  Stream<List<CustomRecipeDto>> watchEncyclopediaRecipesForLot(String lotId) {
    return (select(encyclopediaRecipes)
          ..where(
            (t) => t.beanId.equals(int.tryParse(lotId) ?? 0) & t.isDeletedLocal.equals(false),
          ))
        .watch()
        .map((rows) => rows.map((r) => CustomRecipeDto.fromEncyclopedia(r)).toList());
  }

  Stream<List<CustomRecipeDto>> watchUserLotRecipesForMethod(String methodKey) {
    return (select(userLotRecipes)
          ..where(
            (t) => t.methodKey.equals(methodKey) & t.isDeletedLocal.equals(false),
          ))
        .watch()
        .map((rows) => rows.map((r) => CustomRecipeDto.fromUserLot(r)).toList());
  }

  Stream<List<CustomRecipeDto>> watchAllUserLotRecipes() {
    return (select(userLotRecipes)..where((t) => t.isDeletedLocal.equals(false)))
        .watch()
        .map((rows) => rows.map((r) => CustomRecipeDto.fromUserLot(r)).toList());
  }


  Stream<List<CustomRecipeDto>> watchEncyclopediaRecipesForMethod(
    String methodKey,
  ) {
    return (select(encyclopediaRecipes)
          ..where(
            (t) => t.methodKey.equals(methodKey) & t.isDeletedLocal.equals(false),
          ))
        .watch()
        .map(
          (rows) =>
              rows.map((r) => CustomRecipeDto.fromEncyclopedia(r)).toList(),
        );
  }

  Stream<List<CustomRecipeDto>> watchAllEncyclopediaRecipes() {
    return (select(encyclopediaRecipes)
          ..where((t) => t.isDeletedLocal.equals(false)))
        .watch()
        .map(
          (rows) =>
              rows.map((r) => CustomRecipeDto.fromEncyclopedia(r)).toList(),
        );
  }

  Stream<List<CustomRecipeDto>> watchAlternativeRecipes([String? methodKey]) {
    final query = select(alternativeRecipes)
      ..where((t) => t.isDeletedLocal.equals(false));
    if (methodKey != null) {
      query.where((t) => t.methodKey.equals(methodKey));
    }
    return (query..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map(
          (rows) =>
              rows.map((r) => CustomRecipeDto.fromAlternative(r)).toList(),
        );
  }

  Stream<List<CustomRecipeDto>> watchAllCustomRecipes() {
    // This is now redundant but kept for compatibility. 
    // We should use the unified provider instead.
    return watchAllUserLotRecipes();
  }

  CustomRecipeDto _mapUserLotRecipe(UserLotRecipe r) {
    return CustomRecipeDto(
      id: r.id,
      lotId: r.lotId,
      methodKey: r.methodKey,
      name: r.name,
      coffeeGrams: r.coffeeGrams,
      totalWaterMl: r.totalWaterMl,
      grindNumber: r.grindNumber,
      comandanteClicks: r.comandanteClicks,
      ek43Division: r.ek43Division,
      totalPours: r.totalPours,
      pours: _parseList(r.pourScheduleJson),
      brewTempC: r.brewTempC,
      notes: r.notes,
      rating: r.rating,
      createdAt: r.createdAt,
      updatedAt: r.updatedAt,
      isSynced: r.isSynced,
      isFavorite: r.isFavorite,
      isArchived: r.isArchived,
      microns: r.microns,
      recipeType: r.recipeType,
      brewRatio: r.brewRatio,
      grinderName: r.grinderName,
      extractionTimeSeconds: r.extractionTimeSeconds,
      difficulty: r.difficulty,
      contentHtml: r.contentHtml,
      segment: RecipeSegment.userLot,
    );
  }

  Future<String> upsertUserLotRecipe(UserLotRecipesCompanion r) async {
    try {
      final row = await into(
        userLotRecipes,
      ).insertReturning(r, mode: InsertMode.insertOrReplace);
      debugPrint('AppDatabase: Successfully upserted user lot recipe ${row.id}');
      return row.id;
    } catch (e) {
      debugPrint('AppDatabase: Error upserting user lot recipe: $e');
      rethrow;
    }
  }

  Future<String> upsertCustomRecipe(UserLotRecipesCompanion r) => upsertUserLotRecipe(r);

  Future<String> insertCustomRecipe(UserLotRecipesCompanion r) =>
      upsertCustomRecipe(r);

  Future<String> upsertEncyclopediaRecipe(EncyclopediaRecipesCompanion r) async {
    try {
      final row = await into(
        encyclopediaRecipes,
      ).insertReturning(r, mode: InsertMode.insertOrReplace);
      return row.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> upsertAlternativeRecipe(AlternativeRecipesCompanion r) async {
    try {
      final row = await into(
        alternativeRecipes,
      ).insertReturning(r, mode: InsertMode.insertOrReplace);
      return row.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCustomRecipe(UserLotRecipesCompanion r) async {
    await upsertCustomRecipe(r);
  }

  Future<int> deleteUserLotRecipe(String id) async {
    return (update(userLotRecipes)..where((t) => t.id.equals(id))).write(
      const UserLotRecipesCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );
  }

  Future<int> deleteEncyclopediaRecipe(String id) async {
    return (update(encyclopediaRecipes)..where((t) => t.id.equals(id))).write(
      const EncyclopediaRecipesCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );
  }

  Future<int> deleteAlternativeRecipe(String id) async {
    return (update(alternativeRecipes)..where((t) => t.id.equals(id))).write(
      const AlternativeRecipesCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );
  }

  Future<int> deleteRecipeBySegment(String id, RecipeSegment segment) {
    switch (segment) {
      case RecipeSegment.userLot:
        return deleteUserLotRecipe(id);
      case RecipeSegment.encyclopedia:
        return deleteEncyclopediaRecipe(id);
      case RecipeSegment.alternative:
        return deleteAlternativeRecipe(id);
    }
  }

  Future<int> deleteCustomRecipe(String id) => deleteUserLotRecipe(id);

  Future<int> toggleUserLotRecipeFavorite(String id, bool isFavorite) async {
    return (update(userLotRecipes)..where((t) => t.id.equals(id))).write(
      UserLotRecipesCompanion(
        isFavorite: Value(isFavorite),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> toggleEncyclopediaRecipeFavorite(
    String id,
    bool isFavorite,
  ) async {
    return (update(encyclopediaRecipes)..where((t) => t.id.equals(id))).write(
      EncyclopediaRecipesCompanion(
        isFavorite: Value(isFavorite),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> toggleAlternativeRecipeFavorite(String id, bool isFavorite) async {
    return (update(alternativeRecipes)..where((t) => t.id.equals(id))).write(
      AlternativeRecipesCompanion(
        isFavorite: Value(isFavorite),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> toggleUserLotRecipeArchive(String id, bool isArchived) async {
    return (update(userLotRecipes)..where((t) => t.id.equals(id))).write(
      UserLotRecipesCompanion(
        isArchived: Value(isArchived),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> toggleEncyclopediaRecipeArchive(String id, bool isArchived) async {
    return (update(encyclopediaRecipes)..where((t) => t.id.equals(id))).write(
      EncyclopediaRecipesCompanion(
        isArchived: Value(isArchived),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> toggleAlternativeRecipeArchive(String id, bool isArchived) async {
    return (update(alternativeRecipes)..where((t) => t.id.equals(id))).write(
      AlternativeRecipesCompanion(
        isArchived: Value(isArchived),
        isSynced: const Value(false),
      ),
    );
  }

  Future<int> deleteCustomRecipePermanently(String id) =>
      (delete(userLotRecipes)..where((t) => t.id.equals(id))).go();

  Future<int> deleteEncyclopediaRecipePermanently(String id) =>
      (delete(encyclopediaRecipes)..where((t) => t.id.equals(id))).go();

  Future<int> deleteAlternativeRecipePermanently(String id) =>
      (delete(alternativeRecipes)..where((t) => t.id.equals(id))).go();

  /// Clears all user-specific data from the local database.
  /// Call this upon user sign-out to prevent data leakage between accounts.
  Future<void> clearUserData() async {
    await transaction(() async {
      await delete(userLotRecipes).go();
      await delete(encyclopediaRecipes).go();
      await delete(alternativeRecipes).go();
      await delete(coffeeLots).go();
      await delete(fermentationLogs).go();
    });
  }

  // ── Brewing (Static Wide Table) ───────────────────────────────────────────
  /// Reads from V2 table (populated by SyncService V2). English-only for brewing methods.
  Future<List<BrewingRecipeDto>> getAllBrewingRecipes(String lang) async {
    final altRecipes = await getAllAlternativeBrewing(lang);
    return altRecipes
        .map(
          (e) => BrewingRecipeDto(
            id: e.id,
            methodKey: e.methodKey,
            name: e.name,
            description: e.description,
            contentHtml: e.contentHtml,
            imageUrl: e.imageUrl,
            ratioGramsPerMl: e.ratioGramsPerMl ?? 0.066,
            tempC: e.tempC ?? 93.0,
            totalTimeSec: e.totalTimeSec ?? 180,
            difficulty: e.difficulty ?? 'Intermediate',
            stepsJson: e.stepsJson ?? '[]',
            flavorProfile: e.flavorProfile ?? 'Balanced',
            iconName: e.iconName,
            category: e.category,
            coffeeGrams: e.coffeeGrams,
            weight: e.weight,
            sortOrder: e.sortOrder,
          ),
        )
        .toList();
  }

  Future<void> smartUpsertBrewingRecipe(
    BrewingRecipesCompanion recipe,
    List<BrewingRecipeTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(brewingRecipes, [recipe]);
      batch.insertAllOnConflictUpdate(brewingRecipeTranslations, translations);
    });
  }

  /// Migrates data created in guest mode (or using 'local_user' ID) to the actual user ID.
  /// Sets isSynced to false so that the next sync will push these records to Supabase.
  Future<void> claimGuestData(String newUserId) async {
    await transaction(() async {
      // Update Lots
      await (update(coffeeLots)..where(
            (t) => t.userId.equals('guest') | t.userId.equals('local_user'),
          ))
          .write(
            CoffeeLotsCompanion(
              userId: Value(newUserId),
              isSynced: const Value(false),
            ),
          );

      // Update Recipes (All Segments)

      await (update(userLotRecipes)..where(
            (t) => t.userId.equals('guest') | t.userId.equals('local_user'),
          ))
          .write(UserLotRecipesCompanion(
            userId: Value(newUserId),
            isSynced: const Value(false),
          ));

      await (update(encyclopediaRecipes)..where(
            (t) => t.userId.equals('guest') | t.userId.equals('local_user'),
          ))
          .write(EncyclopediaRecipesCompanion(
            userId: Value(newUserId),
            isSynced: const Value(false),
          ));

      await (update(alternativeRecipes)..where(
            (t) => t.userId.equals('guest') | t.userId.equals('local_user'),
          ))
          .write(AlternativeRecipesCompanion(
            userId: Value(newUserId),
            isSynced: const Value(false),
          ));
    });
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────
  Map<String, dynamic> _parseJson(String jsonStr) {
    try {
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  List<T> _parseList<T>(String jsonStr) {
    try {
      final List<dynamic> list = jsonDecode(jsonStr) as List<dynamic>;
      return list.cast<T>();
    } catch (_) {
      return <T>[];
    }
  }

  /// Safely adds a column to a table, ignoring "duplicate column name" errors.
  /// This is essential for Windows/Emulators where migrations might be triggered redundantly.
  Future<void> _safeAddColumn(
    Migrator m,
    TableInfo table,
    GeneratedColumn column,
  ) async {
    try {
      await m.addColumn(table, column);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('duplicate column name') ||
          msg.contains('already exists')) {
        return; // Safe to ignore
      }
      rethrow;
    }
  }
}

// Legacy extension removed. Logic moved to AppDatabase.getAllBrewingRecipes.
