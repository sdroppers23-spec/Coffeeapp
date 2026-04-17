import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends Notifier<String> {
  @override
  String build() => 'uk';
  void setLocale(String lang) => state = lang;
}

final localeProvider = NotifierProvider<LocaleNotifier, String>(
  () => LocaleNotifier(),
);

extension LocalizationExtension on WidgetRef {
  String t(String key) {
    final locale = watch(
      localeProvider,
    ); // watch triggers rebuild on locale change
    return AppLocalizations(locale).translate(key);
  }
}

extension BuildContextLocalization on BuildContext {
  String t(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}

class LocaleService {
  static String get currentLocale => 'uk'; // Default to UK for v17 bridge
}

class AppLocalizations {
  final String locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(
      ProviderScope.containerOf(context).read(localeProvider),
    );
  }

  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'discover': 'Discover',
      'timer': 'Timer',
      'scanner': 'Scanner',
      'settings': 'Settings',
      'profile': 'My Profile',
      'encyclopedia': 'Encyclopedia',
      'farmers': 'Farmers',
      'roasters': 'Roasters',
      'specialty': 'Specialty',
      'recipes': 'Recipes',
      'scans': 'Scans',
      'badges': 'Badges',
      'edit_profile': 'EDIT PROFILE',
      'sign_out': 'Sign Out',
      'compare': 'Compare',
      'log_in': 'LOG IN',
      'sign_up': 'SIGN UP',
      'email': 'Email',
      'password': 'Password',
      'google_sign_in': 'Continue with Google',
      'language': 'Language',
      'bloom': 'Bloom',
      'pour': 'Pour',
      'next': 'Next',
      'prev': 'Prev',
      'running': 'RUNNING',
      'paused': 'PAUSED',
      'reset': 'Reset',
      'source': 'Source',
      'purchase_details': 'PURCHASE DETAILS',
      'price': 'Price',
      'weight': 'Weight',
      'roast_date': 'Roast Date',
      'lot_number': 'Lot #',
      'roast_level': 'ROAST LEVEL',
      'sync_options': 'Data Sync',
      'sync_choice_desc': 'Choose synchronization mode:',
      'cloud_sync': 'Cloud Sync',
      'push_local': 'Push to Cloud',
      'process_natural': 'Natural',
      'process_washed': 'Washed',
      'process_anaerobic': 'Anaerobic',
      'process_honey': 'Honey',
      'process_washed_desc':
          '### Stage 1: Depulping\nThe skin and pulp are removed mechanically. The sticky mucilage stays on the parchment.\n### Stage 2: Fermentation\nBeans soak in water tanks for 12-48 hours where bacteria break down the mucilage.\n### Stage 3: Washing & Drying\nBeans are washed with clean water and dried on patios or beds for 1-2 weeks.',
      'process_natural_desc':
          '### Stage 1: Sorting\nOnly ripe cherries are selected and spread out on African beds or patios.\n### Stage 2: Drying\nThe whole fruit dries for 2-4 weeks, allowing sugars to concentrate inside the bean.\n### Stage 3: Hulling\nThe dried "raisin-like" husk is removed only after reaching 11-12% moisture.',
      'process_anaerobic_desc':
          '### Stage 1: Sealing\nCherries are placed in airtight tanks where oxygen is removed.\n### Stage 2: Controlled Fermentation\nLactic acid bacteria thrive for 48-120 hours creating complex, funky flavor profiles.',
      'process_thermal_desc':
          '### Stage 1: Hot Shock\nBeans are washed with 40°C water to expand pores and absorb fermentation products.\n### Stage 2: Cold Shock\nImmediately rinsed with 12°C water to "lock" the intense flavors inside the bean.',
      'shop_coffee': 'SHOP THIS COFFEE',
      'terroir_farm': 'TERROIR & FARM',
      'sensory_grid': 'SENSORY PROFILE',
      'cupping_score': 'Cupping Score',
      'aroma': 'Aroma',
      'body': 'Body',
      'aftertaste': 'Aftertaste',
      'acidity_type': 'Acidity Type',
      'indicators': 'Indicators',
      'acidity': 'Acidity',
      'sweetness': 'Sweetness',
      'bitterness': 'Bitterness',
      'intensity': 'Intensity',
      'flavor': 'Flavor',
      'balance': 'Balance',
      'process_washed_label': 'Washed',
      'process_natural_label': 'Natural',
      'process_honey_label': 'Honey',
      'process_anaerobic_label': 'Anaerobic',
      'tab_product': 'Product',
      'tab_source': 'Source',
      'tab_recipes': 'Recipes',
      'roast_light': 'LIGHT',
      'roast_medium': 'MEDIUM',
      'roast_dark': 'DARK',
      'no_recipes_for_lot': 'No recommended recipes for this lot yet.',
      'process_detail': 'PROCESSING DETAILS',
      'story_terroir': 'STORY & TERROIR',
      'coffee_origins': 'Coffee Origins',
      'premium_roasters': 'Premium Roasters',
      'auth_subtitle': 'Sign in to sync your coffee journey',
      'search_origins': 'Search origins...',
      'no_results': 'No results for',
      'altitude': 'Altitude',
      'varieties': 'Varieties',
      'region': 'Region',
      'process': 'Process',
      'lot_desc_col_46_filter':
          'Complex acidity, long blackberry aftertaste. Light roast for filter brewing.',
      'lot_desc_col_31_filter':
          'Long apple acidity. Thermal shock processed Chiroso variety.',
      'lot_desc_kenya_20_filter':
          'Bright berry classic. Notes of red berries and honey.',
      'lot_desc_eth_37_filter':
          'Clean and elegant tea profile. Jasmine and lemon notes.',
      'lot_desc_col_46_espresso':
          'Full body, perfect for milk-based drinks. Notes of pear and marzipan.',
      'lot_desc_tanzania_utengule':
          'Sweet and balanced lot from Tanzania. Honey process adds honey sweetness and fruit clarity.',
      'lot_desc_col_alto_osos':
          'Aged natural processing with anaerobic-like sweetness. High complexity with tropical fruit and rum notes.',
      'lot_desc_indonesia_manis':
          'Indonesia without earthiness. Only fruit, rum, and chocolate delight.',
      'lot_desc_kenya_gichathaini':
          'Bright and juicy Kenya with characteristic currant acidity and long aftertaste.',
      'catalog': 'Catalog',
      'favorites': 'Favorites',
      'compare_tab': 'Comparison',
      'sort_by': 'Sort by',
      'sort_country_az': 'Country (A-Z)',
      'sort_country_za': 'Country (Z-A)',
      'sort_region_az': 'Region (A-Z)',
      'sort_region_za': 'Region (Z-A)',
      'sort_country_region': 'Country & Region',
      'sort_price_retail_high': 'Price (Retail: High-Low)',
      'sort_price_retail_low': 'Price (Retail: Low-High)',
      'sort_price_wholesale_high': 'Price (Wholesale: Max)',
      'sort_process': 'Processing Method',
      'sort_newest': 'Newest First',
      'no_favorites': 'No favorites yet',
      'read_more': 'Read more',
      'about_farm_region': 'ABOUT FARM & REGION',
      'recipes_processing': 'PROCESSING METHODS',
      'harvest': 'Harvest',
    },
    'uk': {
      'discover': 'Відкриття',
      'timer': 'Таймер',
      'scanner': 'Сканер',
      'settings': 'Налаштування',
      'profile': 'Мій Профіль',
      'encyclopedia': 'Енциклопедія',
      'farmers': 'Фермери',
      'roasters': 'Обсмажчики',
      'specialty': 'Спешелті',
      'recipes': 'Рецепти',
      'scans': 'Скан-історія',
      'badges': 'Значки',
      'edit_profile': 'РЕДАГУВАТИ ПРОФІЛЬ',
      'sign_out': 'Вийти',
      'compare': 'Порівняти',
      'log_in': 'УВІЙТИ',
      'sign_up': 'РЕЄСТРАЦІЯ',
      'email': 'Email',
      'password': 'Пароль',
      'google_sign_in': 'Увійти з Google',
      'language': 'Мова',
      'bloom': 'Блум',
      'pour': 'Вливання',
      'next': 'Далі',
      'prev': 'Назад',
      'running': 'ПРАЦЮЄ',
      'paused': 'ПАУЗА',
      'reset': 'Скинути',
      'source': 'Джерело',
      'purchase_details': 'ДЕТАЛІ ПОКУПКИ',
      'price': 'Ціна',
      'weight': 'Вага',
      'roast_date': 'Дата обсмажки',
      'lot_number': 'Лот #',
      'roast_level': 'РІВЕНЬ ОБСМАЖКИ',
      'shop_coffee': 'КУПИТИ ЦЮ КАВУ',
      'terroir_farm': 'ТЕРРУАР ТА ФЕРМА',
      'sensory_grid': 'СЕНСОРНИЙ ПРОФІЛЬ',
      'cupping_score': 'Оцінка каппінгу',
      'aroma': 'Аромат',
      'body': 'Тіло',
      'aftertaste': 'Післясмак',
      'acidity_type': 'Тип кислотності',
      'indicators': 'Показники',
      'acidity': 'Кислотність',
      'sweetness': 'Солодкість',
      'bitterness': 'Гіркота',
      'intensity': 'Інтенсивність',
      'flavor': 'Смак',
      'balance': 'Баланс',
      'process_washed_label': 'Митий',
      'process_natural_label': 'Натуральний',
      'process_honey_label': 'Хані',
      'process_anaerobic_label': 'Анаеробний',
      'tab_product': 'Продукт',
      'tab_source': 'Походження',
      'tab_recipes': 'Рецепти',
      'roast_light': 'СВІТЛИЙ',
      'roast_medium': 'СЕРЕДНІЙ',
      'roast_dark': 'ТЕМНИЙ',
      'no_recipes_for_lot': 'Рецептів для цього лоту ще немає.',
      'process_detail': 'ДЕТАЛІ ОБРОБКИ',
      'sync_options': 'Синхронізація',
      'sync_choice_desc': 'Оберіть режим:',
      'cloud_sync': 'Завантажити з хмари',
      'push_local': 'Вивантажити у хмару',
      'process_washed_desc':
          '### Етап 1: Депульпація\nЗнімається шкірка та м\'якоть механічним способом.\n### Етап 2: Ферментація\nЗерна у слизу занурюються у воду на 12-48 годин для очищення ферментами.\n### Етап 3: Промивка та Сушка\nЗерно промивають чистою водою та сушать на сонці до вологості 11-12%.',
      'process_natural_desc':
          '### Етап 1: Сортування\nЦілі ягоди розкладають на африканських ліжках.\n### Етап 2: Сушка у ягоді\nТриває 2-4 тижні. Ягода засихає, віддаючи всі цукри зерну всередині.\n### Етап 3: Халлінг\nСуха оболонка знімається лише після повної сушки.',
      'process_anaerobic_desc':
          '### Етап 1: Герметизація\nЯгоди завантажують у бочки без доступу кисню.\n### Етап 2: Анаеробна ферментація\nТриває 48-120 годин, створюючи складний "фанкі" смак.',
      'process_thermal_desc':
          '### Етап 1: Гарячий шок\nПромивання водою 40°C для розкриття пор.\n### Етап 2: Холодний шок\nРізке охолодження водою 12°C для "запечатування" смаку.',
      'process_honey': 'Хані',
      'story_terroir': 'ІСТОРІЯ ТА ТЕРРУАР',
      'auth_subtitle': 'Увійдіть, щоб відстежувати свій шлях',
      'search_origins': 'Пошук...',
      'no_results': 'Немає результатів для',
      'coffee_origins': 'Coffee Origins',
      'region': 'Регіон',
      'altitude': 'Висота',
      'varieties': 'Сорти',
      'process': 'Обробка',
      'lot_desc_col_46_filter':
          'Складна кислотність, довгий ожиновий післясмак. Світле обсмаження для фільтр-заварювання.',
      'lot_desc_col_31_filter':
          'Тривала яблучна кислотність. Лот оброблений методом термального шоку.',
      'lot_desc_kenya_20_filter':
          'Яскрава ягідна класика. Ноти червоних ягід та меду.',
      'lot_desc_eth_37_filter':
          'Чистий та елегантний чайний профіль. Ноти жасмину та лимону.',
      'lot_desc_col_46_espresso':
          'Щільне тіло, ідеально для молочних напоїв. Ноти груші та марципану.',
      'lot_desc_tanzania_utengule':
          'Солодкий та збалансований лот з Танзанії. Оброблений методом Honey, що додає медової солодкості.',
      'lot_desc_col_alto_osos':
          'Витримана натуральна обробка з перевагами анаеробного смаку. Висока солодкість, нотки тропічних фруктів та рому.',
      'lot_desc_indonesia_manis':
          'Індонезія без землі. Тільки фрукти, ром та шоколадна насолода.',
      'lot_desc_kenya_gichathaini':
          'Яскрава та соковита Кенія з характерною смородиновою кислотністю та тривалим післясмаком.',
      'catalog': 'Каталог',
      'favorites': 'Обране',
      'compare_tab': 'Порівняння',
      'sort_by': 'Сортувати',
      'sort_country_az': 'Країна (А-Я)',
      'sort_country_za': 'Країна (Я-А)',
      'sort_region_az': 'Регіон (А-Я)',
      'sort_region_za': 'Регіон (Я-А)',
      'sort_country_region': 'Країна та Регіон',
      'sort_price_retail_high': 'Ціна (Роздріб: Дорого-Дешево)',
      'sort_price_retail_low': 'Ціна (Роздріб: Дешево-Дорого)',
      'sort_price_wholesale_high': 'Ціна (Опт: Максимум)',
      'sort_process': 'Метод обробки',
      'sort_newest': 'Спочатку нові',
      'no_favorites': 'У вас поки немає обраного',
      'read_more': 'Детальніше',
      'about_farm_region': 'ПРО ФЕРМУ ТА РЕГІОН',
      'recipes_processing': 'МЕТОДИ ОБРОБКИ',
      'harvest': 'Врожай',
    },
    'ru': {
      'discover': 'Открытия',
      'timer': 'Таймер',
      'scanner': 'Сканер',
      'settings': 'Настройки',
      'profile': 'Мой Профиль',
      'encyclopedia': 'Энциклопедия',
      'farmers': 'Фермеры',
      'roasters': 'Обжарщики',
      'specialty': 'Спешелти',
      'recipes': 'Рецепты',
      'scans': 'Сканы',
      'badges': 'Значки',
      'edit_profile': 'РЕДАКТИРОВАТЬ ПРОФИЛЬ',
      'sign_out': 'Выйти',
      'compare': 'Сравнить',
      'log_in': 'ВОЙТИ',
      'sign_up': 'РЕГИСТРАЦИЯ',
      'email': 'Эл. почта',
      'password': 'Пароль',
      'google_sign_in': 'Продолжить с Google',
      'language': 'Язык',
      'bloom': 'Цветение',
      'pour': 'Вливание',
      'next': 'Далее',
      'prev': 'Назад',
      'running': 'РАБОТАЕТ',
      'paused': 'ПАУЗА',
      'reset': 'Сбросить',
      'source': 'Источник',
      'purchase_details': 'ДЕТАЛИ ПОКУПКИ',
      'price': 'Цена',
      'weight': 'Вес',
      'roast_date': 'Дата обжарки',
      'lot_number': 'Лот #',
      'roast_level': 'УРОВЕНЬ ОБЖАРКИ',
      'shop_coffee': 'КУПИТЬ ЭТОТ КОФЕ',
      'terroir_farm': 'ТЕРРУАР И ФЕРМА',
      'sensory_grid': 'СЕНСОРНЫЙ ПРОФИЛЬ',
      'cupping_score': 'Оценка каппинга',
      'aroma': 'Аромат',
      'body': 'Тело',
      'aftertaste': 'Послевкусие',
      'acidity_type': 'Тип кислотности',
      'indicators': 'Показатели',
      'acidity': 'Кислотность',
      'sweetness': 'Сладость',
      'bitterness': 'Горечь',
      'intensity': 'Интенсивность',
      'flavor': 'Вкус',
      'balance': 'Баланс',
      'process_washed_label': 'Мытый',
      'process_natural_label': 'Натуральный',
      'process_honey_label': 'Хани',
      'process_anaerobic_label': 'Анаэробный',
      'tab_product': 'Продукт',
      'tab_source': 'Происхождение',
      'tab_recipes': 'Рецепты',
      'roast_light': 'СВЕТЛАЯ',
      'roast_medium': 'СРЕДНЯЯ',
      'roast_dark': 'ТЁМНАЯ',
      'no_recipes_for_lot': 'Рецептов для этого лота пока нет.',
      'process_detail': 'ДЕТАЛИ ОБРАБОТКИ',
      'story_terroir': 'ИСТОРИЯ И ТЕРРУАР',
      'sync_options': 'Синхронизация',
      'sync_choice_desc': 'Выберите режим:',
      'cloud_sync': 'Загрузить из облака',
      'push_local': 'Выгрузить в облако',
      'process_washed_desc':
          '### Этап 1: Депульпация\nСнимается кожица и мякоть механическим способом.\n### Этап 2: Ферментация\nЗерна в слизи погружаются в воду на 12-48 часов для очистки ферментами.\n### Этап 3: Промывка и Сушка\nЗерно промывают чистой водой и сушат на солнце до влажности 11-12%.',
      'process_natural_desc':
          '### Этап 1: Сортировка\nЦелые ягоды раскладывают на африканских кроватях.\n### Этап 2: Сушка в ягоде\nДлится 2-4 недели. Ягода засыхает, отдавая все сахара зерну внутри.\n### Этап 3: Халлинг\nСухая оболонка снимается только после полной сушки.',
      'process_anaerobic_desc':
          '### Этап 1: Герметизация\nЯгоды загружают в бочки без доступа кислорода.\n### Этап 2: Анаэробная ферментация\nДлится 48-120 часов, создавая сложный "фанки" вкус.',
      'process_thermal_desc':
          '### Этап 1: Горячий шок\nПромывка водой 40°C для открытия пор.\n### Этап 2: Холодный шок\nРезкое охолодження водой 12°C для "запечатывания" вкуса.',
      'process_honey': 'Хани',
      'auth_subtitle': 'Войдите, чтобы отслеживать свой путь',
      'search_origins': 'Поиск...',
      'no_results': 'Нет результатов для',
      'coffee_origins': 'Coffee Origins',
      'region': 'Регион',
      'altitude': 'Высота',
      'varieties': 'Сорта',
      'process': 'Обработка',
      'lot_desc_col_46_filter':
          'Сложная кислотность, долгое ежевичное послевкусие. Светлая обжарка для фильтр-заваривания.',
      'lot_desc_col_31_filter':
          'Длительная яблочная кислотность. Лот обработан методом термального шока.',
      'lot_desc_kenya_20_filter':
          'Яркая ягодная классика. Ноты красных ягод и меда.',
      'lot_desc_eth_37_filter':
          'Чистый и элегантный чайный профиль. Ноты жасмина и лимона.',
      'lot_desc_col_46_espresso':
          'Плотное тело, идеально для молочных напитков. Ноты груши и марципана.',
      'lot_desc_tanzania_utengule':
          'Сладкий и сбалансированный лот из Танзании. Обработан методом Honey, добавляющим медовую сладость.',
      'lot_desc_col_alto_osos':
          'Выдержанная натуральная обработка с преимуществами анаэробного вкуса. Высокая сладость, нотки тропических фруктов и рома.',
      'lot_desc_indonesia_manis':
          'Индонезия без земли. Только фрукты, ром и шоколадное наслаждение.',
      'lot_desc_kenya_gichathaini':
          'Яркая и сочная Кения с характерной смородиновой кислотностью и длительным послевкусием.',
    },
  };

  String translate(String key) {
    return _translations[locale]?[key] ?? _translations['en']?[key] ?? key;
  }
}
