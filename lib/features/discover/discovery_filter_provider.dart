import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortType {
  none,
  alphabetAsc,
  alphabetDesc,
  priceAsc,
  priceDesc,
  dateAsc,
  dateDesc,
}

class DiscoveryFilterState {
  final String search;
  final Set<String> selectedCountries;
  final Set<String> selectedFlavorNotes;
  final Set<String> selectedProcesses;
  final SortType sortType;
  final bool isGrid;
  final bool showFavoritesOnly;
  final bool showArchivedOnly;

  const DiscoveryFilterState({
    this.search = '',
    this.selectedCountries = const {},
    this.selectedFlavorNotes = const {},
    this.selectedProcesses = const {},
    this.sortType = SortType.none,
    this.isGrid = false,
    this.showFavoritesOnly = false,
    this.showArchivedOnly = false,
  });

  DiscoveryFilterState copyWith({
    String? search,
    Set<String>? selectedCountries,
    Set<String>? selectedFlavorNotes,
    Set<String>? selectedProcesses,
    SortType? sortType,
    bool? isGrid,
    bool? showFavoritesOnly,
    bool? showArchivedOnly,
  }) {
    return DiscoveryFilterState(
      search: search ?? this.search,
      selectedCountries: selectedCountries ?? this.selectedCountries,
      selectedFlavorNotes: selectedFlavorNotes ?? this.selectedFlavorNotes,
      selectedProcesses: selectedProcesses ?? this.selectedProcesses,
      sortType: sortType ?? this.sortType,
      isGrid: isGrid ?? this.isGrid,
      showFavoritesOnly: showFavoritesOnly ?? this.showFavoritesOnly,
      showArchivedOnly: showArchivedOnly ?? this.showArchivedOnly,
    );
  }

  bool get hasActiveFilters =>
      selectedCountries.isNotEmpty ||
      selectedFlavorNotes.isNotEmpty ||
      selectedProcesses.isNotEmpty ||
      sortType != SortType.none ||
      showFavoritesOnly ||
      showArchivedOnly;
}

class DiscoveryFilterNotifier extends Notifier<DiscoveryFilterState> {
  @override
  DiscoveryFilterState build() => const DiscoveryFilterState();

  void updateSearch(String val) => state = state.copyWith(search: val);

  void toggleCountry(String country) {
    final next = Set<String>.from(state.selectedCountries);
    if (next.contains(country)) {
      next.remove(country);
    } else {
      next.add(country);
    }
    state = state.copyWith(selectedCountries: next);
  }

  void toggleFlavorNote(String note) {
    final next = Set<String>.from(state.selectedFlavorNotes);
    if (next.contains(note)) {
      next.remove(note);
    } else {
      next.add(note);
    }
    state = state.copyWith(selectedFlavorNotes: next);
  }

  void toggleProcess(String process) {
    final next = Set<String>.from(state.selectedProcesses);
    if (next.contains(process)) {
      next.remove(process);
    } else {
      next.add(process);
    }
    state = state.copyWith(selectedProcesses: next);
  }

  void updateSort(SortType type) => state = state.copyWith(sortType: type);

  void toggleViewMode() => state = state.copyWith(isGrid: !state.isGrid);

  void toggleFavoritesOnly() =>
      state = state.copyWith(
        showFavoritesOnly: !state.showFavoritesOnly,
        showArchivedOnly: false,
      );

  void toggleArchivedOnly() =>
      state = state.copyWith(
        showArchivedOnly: !state.showArchivedOnly,
        showFavoritesOnly: false,
      );

  void showAll() => state = state.copyWith(
        showFavoritesOnly: false,
        showArchivedOnly: false,
      );

  void showFavorites() => state = state.copyWith(
        showFavoritesOnly: true,
        showArchivedOnly: false,
      );

  void showArchived() => state = state.copyWith(
        showFavoritesOnly: false,
        showArchivedOnly: true,
      );

  void clearFilters() {
    state = state.copyWith(
      selectedCountries: const {},
      selectedFlavorNotes: const {},
      selectedProcesses: const {},
      sortType: SortType.none,
      showFavoritesOnly: false,
    );
  }

  void removeFilter(String type, String value) {
    if (type == 'country') {
      final next = Set<String>.from(state.selectedCountries)..remove(value);
      state = state.copyWith(selectedCountries: next);
    } else if (type == 'flavor') {
      final next = Set<String>.from(state.selectedFlavorNotes)..remove(value);
      state = state.copyWith(selectedFlavorNotes: next);
    } else if (type == 'process') {
      final next = Set<String>.from(state.selectedProcesses)..remove(value);
      state = state.copyWith(selectedProcesses: next);
    } else if (type == 'sort') {
      state = state.copyWith(sortType: SortType.none);
    }
  }
}

final encyclopediaFilterProvider =
    NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>(() {
      return DiscoveryFilterNotifier();
    });

final myLotsFilterProvider =
    NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>(() {
      return DiscoveryFilterNotifier();
    });

final brewingFilterProvider =
    NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>(() {
      return DiscoveryFilterNotifier();
    });
