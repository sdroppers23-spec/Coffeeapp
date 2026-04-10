class FlagConstants {
  static const Map<String, String> glassFlags = {
    // Colombia
    'Colombia': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/colombia_sphere.png',
    'Колумбія': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/colombia_sphere.png',
    
    // Ethiopia
    'Ethiopia': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/ethiopia_sphere.png',
    'Ефіопія': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/ethiopia_sphere.png',
    
    // Brazil
    'Brazil': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/brazil_sphere.png',
    'Бразилія': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/brazil_sphere.png',
    
    // Kenya
    'Kenya': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/kenya_sphere.png',
    'Кенія': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/kenya_sphere.png',
    
    // Costa Rica
    'Costa Rica': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/costa_rica_sphere.png',
    'Коста-Ріка': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/costa_rica_sphere.png',
    'Коста-Рика': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/costa_rica_sphere.png',
    
    // El Salvador
    'El Salvador': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/el_salvador_sphere.png',
    'Сальвадор': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/el_salvador_sphere.png',
    'Ель-Сальвадор': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/el_salvador_sphere.png',
    
    // Ecuador
    'Ecuador': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/ecuador_sphere.png',
    'Еквадор': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/ecuador_sphere.png',
    
    // Guatemala
    'Guatemala': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/guatemala_sphere.png',
    'Гватемала': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/guatemala_sphere.png',
    
    // Indonesia
    'Indonesia': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/indonesia_sphere.png',
    'Індонезія': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/indonesia_sphere.png',
    
    // Panama
    'Panama': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/panama_sphere.png',
    'Панама': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/panama_sphere.png',

    // Rwanda
    'Rwanda': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/rwanda_sphere.png',
    'Руанда': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/rwanda_sphere.png',

    // Honduras
    'Honduras': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/honduras_sphere.png',
    'Гондурас': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/honduras_sphere.png',

    // Uganda
    'Uganda': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/uganda_sphere.png',
    'Уганда': 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/uganda_sphere.png',
  };

  static String? getFlag(String? countryName) {
    if (countryName == null || countryName.isEmpty) return null;
    
    // Normalize string for better matching
    String normalize(String s) {
      return s.trim().toLowerCase()
          .replaceAll('і', 'i')
          .replaceAll('и', 'i') 
          .replaceAll('й', 'i')
          .replaceAll(' ', '') // Remove spaces for ultra-fuzzy match
          .replaceAll('-', '') 
          .replaceAll(RegExp(r'[^a-z0-9а-яіїєґ]'), '');
    }

    final normalizedInput = normalize(countryName);
    
    // 1. Try exact (normalized) match
    for (final entry in glassFlags.entries) {
      if (normalize(entry.key) == normalizedInput) return entry.value;
    }

    // 2. Try fuzzy match (if normalized input contains any of our normalized keys)
    for (final entry in glassFlags.entries) {
      final normalizedKey = normalize(entry.key);
      if (normalizedKey.length > 3 && (normalizedInput.contains(normalizedKey) || normalizedKey.contains(normalizedInput))) {
        return entry.value;
      }
    }
    
    return null;
  }
}
