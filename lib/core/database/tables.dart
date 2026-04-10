import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

// ─── Schema version: 17 (Sync & Depth Update) ───────────────────────────────
// Per-language columns removed from all main tables.
// Each table now has a companion *Translations table.
// ─────────────────────────────────────────────────────────────────────────────

// ─── LocalizedBeans ──────────────────────────────────────────────────────────
class LocalizedBeans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get brandId =>
      integer().nullable().references(LocalizedBrands, #id)();

  TextColumn get countryEmoji => text().nullable()();

  IntColumn get altitudeMin => integer().nullable()();
  IntColumn get altitudeMax => integer().nullable()();

  TextColumn get lotNumber => text().withDefault(const Constant(''))();
  TextColumn get scaScore => text().withDefault(const Constant('80-84'))();
  RealColumn get cupsScore => real().withDefault(const Constant(82.0))();

  TextColumn get sensoryJson => text().withDefault(const Constant('{}'))();
  TextColumn get priceJson => text().withDefault(const Constant('{}'))();
  TextColumn get plantationPhotosUrl =>
      text().withDefault(const Constant('[]'))();

  TextColumn get harvestSeason => text().nullable()();
  TextColumn get price => text().nullable()();
  TextColumn get weight => text().nullable()();
  TextColumn get roastDate => text().nullable()();
  TextColumn get processingMethodsJson =>
      text().withDefault(const Constant('[]'))();

  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  TextColumn get detailedProcessMarkdown =>
      text().withDefault(const Constant(''))();
  TextColumn get url => text().withDefault(const Constant(''))();

  IntColumn get farmerId =>
      integer().nullable().references(LocalizedFarmers, #id)();
  BoolColumn get isDecaf => boolean().withDefault(const Constant(false))();
  TextColumn get farm => text().nullable()();
  TextColumn get farmPhotosUrlCover => text().nullable()();
  TextColumn get washStation => text().nullable()();
  TextColumn get retailPrice => text().nullable()();
  TextColumn get wholesalePrice => text().nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedBeanTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get beanId => integer().references(LocalizedBeans, #id)();
  TextColumn get languageCode => text()(); // 'en', 'uk', 'de', etc.

  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get varieties => text().nullable()();
  TextColumn get flavorNotes => text().withDefault(const Constant('[]'))();
  TextColumn get processMethod => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get farmDescription => text().nullable()();
  TextColumn get roastLevel => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {beanId, languageCode},
  ];
}

// ─── LocalizedBrands ─────────────────────────────────────────────────────────
class LocalizedBrands extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get siteUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedBrandTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get brandId => integer().references(LocalizedBrands, #id)();
  TextColumn get languageCode => text()();

  TextColumn get shortDesc => text().nullable()();
  TextColumn get fullDesc => text().nullable()();
  TextColumn get location => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {brandId, languageCode},
  ];
}

// ─── LocalizedFarmers ────────────────────────────────────────────────────────
class LocalizedFarmers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get countryEmoji => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedFarmerTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get farmerId => integer().references(LocalizedFarmers, #id)();
  TextColumn get languageCode => text()();

  TextColumn get name => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get story => text().nullable()();
  TextColumn get country => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {farmerId, languageCode},
  ];
}

// ─── SphereRegions ───────────────────────────────────────────────────────────
class SphereRegions extends Table {
  TextColumn get id => text()();
  TextColumn get key => text().unique()();

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get markerColor => text().withDefault(const Constant('#C8A96E'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SphereRegionTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get regionId => text().references(SphereRegions, #id)();
  TextColumn get languageCode => text()();

  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get flavorProfile => text().withDefault(const Constant('[]'))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {regionId, languageCode},
  ];
}

// ─── SpecialtyArticles ───────────────────────────────────────────────────────
class SpecialtyArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imageUrl => text()();
  IntColumn get readTimeMin => integer()();
}

class SpecialtyArticleTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get articleId => integer().references(SpecialtyArticles, #id)();
  TextColumn get languageCode => text()();

  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get contentHtml => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {articleId, languageCode},
  ];
}

// ─── LatteArtPatterns ────────────────────────────────────────────────────────
class LatteArtPatterns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get difficulty => integer()();
  TextColumn get stepsJson => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get userBestScore => integer().withDefault(const Constant(0))();
}

class LatteArtPatternTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patternId => integer().references(LatteArtPatterns, #id)();
  TextColumn get languageCode => text()();

  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get tipText => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {patternId, languageCode},
  ];
}

// ─── CoffeeLots (User's Private) ─────────────────────────────────────────────
class CoffeeLots extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get userId => text()();

  // Roastery
  TextColumn get roasteryName => text().nullable()();
  TextColumn get roasteryCountry => text().nullable()();
  IntColumn get brandId =>
      integer().nullable().references(LocalizedBrands, #id)();

  // Coffee Data
  TextColumn get coffeeName => text().nullable()();
  TextColumn get originCountry => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get altitude => text().nullable()();
  TextColumn get process => text().nullable()();
  TextColumn get roastLevel => text().nullable()();
  DateTimeColumn get roastDate => dateTime().nullable()();
  DateTimeColumn get openedAt => dateTime().nullable()();
  TextColumn get weight => text().nullable()();
  TextColumn get lotNumber => text().nullable()();
  BoolColumn get isDecaf => boolean().withDefault(const Constant(false))();

  // Source
  TextColumn get farm => text().nullable()();
  TextColumn get washStation => text().nullable()();
  TextColumn get farmer => text().nullable()();
  TextColumn get varieties => text().nullable()();

  // Rating & Pricing & Sensory
  TextColumn get flavorProfile => text().nullable()();
  TextColumn get scaScore => text().nullable()();
  TextColumn get retailPrice => text().nullable()();
  TextColumn get wholesalePrice => text().nullable()();
  TextColumn get sensoryJson => text().withDefault(const Constant('{}'))();
  TextColumn get priceJson => text().withDefault(const Constant('{}'))();

  BoolColumn get isGround => boolean().withDefault(const Constant(false))();
  BoolColumn get isOpen => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  // Sync Status
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeletedLocal =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── FermentationLogs ────────────────────────────────────────────────────────
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

// ─── BrewingRecipes ──────────────────────────────────────────────────────────
class BrewingRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get methodKey => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get ratioGramsPerMl => real()();
  RealColumn get tempC => real()();
  IntColumn get totalTimeSec => integer()();
  TextColumn get difficulty => text()();
  TextColumn get stepsJson => text()();
  TextColumn get flavorProfile => text()();
  TextColumn get iconName => text()();
}

// ─── RecommendedRecipes ──────────────────────────────────────────────────────
class RecommendedRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lotId => integer().references(LocalizedBeans, #id)();
  TextColumn get methodKey => text()();
  RealColumn get coffeeGrams => real()();
  RealColumn get waterGrams => real()();
  RealColumn get tempC => real()();
  IntColumn get timeSec => integer()();
  RealColumn get rating => real()();
  TextColumn get sensoryJson => text().withDefault(const Constant('{}'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
}

// ─── CustomRecipes (User's Private) ──────────────────────────────────────────
class CustomRecipes extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get userId => text()();
  TextColumn get lotId => text().nullable()();
  TextColumn get methodKey => text()();
  TextColumn get name => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  RealColumn get coffeeGrams => real()();
  RealColumn get totalWaterMl => real()();
  IntColumn get grindNumber => integer().withDefault(const Constant(0))();
  IntColumn get comandanteClicks => integer().withDefault(const Constant(0))();
  IntColumn get ek43Division => integer().withDefault(const Constant(0))();
  IntColumn get totalPours => integer().withDefault(const Constant(1))();
  TextColumn get pourScheduleJson => text().withDefault(const Constant('[]'))();
  RealColumn get brewTempC => real().withDefault(const Constant(93.0))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get rating => integer().withDefault(const Constant(0))();

  // Sync Status
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeletedLocal =>
      boolean().withDefault(const Constant(false))();
}

// ─── BeanScans ───────────────────────────────────────────────────────────────
class BeanScans extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get userId => text().nullable()();
  DateTimeColumn get scannedAt => dateTime()();
  RealColumn get agtronValue => real()();
  TextColumn get roastLabel => text()();
  TextColumn get flavorProfile => text()();
  TextColumn get recommendedMethod => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();

  // Sync Status
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeletedLocal =>
      boolean().withDefault(const Constant(false))();
}
