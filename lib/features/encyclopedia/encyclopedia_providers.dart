import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

/// Notifier for the Encyclopedia search query
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String query) {
    state = query;
  }
}

/// Provider for the current search query in the Encyclopedia
final encyclopediaSearchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

/// Notifier for the Encyclopedia sorting state
class EncyclopediaSortNotifier extends Notifier<EncyclopediaSortOption> {
  @override
  EncyclopediaSortOption build() => EncyclopediaSortOption.countryAsc;

  void update(EncyclopediaSortOption newState) {
    state = newState;
  }
}

/// Provider for the current sorting state of the Encyclopedia
final encyclopediaSortProvider =
    NotifierProvider<EncyclopediaSortNotifier, EncyclopediaSortOption>(
  EncyclopediaSortNotifier.new,
);

/// Reactive stream of Encyclopedia entries from the local database.
/// This ensures offline availability and high performance.
final localEncyclopediaStreamProvider =
    StreamProvider<List<LocalizedBeanDto>>((ref) {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(localeProvider);

  // Trigger background sync when this provider is first used
  // We use Future.microtask to avoid performing sync during widget build
  Future.microtask(() async {
    try {
      final syncService = ref.read(syncServiceProvider);
      await syncService.syncEncyclopedia();
    } catch (e) {
      debugPrint('BACKGROUND SYNC ERROR: $e');
    }
  });

  return db.watchAllEncyclopediaEntries(lang);
});

/// Final processed data for the Encyclopedia UI (sorted and filtered).
final encyclopediaDataProvider = Provider<AsyncValue<List<LocalizedBeanDto>>>((ref) {
  final entriesAsync = ref.watch(localEncyclopediaStreamProvider);
  final sortOption = ref.watch(encyclopediaSortProvider);
  final search = ref.watch(encyclopediaSearchQueryProvider).toLowerCase();

  return entriesAsync.whenData((entries) {
    // 1. Filter by search query
    var filtered = entries.where((e) {
      if (search.isEmpty) return true;
      return e.country.toLowerCase().contains(search) ||
          e.region.toLowerCase().contains(search) ||
          e.varieties.toLowerCase().contains(search);
    }).toList();

    // 2. Apply Sorting
    filtered.sort((a, b) {
      int compareResult = 0;
      switch (sortOption) {
        case EncyclopediaSortOption.countryAsc:
          compareResult = a.country.compareTo(b.country);
          break;
        case EncyclopediaSortOption.countryDesc:
          compareResult = b.country.compareTo(a.country);
          break;
        case EncyclopediaSortOption.regionAsc:
          compareResult = a.region.compareTo(b.region);
          break;
        case EncyclopediaSortOption.regionDesc:
          compareResult = b.region.compareTo(a.region);
          break;
        case EncyclopediaSortOption.countryRegionAsc:
          compareResult = a.country.compareTo(b.country);
          if (compareResult == 0) compareResult = a.region.compareTo(b.region);
          break;
        case EncyclopediaSortOption.priceRetailAsc:
          compareResult = _comparePrice(a.retailPrice, b.retailPrice);
          break;
        case EncyclopediaSortOption.priceRetailDesc:
          compareResult = _comparePrice(b.retailPrice, a.retailPrice);
          break;
        case EncyclopediaSortOption.priceWholesaleAsc:
          compareResult = _comparePrice(a.wholesalePrice, b.wholesalePrice);
          break;
        case EncyclopediaSortOption.priceWholesaleDesc:
          compareResult = _comparePrice(b.wholesalePrice, a.wholesalePrice);
          break;
        case EncyclopediaSortOption.processAsc:
          compareResult = a.processMethod.compareTo(b.processMethod);
          break;
        case EncyclopediaSortOption.newestFirst:
          if (a.createdAt == null || b.createdAt == null) return 0;
          compareResult = b.createdAt!.compareTo(a.createdAt!);
          break;
      }
      return compareResult;
    });

    return filtered;
  });
});

int _comparePrice(String? a, String? b) {
  final valA = double.tryParse(a ?? '') ?? 0.0;
  final valB = double.tryParse(b ?? '') ?? 0.0;
  return valA.compareTo(valB);
}

/// Provider that tracking locally favorited bean IDs
final favoriteIdsProvider = StreamProvider<Set<int>>((ref) {
  final db = ref.watch(databaseProvider);
  return Stream.fromFuture(db.getFavoriteIds());
});

/// Legacy compatibility - should be migrated to encyclopediaDataProvider
final supabaseEncyclopediaProvider = Provider<AsyncValue<List<LocalizedBeanDto>>>((ref) {
  return ref.watch(encyclopediaDataProvider);
});

