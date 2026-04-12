import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
import 'app_database.dart';

/// Seeds all static content into the local Drift database on first launch.
/// Safe to call on every app start — checks isEmpty before inserting.
class CoffeeDataSeed {
  final AppDatabase db;
  CoffeeDataSeed(this.db);

  static const String bucketUrl = 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles';

  Future<void> seedAll({
    bool force = false,
    Function(String)? onProgress,
  }) async {
    onProgress?.call('Initializing database sync...');
    debugPrint('DB SEEDING: STARTING (FORCE=$force)...');

    if (force) {
      debugPrint('DB SEEDING: PERFORMING MANDATORY CLEANUP...');
      await db.transaction(() async {
        await db.delete(db.localizedBeans).go();
        await db.delete(db.localizedBeanTranslations).go();
        await db.delete(db.localizedBrands).go();
        await db.delete(db.localizedBrandTranslations).go();
        await db.delete(db.brewingRecipes).go();
        await db.delete(db.specialtyArticles).go();
        await db.delete(db.specialtyArticleTranslations).go();
        await db.delete(db.localizedFarmers).go();
        await db.delete(db.localizedFarmerTranslations).go();
      });
      debugPrint('DB SEEDING: CLEANUP COMPLETE.');
    }

    onProgress?.call('Seeding Brands...');
    await _seedBrands();
    onProgress?.call('Seeding Farmers from JSON...');
    await _seedFarmers();
    onProgress?.call('Seeding Encyclopedia from JSON...');
    await _seedEncyclopedia();
    onProgress?.call('Seeding Catalog [STABLE]...');
    await _seedMadHeadsOrigins();
    await _seed3ChampsOrigins();
    
    // onProgress?.call('Seeding Specialty Articles...');
    try {
      await _seedSpecialtyArticles();
      onProgress?.call('Seeding Recommended Recipes...');
      await _seedRecommendedRecipes();
      onProgress?.call('Seeding 30 Champion Brewing Recipes...');
      await _seedBrewingRecipes();

      onProgress?.call('All systems synchronized [STABLE]');
      debugPrint('DB SEEDING: ALL COMPLETED SUCCESSFULLY');
    } catch (e, st) {
      debugPrint('DB SEEDING FATAL ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Synchronization error: $e');
    }
  }

  Future<void> _seedBrands() async {
    final isEmpty = await db.brandsIsEmpty();
    if (!isEmpty) return;

    final List<Map<String, dynamic>> brandsToSeed = [
      {
        'main': LocalizedBrandsCompanion.insert(
          id: const Value(1),
          name: 'Mad Heads',
          logoUrl: const Value('$bucketUrl/brands/mad_heads.png'),
          siteUrl: const Value('https://madheadscoffee.com/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
            languageCode: 'uk',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value('Mad Heads Coffee — це незалежна українська обсмажка, заснована у 2017 році.'),
            location: const Value('Київ, вул. Кирилівська 69'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 1,
            languageCode: 'en',
            shortDesc: const Value('Stay Mad. Respect Quality.'),
            fullDesc: const Value('Mad Heads Coffee is an independent Ukrainian roaster founded in 2017.'),
            location: const Value('Kyiv, Kyrylivska st. 69'),
          ),
        ],
      },
      {
        'main': LocalizedBrandsCompanion.insert(
          id: const Value(2),
          name: '3Champs',
          logoUrl: const Value('$bucketUrl/brands/three_champs.png'),
          siteUrl: const Value('https://3champsroastery.com.ua/'),
        ),
        'trans': [
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 2,
            languageCode: 'uk',
            shortDesc: const Value('Спешелті обсмажка з акцентом на чистоту та яскравість смаку.'),
            fullDesc: const Value('3Champs Roastery — це команда професіоналів. Плодова 1.'),
            location: const Value('Kyiv, Plodova 1'),
          ),
          LocalizedBrandTranslationsCompanion.insert(
            brandId: 2,
            languageCode: 'en',
            shortDesc: const Value('Specialty roastery with an emphasis on purity.'),
            fullDesc: const Value('Professional team based in Kyiv.'),
            location: const Value('Kyiv, Plodova 1'),
          ),
        ],
      },
    ];

    for (var item in brandsToSeed) {
      await db.smartUpsertBrand(
        item['main'] as LocalizedBrandsCompanion,
        item['trans'] as List<LocalizedBrandTranslationsCompanion>,
      );
    }
  }

  Future<void> _seedFarmers() async {
    // Always upsert to ensure data is updated
    final farmers = [
      _FarmerEntry(
        id: 1,
        nameEn: 'Wilton Benitez',
        nameUk: 'Вілтон Бенітез',
        farmName: 'Granja Paraíso 92',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        specializationEn: 'Thermal Shock, Bioreactor Fermentation',
        specializationUk: 'Термальний шок, ферментація в біореакторах',
        bioUk: '''### Хімік-технолог кавового світу
Вілтон Бенітез перетворив свою ферму **Granja Paraíso 92** на справжню наукову лабораторію. Він не просто вирощує каву, він керує її хімічним складом на молекулярному рівні.

#### Ключові технології:
*   **Термальний шок:** Використання різкої зміни температури води (гаряча 40°C / холодна 12°C) для миттєвого закриття пор зерна, що дозволяє "запечатати" унікальні ароматичні сполуки всередині.
*   **Ферментація в біореакторах:** Використання сталевих резервуарів з повним контролем тиску та температури.
*   **Озонова стерилізація:** Очищення ягід озоном перед обробкою для повного видалення небажаних дріжджів та бактерій.''',
        imageUrl: 'assets/images/farmer_wilton_benitez.png',
      ),
      _FarmerEntry(
        id: 2,
        nameEn: 'Oscar & Francisca Chacón',
        nameUk: 'Оскар та Франциска Чакон',
        farmName: 'Micromill Las Lajas',
        countryEn: 'Costa Rica',
        countryUk: 'Коста-Рика',
        specializationEn: 'Black Diamond, Perla Negra, Honey Process',
        specializationUk: 'Black Diamond, Perla Negra, Хані обробки',
        bioUk: '''### Піонери натуральної обробки
Родина Чакон та їхня станція **Las Lajas** стали легендами завдяки своїм експериментам з "сонячною" обробкою кави. Вони були одними з перших у Коста-Риці, хто почав виробляти спешелті-лоти за допомогою Honey та Natural методів.

#### Авторські профілі:
*   **Perla Negra:** Метод, при якому ягоди сушаться на сонці, але на ніч накриваються плівкою для стимуляції внутрішньої ферментації.
*   **Black Diamond:** Надповільне сушіння при низьких температурах, що надає каві екстремальну солодкість та лікерні ноти.''',
        imageUrl: 'assets/images/farmer_oscar_francisca_chacon_1775463574148.png',
      ),
      _FarmerEntry(
        id: 3,
        nameEn: 'Diego Samuel Bermúdez',
        nameUk: 'Дієго Самуель Бермудес',
        farmName: 'Finca El Paraiso',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        specializationEn: 'Double Anaerobic Fermentation, Eco-Enigma Drying',
        specializationUk: 'Подвійна анаеробна ферментація, Еко-Енігма сушіння',
        bioUk: '''### Архітектор смаків
Дієго Бермудес — один із найінноваційніших фермерів Колумбії. Його лоти, такі як знаменитий "Red Plum", змінили уявлення про те, на що здатна кава.

#### Інновації:
*   **Двоетапна анаеробна ферментація:** Спочатку ферментація відбувається в цілій ягоді, потім — у клейковині після депульпації.
*   **Eco-Enigma:** Спеціальна машина для сушіння в закритому циклі, яка видаляє вологу без впливу зовнішнього середовища.''',
        imageUrl: 'assets/images/farmer_samuel_rony.png',
      ),
      _FarmerEntry(
        id: 5,
        nameEn: 'Carlos & Felipe Arcila',
        nameUk: 'Карлос та Феліпе Арсіла',
        farmName: 'Jardines del Eden',
        countryEn: 'Colombia',
        countryUk: 'Колумбія',
        specializationEn: 'Fruit Co-fermentation, Ice Fermentation',
        specializationUk: 'Фруктова ко-ферментація, крижана ферментація',
        bioUk: '''### Майстри фруктових інфузій
Брати Арсіла (Cofinet) — це ті, хто задає тренди у світі ко-ферментованої кави. Вони не бояться експериментувати з інгредієнтами, які раніше вважалися неприпустимими у спешелті.

#### Сміливі експерименти:
*   **Fruit Co-fermentation:** Додавання свіжих фруктів (персиків, полуниці, маракуї) безпосередньо в танки під час ферментації.
*   **Ice Fermentation:** Використання крижаної води для уповільнення процесів і досягнення максимальної чистоти чашки.''',
        imageUrl: 'assets/images/farmer_carlos_felipe_arcila_1775463591773.png',
      ),
      _FarmerEntry(
        id: 6,
        nameEn: 'Aida Batlle',
        nameUk: 'Аїда Батлл',
        farmName: 'Finca Kilimanjaro',
        countryEn: 'El Salvador',
        countryUk: 'Сальвадор',
        specializationEn: 'Cascara pioneer, Kenyan washed style',
        specializationUk: 'Піонерка каскари, мита обробка в кенійському стилі',
        bioUk: '''### Королева Сальвадору
Аїда Батлл — одна з найвідоміших жінок у світі спешелті кави. Вона успадкувала сімейне господарство і перетворила його на еталон якості в Центральній Америці.

#### Досягнення:
*   **Кенійський метод:** Впровадила метод подвійної ферментації в Сальвадорі, що дозволило отримати лоти з надзвичайною чистотою та кислотністю.
*   **Піонер Каскари:** Була однією з перших, хто почав професійно збирати та продавати каскару.''',
        imageUrl: 'assets/images/farmer_aida_batlle_1775463622660.png',
      ),
      _FarmerEntry(
        id: 7,
        nameEn: 'Adam Overton & Rachel Samuel',
        nameUk: 'Адам Овертон та Рейчел Семюел',
        farmName: 'Gesha Village',
        countryEn: 'Ethiopia',
        countryUk: 'Ефіопія',
        specializationEn: 'Gori Gesha preservation, Honey process',
        specializationUk: 'Збереження сорту Gori Gesha, Хані обробка',
        bioUk: '''### Повернення до витоків Гейші
Адам та Рейчел відправилися в експедицію до лісів Горі Геша на південному заході Ефіопії, щоб знайти дике насіння прабатьків сорту Гейша.

#### Проєкт Gesha Village:
*   **Збереження генетики:** Вони виділили кілька різних ефіопських диких сортів (Gori Gesha 2011, Gesha 1931).
*   **Екосистема:** Ферма інтегрована в природний ландшафт.''',
        imageUrl: 'assets/images/farmer_adam_rachel_overton_1775463606712.png',
      ),
      _FarmerEntry(
        id: 8,
        nameEn: 'Pepe Jijón',
        nameUk: 'Пепе Хіхон',
        farmName: 'Finca Soledad',
        countryEn: 'Ecuador',
        countryUk: 'Еквадор',
        specializationEn: 'Wave Fermentation, Biodynamic farming',
        specializationUk: 'Хвильова ферментація (Wave), біодинамічне землеробство',
        bioUk: '''### Біодинаміка серед хмар
Колишній професійний мандрівник та альпініст Пепе Хіхон знайшов свій спокій на високогір'ї Еквадору, створюючи одну з найбільш "етичних" ферм світу.

#### Філософія Wave:
*   **Хвильова ферментація:** Метод, де температура ферментації змінюється циклічно.
*   **Біодинаміка:** Повна відмова від хімікатів та робота з циклами природи.''',
        imageUrl: 'assets/images/farmer_pepe_jijon_1775463639704.png',
      ),
      _FarmerEntry(
        id: 9,
        nameEn: 'Alejo Castro',
        nameUk: 'Алехо Кастро',
        farmName: 'Volcan Azul',
        countryEn: 'Costa Rica',
        countryUk: 'Коста-Рика',
        specializationEn: 'Rare varietal preservation, Anaerobic Natural',
        specializationUk: 'Збереження рідкісних сортів, Анаеробна натуральна',
        bioUk: '''### Охоронець рідкісних різновидів
Представник п'ятого покоління кавової династії, Алехо Кастро, керує фермою **Volcan Azul**, розташованою біля підніжжя вулкана Поас.

#### Його місія:
*   **Генетичне розмаїття:** На фермі вирощується понад 40 різних сортів.
*   **Екологія:** Купівля та охорона гектарів дикого тропічного лісу навколо плантацій.''',
        imageUrl: 'assets/images/farmer_alejo_castro_1775463657692.png',
      ),
      _FarmerEntry(
        id: 10,
        nameEn: 'Luis Norberto Pascoal',
        nameUk: 'Луїс Норберто Паскоаль',
        farmName: 'Daterra',
        countryEn: 'Brazil',
        countryUk: 'Бразилія',
        specializationEn: 'Masterpieces (Aero, Anaerobic), B-Corp Sustainability',
        specializationUk: 'Masterpieces (Аеро, Анаеробні), B-Corp екологічність',
        bioUk: '''### Гігант інновацій
Ферма **Daterra** в Бразилії — це перша кавова ферма у світі, яка отримала сертифікат B-Corp за найвищі стандарти соціальної відповідальності та екології.

#### Masterpieces by Daterra:
*   **Експериментальні лоти:** Кожного року випускає серію "Masterpieces" — результат найбільш сміливих експериментів лабораторії.''',
        imageUrl: 'assets/images/farmer_luis_norberto_pascoal_1775463672082.png',
      ),
    ];

    for (var f in farmers) {
      await db.smartUpsertFarmer(
        LocalizedFarmersCompanion.insert(
          id: Value(f.id),
          imageUrl: Value(f.imageUrl),
          createdAt: Value(DateTime.now()),
        ),
        [
          LocalizedFarmerTranslationsCompanion.insert(
            farmerId: f.id,
            languageCode: 'uk',
            name: Value(f.nameUk),
            country: Value(f.countryUk),
            description: Value(f.specializationUk),
            story: Value(f.bioUk),
          ),
          LocalizedFarmerTranslationsCompanion.insert(
            farmerId: f.id,
            languageCode: 'en',
            name: Value(f.nameEn),
            country: Value(f.countryEn),
            description: Value(f.specializationEn),
            story: const Value(''),
          ),
        ],
      );
    }
  }

  Future<void> _seedEncyclopedia() async {
    // Always upsert to ensure data is updated
    final articles = [
      _ArticleEntry(
        id: '1',
        titleEn: 'Standards & Ethics',
        titleUk: 'Стандарти та Етика',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_1_standards_1775401113100.png',
        contentUk: '''### 1. Фундамент Specialty Coffee
Specialty Coffee — це не просто кава, це система контролю якості від ферми до чашки.

#### Ключові атрибути:
*   **Traceability:** Ми знаємо точні GPS-координати ділянки.
*   **Сенсорна чистота:** Відсутність дефектів (Clean Cup).

#### SCA та CQI
*   **SCA (Specialty Coffee Association):** Встановлює технічні стандарти води, збору та обробки.
*   **CQI (Coffee Quality Institute):** Сертифікує **Q-Grader-ів** — спеціалістів, що виставляють бали каві.''',
      ),
      _ArticleEntry(
        id: '2',
        titleEn: 'Botany & Terroir',
        titleUk: 'Ботаніка та Теруар',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_2_botany_1775401234532.png',
        contentUk: '''### Генетика та Середовище
Смак кави закладається в зерні задовго до обсмажування.

#### Теруар:
*   **Висота:** Понад 1500м уповільнює метаболізм дерева, накопичуючи більше цукрів.
*   **Грунт:** Вулканічний попіл надає іскристу кислотність.

#### Різновиди:
*   **Geisha:** Елітна панамська кава з квітковим профілем.
*   **SL-28:** Кенійська легенда з нотами чорної смородини.''',
      ),
      _ArticleEntry(
        id: '3',
        titleEn: 'Harvesting & Sorting',
        titleUk: 'Збір та Сортування',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_3_agronomy_1775401618408.png',
        contentUk: '''### Тільки стиглі ягоди
У спешелті допускається лише **Hand Picking** — ручний збір.

#### Чому це важливо?
*   Недоспіла ягода (Quakers) дає в'яжучий смак арахісової пасти.
*   Переспіла ягода може додати небажаної оцтової ферментації.

#### Оптичне сортування:
Сучасні ферми використовують лазери для видалення дефектних зерен за кольором та щільністю.''',
      ),
      _ArticleEntry(
        id: '4',
        titleEn: 'Processing & Fermentation',
        titleUk: 'Обробка та Ферментація',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_4_advanced_processing_1775401484863.png',
        contentUk: '''### Магія перетворення
Обробка — це процес видалення шарів кавової ягоди для вивільнення зерна.

#### Основні методи:
*   **Washed (Мита):** Наголос на чистоті та кислотності.
*   **Natural (Натуральна):** Тільність, солодкість та фруктові ноти.
*   **Honey:** Проміжний варіант, де залишається частина клейковини.

#### Анаеробна ферментація:
Кава ферментується без кисню в танках, що створює екзотичні дескриптори (алкогольні ноти, прянощі).''',
      ),
      _ArticleEntry(
        id: '5',
        titleEn: 'Quality Control',
        titleUk: 'Контроль Якості (Green Coffee)',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_5_milling_1775401521163.png',
        contentUk: '''### Аналіз зеленого зерна
Перед обсмажуванням кава проходить суворий контроль.

#### Параметри оцінки:
*   **Moisture Content:** Оптимально 10-12%.
*   **Density:** Висока щільність означає багатший смак.
*   **Defects:** Пошук "чорних" зерен, пошкоджень комахами та плісняви.

Використання колориметрів та вологомірів є стандартом для Specialty лабораторій.''',
      ),
      _ArticleEntry(
        id: '6',
        titleEn: 'Roasting Science',
        titleUk: 'Наука Обсмажування',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_6_roasting_1775401540972.png',
        contentUk: '''### Реакція Маяра та Карамелізація
Обсмажування — це керована хімічна реакція.

#### Етапи:
1.  **Drying Phase:** Випаровування залишків вологи.
2.  **Maillard Reaction:** Формування складних ароматичних сполук.
3.  **First Crack:** Фізичне розширення зерна, початок розвитку.

#### Мета:
Підкреслити терруар, а не "смак смаженого".''',
      ),
      _ArticleEntry(
        id: '7',
        titleEn: 'Sensory & Water',
        titleUk: 'Сенсорика та Хімія Води',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_7_sensory_analysis_1775401560217.png',
        contentUk: '''### Смак — це хімія
Ми п'ємо розчин, де 98-99% — це вода.

#### Роль води:
*   **Магній (Mg2+):** Витягує складні фруктові та ягідні ноти.
*   **Кальцій (Ca2+):** Допомагає розкрити тільність кави.
*   **Буферність (Лужність):** Регулює інтенсивність кислотності.

#### Сенсорний аналіз:
Калібрування за протоколами SCA для об'єктивної оцінки смаку, а не просто "мені подобається".''',
      ),
      _ArticleEntry(
        id: '8',
        titleEn: 'Espresso Physics',
        titleUk: 'Фізика та Хімія Еспресо',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_8_espresso_physics_1775401579031.png',
        contentUk: '''### Екстракція під тиском
Еспресо — це найбільш концентрований спосіб заварювання кави.

#### Параметри:
*   **Тиск:** Традиційні 9 бар або профілювання тиску для Гейші.
*   **Температура:** Впливає на швидкість розчинення речовин.
*   **Brew Ratio:** Співвідношення меленої кави до ваги напою (класика 1:2).

#### Каналізація (Channeling):
Проблема нерівномірованного проходження води через кавову таблетку, що призводить до дисбалансу смаку.''',
      ),
      _ArticleEntry(
        id: '9',
        titleEn: 'Digital Traceability',
        titleUk: 'Діджиталізація та Сталий розвиток',
        categoryEn: 'Education',
        categoryUk: 'Освіта',
        imageUrl: 'assets/images/encyclopedia_module_9_digitalization_1775401596943.png',
        contentUk: '''### Майбутнє індустрії
Сучасні технології допомагають зробити ланцюжок постачання прозорим.

#### Технології:
*   **Blockchain:** Реєстрація кожної транзакції між фермером та обсмажкою.
*   **Профілювання обсмажування:** Програмне забезпечення (Cropster, Artisan) для ідентичного повторення профілів.

#### Sustainability:
Боротьба зі змінами клімату та забезпечення гідної оплати праці збирачів кави.''',
      ),
    ];

    for (var a in articles) {
      final articleId = int.parse(a.id);
      await db.smartUpsertArticle(
        SpecialtyArticlesCompanion.insert(
          id: Value(articleId),
          imageUrl: a.imageUrl,
          readTimeMin: 5,
        ),
        [
          SpecialtyArticleTranslationsCompanion.insert(
            articleId: articleId,
            languageCode: 'uk',
            title: a.titleUk,
            subtitle: a.categoryUk,
            contentHtml: a.contentUk,
          ),
          SpecialtyArticleTranslationsCompanion.insert(
            articleId: articleId,
            languageCode: 'en',
            title: a.titleEn,
            subtitle: a.categoryEn,
            contentHtml: 'Coming soon...',
          ),
        ],
      );
    }
  }

  Future<void> _seedBrewingRecipes() async {
    // We clear current recipes to ensure we get exactly the unique ones
    await db.delete(db.brewingRecipes).go();

    final List<BrewingRecipesCompanion> recipes = [];
    _addV60Recipes(recipes);
    _addAeropressRecipes(recipes);
    _addChemexRecipes(recipes);
    _addFrenchPressRecipes(recipes);
    _addEspressoRecipes(recipes);
    _addMokaRecipes(recipes);
    _addCleverRecipes(recipes);
    _addColdBrewRecipes(recipes);

    for (var r in recipes) {
      await db.into(db.brewingRecipes).insert(r, mode: InsertMode.insertOrReplace);
    }
  }

  void _addV60Recipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'v60',
      name: 'Tetsu Kasuya 4:6 Method',
      description: 'World Brewers Cup 2016 Winning Recipe.',
      ratioGramsPerMl: 20 / 300,
      tempC: 92.0,
      totalTimeSec: 210,
      difficulty: 'Advanced',
      flavorProfile: 'Balanced & Sweet',
      iconName: 'v60',
      stepsJson: jsonEncode([
        {'title': 'Bloom', 'desc': 'Pour 50g. Wait 45s.', 'durationSec': 45},
        {'title': '2nd Pour', 'desc': 'Pour 70g. Wait until 1:30.', 'durationSec': 45},
        {'title': '3rd Pour', 'desc': 'Pour 60g. Wait until 2:15.', 'durationSec': 45},
        {'title': '4th Pour', 'desc': 'Pour 60g. Wait until 3:00.', 'durationSec': 45},
        {'title': 'Final Pour', 'desc': 'Pour 60g. Total 300g.', 'durationSec': 30},
      ]),
    ));
  }

  void _addAeropressRecipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'aeropress',
      name: 'Tim Wendelboe Ritual',
      description: 'Simple and consistent inverted method.',
      ratioGramsPerMl: 14 / 200,
      tempC: 95.0,
      totalTimeSec: 120,
      difficulty: 'Easy',
      flavorProfile: 'Elegant',
      iconName: 'aeropress',
      stepsJson: jsonEncode([
        {'title': 'Immersion', 'desc': 'Add coffee and water. Stir 3 times.', 'durationSec': 60},
        {'title': 'Flip & Press', 'desc': 'Flip and press for 30s.', 'durationSec': 60},
      ]),
    ));
  }

  void _addChemexRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'chemex');
  void _addFrenchPressRecipes(List<BrewingRecipesCompanion> list) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: 'french_press',
      name: 'James Hoffmann French Press',
      description: 'The "No Press" method.',
      ratioGramsPerMl: 30 / 500,
      tempC: 95.0,
      totalTimeSec: 600,
      difficulty: 'Easy',
      flavorProfile: 'Full Body',
      iconName: 'french_press',
      stepsJson: jsonEncode([
        {'title': 'Steep', 'desc': 'Wait 4 minutes.', 'durationSec': 240},
        {'title': 'Clean', 'desc': 'Remove foam.', 'durationSec': 60},
        {'title': 'Wait', 'desc': 'Wait 5 more minutes.', 'durationSec': 300},
      ]),
    ));
  }

  void _addEspressoRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'espresso');
  void _addMokaRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'moka_pot');
  void _addCleverRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'clever');
  void _addColdBrewRecipes(List<BrewingRecipesCompanion> list) => _addGenericRecipes(list, 'cold_brew');

  void _addGenericRecipes(List<BrewingRecipesCompanion> list, String method) {
    list.add(BrewingRecipesCompanion.insert(
      methodKey: method,
      name: '${method.toUpperCase()} Classic Recipe',
      description: 'Standard starting recipe for $method.',
      ratioGramsPerMl: 1 / 15,
      tempC: 94.0,
      totalTimeSec: 180,
      difficulty: 'Intermediate',
      flavorProfile: 'Balanced',
      iconName: method,
      stepsJson: jsonEncode([
        {'title': 'Preparation', 'desc': 'Setup and bloom.', 'durationSec': 60},
        {'title': 'Brewing', 'desc': 'Main extraction.', 'durationSec': 120},
      ]),
    ));
  }

  Future<void> _seedRecommendedRecipes() async {
    await db.delete(db.recommendedRecipes).go();
    final allLots = await db.select(db.localizedBeans).get();
    if (allLots.isEmpty) return;
    for (var lot in allLots) {
      await db.insertRecommendedRecipe(
        RecommendedRecipesCompanion.insert(
          lotId: lot.id,
          methodKey: 'v60',
          coffeeGrams: 15.0,
          waterGrams: 250.0,
          tempC: 93.0,
          timeSec: 180,
          rating: 4.8,
          sensoryJson: const Value('{}'),
          notes: const Value('Best with 4:6 method.'),
        ),
      );
    }
  }

  Future<void> _seedMadHeadsOrigins() async {
    final entries = [
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(101), brandId: const Value(1), countryEmoji: const Value('🇪🇹'), cupsScore: const Value(88.0)),
        LocalizedBeanTranslationsCompanion.insert(beanId: 101, languageCode: 'uk', country: const Value('Ефіопія'), region: const Value('Guji'), varieties: const Value('Heirloom'), flavorNotes: Value(jsonEncode(['Peach', 'Jasmine'])), description: const Value('Класична мита Ефіопія.')),
      ),
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(102), brandId: const Value(1), countryEmoji: const Value('🇨🇴'), cupsScore: const Value(87.5)),
        LocalizedBeanTranslationsCompanion.insert(beanId: 102, languageCode: 'uk', country: const Value('Колумбія'), region: const Value('Huila'), varieties: const Value('Caturra'), flavorNotes: Value(jsonEncode(['Chocolate', 'Red Apple'])), description: const Value('Збалансована Колумбія.')),
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, [e.trans]);
    }
  }

  Future<void> _seed3ChampsOrigins() async {
    final entries = [
      _Entry(
        LocalizedBeansCompanion.insert(id: const Value(201), brandId: const Value(2), countryEmoji: const Value('🇰🇪'), cupsScore: const Value(89.0)),
        LocalizedBeanTranslationsCompanion.insert(beanId: 201, languageCode: 'uk', country: const Value('Кенія'), region: const Value('Nyeri'), varieties: const Value('SL28'), flavorNotes: Value(jsonEncode(['Blackcurrant', 'Tomato'])), description: const Value('Яскрава Кенія.')),
      ),
    ];
    for (var e in entries) {
      await db.smartUpsertBean(e.main, [e.trans]);
    }
  }

  Future<void> _seedSpecialtyArticles() async {
    // Handled by _seedEncyclopedia
  }
}

class _FarmerEntry {
  final int id;
  final String nameEn;
  final String nameUk;
  final String farmName;
  final String countryEn;
  final String countryUk;
  final String specializationEn;
  final String specializationUk;
  final String bioUk;
  final String imageUrl;

  _FarmerEntry({
    required this.id,
    required this.nameEn,
    required this.nameUk,
    required this.farmName,
    required this.countryEn,
    required this.countryUk,
    required this.specializationEn,
    required this.specializationUk,
    required this.bioUk,
    required this.imageUrl,
  });
}

class _ArticleEntry {
  final String id;
  final String titleEn;
  final String titleUk;
  final String categoryEn;
  final String categoryUk;
  final String contentUk;
  final String imageUrl;

  _ArticleEntry({
    required this.id,
    required this.titleEn,
    required this.titleUk,
    required this.categoryEn,
    required this.categoryUk,
    required this.contentUk,
    required this.imageUrl,
  });
}

class _Entry {
  final LocalizedBeansCompanion main;
  final LocalizedBeanTranslationsCompanion trans;
  _Entry(this.main, this.trans);
}


