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
    SphereRegions,
    SphereRegionTranslations,
    SpecialtyArticles,
    CoffeeLots,
    FermentationLogs,
    BrewingRecipes,
    RecommendedRecipes,
    CustomRecipes,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 27;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 26) {
        // Migration to Localized Composite Keys & Project Recovery
        await transaction(() async {
          // Drop tables that need schema change (ID -> Composite Key)
          // We use the generated table names directly for customStatement
          

          // Ensure old tables are removed
          await customStatement('DROP TABLE IF EXISTS localized_farmer_translations;');
          await customStatement('DROP TABLE IF EXISTS specialty_article_translations;');

          // Recreate tables with new wide schema
          await customStatement('DROP TABLE IF EXISTS localized_farmers;');
          await customStatement('DROP TABLE IF EXISTS specialty_articles;');
          await m.createTable(localizedFarmers);
          await m.createTable(specialtyArticles);

          // Delete deprecated tables
          await customStatement('DROP TABLE IF EXISTS latte_art_patterns;');
          await customStatement(
            'DROP TABLE IF EXISTS latte_art_pattern_translations;',
          );
          await customStatement('DROP TABLE IF EXISTS bean_scans;');

          // Ensure brand_id exists in coffee_lots
          try {
            await customStatement(
              'ALTER TABLE coffee_lots ADD COLUMN brand_id INTEGER;',
            );
          } catch (_) {}
        });
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
    final query = select(localizedFarmers);
    final rows = await query.get();
    
    return rows.map((farmer) {
      final isUk = lang == 'uk';
      final isEn = lang == 'en';
      
      // Basic 2-lang logic for now, expandable to 13
      String name = farmer.nameUk;
      String desc = farmer.descriptionHtmlUk;
      
      if (isEn) {
        name = farmer.nameEn ?? farmer.nameUk;
        desc = farmer.descriptionHtmlEn ?? farmer.descriptionHtmlUk;
      } else if (!isUk) {
        // Fallback or other language logic here
        name = farmer.nameEn ?? farmer.nameUk;
        desc = farmer.descriptionHtmlEn ?? farmer.descriptionHtmlUk;
      }
      
      return LocalizedFarmerDto(
        id: farmer.id,
        imageUrl: farmer.imageUrl,
        flagUrl: farmer.flagUrl,
        name: name,
        descriptionHtml: desc,
        region: farmer.regionUk ?? '',
        country: farmer.countryUk ?? '',
        latitude: farmer.latitude,
        longitude: farmer.longitude,
        createdAt: farmer.createdAt,
      );
    }).toList();
  }

  Future<void> smartUpsertFarmer(LocalizedFarmersCompanion f) =>
      into(localizedFarmers).insertOnConflictUpdate(f);

  Future<void> upsertLocalizedFarmer(LocalizedFarmersCompanion f) =>
      smartUpsertFarmer(f);

  // ── Brands ───────────────────────────────────────────────────────────────────
  Future<List<LocalizedBrandDto>> getAllBrands([String lang = 'uk']) async {
    final query = select(localizedBrands).join([
      innerJoin(
        localizedBrandTranslations,
        localizedBrandTranslations.brandId.equalsExp(localizedBrands.id),
      ),
    ])..where(localizedBrandTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) {
      final brand = row.readTable(localizedBrands);
      final translation = row.readTable(localizedBrandTranslations);
      return LocalizedBrandDto(
        id: brand.id,
        name: brand.name,
        logoUrl: brand.logoUrl ?? '',
        siteUrl: brand.siteUrl ?? '',
        shortDesc: translation.shortDesc ?? '',
        fullDesc: translation.fullDesc ?? '',
        location: translation.location ?? '',
      );
    }).toList();
  }

  Future<LocalizedBrandDto?> getBrandById(int id, String lang) async {
    final query =
        select(localizedBrands).join([
          innerJoin(
            localizedBrandTranslations,
            localizedBrandTranslations.brandId.equalsExp(localizedBrands.id),
          ),
        ])..where(
          localizedBrands.id.equals(id) &
              localizedBrandTranslations.languageCode.equals(lang),
        );

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final brand = row.readTable(localizedBrands);
    final translation = row.readTable(localizedBrandTranslations);
    return LocalizedBrandDto(
      id: brand.id,
      name: brand.name,
      logoUrl: brand.logoUrl ?? '',
      siteUrl: brand.siteUrl ?? '',
      shortDesc: translation.shortDesc ?? '',
      fullDesc: translation.fullDesc ?? '',
      location: translation.location ?? '',
    );
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
      innerJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id),
      ),
    ])..where(localizedBeanTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) => _mapBeanRow(row)).toList();
  }

  Stream<List<LocalizedBeanDto>> watchAllEncyclopediaEntries(String lang) {
    final query = select(localizedBeans).join([
      innerJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id),
      ),
    ])..where(localizedBeanTranslations.languageCode.equals(lang));

    return query.watch().map(
      (rows) => rows.map((row) => _mapBeanRow(row)).toList(),
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
      innerJoin(
        localizedBeanTranslations,
        localizedBeanTranslations.beanId.equalsExp(localizedBeans.id),
      ),
    ])..where(
      localizedBeans.brandId.equals(brandId) &
          localizedBeanTranslations.languageCode.equals(lang),
    );

    final rows = await query.get();
    return rows.map((row) => _mapBeanRow(row)).toList();
  }

  Future<LocalizedBeanDto?> getBeanById(int id, String lang) async {
    final query =
        select(localizedBeans).join([
          innerJoin(
            localizedBeanTranslations,
            localizedBeanTranslations.beanId.equalsExp(localizedBeans.id),
          ),
        ])..where(
          localizedBeans.id.equals(id) &
              localizedBeanTranslations.languageCode.equals(lang),
        );

    final row = await query.getSingleOrNull();
    return row != null ? _mapBeanRow(row) : null;
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

  LocalizedBeanDto _mapBeanRow(TypedResult row) {
    final bean = row.readTable(localizedBeans);
    final translation = row.readTable(localizedBeanTranslations);

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
      country: translation.country ?? '',
      region: translation.region ?? '',
      varieties: translation.varieties ?? '',
      flavorNotes: _parseList<String>(translation.flavorNotes),
      description: translation.description ?? '',
      farmDescription: translation.farmDescription ?? '',
      roastLevel: translation.roastLevel ?? '',
      processMethod: translation.processMethod ?? '',
      isFavorite: bean.isFavorite,
      createdAt: bean.createdAt,
    );
  }

  // ── Smart Upsert & Conflicts ────────────────────────────────────────────────
  Future<void> smartUpsertBrand(
    LocalizedBrandsCompanion brand,
    List<LocalizedBrandTranslationsCompanion> translations,
  ) async {
    await transaction(() async {
      await into(localizedBrands).insertOnConflictUpdate(brand);
      for (final t in translations) {
        await into(localizedBrandTranslations).insertOnConflictUpdate(t);
      }
    });
  }

  // smartUpsertFarmer moved to line 129

  Future<void> smartUpsertBean(
    LocalizedBeansCompanion bean,
    List<LocalizedBeanTranslationsCompanion> translations,
  ) async {
    await transaction(() async {
      await into(localizedBeans).insertOnConflictUpdate(bean);
      for (final t in translations) {
        await into(localizedBeanTranslations).insertOnConflictUpdate(t);
      }
    });
  }

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
  ) async {
    await into(specialtyArticles).insertOnConflictUpdate(article);
  }

  Future<List<SpecialtyArticleDto>> getAllArticles(String lang) async {
    final query = select(specialtyArticles);
    final rows = await query.get();
    
    return rows.map((article) {
      final isUk = lang == 'uk';
      return SpecialtyArticleDto(
        id: article.id,
        title: isUk ? article.titleUk : (article.titleEn ?? article.titleUk),
        imageUrl: article.imageUrl,
        flagUrl: article.flagUrl,
        readTimeMin: article.readTimeMin,
        contentHtml: isUk ? article.contentHtmlUk : (article.contentHtmlEn ?? article.contentHtmlUk),
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
    final query = select(coffeeLots)..where((t) => t.userId.equals(userId));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Future<List<CoffeeLotDto>> getUserLots(String userId) =>
      getAllUserLots(userId);

  Future<List<CoffeeLotDto>> getLotsForBrand(int brandId) async {
    final query = select(coffeeLots)..where((t) => t.brandId.equals(brandId));
    final rows = await query.get();
    return rows.map((r) => _mapLotRow(r)).toList();
  }

  Future<CoffeeLotDto?> findConflictLot(String id) async {
    final row = await (select(
      coffeeLots,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _mapLotRow(row) : null;
  }

  Future<int> upsertUserLot(CoffeeLotsCompanion lot) =>
      into(coffeeLots).insertOnConflictUpdate(lot);

  Future<int> deleteUserLot(String id) =>
      (delete(coffeeLots)..where((t) => t.id.equals(id))).go();

  Future<int> deleteLotPermanently(String id) => deleteUserLot(id);

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
      CoffeeLotsCompanion(isFavorite: Value(val)),
    );
  }

  Future<void> toggleLotArchive(String id, bool val) async {
    await (update(coffeeLots)..where((t) => t.id.equals(id))).write(
      CoffeeLotsCompanion(isArchived: Value(val)),
    );
  }

  Future<int> deleteUserLotsByBrand(int brandId) =>
      (delete(coffeeLots)..where((t) => t.brandId.equals(brandId))).go();

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
    );
  }

  Future<List<CustomRecipeDto>> getAllCustomRecipes(String userId) async {
    final rows = await (select(
      customRecipes,
    )..where((t) => t.userId.equals(userId))).get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForMethod(
    String userId,
    String methodKey,
  ) async {
    final rows =
        await (select(customRecipes)..where(
              (t) => t.userId.equals(userId) & t.methodKey.equals(methodKey),
            ))
            .get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
  }

  Future<List<CustomRecipeDto>> getCustomRecipesForLot(String lotId) async {
    final rows = await (select(
      customRecipes,
    )..where((t) => t.lotId.equals(lotId))).get();
    return rows.map((r) => _mapCustomRecipe(r)).toList();
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

  Future<int> deleteCustomRecipe(String id) =>
      (delete(customRecipes)..where((t) => t.id.equals(id))).go();

  // ── Brewing (Static Wide Table) ───────────────────────────────────────────
  Future<List<BrewingRecipe>> getAllRecipes([String lang = 'en']) async {
    final rows = await select(brewingRecipes).get();
    return rows.map((r) {

      return BrewingRecipe(
        id: r.id,
        methodKey: r.methodKey,
        nameUk: r.nameUk,
        descriptionUk: r.descriptionUk,
        imageUrl: r.imageUrl,
        nameEn: r.nameEn,
        descriptionEn: r.descriptionEn,
        namePl: r.namePl,
        descriptionPl: r.descriptionPl,
        nameDe: r.nameDe,
        descriptionDe: r.descriptionDe,
        nameFr: r.nameFr,
        descriptionFr: r.descriptionFr,
        nameEs: r.nameEs,
        descriptionEs: r.descriptionEs,
        nameIt: r.nameIt,
        descriptionIt: r.descriptionIt,
        namePt: r.namePt,
        descriptionPt: r.descriptionPt,
        nameRo: r.nameRo,
        descriptionRo: r.descriptionRo,
        nameTr: r.nameTr,
        descriptionTr: r.descriptionTr,
        nameJa: r.nameJa,
        descriptionJa: r.descriptionJa,
        nameKo: r.nameKo,
        descriptionKo: r.descriptionKo,
        nameZh: r.nameZh,
        descriptionZh: r.descriptionZh,
        ratioGramsPerMl: r.ratioGramsPerMl,
        tempC: r.tempC,
        totalTimeSec: r.totalTimeSec,
        difficulty: r.difficulty,
        stepsJson: r.stepsJson,
        flavorProfile: r.flavorProfile,
        iconName: r.iconName,
      );
    }).toList();
  }

  Future<int> smartUpsertBrewingRecipe(BrewingRecipesCompanion r) =>
      into(brewingRecipes).insertOnConflictUpdate(r);

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

extension BrewingRecipeX on BrewingRecipe {
  String getName(String lang) {
    if (lang == 'uk') return nameUk;
    return nameEn ?? nameUk;
  }

  String getDescription(String lang) {
    if (lang == 'uk') return descriptionUk;
    return descriptionEn ?? descriptionUk;
  }
}
