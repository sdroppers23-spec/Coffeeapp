import 'package:drift/drift.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

// ─── Existing tables ──────────────────────────────────────────────────────────

class CoffeeLots extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get region => text()();
  IntColumn get altitudeM => integer()();
  TextColumn get processMethod => text()();
  RealColumn get qGradeScore => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class FermentationLogs extends Table {
  TextColumn get id => text()();
  TextColumn get lotId => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get brix => real()();
  RealColumn get ph => real()();
  RealColumn get tempC => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Brewing Recipes ──────────────────────────────────────────────────────────
/// Pre-seeded step-by-step brewing method guides.
class BrewingRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get methodKey => text()(); // e.g. 'v60', 'chemex'
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get ratioGramsPerMl => real()(); // coffee grams per ml water
  RealColumn get tempC => real()();
  IntColumn get totalTimeSec => integer()();
  TextColumn get difficulty => text()(); // 'Beginner','Intermediate','Advanced'
  TextColumn get stepsJson => text()(); // JSON: [{title, desc, durationSec}]
  TextColumn get flavorProfile => text()(); // e.g. 'Clean & Bright'
  TextColumn get iconName => text()(); // icon identifier
}

// ─── Encyclopedia Entries ─────────────────────────────────────────────────────
class EncyclopediaEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get countryEmoji => text()();
  TextColumn get country => text()();
  TextColumn get region => text()();
  IntColumn get altitudeMin => integer()();
  IntColumn get altitudeMax => integer()();
  TextColumn get varieties => text()(); // comma-separated
  TextColumn get flavorNotes => text()(); // JSON array of strings
  TextColumn get processMethod => text()(); // comma-separated
  TextColumn get harvestSeason => text()();
  TextColumn get description => text()();
  RealColumn get cupsScore => real()(); // typical SCA score

  // New columns for v3
  TextColumn get farmDescription => text().withDefault(const Constant(''))();
  TextColumn get farmPhotosUrlCover => text().withDefault(const Constant(''))();
  TextColumn get plantationPhotosUrl => text().withDefault(const Constant(''))();
  TextColumn get processingMethodsJson => text().withDefault(const Constant('[]'))();

  // New column for v4
  IntColumn get brandId => integer().nullable().references(Brands, #id)();

  // New column for v8: Extended sensory data (scales 1-5, aroma, body type, etc.)
  TextColumn get sensoryJson => text().withDefault(const Constant('{}'))();

  // New columns for v9: Coffee Journal (Screenshot 2)
  TextColumn get roastLevel => text().withDefault(const Constant(''))(); // Light, Medium, Dark
  TextColumn get weight => text().withDefault(const Constant(''))(); // e.g. "250g"
  TextColumn get price => text().withDefault(const Constant(''))(); // e.g. "€12.50"
  TextColumn get roastDate => text().withDefault(const Constant(''))(); 
  TextColumn get lotNumber => text().withDefault(const Constant(''))();
  TextColumn get url => text().withDefault(const Constant(''))();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  TextColumn get detailedProcessMarkdown => text().withDefault(const Constant(''))();
}

// ─── Recommended Recipes (professional recipes from roasters/admins) ─────────
class RecommendedRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lotId => integer().references(EncyclopediaEntries, #id)();
  TextColumn get methodKey => text()(); // v60, chemex, etc.
  RealColumn get coffeeGrams => real()();
  RealColumn get waterGrams => real()();
  RealColumn get tempC => real()();
  IntColumn get timeSec => integer()();
  RealColumn get rating => real()(); // 0-10
  TextColumn get sensoryJson => text().withDefault(const Constant('{}'))(); // for radar chart
  TextColumn get notes => text().withDefault(const Constant(''))();
}

// ─── Brands (Roasters/Farms) ──────────────────────────────────────────────────
class Brands extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get shortDesc => text()();
  TextColumn get fullDesc => text()();
  TextColumn get logoUrl => text().withDefault(const Constant(''))();
  TextColumn get siteUrl => text().withDefault(const Constant(''))();
  TextColumn get location => text().withDefault(const Constant(''))();
}

// ─── Specialty Articles ───────────────────────────────────────────────────────
class SpecialtyArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get contentHtml => text()(); // markdown/HTML content
  TextColumn get imageUrl => text()();
  IntColumn get readTimeMin => integer()();
}

// ─── Latte Art Patterns ───────────────────────────────────────────────────────
class LatteArtPatterns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get difficulty => integer()(); // 1-5 stars
  TextColumn get stepsJson => text()(); // JSON: [{step, instruction, imageName}]
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get userBestScore => integer().withDefault(const Constant(0))();
  TextColumn get description => text()();
  TextColumn get tipText => text()();
}

// ─── Bean Scans (scan history) ────────────────────────────────────────────────
class BeanScans extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get scannedAt => dateTime()();
  RealColumn get agtronValue => real()();
  TextColumn get roastLabel => text()(); // 'Light Roast' etc.
  TextColumn get flavorProfile => text()(); // JSON array of flavor descriptors
  TextColumn get recommendedMethod => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
}

// ─── Custom Recipes (user-created) ───────────────────────────────────────────
/// User's personal brew recipes linked to a brewing method.
class CustomRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get methodKey => text()(); // links to BrewingRecipes.methodKey
  TextColumn get name => text()(); // user-given name, e.g. "My Perfect V60"
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  // ── Coffee & Water ──────────────────────────────────────────────────────────
  RealColumn get coffeeGrams => real()();    // actual grams of coffee used
  RealColumn get totalWaterMl => real()();   // actual total water in ml

  // ── Grinder settings ────────────────────────────────────────────────────────
  IntColumn get grindNumber => integer().withDefault(const Constant(0))();
  // Number on the grinder scale (generic)
  IntColumn get comandanteClicks => integer().withDefault(const Constant(0))();
  // Number of clicks on Comandante C40/C60
  IntColumn get ek43Division => integer().withDefault(const Constant(0))();
  // Mahlkoenig EK43 division number

  // ── Pour schedule ────────────────────────────────────────────────────────────
  IntColumn get totalPours => integer().withDefault(const Constant(1))();
  // Total number of pours/pulses
  TextColumn get pourScheduleJson => text().withDefault(const Constant('[]'))();
  // JSON: [{pourNumber, waterMl, atMinute, durationSec, notes}]

  // ── Extra ─────────────────────────────────────────────────────────────────────
  RealColumn get brewTempC => real().withDefault(const Constant(93.0))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get rating => integer().withDefault(const Constant(0))(); // 0-5
}

// ─── Database class ───────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  CoffeeLots,
  FermentationLogs,
  BrewingRecipes,
  EncyclopediaEntries,
  Brands,
  LatteArtPatterns,
  BeanScans,
  CustomRecipes,
  SpecialtyArticles,
  RecommendedRecipes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(brewingRecipes);
        await m.createTable(encyclopediaEntries);
        await m.createTable(latteArtPatterns);
        await m.createTable(beanScans);
        await m.createTable(customRecipes);
      }
      if (from < 3) {
        await m.createTable(specialtyArticles);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.farmDescription);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.farmPhotosUrlCover);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.plantationPhotosUrl);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.processingMethodsJson);
      }
      if (from < 4) {
        await m.createTable(brands);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.brandId);
      }
      if (from < 8) {
        await m.addColumn(encyclopediaEntries, (encyclopediaEntries as dynamic).sensoryJson);
      }
      if (from < 9) {
        await m.createTable(recommendedRecipes);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.roastLevel);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.weight);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.price);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.roastDate);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.lotNumber);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.url);
        await m.addColumn(encyclopediaEntries, encyclopediaEntries.isPremium);
      }
      if (from < 10) {
        await m.addColumn(encyclopediaEntries, (encyclopediaEntries as dynamic).detailedProcessMarkdown);
      }
    },
  );

  // ── CoffeeLots ───────────────────────────────────────────────────────────────
  Future<List<CoffeeLot>> getAllLots() => select(coffeeLots).get();
  Future<int> insertLot(CoffeeLotsCompanion lot) => into(coffeeLots).insert(lot);

  // ── FermentationLogs ─────────────────────────────────────────────────────────
  Future<List<FermentationLog>> getLogsForLot(String lotId) {
    return (select(fermentationLogs)..where((t) => t.lotId.equals(lotId))).get();
  }
  Future<int> insertLog(FermentationLogsCompanion log) =>
      into(fermentationLogs).insert(log);

  // ── BrewingRecipes ────────────────────────────────────────────────────────────
  Future<List<BrewingRecipe>> getAllRecipes() => select(brewingRecipes).get();
  Future<BrewingRecipe?> getRecipeByKey(String key) {
    return (select(brewingRecipes)..where((t) => t.methodKey.equals(key)))
        .getSingleOrNull();
  }
  Future<int> insertRecipe(BrewingRecipesCompanion r) =>
      into(brewingRecipes).insertOnConflictUpdate(r);

  // ── EncyclopediaEntries ───────────────────────────────────────────────────────
  Future<List<EncyclopediaEntry>> getAllOrigins() =>
      select(encyclopediaEntries).get();
  Future<List<EncyclopediaEntry>> getLotsForBrand(int brandId) {
    return (select(encyclopediaEntries)..where((t) => t.brandId.equals(brandId))).get();
  }
  Future<int> insertOrigin(EncyclopediaEntriesCompanion e) =>
      into(encyclopediaEntries).insertOnConflictUpdate(e);
  Future<bool> encyclopediaIsEmpty() async {
    final count = await select(encyclopediaEntries).get();
    return count.isEmpty;
  }
  Future<void> deleteLotsForBrand(int brandId) {
    return (delete(encyclopediaEntries)..where((t) => t.brandId.equals(brandId))).go();
  }

  // ── Brands ───────────────────────────────────────────────────────────────────
  Future<List<Brand>> getAllBrands() => select(brands).get();
  Future<Brand?> getBrandById(int id) => 
      (select(brands)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<int> insertBrand(BrandsCompanion b) => 
      into(brands).insertOnConflictUpdate(b);
  Future<bool> brandsIsEmpty() async {
    final count = await select(brands).get();
    return count.isEmpty;
  }

  // ── SpecialtyArticles ─────────────────────────────────────────────────────────
  Future<List<SpecialtyArticle>> getAllSpecialtyArticles() => select(specialtyArticles).get();
  Future<int> insertSpecialtyArticle(SpecialtyArticlesCompanion a) => into(specialtyArticles).insert(a);
  Future<bool> specialtyArticlesIsEmpty() async {
    final count = await select(specialtyArticles).get();
    return count.isEmpty;
  }

  // ── LatteArtPatterns ─────────────────────────────────────────────────────────
  Future<List<LatteArtPattern>> getAllPatterns() =>
      select(latteArtPatterns).get();
  Future<int> insertPattern(LatteArtPatternsCompanion p) =>
      into(latteArtPatterns).insertOnConflictUpdate(p);
  Future<bool> patternsIsEmpty() async {
    final count = await select(latteArtPatterns).get();
    return count.isEmpty;
  }
  Future<void> updatePatternFavorite(int id, bool isFav) {
    return (update(latteArtPatterns)..where((t) => t.id.equals(id)))
        .write(LatteArtPatternsCompanion(isFavorite: Value(isFav)));
  }
  Future<void> updatePatternScore(int id, int score) {
    return (update(latteArtPatterns)..where((t) => t.id.equals(id)))
        .write(LatteArtPatternsCompanion(userBestScore: Value(score)));
  }

  // ── BeanScans ─────────────────────────────────────────────────────────────────
  Future<List<BeanScan>> getAllScans() =>
      (select(beanScans)..orderBy([(t) => OrderingTerm.desc(t.scannedAt)])).get();
  Future<int> insertScan(BeanScansCompanion s) => into(beanScans).insert(s);
  Future<int> deleteScan(int id) =>
      (delete(beanScans)..where((t) => t.id.equals(id))).go();

  // ── CustomRecipes ─────────────────────────────────────────────────────────────
  Future<List<CustomRecipe>> getCustomRecipesForMethod(String methodKey) {
    return (select(customRecipes)
          ..where((t) => t.methodKey.equals(methodKey))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }
  Future<int> insertCustomRecipe(CustomRecipesCompanion r) =>
      into(customRecipes).insert(r);
  Future<bool> updateCustomRecipe(CustomRecipesCompanion r) =>
      update(customRecipes).replace(r);
  Future<int> deleteCustomRecipe(int id) =>
      (delete(customRecipes)..where((t) => t.id.equals(id))).go();
  Future<CustomRecipe?> getCustomRecipeById(int id) =>
      (select(customRecipes)..where((t) => t.id.equals(id))).getSingleOrNull();

  // ── RecommendedRecipes ────────────────────────────────────────────────────────
  Future<List<RecommendedRecipe>> getRecommendedRecipesForLot(int lotId) =>
      (select(recommendedRecipes)..where((t) => t.lotId.equals(lotId))).get();
  
  Future<List<RecommendedRecipe>> getRecommendedRecipesForMethod(String methodKey) =>
      (select(recommendedRecipes)..where((t) => t.methodKey.equals(methodKey))).get();

  Future<int> insertRecommendedRecipe(RecommendedRecipesCompanion r) =>
      into(recommendedRecipes).insertOnConflictUpdate(r);
  
  Future<void> deleteRecommendedRecipesForLot(int lotId) =>
      (delete(recommendedRecipes)..where((t) => t.lotId.equals(lotId))).go();
}

// ─── Connection ───────────────────────────────────────────────────────────────
QueryExecutor _openConnection() {
  return openConnection();
}
