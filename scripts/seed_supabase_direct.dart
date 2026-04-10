import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  stdout.writeln('--- DIRECT SUPABASE SEEDER (Zero-Dep) ---');

  // 1. Load .env manually
  final envFile = File('.env');
  if (!envFile.existsSync()) {
    stderr.writeln('Error: .env not found');
    return;
  }

  final env = splitEnv(envFile.readAsStringSync());
  final url = env['SUPABASE_URL']?.trim();
  final key = env['SUPABASE_ANON_KEY']?.trim();

  if (url == null || key == null) {
    stderr.writeln('Error: Missing SUPABASE_URL or SUPABASE_ANON_KEY');
    return;
  }

  final client = HttpClient();

  Future<void> post(String table, Map<String, dynamic> body) async {
    try {
      final request = await client.postUrl(Uri.parse('$url/rest/v1/$table'));
      request.headers.set('apikey', key);
      request.headers.set('Authorization', 'Bearer $key');
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Prefer', 'resolution=merge-duplicates');

      request.write(jsonEncode(body));
      final response = await request.close();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // print('Success: $table');
      } else {
        final respBody = await response.transform(utf8.decoder).join();
        stderr.writeln('Error in $table: ${response.statusCode} - $respBody');
      }
    } catch (e) {
      stderr.writeln('Network Error: $e');
    }
  }

  // 2. Seed Brands
  stdout.writeln('Seeding Brands...');
  final brands = [
    {
      'id': 1,
      'name': 'Mad Heads',
      'short_desc_uk': 'Залишайся божевільним.',
      'short_desc_en': 'Stay Mad.',
      'full_desc_uk': 'Mad Heads Coffee — це незалежна українська обсмажка.',
      'full_desc_en': 'Mad Heads Coffee is an independent roastery.',
      'site_url': 'https://madheadscoffee.com/',
      'location_uk': 'Київ, вул. Кирилівська 69',
      'location_en': 'Kyiv, Kyrylivska st. 69',
      'logo_url':
          'https://madheadscoffee.com/wp-content/uploads/2021/05/Logo_MH_Black-1.png',
    },
    {
      'id': 2,
      'name': '3 Champs Roastery',
      'short_desc_uk': 'Три Чемпіони обсмажування.',
      'short_desc_en': 'Three Roasting Champions.',
      'full_desc_uk':
          '3 Champs Roastery — це команда професіоналів, що фокусується на винятковості кожного лоту.',
      'full_desc_en':
          '3 Champs Roastery is a team of professionals focused on the uniqueness of every lot.',
      'site_url': 'https://3champsroastery.com.ua/',
      'location_uk': 'Київ, Україна',
      'location_en': 'Kyiv, Ukraine',
      'logo_url':
          'https://3champsroastery.com.ua/wp-content/uploads/2021/03/logo-black.png',
    },
  ];

  for (var b in brands) {
    await post('localized_brands', b);
    stdout.writeln('  - Brand: ${b['name']}');
  }

  // 3. Seed Beans
  stdout.writeln('Seeding 26 Beans...');
  final beans = [
    _createBean(
      2,
      lot: "49",
      nameEn: "Colombia 49 Filter",
      nameUk: "Колумбія 49 Фільтр",
      descUk:
          "Квіткова кава з нотами жасмину, бузини та довгим післясмаком аличі",
      processUk: "Анаеробна мита",
      variety: "Ява",
      sca: "87.5",
      aroma: "Жасмин",
      body: "Середнє, округле",
      acidity: "Бузина",
      aftertaste: "Алича",
      dots: {"acidity": 5, "sweetness": 5, "bitterness": 2, "intensity": 3},
      prices: {"r250": 555, "w250": 475, "r1k": 2220, "w1k": 1900},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "50",
      nameEn: "Colombia 50 Filter",
      nameUk: "Колумбія 50 Фільтр",
      descUk:
          "Яскрава ягідна кава з нотами вишні, апельсину та бархатистим тілом",
      processUk: "Натуральна",
      variety: "Вуш-вуш",
      sca: "87.25",
      aroma: "Вишня",
      body: "Середнє, округле",
      acidity: "Сицилійський апельсин",
      aftertaste: "Ревень",
      dots: {"acidity": 5, "sweetness": 3, "bitterness": 1, "intensity": 5},
      prices: {"r250": 650, "w250": 570, "r1k": 2600, "w1k": 2280},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "48",
      nameEn: "Colombia 48 Filter",
      nameUk: "Колумбія 48 Фільтр",
      descUk: "Солодка, фруктова кава з нотами шовковиці та льодяника",
      processUk: "Натуральна",
      variety: "Рожевий Бурбон",
      sca: "87",
      aroma: "Шовковиця",
      body: "Середнє, округле",
      acidity: "Нектарин",
      aftertaste: "Фруктовий льодяник",
      dots: {"acidity": 2, "sweetness": 5, "bitterness": 1, "intensity": 2},
      prices: {"r250": 555, "w250": 475, "r1k": 2220, "w1k": 1900},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "47",
      nameEn: "Colombia 47 Filter",
      nameUk: "Колумбія 47 Фільтр",
      descUk: "Іскриста яблучна кава з нотами ківі та післясмаком какао",
      processUk: "Мита",
      variety: "Катурра, Катуаі",
      sca: "86.5",
      aroma: "Яблуко",
      body: "Середнє, округле",
      acidity: "Ківі",
      aftertaste: "Какао",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 1, "intensity": 2},
      prices: {"r250": 390, "w250": 310, "r1k": 1560, "w1k": 1240},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "46",
      nameEn: "Colombia 46 Filter",
      nameUk: "Колумбія 46 Фільтр",
      descUk:
          "Яскрава кава з відтінками груші, марципану та ягідним післясмаком",
      processUk: "Натуральна",
      variety: "Катурра, Кастільо",
      sca: "86",
      aroma: "Груша",
      body: "Середнє, округле",
      acidity: "Ківі",
      aftertaste: "Марципан",
      dots: {"acidity": 5, "sweetness": 5, "bitterness": 1, "intensity": 5},
      prices: {"r250": 405, "w250": 325, "r1k": 1620, "w1k": 1300},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "44",
      nameEn: "Colombia 44 Filter (Thermal Shock)",
      nameUk: "Колумбія 44 Фільтр (Термал Шок)",
      descUk: "Яскрава кава з нотами персика, винограду та морозива",
      processUk: "Термал Шок",
      variety: "Сідра, SL28",
      sca: "88.5",
      aroma: "Персик",
      body: "Щільне, округле",
      acidity: "Цитрус, Яблуко",
      aftertaste: "Довгий, винний",
      dots: {"acidity": 3, "sweetness": 5, "bitterness": 1, "intensity": 5},
      prices: {"r250": 705, "w250": 625, "r1k": 2820, "w1k": 2500},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "45",
      nameEn: "Colombia 45 Filter",
      nameUk: "Колумбія 45 Фільтр",
      descUk: "Ніжна кава з нотами троянди, грейпфрута та бісквіта",
      processUk: "Термал Шок",
      variety: "Геша, Червоний Бурбон",
      sca: "86.75",
      aroma: "Троянда",
      body: "Бархатисте",
      acidity: "Грейпфрут",
      aftertaste: "Довгий, квітковий",
      dots: {"acidity": 3, "sweetness": 4, "bitterness": 1, "intensity": 4},
      prices: {"r250": 420, "w250": 340, "r1k": 1680, "w1k": 1360},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "31",
      nameEn: "Colombia 31 Filter (Thermal Shock)",
      nameUk: "Колумбія 31 Фільтр (Термал Шок)",
      descUk: "Фруктова кава з відтінками жасмину, ківі та послесмаком лохини",
      processUk: "Термал Шок",
      variety: "Чиросо, Катурра",
      sca: "88",
      aroma: "Жасмин",
      body: "Середнє, округле",
      acidity: "Ківі",
      aftertaste: "Лохина",
      dots: {"acidity": 5, "sweetness": 3, "bitterness": 1, "intensity": 5},
      prices: {"r250": 485, "w250": 405, "r1k": 1940, "w1k": 1620},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "20",
      nameEn: "Kenya 20 Filter",
      nameUk: "Кенія 20 Фільтр",
      descUk: "Ягідна кава з нотами кеш’ю та медовим післясмаком",
      processUk: "Мита",
      variety: "СЛ 28, СЛ 34",
      sca: "85.5",
      aroma: "Червоні ягоди",
      body: "Середнє, округле",
      acidity: "Мед",
      aftertaste: "Апельсин",
      dots: {"acidity": 3, "sweetness": 2, "bitterness": 1, "intensity": 1},
      prices: {"r250": 340, "w250": 260, "r1k": 1360, "w1k": 1040},
      country: "Кенія",
      emoji: "🇰🇪",
    ),
    _createBean(
      2,
      lot: "14",
      nameEn: "Rwanda 14 Filter",
      nameUk: "Руанда 14 Фільтр",
      descUk: "Фруктова кава з апельсином та кісточковими фруктами",
      processUk: "Натуральна",
      variety: "Рожевий Бурбон",
      sca: "84.75",
      aroma: "Апельсин",
      body: "Середнє, округле",
      acidity: "Бісквіт",
      aftertaste: "Кісточкові фрукти",
      dots: {"acidity": 2, "sweetness": 3, "bitterness": 1, "intensity": 2},
      prices: {"r250": 370, "w250": 290, "r1k": 1480, "w1k": 1160},
      country: "Руанда",
      emoji: "🇷🇼",
    ),
    _createBean(
      2,
      lot: "4",
      nameEn: "Indonesia 4 Filter",
      nameUk: "Індонезія 4 Фільтр",
      descUk: "Алкогольні відтінки та стиглі фрукти",
      processUk: "Анаеробна натуральна",
      variety: "С-ліні, Бурбон",
      sca: "86",
      aroma: "Апельсин",
      body: "Середнє, округле",
      acidity: "Лохина",
      aftertaste: "Ревень",
      dots: {"acidity": 5, "sweetness": 3, "bitterness": 1, "intensity": 5},
      prices: {"r250": 465, "w250": 385, "r1k": 1860, "w1k": 1540},
      country: "Індонезія",
      emoji: "🇮🇩",
    ),
    _createBean(
      2,
      lot: "9",
      nameEn: "Colombia 9 Filter",
      nameUk: "Колумбія 9 Фільтр",
      descUk: "Тропіки, ожина та алкогольні ноти",
      processUk: "Натуральна",
      variety: "Гейша",
      sca: "87.5",
      aroma: "Тропіки",
      body: "Делікатне",
      acidity: "Ожина",
      aftertaste: "Алкогольний",
      dots: {"acidity": 3, "sweetness": 5, "bitterness": 1, "intensity": 1},
      prices: {"r250": 530, "w250": 450, "r1k": 2120, "w1k": 1800},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "12",
      nameEn: "Costa-Rica 12 Filter",
      nameUk: "Коста-Ріка 12 Фільтр",
      descUk: "Кориця, яблуко та виноград",
      processUk: "Натуральна",
      variety: "Катурра",
      sca: "86.5",
      aroma: "Кориця",
      body: "Середнє",
      acidity: "Яблуко",
      aftertaste: "Виноград",
      dots: {"acidity": 2, "sweetness": 5, "bitterness": 1, "intensity": 3},
      prices: {"r250": 570, "w250": 490, "r1k": 2280, "w1k": 1960},
      country: "Коста-Ріка",
      emoji: "🇨🇷",
    ),
    _createBean(
      2,
      lot: "5",
      nameEn: "Indonesia 5 Filter",
      nameUk: "Індонезія 5 Фільтр",
      descUk: "Червоне вино та тропіки",
      processUk: "Анаеробна Натуральна",
      variety: "Ateng",
      sca: "85.75",
      aroma: "Червоне вино",
      body: "Щільне",
      acidity: "Тропіки",
      aftertaste: "Довгий",
      dots: {"acidity": 5, "sweetness": 2, "bitterness": 1, "intensity": 5},
      prices: {"r250": 435, "w250": 355, "r1k": 1740, "w1k": 1420},
      country: "Індонезія",
      emoji: "🇮🇩",
    ),
    _createBean(
      2,
      lot: "8",
      nameEn: "Ethiopia 8 Filter",
      nameUk: "Ефіопія 8 Фільтр",
      descUk: "Жасмин та абрикос",
      processUk: "Мита",
      variety: "Heirloom",
      sca: "85",
      aroma: "Жасмин",
      body: "Легке",
      acidity: "Абрикос",
      aftertaste: "Червоні ягоди",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 1, "intensity": 2},
      prices: {"r250": 380, "w250": 300, "r1k": 1520, "w1k": 1200},
      country: "Ефіопія",
      emoji: "🇪🇹",
    ),
    _createBean(
      2,
      lot: "2",
      nameEn: "Colombia Decaf 2 Filter",
      nameUk: "Колумбія Без Кофеїну 2 Фільтр",
      descUk: "Мандарин та яблуко без кофеїну",
      processUk: "Термал Шок",
      variety: "Кастійо",
      sca: "86.5",
      aroma: "Мандарин",
      body: "Щільне",
      acidity: "Яблуко",
      aftertaste: "Квіти",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 1, "intensity": 5},
      prices: {"r250": 365, "w250": 285, "r1k": 1460, "w1k": 1140},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "37",
      nameEn: "Ethiopia 37 Filter",
      nameUk: "Ефіопія 37 Фільтр",
      descUk: "Персик та яблучна кислинка",
      processUk: "Анаеробна Натуральна",
      variety: "Heirloom",
      sca: "86.5",
      aroma: "Персик",
      body: "Середнє",
      acidity: "Жасмин",
      aftertaste: "Яблучна кислинка",
      dots: {"acidity": 2, "sweetness": 5, "bitterness": 1, "intensity": 2},
      prices: {"r250": 420, "w250": 340, "r1k": 1680, "w1k": 1360},
      country: "Ефіопія",
      emoji: "🇪🇹",
    ),
    _createBean(
      2,
      lot: "10",
      nameEn: "Kenya 10 Filter",
      nameUk: "Кенія 10 Фільтр",
      descUk: "Кизил та зелене яблуко",
      processUk: "Мита",
      variety: "SL28, SL34",
      sca: "85.25",
      aroma: "Кизил",
      body: "Середнє",
      acidity: "Зелене яблуко",
      aftertaste: "Мед",
      dots: {"acidity": 5, "sweetness": 2, "bitterness": 1, "intensity": 2},
      prices: {"r250": 385, "w250": 305, "r1k": 1540, "w1k": 1220},
      country: "Кенія",
      emoji: "🇰🇪",
    ),
    _createBean(
      2,
      lot: "2",
      nameEn: "BB2 Brew Blend 2 Filter",
      nameUk: "BB2 Brew Blend 2 Фільтр",
      descUk: "Смородина та тропіки",
      processUk: "Анаеробна Х Мита",
      variety: "Heirloom, Caturra",
      sca: "85",
      aroma: "Смородина",
      body: "Вершкове",
      acidity: "Тропіки",
      aftertaste: "Вершкове тіло",
      dots: {"acidity": 2, "sweetness": 5, "bitterness": 1, "intensity": 1},
      prices: {"r250": 345, "w250": 265, "r1k": 1380, "w1k": 1060},
      country: "Blend",
      emoji: "🌍",
    ),
    _createBean(
      2,
      lot: "28",
      nameEn: "Ethiopia 28 Filter",
      nameUk: "Ефіопія 28 Фільтр",
      descUk: "Жасмин та чорний чай",
      processUk: "Мита",
      variety: "Heirloom",
      sca: "84",
      aroma: "Жасмин",
      body: "Легке",
      acidity: "Чорний чай",
      aftertaste: "Квітковий",
      dots: {"acidity": 2, "sweetness": 3, "bitterness": 1, "intensity": 1},
      prices: {"r250": 328, "w250": 248, "r1k": 1312, "w1k": 992},
      country: "Ефіопія",
      emoji: "🇪🇹",
    ),
    _createBean(
      2,
      lot: "37",
      nameEn: "Colombia 37 Filter",
      nameUk: "Колумбія 37 Фільтр",
      descUk: "Червоне яблуко та ром",
      processUk: "Натуральна",
      variety: "Кастійо",
      sca: "85.75",
      aroma: "Червоне яблуко",
      body: "Середнє",
      acidity: "Виноград",
      aftertaste: "Ром",
      dots: {"acidity": 3, "sweetness": 5, "bitterness": 1, "intensity": 3},
      prices: {"r250": 370, "w250": 290, "r1k": 1480, "w1k": 1160},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "1",
      nameEn: "Colombia Decaf 1 Filter",
      nameUk: "Колумбія Без Кофеїну 1 Фільтр",
      descUk: "Карамель та какао без кофеїну",
      processUk: "Мита Шугакейн",
      variety: "Катурра",
      sca: "82",
      aroma: "Карамель",
      body: "Легке",
      acidity: "Яблучна кислотність",
      aftertaste: "Какао",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 0, "intensity": 1},
      prices: {"r250": 335, "w250": 255, "r1k": 1340, "w1k": 1020},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "4",
      nameEn: "Colombia 4 Filter",
      nameUk: "Колумбія 4 Фільтр",
      descUk: "Яблуко та карамель",
      processUk: "Мита",
      variety: "Катурра",
      sca: "83",
      aroma: "Яблуко",
      body: "Середнє",
      acidity: "Цитра",
      aftertaste: "Карамель",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 1, "intensity": 2},
      prices: {"r250": 340, "w250": 260, "r1k": 1360, "w1k": 1040},
      country: "Колумбія",
      emoji: "🇨🇴",
    ),
    _createBean(
      2,
      lot: "13",
      nameEn: "Rwanda 13 Filter",
      nameUk: "Руанда 13 Фільтр",
      descUk: "Червоні ягоди та мед",
      processUk: "Мита",
      variety: "Бурбон",
      sca: "84.5",
      aroma: "Червоні ягоди",
      body: "Середнє",
      acidity: "Мед",
      aftertaste: "Делікатний",
      dots: {"acidity": 2, "sweetness": 2, "bitterness": 2, "intensity": 2},
      prices: {"r250": 340, "w250": 260, "r1k": 1360, "w1k": 1040},
      country: "Руанда",
      emoji: "🇷🇼",
    ),
    _createBean(
      2,
      lot: "4",
      nameEn: "Rwanda 4 Filter",
      nameUk: "Руанда 4 Фільтр",
      descUk: "Тропічні фрукти та полуниця",
      processUk: "Анаеробна Натуральна",
      variety: "Бурбон",
      sca: "86",
      aroma: "Тропіки",
      body: "Легке",
      acidity: "Полуниця",
      aftertaste: "Солодкий",
      dots: {"acidity": 3, "sweetness": 5, "bitterness": 1, "intensity": 2},
      prices: {"r250": 390, "w250": 310, "r1k": 1560, "w1k": 1240},
      country: "Руанда",
      emoji: "🇷🇼",
    ),
    {
      'brand_id': 1,
      'country_emoji': '🇹🇿',
      'country_uk': 'Танзанія',
      'country_en': 'Tanzania',
      'region_uk': 'Утенгуле',
      'region_en': 'Utengule',
      'altitude_min': 1600,
      'altitude_max': 1600,
      'process_method_uk': 'Хані',
      'process_method_en': 'Honey',
      'varieties_uk': 'Бурбон',
      'varieties_en': 'Bourbon',
      'cups_score': 85.5,
      'flavor_notes_uk': jsonEncode(['Персик', 'Яблуко', 'Чай']),
      'flavor_notes_en': jsonEncode(['Peach', 'Apple', 'Tea']),
      'description_uk': 'Солодкий та збалансований лот.',
      'description_en': 'Sweet and balanced lot.',
      'roast_level_uk': 'Світле',
      'roast_level_en': 'Light',
      'price': '450₴',
      'weight': '250g',
    },
  ];

  for (var b in beans) {
    b.removeWhere((k, v) => v == null);
    await post('localized_beans', b);
    stdout.writeln('  - Bean: ${b['region_uk']}');
  }

  stdout.writeln('\n--- SEED COMPLETE ---');
  client.close();
}

Map<String, String> splitEnv(String content) {
  final lines = content.split('\n');
  final map = <String, String>{};
  for (var line in lines) {
    if (line.contains('=')) {
      final parts = line.split('=');
      if (parts.length >= 2) {
        map[parts[0].trim()] = parts.sublist(1).join('=').trim();
      }
    }
  }
  return map;
}

Map<String, dynamic> _createBean(
  int brandId, {
  required String lot,
  required String nameEn,
  required String nameUk,
  required String descUk,
  required String processUk,
  required String variety,
  required String sca,
  required String aroma,
  required String body,
  required String acidity,
  required String aftertaste,
  required Map<String, int> dots,
  required Map<String, int> prices,
  required String country,
  required String emoji,
}) {
  return {
    'brand_id': brandId,
    'lot_number': lot,
    'country_emoji': emoji,
    'country_uk': country,
    'country_en': country,
    'region_uk': nameUk,
    'region_en': nameEn,
    'process_method_uk': processUk,
    'process_method_en': processUk,
    'varieties_uk': variety,
    'varieties_en': variety,
    'sca_score': sca,
    'description_uk': descUk,
    'description_en': descUk,
    'sensory_json': jsonEncode({
      "aroma": aroma,
      "body": body,
      "acidity": acidity,
      "aftertaste": aftertaste,
      "dots": dots,
    }),
    'price_json': jsonEncode(prices),
    'roast_level_uk': 'Світле',
    'roast_level_en': 'Light',
  };
}
