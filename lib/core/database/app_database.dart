import 'dart:convert';
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
    CustomRecipes,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 31;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 29) {
        // Migration for story columns in Farmers
        await transaction(() async {
          // recreate farmers or just add column, but recreation is safer for this state
          await customStatement('DROP TABLE IF EXISTS localized_farmers;');
          await customStatement('DROP TABLE IF EXISTS localized_farmer_translations;');
          
          await m.createTable(localizedFarmers);
          await m.createTable(localizedFarmerTranslations);
          
          // Force recreation of articles/beans/recipes to ensure they are consistent after parallel sync failures
          await customStatement('DROP TABLE IF EXISTS specialty_articles;');
          await customStatement('DROP TABLE IF EXISTS specialty_article_translations;');
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
        await m.addColumn(customRecipes, customRecipes.recipeType);
        await m.addColumn(customRecipes, customRecipes.brewRatio);
        await m.addColumn(customRecipes, customRecipes.grinderName);
        await m.addColumn(customRecipes, customRecipes.microns);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  // ── Specialty Articles ───────────────────────────────────────────────────────

  Future<bool> encyclopediaIsEmpty() async =>
      (await select(specialtyArticles).get()).isEmpty;

  Future<bool> farmersIsEmpty() async =>
      (await select(localizedFarmers).get()).isEmpty;

  Future<bool> specialtyArticlesIsEmpty() async =>
      (await select(specialtyArticles).get()).isEmpty;

  // ── Farmers ──────────────────────────────────────────────────────────────────
  // ── Farmers (Wide Table) ───────────────────────────────────────────────────
  Future<List<LocalizedFarmerDto>> getAllFarmers(String lang) async {
    final query = select(localizedFarmers).join([
      leftOuterJoin(
        localizedFarmerTranslations,
        localizedFarmerTranslations.farmerId.equalsExp(localizedFarmers.id) &
            localizedFarmerTranslations.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    
    return rows.map((row) {
      final farmer = row.readTable(localizedFarmers);
      final translation = row.readTableOrNull(localizedFarmerTranslations);

      return LocalizedFarmerDto(
        id: farmer.id,
        imageUrl: farmer.imageUrl,
        flagUrl: farmer.flagUrl,
        name: translation?.name ?? 'Unknown',
        descriptionHtml: translation?.descriptionHtml ?? '',
        story: translation?.story ?? translation?.descriptionHtml ?? '',
        region: translation?.region ?? '',
        country: translation?.country ?? '',
        latitude: farmer.latitude,
        longitude: farmer.longitude,
        createdAt: farmer.createdAt,
      );
    }).toList();
  }

  Future<void> smartUpsertFarmer(
    LocalizedFarmersCompanion f,
    List<LocalizedFarmerTranslationsCompanion> translations,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(localizedFarmers, [f]);
      batch.insertAllOnConflictUpdate(localizedFarmerTranslations, translations);
    });
  }

  Future<void> upsertLocalizedFarmer(
    LocalizedFarmersCompanion f,
    List<LocalizedFarmerTranslationsCompanion> translations,
  ) =>
      smartUpsertFarmer(f, translations);

  // ── Brands ───────────────────────────────────────────────────────────────────
  Future<List<LocalizedBrandDto>> getAllBrands([String lang = 'uk']) async {
    final query = select(localizedBrands).join([
      leftOuterJoin(
        localizedBrandTranslations,
        localizedBrandTranslations.brandId.equalsExp(localizedBrands.id) &
            localizedBrandTranslations.languageCode.equals(lang),
      ),
    ]);

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
      );
    }).toList();
  }

  Future<LocalizedBrandDto?> getBrandById(int id, String lang) async {
    final query =
        select(localizedBrands).join([
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
    );
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

  Future<int> addBrand(String name, String location, String shortDesc) async {
    final res = await into(localizedBrands).insert(
      LocalizedBrandsCompanion.insert(
        name: name,
        createdAt: Value(DateTime.now()),
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

  Future<LocalizedBrandTranslation?> getBrandTranslation(
    int brandId,
    String lang,
  ) =>
      (select(localizedBrandTranslations)..where(
            (t) => t.brandId.equals(brandId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

  Future<int> deleteBrand(int id) =>
      (delete(localizedBrands)..where((t) => t.id.equals(id))).go();

  // Helper methods to clear data
  Future<void> clearFarmers() async {
    await delete(localizedFarmers).go();
  }

  Future<void> clearSpecialtyArticles() async {
    await delete(specialtyArticles).go();
  }

  // ── Origins / Beans ──────────────────────────────────────────────────────────
  Future<List<LocalizedBeanDto>> getAllOrigins(String lang) async {
    final query = select(localizedBeans).join([
      leftOuterJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id) &
            localizedBeanTranslations.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) => _mapBeanRow(row, lang)).toList();
  }

  Stream<List<LocalizedBeanDto>> watchAllEncyclopediaEntries(String lang) {
    final query = select(localizedBeans).join([
      leftOuterJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id) &
            localizedBeanTranslations.languageCode.equals(lang),
      ),
    ]);

    return query.watch().map(
      (rows) => rows.map((row) => _mapBeanRow(row, lang)).toList(),
    );
  }

  Future<List<LocalizedBeanDto>> getAllBeans(String lang) =>
      getAllOrigins(lang);
  Future<List<LocalizedBeanDto>> getAllEncyclopediaEntries(String lang) =>
      getAllOrigins(lang);

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
    final query = select(localizedBeans).join([
      leftOuterJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id) &
            localizedBeanTranslations.languageCode.equals(lang),
      ),
    ])..where(localizedBeans.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapBeanRow(row, lang);
  }

  Stream<LocalizedBeanDto?> watchBeanById(int id, String lang) {
    final query = select(localizedBeans).join([
      leftOuterJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id) &
            localizedBeanTranslations.languageCode.equals(lang),
      ),
    ])..where(localizedBeans.id.equals(id));

    return query.watchSingleOrNull().map((row) => row != null ? _mapBeanRow(row, lang) : null);
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
    await into(localizedBeans).insertOnConflictUpdate(
      LocalizedBeansCompanion(
        id: Value(beanId),
        isFavorite: Value(isFavorite),
      ),
    );
  }

  Future<Set<int>> getFavoriteIds() async {
    final query = selectOnly(localizedBeans)
      ..addColumns([localizedBeans.id])
      ..where(localizedBeans.isFavorite.equals(true));
    final rows = await query.get();
    return rows.map((r) => r.read(localizedBeans.id)!).toSet();
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
      batch.insertAllOnConflictUpdate(specialtyArticleTranslations, translations);
    });
  }

  Future<List<SpecialtyArticleDto>> getAllArticles(String lang) async {
    final query = select(specialtyArticles).join([
      leftOuterJoin(
        specialtyArticleTranslations,
        specialtyArticleTranslations.articleId.equalsExp(specialtyArticles.id) &
            specialtyArticleTranslations.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    
    return rows.map((row) {
      final article = row.readTable(specialtyArticles);
      final translation = row.readTableOrNull(specialtyArticleTranslations);
      
      return SpecialtyArticleDto(
        id: article.id,
        title: translation?.title ?? 'Untitled',
        subtitle: translation?.subtitle ?? '',
        imageUrl: article.imageUrl,
        flagUrl: article.flagUrl,
        readTimeMin: article.readTimeMin,
        contentHtml: translation?.contentHtml ?? '',
      );
    }).toList();
  }

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
    final query = select(coffeeLots)..where((t) => t.userId.equals(userId) & t.isDeletedLocal.equals(false));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Future<List<CoffeeLotDto>> getUserLots(String userId) =>
      getAllUserLots(userId);

  Future<List<CoffeeLotDto>> getLotsForBrand(int brandId) async {
    final query = select(coffeeLots)..where((t) => t.brandId.equals(brandId) & t.isDeletedLocal.equals(false));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Stream<List<CoffeeLotDto>> watchUserLots(String userId) {
    final query = select(coffeeLots)..where((t) => t.userId.equals(userId));
    return query.watch().map((rows) => rows.map((r) => _mapLotRow(r)).toList());
  }

  Future<CoffeeLotDto?> findConflictLot(String id) async {
    final row = await (select(
      coffeeLots,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _mapLotRow(row) : null;
  }

  Future<int> upsertUserLot(CoffeeLotsCompanion lot) =>
      into(coffeeLots).insertOnConflictUpdate(lot);

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
      CoffeeLotsCompanion(
        isFavorite: Value(val),
        isSynced: const Value(false),
      ),
    );
  }

  Future<void> toggleLotArchive(String id, bool val) async {
    await (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      CoffeeLotsCompanion(
        isArchived: Value(val),
        isSynced: const Value(false),
      ),
    );
  }

  Future<CoffeeLotDto?> getLotById(String id) async {
    final query = select(coffeeLots)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _mapLotRow(row) : null;
  }

  Stream<CoffeeLotDto?> watchLotById(String id) {
    final query = select(coffeeLots)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull().map((row) => row != null ? _mapLotRow(row) : null);
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

  Future<List<CustomRecipeDto>> getAllCustomRecipes(String userId) async {
    final rows = await (select(
      customRecipes,
    )..where((t) => t.userId.equals(userId) & t.isDeletedLocal.equals(false))).get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForMethod(
    String userId,
    String methodKey,
  ) async {
    final rows = await (select(customRecipes)
          ..where((t) =>
              t.userId.equals(userId) &
              t.methodKey.equals(methodKey) &
              t.isDeletedLocal.equals(false)))
        .get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForLot(String lotId) async {
    final rows = await (select(
      customRecipes,
    )..where((t) => t.lotId.equals(lotId) & t.isDeletedLocal.equals(false))).get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
  }

  Stream<List<CustomRecipeDto>> watchCustomRecipesForLot(String lotId) {
    final query = select(customRecipes)..where((t) => t.lotId.equals(lotId) & t.isDeletedLocal.equals(false));
    return query.watch().map((rows) => rows.map((r) => _mapCustomRecipe(r)).toList());
  }

  CustomRecipeDto _mapCustomRecipe(CustomRecipe r) {
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
      updatedAt: r.updatedAt,
      isSynced: r.isSynced,
      microns: r.microns,
      recipeType: r.recipeType,
      brewRatio: r.brewRatio,
      grinderName: r.grinderName,
    );
  }

  Future<String> upsertCustomRecipe(CustomRecipesCompanion r) async {
    await into(customRecipes).insertOnConflictUpdate(r);
    return r.id.value;
  }

  Future<String> insertCustomRecipe(CustomRecipesCompanion r) =>
      upsertCustomRecipe(r);

  Future<void> updateCustomRecipe(CustomRecipesCompanion r) async {
    await upsertCustomRecipe(r);
  }

  Future<int> deleteCustomRecipe(String id) async {
    return (update(customRecipes)..where((t) => t.id.equals(id))).write(
      const CustomRecipesCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );
  }

  Future<int> deleteCustomRecipePermanently(String id) =>
      (delete(customRecipes)..where((t) => t.id.equals(id))).go();

  // ── Brewing (Static Wide Table) ───────────────────────────────────────────
  Future<List<BrewingRecipeDto>> getAllBrewingRecipes(String lang) async {
    final query = select(brewingRecipes).join([
      leftOuterJoin(
        brewingRecipeTranslations,
        brewingRecipeTranslations.recipeKey.equalsExp(brewingRecipes.methodKey) &
            brewingRecipeTranslations.languageCode.equals(lang),
      ),
    ]);

    final rows = await query.get();
    
    return rows.map((row) {
      final recipe = row.readTable(brewingRecipes);
      final translation = row.readTableOrNull(brewingRecipeTranslations);
      
      final isUk = lang == 'uk';
      String name = recipe.nameUk;
      String desc = recipe.descriptionUk;
      
      if (!isUk && translation != null) {
        name = translation.name ?? name;
        desc = translation.description ?? desc;
      }
      
      return BrewingRecipeDto(
        id: recipe.id,
        methodKey: recipe.methodKey,
        name: name,
        description: desc,
        imageUrl: recipe.imageUrl,
        ratioGramsPerMl: recipe.ratioGramsPerMl,
        tempC: recipe.tempC,
        totalTimeSec: recipe.totalTimeSec,
        difficulty: recipe.difficulty,
        stepsJson: recipe.stepsJson,
        flavorProfile: recipe.flavorProfile,
        iconName: recipe.iconName,
      );
    }).toList();
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
}

// Legacy extension removed. Logic moved to AppDatabase.getAllBrewingRecipes.
