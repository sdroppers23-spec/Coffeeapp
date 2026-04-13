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
  Set<Column> get primaryKey => {beanId, languageCode};
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
  IntColumn get brandId => integer().references(LocalizedBrands, #id)();
  TextColumn get languageCode => text()();

  TextColumn get shortDesc => text().nullable()();
  TextColumn get fullDesc => text().nullable()();
  TextColumn get location => text().nullable()();

  @override
  Set<Column> get primaryKey => {brandId, languageCode};
}

// ─── LocalizedFarmers (Wide Table for 13 Languages) ──────────────────────────
class LocalizedFarmers extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // PRIMARY (Ukrainian)
  TextColumn get nameUk => text().withDefault(const Constant('Тут має бути ім\'я'))();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути фото'))();
  TextColumn get flagUrl => text().withDefault(const Constant('Тут має бути прапор'))();
  TextColumn get descriptionHtmlUk => text().withDefault(const Constant('Тут має бути опис'))();
  TextColumn get regionUk => text().nullable()();
  TextColumn get countryUk => text().nullable()();

  // OTHER LANGUAGES (12)
  TextColumn get nameEn => text().nullable()();
  TextColumn get descriptionHtmlEn => text().nullable()();

  TextColumn get namePl => text().nullable()();
  TextColumn get descriptionHtmlPl => text().nullable()();

  TextColumn get nameDe => text().nullable()();
  TextColumn get descriptionHtmlDe => text().nullable()();

  TextColumn get nameFr => text().nullable()();
  TextColumn get descriptionHtmlFr => text().nullable()();

  TextColumn get nameEs => text().nullable()();
  TextColumn get descriptionHtmlEs => text().nullable()();

  TextColumn get nameIt => text().nullable()();
  TextColumn get descriptionHtmlIt => text().nullable()();

  TextColumn get namePt => text().nullable()();
  TextColumn get descriptionHtmlPt => text().nullable()();

  TextColumn get nameRo => text().nullable()();
  TextColumn get descriptionHtmlRo => text().nullable()();

  TextColumn get nameTr => text().nullable()();
  TextColumn get descriptionHtmlTr => text().nullable()();

  TextColumn get nameJa => text().nullable()();
  TextColumn get descriptionHtmlJa => text().nullable()();

  TextColumn get nameKo => text().nullable()();
  TextColumn get descriptionHtmlKo => text().nullable()();

  TextColumn get nameZh => text().nullable()();
  TextColumn get descriptionHtmlZh => text().nullable()();

  // Coordinates & Metadata
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
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

// ─── SpecialtyArticles (Wide Table for 13 Languages) ─────────────────────────
class SpecialtyArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // PRIMARY (Ukrainian)
  TextColumn get titleUk => text().withDefault(const Constant('Тут має бути заголовок'))();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути лінк на бакет'))();
  TextColumn get flagUrl => text().withDefault(const Constant('Тут має бути лінк на прапор'))();
  TextColumn get contentHtmlUk => text().withDefault(const Constant('Тут має бути текст статті'))();
  IntColumn get readTimeMin => integer().withDefault(const Constant(5))();

  // OTHER LANGUAGES (12)
  TextColumn get titleEn => text().nullable()();
  TextColumn get contentHtmlEn => text().nullable()();

  TextColumn get titlePl => text().nullable()();
  TextColumn get contentHtmlPl => text().nullable()();

  TextColumn get titleDe => text().nullable()();
  TextColumn get contentHtmlDe => text().nullable()();

  TextColumn get titleFr => text().nullable()();
  TextColumn get contentHtmlFr => text().nullable()();

  TextColumn get titleEs => text().nullable()();
  TextColumn get contentHtmlEs => text().nullable()();

  TextColumn get titleIt => text().nullable()();
  TextColumn get contentHtmlIt => text().nullable()();

  TextColumn get titlePt => text().nullable()();
  TextColumn get contentHtmlPt => text().nullable()();

  TextColumn get titleRo => text().nullable()();
  TextColumn get contentHtmlRo => text().nullable()();

  TextColumn get titleTr => text().nullable()();
  TextColumn get contentHtmlTr => text().nullable()();

  TextColumn get titleJa => text().nullable()();
  TextColumn get contentHtmlJa => text().nullable()();

  TextColumn get titleKo => text().nullable()();
  TextColumn get contentHtmlKo => text().nullable()();

  TextColumn get titleZh => text().nullable()();
  TextColumn get contentHtmlZh => text().nullable()();
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

// ─── BrewingRecipes (Wide Table for 13 Languages) ──────────────────────────
class BrewingRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get methodKey => text().unique()();
  
  // PRIMARY (Ukrainian)
  TextColumn get nameUk => text().withDefault(const Constant('Тут має бути назва'))();
  TextColumn get descriptionUk => text().withDefault(const Constant('Тут має бути опис'))();
  TextColumn get imageUrl => text().withDefault(const Constant('Тут має бути лінк на фото'))();

  // OTHER LANGUAGES (12)
  TextColumn get nameEn => text().nullable()();
  TextColumn get descriptionEn => text().nullable()();

  TextColumn get namePl => text().nullable()();
  TextColumn get descriptionPl => text().nullable()();

  TextColumn get nameDe => text().nullable()();
  TextColumn get descriptionDe => text().nullable()();

  TextColumn get nameFr => text().nullable()();
  TextColumn get descriptionFr => text().nullable()();

  TextColumn get nameEs => text().nullable()();
  TextColumn get descriptionEs => text().nullable()();

  TextColumn get nameIt => text().nullable()();
  TextColumn get descriptionIt => text().nullable()();

  TextColumn get namePt => text().nullable()();
  TextColumn get descriptionPt => text().nullable()();

  TextColumn get nameRo => text().nullable()();
  TextColumn get descriptionRo => text().nullable()();

  TextColumn get nameTr => text().nullable()();
  TextColumn get descriptionTr => text().nullable()();

  TextColumn get nameJa => text().nullable()();
  TextColumn get descriptionJa => text().nullable()();

  TextColumn get nameKo => text().nullable()();
  TextColumn get descriptionKo => text().nullable()();

  TextColumn get nameZh => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  // Settings
  RealColumn get ratioGramsPerMl => real().withDefault(const Constant(0.066))();
  RealColumn get tempC => real().withDefault(const Constant(93.0))();
  IntColumn get totalTimeSec => integer().withDefault(const Constant(180))();
  TextColumn get difficulty => text().withDefault(const Constant('Intermediate'))();
  TextColumn get stepsJson => text().withDefault(const Constant('[]'))();
  TextColumn get flavorProfile => text().withDefault(const Constant('Balanced'))();
  TextColumn get iconName => text().nullable()();
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

// BeanScans removed as per user request
