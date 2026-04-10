import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../discovery_filter_provider.dart';
import '../../../core/providers/settings_provider.dart';

class FilterChipBar extends ConsumerWidget {
  final NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState> filterProvider;

  const FilterChipBar({
    super.key,
    required this.filterProvider,
    this.hideFavorites = false,
  });

  final bool hideFavorites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);
    if (!state.hasActiveFilters) return const SizedBox.shrink();

    final chips = <_FilterChipData>[];

    // Add Favorites chip
    if (state.showFavoritesOnly && !hideFavorites) {
      chips.add(_FilterChipData(
        type: 'favorites',
        value: 'favorites',
        label: 'Favorites',
        icon: Icons.favorite_rounded,
      ));
    }

    // Add Sort chip
    if (state.sortType != SortType.none) {
      chips.add(_FilterChipData(
        type: 'sort',
        value: 'sort',
        label: _getSortLabel(state.sortType),
        icon: Icons.sort_rounded,
      ));
    }

    // Add Country chips
    for (final country in state.selectedCountries) {
      chips.add(_FilterChipData(
        type: 'country',
        value: country,
        label: country,
        icon: Icons.public_rounded,
      ));
    }

    // Add Flavor chips
    for (final flavor in state.selectedFlavorNotes) {
      chips.add(_FilterChipData(
        type: 'flavor',
        value: flavor,
        label: flavor,
        icon: Icons.local_cafe_rounded,
      ));
    }

    // Add Process chips
    for (final process in state.selectedProcesses) {
      chips.add(_FilterChipData(
        type: 'process',
        value: process,
        label: process,
        icon: Icons.settings_input_component_rounded,
      ));
    }

    return Container(
      height: 44,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final chip = chips[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFC8A96E),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(chip.icon, size: 14, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  chip.label,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                    if (chip.type == 'favorites') {
                      ref.read(filterProvider.notifier).toggleFavoritesOnly();
                    } else {
                      ref.read(filterProvider.notifier).removeFilter(chip.type, chip.value);
                    }
                  },
                  child: const Icon(Icons.close_rounded, size: 16, color: Colors.black54),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getSortLabel(SortType type) {
    switch (type) {
      case SortType.alphabetAsc: return 'A-Z';
      case SortType.alphabetDesc: return 'Z-A';
      case SortType.priceAsc: return 'Cost ↑';
      case SortType.priceDesc: return 'Cost ↓';
      case SortType.dateAsc: return 'Oldest';
      case SortType.dateDesc: return 'Newest';
      default: return 'Sorted';
    }
  }
}

class _FilterChipData {
  final String type;
  final String value;
  final String label;
  final IconData icon;

  _FilterChipData({
    required this.type,
    required this.value,
    required this.label,
    required this.icon,
  });
}
