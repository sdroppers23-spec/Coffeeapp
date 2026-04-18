// ─── Schema version: 26 (Localized Composite Keys & Recovery) ──────────────
// Per-language columns removed from all main tables.
// Each table now has a companion *Translations table.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

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

  // PRIMARY CONTENT (UK)
  TextColumn get countryUk => text().nullable()();
  TextColumn get regionUk => text().nullable()();
  TextColumn get varietiesUk => text().nullable()();
  TextColumn get flavorNotesUk => text().withDefault(const Constant('[]'))();
  TextColumn get processMethodUk => text().nullable()();
  TextColumn get descriptionUk => text().nullable()();
  TextColumn get farmDescriptionUk => text().nullable()();
  TextColumn get roastLevelUk => text().nullable()();

  TextColumn get farm => text().nullable()();
  TextColumn get farmPhotosUrlCover => text().nullable()();
  TextColumn get washStation => text().nullable()();
  TextColumn get retailPrice => text().nullable()();
  TextColumn get wholesalePrice => text().nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedBeanTranslations extends Table {
  IntColumn get beanId => integer().references(LocalizedBeans, #id)();
  TextColumn get languageCode => text()(); // 'en', 'pl', etc.

  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get varieties => text().nullable()();
  TextColumn get flavorNotes => text().withDefault(const Constant('[]'))();
  TextColumn get processMethod => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get farmDescription => text().nullable()();
  TextColumn get roastLevel => text().nullable()();

  @override
  Set<Column> get primaryKey => {beanId, languageCode};
}

// ─── LocalizedBrands ─────────────────────────────────────────────────────────
class LocalizedBrands extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get siteUrl => text().nullable()();
  
  // PRIMARY CONTENT (UK)
  TextColumn get shortDescUk => text().nullable()();
  TextColumn get fullDescUk => text().nullable()();
  TextColumn get locationUk => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedBrandTranslations extends Table {
  IntColumn get brandId => integer().references(LocalizedBrands, #id)();
  TextColumn get languageCode => text()();

  TextColumn get shortDesc => text().nullable()();
  TextColumn get fullDesc => text().nullable()();
  TextColumn get location => text().nullable()();

  @override
  Set<Column> get primaryKey => {brandId, languageCode};
}

// ─── LocalizedFarmers (Wide Table for 13 Languages) ──────────────────────────
// ─── LocalizedFarmers (Main + Translations) ──────────────────────────
class LocalizedFarmers extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // PRIMARY (Ukrainian)
  TextColumn get nameUk => text().withDefault(const Constant('Тут має бути ім\'я'))();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути фото'))();
  TextColumn get flagUrl => text().withDefault(const Constant('Тут має бути прапор'))();
  TextColumn get descriptionHtmlUk => text().withDefault(const Constant('Тут має бути опис'))();
  TextColumn get regionUk => text().nullable()();
  TextColumn get countryUk => text().nullable()();

  // Coordinates & Metadata
  TextColumn get storyUk => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class LocalizedFarmerTranslations extends Table {
  IntColumn get farmerId => integer().references(LocalizedFarmers, #id)();
  TextColumn get languageCode => text()(); // 'en', 'pl', etc.

  TextColumn get name => text().nullable()();
  TextColumn get descriptionHtml => text().nullable()();
  TextColumn get story => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get country => text().nullable()();

  @override
  Set<Column> get primaryKey => {farmerId, languageCode};
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
  TextColumn get regionId => text().references(SphereRegions, #id)();
  TextColumn get languageCode => text()();

  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get flavorProfile => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {regionId, languageCode};
}

class SpecialtyArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // PRIMARY (Ukrainian)
  TextColumn get titleUk => text().withDefault(const Constant('Тут має бути заголовок'))();
  TextColumn get subtitleUk => text().nullable()();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути лінк на бакет'))();
  TextColumn get flagUrl => text().withDefault(const Constant('Тут має бути лінк на прапор'))();
  TextColumn get contentHtmlUk => text().withDefault(const Constant('Тут має бути текст статті'))();
  IntColumn get readTimeMin => integer().withDefault(const Constant(5))();
}

class SpecialtyArticleTranslations extends Table {
  IntColumn get articleId => integer().references(SpecialtyArticles, #id)();
  TextColumn get languageCode => text()(); // 'en', 'pl', etc.

  TextColumn get title => text().nullable()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get contentHtml => text().nullable()();

  @override
  Set<Column> get primaryKey => {articleId, languageCode};
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
  TextColumn get imageUrl => text().nullable()();
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

// ─── BrewingRecipes (Wide Table for 13 Languages) ──────────────────────────
class BrewingRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get methodKey => text().unique()();
  
  // PRIMARY CONTENT (UK)
  TextColumn get nameUk => text().withDefault(const Constant('Назва методу'))();
  TextColumn get descriptionUk => text().withDefault(const Constant('Тут має бути опис'))();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути лінк на фото'))();

  // Settings
  RealColumn get ratioGramsPerMl => real().withDefault(const Constant(0.066))();
  RealColumn get tempC => real().withDefault(const Constant(93.0))();
  IntColumn get totalTimeSec => integer().withDefault(const Constant(180))();
  TextColumn get difficulty => text().withDefault(const Constant('Intermediate'))();
  TextColumn get stepsJson => text().withDefault(const Constant('[]'))();
  TextColumn get flavorProfile => text().withDefault(const Constant('Balanced'))();
  TextColumn get iconName => text().nullable()();
}

class BrewingRecipeTranslations extends Table {
  TextColumn get recipeKey => text().references(BrewingRecipes, #methodKey)();
  TextColumn get languageCode => text()(); // 'en', 'pl', etc.

  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {recipeKey, languageCode};
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

  // Advanced Recipe Features
  IntColumn get microns => integer().nullable()();
  TextColumn get recipeType => text().withDefault(const Constant('filter'))(); // 'espresso' or 'filter'
  RealColumn get brewRatio => real().nullable()();
  TextColumn get grinderName => text().nullable()();

  // Sync Status
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeletedLocal =>
      boolean().withDefault(const Constant(false))();
}

// BeanScans removed as per user request
