import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';

enum EncyclopediaSortField { country, region, countryRegion, price, process }

class EncyclopediaSortState {
  final EncyclopediaSortField field;
  final bool ascending;

  const EncyclopediaSortState({
    this.field = EncyclopediaSortField.country,
    this.ascending = true,
  });

  EncyclopediaSortState copyWith({
    EncyclopediaSortField? field,
    bool? ascending,
  }) {
    return EncyclopediaSortState(
      field: field ?? this.field,
      ascending: ascending ?? this.ascending,
    );
  }
}

/// Provider for the current sorting state of the Encyclopedia
final encyclopediaSortProvider =
    StateProvider<EncyclopediaSortState>((ref) => const EncyclopediaSortState());

/// Provider that tracks locally favorited Supabase bean IDs
final favoriteIdsProvider = FutureProvider<Set<int>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getFavoriteIds();
});

final supabaseEncyclopediaProvider =
    FutureProvider<List<EncyclopediaEntry>>((ref) async {
  final supabase = ref.watch(supabaseProvider);
  final lang = ref.watch(localeProvider);
  final sortState = ref.watch(encyclopediaSortProvider);
  
  // Fetch favorites to enrich the data (we use a regular future to avoid rebuild loops)
  final favorites = await ref.read(databaseProvider).getFavoriteIds();

  debugPrint('DEBUG: Fetching Encyclopedia from Supabase (lang: $lang)');

  try {
    final response = await supabase
        .from('localized_beans')
        .select()
        .order('id'); // Consistent base order

    final List<dynamic> data = response as List<dynamic>;
    debugPrint('DEBUG: Fetched ${data.length} lots from Supabase');

    final entries = data.map<EncyclopediaEntry>((item) {
      final sensoryJson = item['sensory_json'];
      final priceJson = item['price_json'];
      final processingRaw = item['processing_methods_json'];
      final plantationPhotosRaw = item['plantation_photos_url'];

      // Localized fields depend on the current app language
      final country = item['country_$lang'] ?? item['country_en'] ?? '';
      final region = item['region_$lang'] ?? item['region_en'] ?? '';
      final varieties = item['varieties_$lang'] ?? item['varieties_en'] ?? '';
      final description =
          item['description_$lang'] ?? item['description_en'] ?? '';
      final processMethod =
          item['process_method_$lang'] ?? item['process_method_en'] ?? '';
      final flavorNotesRaw =
          item['flavor_notes_$lang'] ?? item['flavor_notes_en'] ?? '[]';

      List<String> parseList(dynamic raw) {
        if (raw == null) return [];
        if (raw is List) return raw.cast<String>();
        if (raw is String) {
          try {
            final decoded = jsonDecode(raw);
            if (decoded is List) return decoded.cast<String>();
          } catch (_) {}
        }
        return [];
      }

      final id = item['id'] as int;

      // Construct country-specific flag URL from specialty-articles bucket
      final countryEn = item['country_en'] ?? 'Unknown';
      final flagUrl = supabase.storage
          .from('specialty-articles')
          .getPublicUrl('$countryEn sphere.png');

      return EncyclopediaEntry(
        id: id,
        country: country,
        region: region,
        varieties: varieties,
        description: description,
        processMethod: processMethod,
        flavorNotes: parseList(flavorNotesRaw),
        countryEmoji: item['country_emoji'],
        altitudeMin: item['altitude_min'] as int?,
        altitudeMax: item['altitude_max'] as int?,
        lotNumber: item['lot_number'] ?? '',
        scaScore: item['sca_score']?.toString() ?? '85+',
        cupsScore: (item['cups_score'] as num?)?.toDouble() ?? 0.0,
        sensoryPoints: _parseJsonData(sensoryJson),
        pricing: _parseJsonData(priceJson),
        isPremium: item['is_premium'] ?? false,
        detailedProcess: item['detailed_process_markdown'] ?? '',
        url: flagUrl, // We use the dynamic flag URL as the primary image for the catalog
        isDecaf: item['is_decaf'] ?? false,
        farm: item['farm'],
        farmPhotosUrlCover: item['farm_photos_url_cover'],
        washStation: item['wash_station'],
        retailPrice: item['retail_price'],
        wholesalePrice: item['wholesale_price'],
        harvestSeason: item['harvest_season'],
        price: item['price'],
        weight: item['weight'],
        roastDate: item['roast_date'],
        processingMethodsJson: processingRaw is String ? processingRaw : jsonEncode(processingRaw ?? []),
        plantationPhotos: parseList(plantationPhotosRaw),
        isFavorite: favorites.contains(id),
      );
    }).toList();

    // Apply Sorting logic
    entries.sort((a, b) {
      int cmp = 0;
      switch (sortState.field) {
        case EncyclopediaSortField.country:
          cmp = a.country.compareTo(b.country);
          break;
        case EncyclopediaSortField.region:
          cmp = a.region.compareTo(b.region);
          break;
        case EncyclopediaSortField.countryRegion:
          cmp = a.country.compareTo(b.country);
          if (cmp == 0) cmp = a.region.compareTo(b.region);
          break;
        case EncyclopediaSortField.price:
          cmp = a.maxPrice.compareTo(b.maxPrice);
          break;
        case EncyclopediaSortField.process:
          cmp = a.processMethod.compareTo(b.processMethod);
          break;
      }
      return sortState.ascending ? cmp : -cmp;
    });

    return entries;
  } catch (e, stack) {
    debugPrint('ERROR in supabaseEncyclopediaProvider: $e');
    debugPrint(stack.toString());
    rethrow;
  }
});

Map<String, dynamic> _parseJsonData(dynamic data) {
  if (data == null) return {};
  if (data is Map<String, dynamic>) return data;
  if (data is String) {
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {}
  }
  return {};
}

List<T> _parseList<T>(dynamic data) {
  if (data == null) return <T>[];
  if (data is List) return data.cast<T>();
  if (data is String && data.isNotEmpty) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is List) return decoded.cast<T>();
    } catch (_) {}
  }
  return <T>[];
}
