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
    LatteArtPatterns,
    LatteArtPatternTranslations,
    CoffeeLots,
    FermentationLogs,
    BrewingRecipes,
    RecommendedRecipes,
    CustomRecipes,
    BeanScans,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 17;

  // ── Specialty Articles ───────────────────────────────────────────────────────
  Future<List<SpecialtyArticleDto>> getAllSpecialtyArticles(String lang) async {
    final query = select(specialtyArticles).join([
      innerJoin(
        specialtyArticleTranslations,
        specialtyArticleTranslations.articleId.equalsExp(specialtyArticles.id),
      ),
    ])..where(specialtyArticleTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) {
      final article = row.readTable(specialtyArticles);
      final translation = row.readTable(specialtyArticleTranslations);
      return SpecialtyArticleDto(
        id: article.id,
        imageUrl: article.imageUrl,
        readTimeMin: article.readTimeMin,
        title: translation.title,
        subtitle: translation.subtitle,
        contentHtml: translation.contentHtml,
      );
    }).toList();
  }

  Future<int> insertArticle(SpecialtyArticlesCompanion article) =>
      into(specialtyArticles).insertOnConflictUpdate(article);

  Future<int> insertArticleTranslation(
    SpecialtyArticleTranslationsCompanion t,
  ) => into(specialtyArticleTranslations).insertOnConflictUpdate(t);

  Future<int> upsertSpecialtyArticle(SpecialtyArticlesCompanion article) =>
      insertArticle(article);

  Future<int> upsertSpecialtyArticleTranslation(
    SpecialtyArticleTranslationsCompanion t,
  ) => insertArticleTranslation(t);

  // ── Farmers ──────────────────────────────────────────────────────────────────
  Future<List<LocalizedFarmerDto>> getAllFarmers(String lang) async {
    final query = select(localizedFarmers).join([
      innerJoin(
        localizedFarmerTranslations,
        localizedFarmerTranslations.farmerId.equalsExp(localizedFarmers.id),
      ),
    ])..where(localizedFarmerTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) {
      final farmer = row.readTable(localizedFarmers);
      final translation = row.readTable(localizedFarmerTranslations);
      return LocalizedFarmerDto(
        id: farmer.id,
        imageUrl: farmer.imageUrl ?? '',
        countryEmoji: farmer.countryEmoji ?? '',
        latitude: farmer.latitude ?? 0.0,
        longitude: farmer.longitude ?? 0.0,
        name: translation.name ?? '',
        region: translation.region ?? '',
        description: translation.description ?? '',
        story: translation.story ?? '',
        country: translation.country ?? '',
      );
    }).toList();
  }

  Future<int> upsertLocalizedFarmer(LocalizedFarmersCompanion f) =>
      into(localizedFarmers).insertOnConflictUpdate(f);

  Future<int> upsertLocalizedFarmerTranslation(
    LocalizedFarmerTranslationsCompanion t,
  ) => into(localizedFarmerTranslations).insertOnConflictUpdate(t);

  // ── Brands ───────────────────────────────────────────────────────────────────
  Future<List<LocalizedBrandDto>> getAllBrands(String lang) async {
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

  Future<int> insertBrand(LocalizedBrandsCompanion b) =>
      into(localizedBrands).insertOnConflictUpdate(b);

  Future<int> insertBrandTranslation(LocalizedBrandTranslationsCompanion t) =>
      into(localizedBrandTranslations).insertOnConflictUpdate(t);

  Future<int> upsertLocalizedBrand(LocalizedBrandsCompanion b) =>
      insertBrand(b);

  Future<int> upsertLocalizedBrandTranslation(
    LocalizedBrandTranslationsCompanion t,
  ) => insertBrandTranslation(t);

  Future<LocalizedBrandTranslation?> getBrandTranslation(
    int brandId,
    String lang,
  ) =>
      (select(localizedBrandTranslations)..where(
            (t) => t.brandId.equals(brandId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

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

  Future<List<LocalizedBeanDto>> getAllBeans(String lang) =>
      getAllOrigins(lang);
  Future<List<LocalizedBeanDto>> getAllEncyclopediaEntries(String lang) =>
      getAllOrigins(lang);

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

  Future<int> insertBeanTranslation(LocalizedBeanTranslationsCompanion t) =>
      into(localizedBeanTranslations).insertOnConflictUpdate(t);

  Future<int> upsertLocalizedBean(LocalizedBeansCompanion b) => insertBean(b);

  Future<int> upsertLocalizedBeanTranslation(
    LocalizedBeanTranslationsCompanion t,
  ) => insertBeanTranslation(t);

  Future<LocalizedBeanTranslation?> getBeanTranslation(
    int beanId,
    String lang,
  ) =>
      (select(localizedBeanTranslations)..where(
            (t) => t.beanId.equals(beanId) & t.languageCode.equals(lang),
          ))
          .getSingleOrNull();

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

  // ── Latte Art Patterns ───────────────────────────────────────────────────────
  Future<List<LatteArtPatternDto>> getAllLatteArtPatterns(String lang) async {
    final query = select(latteArtPatterns).join([
      innerJoin(
        latteArtPatternTranslations,
        latteArtPatternTranslations.patternId.equalsExp(latteArtPatterns.id),
      ),
    ])..where(latteArtPatternTranslations.languageCode.equals(lang));

    final rows = await query.get();
    return rows.map((row) {
      final pattern = row.readTable(latteArtPatterns);
      final translation = row.readTable(latteArtPatternTranslations);
      return LatteArtPatternDto(
        id: pattern.id,
        difficulty: pattern.difficulty,
        steps: _parseList(pattern.stepsJson),
        isFavorite: pattern.isFavorite,
        userBestScore: pattern.userBestScore,
        name: translation.name,
        description: translation.description,
        tipText: translation.tipText,
      );
    }).toList();
  }

  Future<int> insertLatteArtPattern(LatteArtPatternsCompanion p) =>
      into(latteArtPatterns).insertOnConflictUpdate(p);

  Future<int> insertLatteArtPatternTranslation(
    LatteArtPatternTranslationsCompanion t,
  ) => into(latteArtPatternTranslations).insertOnConflictUpdate(t);

  Future<int> upsertLatteArtPattern(LatteArtPatternsCompanion p) =>
      insertLatteArtPattern(p);

  Future<int> upsertLatteArtPatternTranslation(
    LatteArtPatternTranslationsCompanion t,
  ) => insertLatteArtPatternTranslation(t);

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
        name: translation.name,
        description: translation.description ?? '',
        imageUrl: '', // Default if needed
        latitude: region.latitude,
        longitude: region.longitude,
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

  Future<CoffeeLot?> findConflictLot(String id) =>
      (select(coffeeLots)..where((t) => t.id.equals(id))).getSingleOrNull();

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

  // ── Bean Eye (Scans) ────────────────────────────────────────────────────────
  Future<int> insertScan(BeanScansCompanion s) => into(beanScans).insert(s);
  Future<List<BeanScan>> getAllScans() => select(beanScans).get();
  Future<int> deleteScan(String id) =>
      (delete(beanScans)..where((t) => t.id.equals(id))).go();

  // ── Brewing (Static) ────────────────────────────────────────────────────────
  Future<List<BrewingRecipe>> getAllRecipes() => select(brewingRecipes).get();

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
