// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'package:supabase/supabase.dart';

// CONFIGURATION: Using the correct URL and Key
const String supabaseUrl = 'https://lylnnqojnytndybhuicr.supabase.co';
const String supabaseKey = 'sb_publishable_d_gdrnpNa7gFwgqEb5VteQ_y3UKhjS-';

Future<void> batchInsert(
  SupabaseClient client,
  String table,
  List<Map<String, dynamic>> items, {
  int batchSize = 50,
}) async {
  print('Batching $table: ${items.length} items...');
  for (var i = 0; i < items.length; i += batchSize) {
    final end = (i + batchSize < items.length) ? i + batchSize : items.length;
    final batch = items.sublist(i, end);
    try {
      await client.from(table).insert(batch);
      print('  [✓] Pushed $end/${items.length}');
    } catch (e) {
      print('  [✗] Error in batch $i-$end: $e');
    }
  }
}

void main() async {
  print('🚀 STARTING RELIABLE SYNCING (RESTORATION MODE)...');

  final client = SupabaseClient(supabaseUrl, supabaseKey);
  final langs = [
    'en',
    'uk',
    'de',
    'es',
    'fr',
    'it',
    'ja',
    'pl',
    'pt',
    'ro',
    'ru',
    'tr',
    'zh',
  ];

  // 1. CLEANUP PREVIOUS DATA
  print('Cleaning tables...');
  try {
    await client.from('localized_bean_translations').delete().neq('id', 0);
    await client.from('localized_beans').delete().neq('id', 0);
    await client.from('localized_brand_translations').delete().neq('id', 0);
    await client.from('localized_brands').delete().neq('id', 0);
    await client.from('localized_farmer_translations').delete().neq('id', 0);
    await client.from('localized_farmers').delete().neq('id', 0);
    await client.from('specialty_article_translations').delete().neq('id', 0);
    await client.from('specialty_articles').delete().neq('id', 0);
  } catch (e) {
    print('Cleanup warning: $e');
  }

  // 2. BRANDS
  print('Pushing Brands...');
  final brands = [
    {
      'id': 1,
      'name': '3 Champs Roastery',
      'site_url': 'https://3champsroastery.com.ua/',
      'logo_url':
          'https://3champsroastery.com.ua/wp-content/uploads/2021/04/3Champslogo.jpg',
    },
    {
      'id': 2,
      'name': 'Mad Heads',
      'site_url': 'https://madheadscoffee.com/',
      'logo_url':
          'https://madheadscoffee.com/wp-content/uploads/2020/09/mad_headslogo.png',
    },
  ];
  await client.from('localized_brands').insert(brands);

  final List<Map<String, dynamic>> brandTrs = [];
  for (var b in brands) {
    for (var l in langs) {
      brandTrs.add({
        'brand_id': b['id'],
        'language_code': l,
        'short_desc': l == 'uk'
            ? 'Преміальна обсмажка.'
            : 'Premium specialty roaster.',
        'full_desc':
            'Professional roastery focused on high-quality SCA lots. [$l]',
        'location': 'Kyiv, Ukraine',
      });
    }
  }
  await batchInsert(client, 'localized_brand_translations', brandTrs);

  // 3. 46 COFFEE LOTS
  print('Pushing 46 Coffee Lots...');
  final coffeeLots = [
    {
      'id': 1,
      'lot': '49',
      'emoji': '🇨🇴',
      'sca': '87.5',
      'orig': 'Colombia',
      'proc': 'Anaerobic Washed',
      'var': 'Java',
      'price': 555,
      'reg': 'Las Flores',
    },
    {
      'id': 2,
      'lot': '50',
      'emoji': '🇨🇴',
      'sca': '87.25',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Wush Wush',
      'price': 650,
      'reg': 'Monteverde',
    },
    {
      'id': 3,
      'lot': '48',
      'emoji': '🇨🇴',
      'sca': '87.0',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Pink Bourbon',
      'price': 555,
      'reg': 'La Roca',
    },
    {
      'id': 4,
      'lot': '47',
      'emoji': '🇨🇴',
      'sca': '86.5',
      'orig': 'Colombia',
      'proc': 'Washed',
      'var': 'Caturra, Catuai',
      'price': 390,
      'reg': 'Combeima',
    },
    {
      'id': 5,
      'lot': '46',
      'emoji': '🇨🇴',
      'sca': '86.0',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Caturra, Castillo',
      'price': 405,
      'reg': 'Las Flores',
    },
    {
      'id': 6,
      'lot': '44',
      'emoji': '🇨🇴',
      'sca': '88.5',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Sidra, SL28',
      'price': 705,
      'reg': 'Wilton Benitez',
    },
    {
      'id': 7,
      'lot': '45',
      'emoji': '🇨🇴',
      'sca': '86.75',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Gesha, Red Bourbon',
      'price': 420,
      'reg': 'Granja Paraiso',
    },
    {
      'id': 8,
      'lot': '31',
      'emoji': '🇨🇴',
      'sca': '88.0',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Chiroso, Caturra',
      'price': 485,
      'reg': 'Granja Paraiso',
    },
    {
      'id': 9,
      'lot': '20',
      'emoji': '🇰🇪',
      'sca': '85.5',
      'orig': 'Kenya',
      'proc': 'Washed',
      'var': 'SL28, SL34',
      'price': 340,
      'reg': 'Kirinyaga',
    },
    {
      'id': 10,
      'lot': '14',
      'emoji': '🇷🇼',
      'sca': '84.75',
      'orig': 'Rwanda',
      'proc': 'Natural',
      'var': 'Pink Bourbon',
      'price': 370,
      'reg': 'Coakambu',
    },
    {
      'id': 11,
      'lot': '4-F',
      'emoji': '🇮🇩',
      'sca': '86.0',
      'orig': 'Indonesia',
      'proc': 'Anaerobic Natural',
      'var': 'S-Lini, Bourbon',
      'price': 465,
      'reg': 'Frinsa',
    },
    {
      'id': 12,
      'lot': '9-F',
      'emoji': '🇨🇴',
      'sca': '87.5',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Geisha',
      'price': 530,
      'reg': 'El Diviso',
    },
    {
      'id': 13,
      'lot': '12-F',
      'emoji': '🇨🇷',
      'sca': '86.5',
      'orig': 'Costa Rica',
      'proc': 'Natural',
      'var': 'Caturra',
      'price': 570,
      'reg': 'Las Lajas',
    },
    {
      'id': 14,
      'lot': '5-F',
      'emoji': '🇮🇩',
      'sca': '85.75',
      'orig': 'Indonesia',
      'proc': 'Anaerobic Natural',
      'var': 'Ateng',
      'price': 435,
      'reg': 'Frinsa',
    },
    {
      'id': 15,
      'lot': '8-F',
      'emoji': '🇪🇹',
      'sca': '85.0',
      'orig': 'Ethiopia',
      'proc': 'Washed',
      'var': 'Heirloom',
      'price': 380,
      'reg': 'Sidamo',
    },
    {
      'id': 16,
      'lot': 'D2-F',
      'emoji': '🇨🇴',
      'sca': '86.5',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Castillo',
      'price': 365,
      'reg': 'Decaf',
    },
    {
      'id': 17,
      'lot': '37-F',
      'emoji': '🇪🇹',
      'sca': '86.5',
      'orig': 'Ethiopia',
      'proc': 'Anaerobic Natural',
      'var': 'Heirloom',
      'price': 420,
      'reg': 'Guji',
    },
    {
      'id': 18,
      'lot': '10-F',
      'emoji': '🇰🇪',
      'sca': '85.25',
      'orig': 'Kenya',
      'proc': 'Washed',
      'var': 'SL28, SL34',
      'price': 385,
      'reg': 'Nyeri',
    },
    {
      'id': 19,
      'lot': 'BB2-F',
      'emoji': '🌍',
      'sca': '85.0',
      'orig': 'Blend',
      'proc': 'Anaerobic x Washed',
      'var': 'Mixed',
      'price': 345,
      'reg': 'House',
    },
    {
      'id': 20,
      'lot': '28-F',
      'emoji': '🇪🇹',
      'sca': '84.0',
      'orig': 'Ethiopia',
      'proc': 'Washed',
      'var': 'Heirloom',
      'price': 328,
      'reg': 'Yirgacheffe',
    },
    {
      'id': 21,
      'lot': '4-RF',
      'emoji': '🇷🇼',
      'sca': '86.0',
      'orig': 'Rwanda',
      'proc': 'Anaerobic Natural',
      'var': 'Bourbon',
      'price': 390,
      'reg': 'Coakambu',
    },
    {
      'id': 22,
      'lot': '13-F',
      'emoji': '🇷🇼',
      'sca': '84.5',
      'orig': 'Rwanda',
      'proc': 'Washed',
      'var': 'Bourbon',
      'price': 340,
      'reg': 'Kibuye',
    },
    {
      'id': 23,
      'lot': '4-CF',
      'emoji': '🇨🇴',
      'sca': '83.0',
      'orig': 'Colombia',
      'proc': 'Washed',
      'var': 'Caturra',
      'price': 340,
      'reg': 'Huila',
    },
    {
      'id': 24,
      'lot': '37-CF',
      'emoji': '🇨🇴',
      'sca': '85.75',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Castillo',
      'price': 370,
      'reg': 'Tolima',
    },
    {
      'id': 25,
      'lot': 'D1-F',
      'emoji': '🇨🇴',
      'sca': '82.0',
      'orig': 'Colombia',
      'proc': 'Washed Sugarcane',
      'var': 'Caturra',
      'price': 335,
      'reg': 'Decaf',
    },
    {
      'id': 26,
      'lot': 'UT-F',
      'emoji': '🇹🇿',
      'sca': '85.5',
      'orig': 'Tanzania',
      'proc': 'Honey',
      'var': 'Bourbon',
      'price': 450,
      'reg': 'Mbeya',
    },
    {
      'id': 27,
      'lot': '37-E',
      'emoji': '🇪🇹',
      'sca': '87.0',
      'orig': 'Ethiopia',
      'proc': 'Anaerobic Natural',
      'var': 'Heirloom',
      'price': 420,
      'reg': 'Guji',
    },
    {
      'id': 28,
      'lot': '46-E',
      'emoji': '🇨🇴',
      'sca': '86.0',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Caturra, Castillo',
      'price': 405,
      'reg': 'Las Flores',
    },
    {
      'id': 29,
      'lot': '31-E',
      'emoji': '🇨🇴',
      'sca': '88.0',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Chiroso',
      'price': 485,
      'reg': 'Granja Paraiso',
    },
    {
      'id': 30,
      'lot': '4-E',
      'emoji': '🇮🇩',
      'sca': '86.0',
      'orig': 'Indonesia',
      'proc': 'Anaerobic Natural',
      'var': 'S-Lini',
      'price': 465,
      'reg': 'Frinsa',
    },
    {
      'id': 31,
      'lot': '12-E',
      'emoji': '🇨🇷',
      'sca': '86.5',
      'orig': 'Costa Rica',
      'proc': 'Natural',
      'var': 'Caturra',
      'price': 570,
      'reg': 'Las Lajas',
    },
    {
      'id': 32,
      'lot': '8-E',
      'emoji': '🇪🇹',
      'sca': '85.0',
      'orig': 'Ethiopia',
      'proc': 'Washed',
      'var': 'Heirloom',
      'price': 380,
      'reg': 'Sidamo',
    },
    {
      'id': 33,
      'lot': '20-E',
      'emoji': '🇰🇪',
      'sca': '85.5',
      'orig': 'Kenya',
      'proc': 'Washed',
      'var': 'SL28, SL34',
      'price': 340,
      'reg': 'Kirinyaga',
    },
    {
      'id': 34,
      'lot': '14-E',
      'emoji': '🇷🇼',
      'sca': '84.75',
      'orig': 'Rwanda',
      'proc': 'Natural',
      'var': 'Bourbon',
      'price': 370,
      'reg': 'Coakambu',
    },
    {
      'id': 35,
      'lot': '10-E',
      'emoji': '🇰🇪',
      'sca': '85.25',
      'orig': 'Kenya',
      'proc': 'Washed',
      'var': 'SL28',
      'price': 385,
      'reg': 'Nyeri',
    },
    {
      'id': 36,
      'lot': '4-RE',
      'emoji': '🇷🇼',
      'sca': '86.0',
      'orig': 'Rwanda',
      'proc': 'Anaerobic Natural',
      'var': 'Bourbon',
      'price': 390,
      'reg': 'Coakambu',
    },
    {
      'id': 37,
      'lot': '13-E',
      'emoji': '🇷🇼',
      'sca': '84.5',
      'orig': 'Rwanda',
      'proc': 'Washed',
      'var': 'Bourbon',
      'price': 340,
      'reg': 'Kibuye',
    },
    {
      'id': 38,
      'lot': '47-EA',
      'emoji': '🇨🇴',
      'sca': '86.5',
      'orig': 'Colombia',
      'proc': 'Washed',
      'var': 'Caturra',
      'price': 390,
      'reg': 'Combeima',
    },
    {
      'id': 39,
      'lot': '28-E',
      'emoji': '🇪🇹',
      'sca': '84.0',
      'orig': 'Ethiopia',
      'proc': 'Washed',
      'var': 'Heirloom',
      'price': 328,
      'reg': 'Yirgacheffe',
    },
    {
      'id': 40,
      'lot': '9-E',
      'emoji': '🇨🇴',
      'sca': '87.5',
      'orig': 'Colombia',
      'proc': 'Natural',
      'var': 'Geisha',
      'price': 530,
      'reg': 'El Diviso',
    },
    {
      'id': 41,
      'lot': '5-E',
      'emoji': '🇮🇩',
      'sca': '85.75',
      'orig': 'Indonesia',
      'proc': 'Anaerobic Natural',
      'var': 'Ateng',
      'price': 435,
      'reg': 'Frinsa',
    },
    {
      'id': 42,
      'lot': 'D2-E',
      'emoji': '🇨🇴',
      'sca': '86.5',
      'orig': 'Colombia',
      'proc': 'Thermal Shock',
      'var': 'Castillo',
      'price': 365,
      'reg': 'Decaf',
    },
    {
      'id': 43,
      'lot': 'B100-E',
      'emoji': '🌍',
      'sca': '83.0',
      'orig': 'Blend',
      'proc': 'Mixed',
      'var': 'Mixed',
      'price': 300,
      'reg': 'House',
    },
    {
      'id': 44,
      'lot': 'B50-E',
      'emoji': '🌍',
      'sca': '82.0',
      'orig': 'Blend',
      'proc': 'Mixed',
      'var': 'Mixed',
      'price': 280,
      'reg': 'Bistro',
    },
    {
      'id': 45,
      'lot': 'CLE-E',
      'emoji': '🌍',
      'sca': '80.0',
      'orig': 'Blend',
      'proc': 'Washed',
      'var': 'Mixed',
      'price': 250,
      'reg': 'Classic',
    },
    {
      'id': 46,
      'lot': 'HBE-E',
      'emoji': '🌍',
      'sca': '81.0',
      'orig': 'Blend',
      'proc': 'Natural',
      'var': 'Mixed',
      'price': 260,
      'reg': 'Morning',
    },
  ];

  final countryTr = {
    'Colombia': {
      'uk': 'Колумбія',
      'de': 'Kolumbien',
      'es': 'Colombia',
      'fr': 'Colombie',
      'it': 'Colombia',
      'ja': 'コロンビア',
      'pl': 'Kolumbia',
      'pt': 'Colômbia',
      'ro': 'Columbia',
      'ru': 'Колумбия',
      'tr': 'Kolombiya',
      'zh': '哥伦比亚',
    },
    'Ethiopia': {
      'uk': 'Ефіопія',
      'de': 'Äthiopien',
      'es': 'Etiopía',
      'fr': 'Éthiopie',
      'it': 'Etiopia',
      'ja': 'エチオピア',
      'pl': 'Etiopia',
      'pt': 'Etiópia',
      'ro': 'Etiopia',
      'ru': 'Эфиопия',
      'tr': 'Etiyopya',
      'zh': '埃塞俄比亚',
    },
    'Kenya': {
      'uk': 'Кенія',
      'de': 'Kenia',
      'es': 'Kenia',
      'fr': 'Kenya',
      'it': 'Kenya',
      'ja': 'ケニア',
      'pl': 'Kenia',
      'pt': 'Quénia',
      'ro': 'Kenya',
      'ru': 'Кения',
      'tr': 'Kenya',
      'zh': '肯尼亚',
    },
    'Rwanda': {
      'uk': 'Руанда',
      'de': 'Ruanda',
      'es': 'Ruanda',
      'fr': 'Rwanda',
      'it': 'Ruanda',
      'ja': 'ルワンダ',
      'pl': 'Rwanda',
      'pt': 'Ruanda',
      'ro': 'Rwanda',
      'ru': 'Руанда',
      'tr': 'Ruanda',
      'zh': '卢旺达',
    },
    'Indonesia': {
      'uk': 'Індонезія',
      'de': 'Indonesien',
      'es': 'Indonesia',
      'fr': 'Indonésie',
      'it': 'Indonesia',
      'ja': 'インドネシア',
      'pl': 'Indonezja',
      'pt': 'Indonésia',
      'ro': 'Indonézia',
      'ru': 'Индонезия',
      'tr': 'Endonezya',
      'zh': '印度尼西亚',
    },
    'Costa Rica': {
      'uk': 'Коста-Ріка',
      'de': 'Costa Rica',
      'es': 'Costa Rica',
      'fr': 'Costa Rica',
      'it': 'Costa Rica',
      'ja': 'コスタリカ',
      'pl': 'Kostaryka',
      'pt': 'Costa Rica',
      'ro': 'Costa Rica',
      'ru': 'Коста-Рика',
      'tr': 'Kosta Rika',
      'zh': '哥斯达黎加',
    },
    'Tanzania': {
      'uk': 'Танзанія',
      'de': 'Tansania',
      'es': 'Tanzania',
      'fr': 'Tanzanie',
      'it': 'Tansania',
      'ja': 'タンザニア',
      'pl': 'Tanzania',
      'pt': 'Tanzânia',
      'ro': 'Tanzania',
      'ru': 'Танзанія',
      'tr': 'Tanzanya',
      'zh': '坦桑尼亚',
    },
    'Blend': {
      'uk': 'Бленд',
      'de': 'Mischung',
      'es': 'Mezcla',
      'fr': 'Mélange',
      'it': 'Miscela',
      'ja': 'ブレンド',
      'pl': 'Mieszanka',
      'pt': 'Mistura',
      'ro': 'Amestec',
      'ru': 'Бленд',
      'tr': 'Harman',
      'zh': '混合',
    },
  };

  final List<Map<String, dynamic>> finalBeans = [];
  final List<Map<String, dynamic>> finalBeanTrs = [];

  for (final lot in coffeeLots) {
    finalBeans.add({
      'id': lot['id'],
      'brand_id': 1,
      'lot_number': lot['lot'],
      'country_emoji': lot['emoji'],
      'sca_score': lot['sca'],
      'sensory_json': jsonEncode({
        'aroma': 4,
        'sweetness': 4,
        'acidity': 3,
        'body': 3,
        'bitterness': 1,
        'intensity': 4,
        'aftertaste': 4,
      }),
      'price_json': jsonEncode({
        'r250': lot['price'].toString(),
        'w250': ((lot['price'] as int) * 0.8).toInt().toString(),
        'r1k': ((lot['price'] as int) * 4).toString(),
        'w1k': ((lot['price'] as int) * 4 * 0.8).toInt().toString(),
      }),
      'url': 'https://3champsroastery.com.ua/',
    });

    for (final l in langs) {
      final baseOrig = lot['orig'] as String;
      final countryLabel = countryTr[baseOrig]?[l] ?? baseOrig;

      finalBeanTrs.add({
        'bean_id': lot['id'],
        'language_code': l,
        'country': countryLabel,
        'region': lot['reg'],
        'process_method': lot['proc'],
        'varieties': lot['var'],
        'description': 'Premium specialty coffee lot. [$l]',
        'roast_level': (lot['lot']!.toString().contains('-E'))
            ? 'Medium'
            : 'Light',
      });
    }
  }

  await batchInsert(client, 'localized_beans', finalBeans);
  await batchInsert(client, 'localized_bean_translations', finalBeanTrs);

  // 4. ARTICLES
  print('Pushing 17 Specialty Articles...');
  final List<Map<String, dynamic>> articles = [];
  final List<Map<String, dynamic>> articleTrs = [];
  final articleMetadata = [
    {'id': 1, 'title': 'What is Specialty Coffee?', 'uk': 'Що таке спешелті?'},
    {'id': 2, 'title': 'The Role of SCA', 'uk': 'Роль SCA'},
    {
      'id': 3,
      'title': 'Scoring and Q-Grading',
      'uk': 'Оцінювання та Q-Грейдинг',
    },
    {'id': 4, 'title': 'Terroir: Conditions', 'uk': 'Тераруар'},
    {'id': 5, 'title': 'Genetics and Varieties', 'uk': 'Генетика'},
    {'id': 6, 'title': 'The Harvest', 'uk': 'Збір врожаю'},
    {'id': 7, 'title': 'Natural Process', 'uk': 'Натуральна обробка'},
    {'id': 8, 'title': 'Washed Process', 'uk': 'Мита обробка'},
    {'id': 9, 'title': 'Honey Process', 'uk': 'Хані обробка'},
    {'id': 10, 'title': 'Anaerobic Ferment', 'uk': 'Анаеробна ферментація'},
    {'id': 11, 'title': 'Carbonic Maceration', 'uk': 'Вуглекислотна мацерація'},
    {'id': 12, 'title': 'Thermal Shock', 'uk': 'Термальний шок'},
    {'id': 13, 'title': 'Brewing Basics', 'uk': 'Основи заварювання'},
    {'id': 14, 'title': 'Grind Size Effect', 'uk': 'Вплив помелу'},
    {'id': 15, 'title': 'Water Chemistry', 'uk': 'Хімія води'},
    {'id': 16, 'title': 'Sensory Training', 'uk': 'Сенсорні тренування'},
    {'id': 17, 'title': 'Future Trends', 'uk': 'Майбутнє кави'},
  ];

  for (var meta in articleMetadata) {
    articles.add({
      'id': meta['id'],
      'image_url':
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
      'read_time_min': 5,
    });
    for (var l in langs) {
      articleTrs.add({
        'article_id': meta['id'],
        'language_code': l,
        'title': (l == 'uk') ? meta['uk'] : meta['title'],
        'subtitle': 'Learn the secrets of coffee.',
        'content_html': 'Full educational content for ${meta['title']} [$l].',
      });
    }
  }
  await batchInsert(client, 'specialty_articles', articles);
  await batchInsert(client, 'specialty_article_translations', articleTrs);

  // 5. FARMERS (Full 10 Farmers)
  print('Pushing 10 Specialty Farmers...');
  final farmers = [
    {
      'id': 1,
      'name_en': 'Wilton Benitez',
      'name_uk': 'Вілтон Бенітез',
      'farm': 'Granja Paraiso 92',
      'country': 'Colombia',
      'emoji': '🇨🇴',
    },
    {
      'id': 2,
      'name_en': 'Chacón Family',
      'name_uk': 'Сім’я Чакон',
      'farm': 'Las Lajas',
      'country': 'Costa Rica',
      'emoji': '🇨🇷',
    },
    {
      'id': 3,
      'name_en': 'Diego Bermúdez',
      'name_uk': 'Дієго Бермудес',
      'farm': 'Finca El Paraiso',
      'country': 'Colombia',
      'emoji': '🇨🇴',
    },
    {
      'id': 4,
      'name_en': 'Jamison Savage',
      'name_uk': 'Джеймісон Севідж',
      'farm': 'Finca Deborah',
      'country': 'Panama',
      'emoji': '🇵🇦',
    },
    {
      'id': 5,
      'name_en': 'Carlos Arcila',
      'name_uk': 'Карлос Арсіла',
      'farm': 'Jardines del Eden',
      'country': 'Colombia',
      'emoji': '🇨🇴',
    },
    {
      'id': 6,
      'name_en': 'Aida Batlle',
      'name_uk': 'Аїда Батлл',
      'farm': 'Finca Kilimanjaro',
      'country': 'El Salvador',
      'emoji': '🇸🇻',
    },
    {
      'id': 7,
      'name_en': 'Adam Overton',
      'name_uk': 'Адам Овертон',
      'farm': 'Gesha Village',
      'country': 'Ethiopia',
      'emoji': '🇪🇹',
    },
    {
      'id': 8,
      'name_en': 'Pepe Jijón',
      'name_uk': 'Пепе Хіхон',
      'farm': 'Finca Soledad',
      'country': 'Ecuador',
      'emoji': '🇪🇨',
    },
    {
      'id': 9,
      'name_en': 'Alejo Castro',
      'name_uk': 'Алехо Кастро',
      'farm': 'Volcan Azul',
      'country': 'Costa Rica',
      'emoji': '🇨🇷',
    },
    {
      'id': 10,
      'name_en': 'Luis Pascoal',
      'name_uk': 'Луїс Паскоаль',
      'farm': 'Daterra',
      'country': 'Brazil',
      'emoji': '🇧🇷',
    },
  ];
  final List<Map<String, dynamic>> finalFarmers = [];
  final List<Map<String, dynamic>> farmerTrs = [];

  for (var f in farmers) {
    finalFarmers.add({
      'id': f['id'],
      'image_url': 'https://placehold.co/600x400',
      'country_emoji': f['emoji'],
      'latitude': 0.0,
      'longitude': 0.0,
    });
    for (var l in langs) {
      farmerTrs.add({
        'farmer_id': f['id'],
        'language_code': l,
        'name': (l == 'uk') ? f['name_uk'] : f['name_en'],
        'country': f['country'],
        'region': f['farm'],
        'description': 'Innovation specialist.',
        'story': 'Famous for unique processing. [$l]',
      });
    }
  }
  await batchInsert(client, 'localized_farmers', finalFarmers);
  await batchInsert(client, 'localized_farmer_translations', farmerTrs);

  print('✅ FULL SYNC COMPLETE!');
}
