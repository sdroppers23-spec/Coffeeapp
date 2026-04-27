import 'dart:convert';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings
import 'dart:io';

void main() async {
  print('🚀 Starting Coffee Universe Modernization (Native HttpClient)...');

  // 1. Setup Supabase Config
  final envFile = File('.env');
  if (!envFile.existsSync()) {
    print('❌ Error: .env file not found');
    return;
  }

  final envLines = envFile.readAsLinesSync();
  final Map<String, String> env = {};
  for (var line in envLines) {
    if (line.contains('=') && !line.startsWith('#')) {
      final idx = line.indexOf('=');
      final key = line.substring(0, idx).trim();
      final value = line.substring(idx + 1).trim();
      env[key] = value;
    }
  }

  final String? baseUrl = env['SUPABASE_URL'];
  final String? anonKey = env['SUPABASE_ANON_KEY'];

  if (baseUrl == null || anonKey == null) {
    print('❌ Error: Supabase credentials not found in .env');
    return;
  }

  print('✅ Connected to Supabase: $baseUrl');

  final client = NativeSupabaseClient(baseUrl, anonKey);

  try {
    print('🧹 Clearing existing data...');
    await client.deleteTable('specialty_article_translations');
    await client.deleteTable('specialty_articles');
    await client.deleteTable('localized_farmer_translations');
    await client.deleteTable('localized_farmers');
    await client.deleteTable('localized_bean_translations');
    await client.deleteTable('localized_beans');
    print('✨ Database tables cleared.');

    print('🏭 Seeding Roasters...');
    final brands = [
      {
        'id': 1,
        'name': 'Mad Heads',
        'logo_url': 'https://madheadscoffee.com/logo.png',
      },
      {
        'id': 2,
        'name': '3 Champs Roastery',
        'logo_url': 'https://3champs.com.ua/logo.png',
      },
    ];
    await client.upsert('brands', brands);

    print('👨‍🌾 Seeding Farmers...');
    final farmersJson = jsonDecode(
      File('Img/unified_farmers.json').readAsStringSync(),
    );
    final List<Map<String, dynamic>> farmersToInsert = [];
    final List<Map<String, dynamic>> farmerTranslations = [];

    final farmerImages = {
      'f_001':
          'https://www.perfectdailygrind.com/wp-content/uploads/2019/08/Jamison-Savage-Finca-Deborah.jpg',
      'f_002':
          'https://cofinet.com.au/cdn/shop/files/Felipe_Carlos_Arcila_480x480.jpg?v=1613567890',
      'f_003':
          'https://www.sweetmarias.com/media/wysiwyg/aida-batlle-el-salvador.jpg',
      'f_004':
          'https://geshavillage.com/wp-content/uploads/2018/06/Adam-and-Rachel-Gesha-Village.jpg',
      'f_005':
          'https://images.squarespace-cdn.com/content/v1/5c9cc5b17eb8824888069d12/1628114400000-8A7A7A7A7A7A7A7A7A7A/Pepe.jpg',
      'f_006':
          'https://volcanazul.com/wp-content/uploads/2020/05/alejo-castro-volcan-azul.jpg',
      'f_007':
          'https://www.daterracoffee.com.br/wp-content/uploads/2020/09/luis-norberto-pascoal.jpg',
    };

    int farmerIdCounter = 1;
    for (var f in farmersJson) {
      final id = farmerIdCounter++;
      final jsonId = f['id'];

      farmersToInsert.add({
        'id': id,
        'name': f['farmer_name_en'],
        'farm_name': f['farm_name'],
        'country': f['country_en'],
        'image_url':
            farmerImages[jsonId] ??
            'https://placehold.co/600x400?text=${f['farmer_name_en']}',
        'altitude': f['altitude_max'] ?? 0,
        'varieties': f['varieties'] is List
            ? (f['varieties'] as List).join(', ')
            : f['varieties'],
      });

      farmerTranslations.add({
        'farmer_id': id,
        'language_code': 'uk',
        'name': f['farmer_name_uk'] ?? f['farmer_name_en'],
        'farm_name': f['farm_name'],
        'country': f['country_uk'] ?? f['country_en'],
        'story': f['biography_uk'] ?? '',
        'description': f['specialization_uk'] ?? '',
      });

      farmerTranslations.add({
        'farmer_id': id,
        'language_code': 'en',
        'name': f['farmer_name_en'],
        'farm_name': f['farm_name'],
        'country': f['country_en'],
        'story': f['biography_en'] ?? '',
        'description': f['specialization_en'] ?? '',
      });
    }
    await client.upsert('localized_farmers', farmersToInsert);
    await client.upsert('localized_farmer_translations', farmerTranslations);

    print('📖 Seeding Encyclopedia...');
    final encyclopediaContent = File(
      'Img/extended_specialty_coffee_encyclopedia.json',
    ).readAsStringSync();
    final objects = encyclopediaContent.split(RegExp(r'\}\n\{'));

    final List<Map<String, dynamic>> articlesList = [];
    final List<Map<String, dynamic>> articleTranslations = [];
    int articleIdCounter = 1;

    final moduleImages = {
      'SC-001':
          'https://www.scaprofessional.com/wp-content/uploads/2021/03/cupping-coffee.jpg',
      'SC-002':
          'https://worldcoffeeresearch.org/media/original_images/Coffee_tree_flowers.jpg',
      'SC-003':
          'https://www.perfectdailygrind.com/wp-content/uploads/2020/03/harvesting-coffee-berries.jpg',
      'SC-004':
          'https://images.squarespace-cdn.com/content/v1/5a9ed56c710699e6971165a2/1523912170362-7AUK0P5E5W0P0P0P0P0P/Drying+beds.jpg',
    };

    for (var objStr in objects) {
      String cleanStr = objStr.trim();
      if (!cleanStr.startsWith('{')) cleanStr = '{' + cleanStr;
      if (!cleanStr.endsWith('}')) cleanStr = cleanStr + '}';

      final module = jsonDecode(cleanStr);
      final moduleId = module['module_metadata']['module_id'];
      final moduleName = module['module_metadata']['module_name'];

      for (var entry in module['content']) {
        final id = articleIdCounter++;
        final topic = entry['topic'];
        final String htmlContent = formatToHtml(entry);

        articlesList.add({
          'id': id,
          'category': moduleName,
          'image_url':
              moduleImages[moduleId] ??
              'https://placehold.co/800x400?text=$topic',
          'is_published': true,
        });

        articleTranslations.add({
          'article_id': id,
          'language_code': 'uk',
          'title': topic,
          'content_html': htmlContent,
        });

        articleTranslations.add({
          'article_id': id,
          'language_code': 'en',
          'title': topic,
          'content_html':
              '<p>Extended information about $topic is coming soon in English.</p>' +
              htmlContent,
        });
      }
    }
    await client.upsert('specialty_articles', articlesList);
    await client.upsert('specialty_article_translations', articleTranslations);

    print('☕ Seeding Beans (Unique Names)...');
    final csvLines = File('localized_beans_10_lang.csv').readAsLinesSync();
    if (csvLines.isNotEmpty) {
      final List<Map<String, dynamic>> beansList = [];
      final List<Map<String, dynamic>> beanTranslations = [];

      for (int i = 1; i < csvLines.length; i++) {
        final line = csvLines[i].trim();
        if (line.isEmpty) continue;

        final fields = parseCsvLine(line);
        if (fields.length < 50) continue;

        final id = i;
        final brandId = int.tryParse(fields[0]) ?? 1;
        final countryEn = fields[2];
        final countryUk = fields[3];
        final varietyEn = fields[24];
        final processEn = fields[44];
        final processUk = fields[45];
        final roasterName = brandId == 1 ? 'Mad Heads' : '3 Champs';

        final uniqueNameEn = '$countryEn $varietyEn $processEn ($roasterName)';
        final uniqueNameUk = '$countryUk $varietyEn $processUk ($roasterName)';

        beansList.add({
          'id': id,
          'brand_id': brandId,
          'region': uniqueNameEn,
          'country': countryEn,
          'altitude_min': int.tryParse(fields[22]) ?? 0,
          'altitude_max': int.tryParse(fields[23]) ?? 0,
          'varieties': varietyEn,
          'process_method': processEn,
          'sca_score': double.tryParse(fields[75]) ?? 0.0,
          'image_url': 'https://placehold.co/400x400?text=$uniqueNameEn',
        });

        beanTranslations.add({
          'bean_id': id,
          'language_code': 'uk',
          'region': uniqueNameUk,
          'country': countryUk,
          'flavor_notes': fields[35],
          'description': fields[55],
        });

        beanTranslations.add({
          'bean_id': id,
          'language_code': 'en',
          'region': uniqueNameEn,
          'country': countryEn,
          'flavor_notes': fields[34],
          'description': fields[54],
        });
      }
      await client.upsert('localized_beans', beansList);
      await client.upsert('localized_bean_translations', beanTranslations);
    }

    print('✅ Modernization Complete!');
  } catch (e, stack) {
    print('❌ Runtime Error: $e\n$stack');
  }
}

String formatToHtml(Map<String, dynamic> data) {
  final StringBuffer sb = StringBuffer();
  data.forEach((key, value) {
    if (key == 'topic') return;
    if (value is String) {
      sb.write('<h3>$key</h3><p>$value</p>');
    } else if (value is List) {
      sb.write('<h3>$key</h3><ul>');
      for (var item in value) {
        if (item is Map) {
          sb.write(
            '<li><strong>${item.values.first}</strong>: ${item.values.last}</li>',
          );
        } else {
          sb.write('<li>$item</li>');
        }
      }
      sb.write('</ul>');
    } else if (value is Map) {
      sb.write('<h3>$key</h3>');
      value.forEach((k, v) {
        sb.write('<p><strong>$k:</strong> $v</p>');
      });
    }
  });
  return sb.toString();
}

List<String> parseCsvLine(String line) {
  final List<String> fields = [];
  bool inQuotes = false;
  final StringBuffer current = StringBuffer();
  for (int i = 0; i < line.length; i++) {
    final char = line[i];
    if (char == '"') {
      inQuotes = !inQuotes;
    } else if (char == ',' && !inQuotes) {
      fields.add(current.toString().trim());
      current.clear();
    } else {
      current.write(char);
    }
  }
  fields.add(current.toString().trim());
  return fields;
}

class NativeSupabaseClient {
  final String baseUrl;
  final String anonKey;
  final HttpClient httpClient = HttpClient();

  NativeSupabaseClient(this.baseUrl, this.anonKey);

  Future<void> upsert(String table, List<Map<String, dynamic>> rows) async {
    // Break into chunks of 50
    for (var i = 0; i < rows.length; i += 50) {
      final end = (i + 50 > rows.length) ? rows.length : i + 50;
      final chunk = rows.sublist(i, end);

      final request = await httpClient.postUrl(
        Uri.parse('$baseUrl/rest/v1/$table'),
      );
      request.headers.add('apikey', anonKey);
      request.headers.add('Authorization', 'Bearer $anonKey');
      request.headers.add('Content-Type', 'application/json');
      request.headers.add('Prefer', 'resolution=merge-duplicates');
      request.write(jsonEncode(chunk));

      final response = await request.close();
      if (response.statusCode >= 300) {
        final body = await response.transform(utf8.decoder).join();
        throw Exception('Upsert failed for $table: $body');
      }
    }
    print('  - Table $table updated (${rows.length} rows)');
  }

  Future<void> deleteTable(String table) async {
    final idCols = ['article_id', 'farmer_id', 'bean_id', 'id'];
    for (var col in idCols) {
      final request = await httpClient.deleteUrl(
        Uri.parse('$baseUrl/rest/v1/$table?$col=neq.-1'),
      );
      request.headers.add('apikey', anonKey);
      request.headers.add('Authorization', 'Bearer $anonKey');
      final response = await request.close();
      if (response.statusCode < 300) return;
    }
  }
}
