import 'dart:io';

void main() {
  final sql = StringBuffer();

  // 1. SEED SPHERE REGIONS (10 MOV)
  final regions = [
    {
      'id': 'sa_1',
      'key': 'south_america',
      'name_en': 'South America',
      'name_uk': 'Південна Америка',
      'name_pl': 'Ameryka Południowa',
      'name_de': 'Südamerika',
      'name_fr': 'Amérique du Sud',
      'name_es': 'Sudamérica',
      'name_it': 'Sud America',
      'name_pt': 'América do Sul',
      'name_ro': 'America de Sud',
      'name_tr': 'Güney Amerika',
      'lat': -15.0,
      'lon': -60.0,
      'color': '#C8A96E',
      'desc_en': 'Chocolate, caramel, and nutty notes.',
      'desc_uk': 'Шоколад, карамель та горіхові нотки.',
    },
    {
      'id': 'ea_1',
      'key': 'east_africa',
      'name_en': 'East Africa',
      'name_uk': 'Східна Африка',
      'name_pl': 'Afryka Wschodnia',
      'name_de': 'Ostafrika',
      'name_fr': 'Afrique de l\'Est',
      'name_es': 'África Oriental',
      'name_it': 'Africa orientale',
      'name_pt': 'África Oriental',
      'name_ro': 'Africa de Est',
      'name_tr': 'Doğu Afrika',
      'lat': 0.0,
      'lon': 35.0,
      'color': '#FF5733',
      'desc_en': 'Bright acidity and floral aromas.',
      'desc_uk': 'Яскрава кислотність та квіткові аромати.',
    },
    {
      'id': 'ap_1',
      'key': 'asia_pacific',
      'name_en': 'Asia Pacific',
      'name_uk': 'Азійсько-Тихоокеанський регіон',
      'name_pl': 'Azja-Pacyfik',
      'name_de': 'Asien-Pazifik',
      'name_fr': 'Asie-Pacifique',
      'name_es': 'Asia-Pacífico',
      'name_it': 'Asia-Pacifico',
      'name_pt': 'Ásia-Pacífico',
      'name_ro': 'Asia-Pacific',
      'name_tr': 'Asya Pasifik',
      'lat': -5.0,
      'lon': 120.0,
      'color': '#2E8B57',
      'desc_en': 'Earthy, spicy, and full-bodied.',
      'desc_uk': 'Землисті, пряні та насичені смаки.',
    },
    {
      'id': 'ca_1',
      'key': 'central_america',
      'name_en': 'Central America',
      'name_uk': 'Центральна Америка',
      'name_pl': 'Ameryka Środковая',
      'name_de': 'Zentralamerika',
      'name_fr': 'Amérique centrale',
      'name_es': 'Centroamérica',
      'name_it': 'America centrale',
      'name_pt': 'América Central',
      'name_ro': 'America Centrală',
      'name_tr': 'Orta Amerika',
      'lat': 15.0,
      'lon': -90.0,
      'color': '#4682B4',
      'desc_en': 'Balanced acidity and sweet citrus.',
      'desc_uk': 'Збалансована кислотність та солодкі цитруси.',
    },
  ];

  for (final r in regions) {
    sql.writeln(
      "INSERT INTO sphere_regions (id, key, name_en, name_uk, name_pl, name_de, name_fr, name_es, name_it, name_pt, name_ro, name_tr, description_en, description_uk, latitude, longitude, marker_color, flavor_profile_en, flavor_profile_uk) VALUES ('${r['id']}', '${r['key']}', '${r['name_en']}', '${r['name_uk']}', '${r['name_pl']}', '${r['name_de']}', '${r['name_fr']}', '${r['name_es']}', '${r['name_it']}', '${r['name_pt']}', '${r['name_ro']}', '${r['name_tr']}', '${r['desc_en']}', '${r['desc_uk']}', ${r['lat']}, ${r['lon']}, '${r['color']}', '[]', '[]') ON CONFLICT (id) DO UPDATE SET name_en = EXCLUDED.name_en;",
    );
  }

  // 2. SEED ARTICLES
  sql.writeln(
    "INSERT INTO specialty_articles (title_en, title_uk, subtitle_en, subtitle_uk, content_html_en, content_html_uk, image_url, read_time_min) VALUES ('Washed Process Guide', 'Гід по митій обробці', 'Clarity and Brightness', 'Чистота та яскравість', 'Detailed guide about washed processing...', 'Детальний гід про миту обробку...', 'https://images.unsplash.com/photo-1518057111178-44a106bad636', 5);",
  );

  File('seed_sphere_and_articles.sql').writeAsStringSync(sql.toString());
  stdout.writeln('Generated seed_sphere_and_articles.sql');
}
