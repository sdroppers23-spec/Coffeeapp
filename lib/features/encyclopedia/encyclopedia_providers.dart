import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

import '../discover/discovery_filter_provider.dart';

/// Notifier for the Encyclopedia search query
// DEPRECATED: Use encyclopediaFilterProvider instead
final encyclopediaSearchQueryProvider =
    Provider<String>((ref) => ref.watch(encyclopediaFilterProvider).search);

/// Provider for the current sorting state of the Encyclopedia
// DEPRECATED: Use encyclopediaFilterProvider instead
final encyclopediaSortProvider =
    Provider<SortType>((ref) => ref.watch(encyclopediaFilterProvider).sortType);

/// Reactive stream of Encyclopedia entries from the local database.
/// This ensures offline availability and high performance.
final localEncyclopediaStreamProvider =
    StreamProvider<List<LocalizedBeanDto>>((ref) {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(localeProvider);

  // Trigger background sync and subscription when this provider is first used
  Future.microtask(() async {
    try {
      final syncService = ref.read(syncServiceProvider);
      // Ensure we have initial data (gentle pull)
      await syncService.syncEncyclopedia();
      // subscribeToRealtimeUpdates now handles all shared tables including beans
      syncService.subscribeToRealtimeUpdates();
    } catch (e) {
      debugPrint('BACKGROUND SYNC ERROR: $e');
    }
  });

  return db.watchAllEncyclopediaEntries(lang);
});

/// Final processed data for the Encyclopedia UI (sorted and filtered).
final encyclopediaDataProvider = Provider<AsyncValue<List<LocalizedBeanDto>>>((ref) {
  final entriesAsync = ref.watch(localEncyclopediaStreamProvider);
  final filterState = ref.watch(encyclopediaFilterProvider);
  final search = filterState.search.toLowerCase();

  return entriesAsync.whenData((entries) {
    // 1. Filter by search query, countries, flavors, and processes
    var filtered = entries.where((e) {
      // Search
      if (search.isNotEmpty) {
        final matchesSearch = e.country.toLowerCase().contains(search) ||
            e.region.toLowerCase().contains(search) ||
            e.varieties.toLowerCase().contains(search);
        if (!matchesSearch) return false;
      }

      // Countries
      if (filterState.selectedCountries.isNotEmpty &&
          !filterState.selectedCountries.contains(e.country)) {
        return false;
      }

      // Flavor Notes
      if (filterState.selectedFlavorNotes.isNotEmpty) {
        final matchesFlavor = e.flavorNotes.any((f) => filterState.selectedFlavorNotes.contains(f));
        if (!matchesFlavor) return false;
      }

      // Process Methods
      if (filterState.selectedProcesses.isNotEmpty &&
          !filterState.selectedProcesses.contains(e.processMethod)) {
        return false;
      }

      // Favorites Only
      if (filterState.showFavoritesOnly && !e.isFavorite) {
        return false;
      }

      return true;
    }).toList();

    // 2. Apply Sorting
    filtered.sort((a, b) {
      switch (filterState.sortType) {
        case SortType.alphabetAsc:
          return a.country.compareTo(b.country);
        case SortType.alphabetDesc:
          return b.country.compareTo(a.country);
        case SortType.priceAsc:
          return _comparePrice(a.retailPrice, b.retailPrice);
        case SortType.priceDesc:
          return _comparePrice(b.retailPrice, a.retailPrice);
        case SortType.dateDesc:
          if (a.createdAt == null || b.createdAt == null) return 0;
          return b.createdAt!.compareTo(a.createdAt!);
        case SortType.dateAsc:
          if (a.createdAt == null || b.createdAt == null) return 0;
          return a.createdAt!.compareTo(b.createdAt!);
        default:
          return 0;
      }
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

final availableEncyclopediaCountriesProvider = Provider<List<String>>((ref) {
  final entries = ref.watch(localEncyclopediaStreamProvider).asData?.value ?? [];
  return entries.map((e) => e.country).where((c) => c.isNotEmpty).toSet().toList()..sort();
});

final availableEncyclopediaFlavorsProvider = Provider<List<String>>((ref) {
  final entries = ref.watch(localEncyclopediaStreamProvider).asData?.value ?? [];
  return entries.expand((e) => e.flavorNotes).where((f) => f.isNotEmpty).toSet().toList()..sort();
});

final availableEncyclopediaProcessesProvider = Provider<List<String>>((ref) {
  final entries = ref.watch(localEncyclopediaStreamProvider).asData?.value ?? [];
  return entries.map((e) => e.processMethod).where((p) => p.isNotEmpty).toSet().toList()..sort();
});

