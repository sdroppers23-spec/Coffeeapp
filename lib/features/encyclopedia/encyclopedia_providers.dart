import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/dtos.dart';

final supabaseEncyclopediaProvider = FutureProvider<List<EncyclopediaEntry>>((ref) async {
  final supabase = ref.watch(supabaseProvider);
  final lang = ref.watch(localeProvider);
  
  // Fetch from localized_beans table which contains the main encyclopedia data
  final response = await supabase
      .from('localized_beans')
      .select()
      .order('country_en');

  return response.map<EncyclopediaEntry>((data) {
    // Map fields based on current language
    final country = data['country_$lang'] ?? data['country_en'] ?? '';
    final region = data['region_$lang'] ?? data['region_en'] ?? '';
    final varieties = data['varieties_$lang'] ?? data['varieties_en'] ?? '';
    final description = data['description_$lang'] ?? data['description_en'] ?? '';
    final flavorNotesRaw = data['flavor_notes_$lang'] ?? data['flavor_notes_en'] ?? [];
    
    // Construct storage URL for the country flag
    // Pattern: [CountryName] sphere.png in specialty-articles bucket
    final countryKey = data['country_en'] ?? 'Unknown';
    final flagUrl = supabase.storage
        .from('specialty-articles')
        .getPublicUrl('$countryKey sphere.png');

    return EncyclopediaEntry(
      id: data['id'],
      country: country,
      region: region,
      varieties: varieties,
      flavorNotes: List<String>.from(flavorNotesRaw),
      description: description,
      farmDescription: data['farm_description'] ?? '',
      roastLevel: data['roast_level_$lang'] ?? data['roast_level_en'] ?? '',
      processMethod: data['process_method_$lang'] ?? data['process_method_en'] ?? '',
      cupsScore: (data['cups_score'] as num?)?.toDouble() ?? 0.0,
      scaScore: data['sca_score']?.toString() ?? '85+',
      sensoryPoints: data['sensory_json'] as Map<String, dynamic>? ?? {},
      pricing: data['price_json'] as Map<String, dynamic>? ?? {},
      isPremium: data['is_premium'] ?? false,
      isFavorite: false, // Default for encyclopedia
      countryEmoji: data['country_emoji'], // Keep as fallback
      altitudeMin: data['altitude_min'],
      altitudeMax: data['altitude_max'],
      lotNumber: data['lot_number'] ?? '',
      detailedProcess: data['detailed_process_markdown'] ?? '',
      plantationPhotos: [], // We use storage URL for flags separately or can populate if needed
      url: flagUrl, // Store flag URL in the url field of DTO for easy access in UI
    );
  }).toList();
});
