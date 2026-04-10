import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../discovery_filter_provider.dart';
import 'filter_sort_sheet.dart';
import '../../../shared/widgets/pressable_scale.dart';

class DiscoveryActionBar extends ConsumerWidget {
  final NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>
  filterProvider;
  final VoidCallback onCompareTap;
  final List<String> availableCountries;
  final List<String> availableFlavors;
  final List<String> availableProcesses;

  const DiscoveryActionBar({
    super.key,
    required this.filterProvider,
    required this.onCompareTap,
    this.availableCountries = const [],
    this.availableFlavors = const [],
    this.availableProcesses = const [],
    this.showFavoritesButton = true,
  });

  final bool showFavoritesButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _ActionButton(
                    icon: Icons.sort_rounded,
                    label: 'Фільтри',
                    isActive: state.hasActiveFilters,
                    onTap: () => _showSortSheet(context, ref),
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    icon: Icons.compare_arrows_rounded,
                    label: 'Порівняння',
                    onTap: onCompareTap,
                  ),
                  if (showFavoritesButton) ...[
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: state.showFavoritesOnly
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      label: 'Обране',
                      isActive: state.showFavoritesOnly,
                      onTap: () => ref
                          .read(filterProvider.notifier)
                          .toggleFavoritesOnly(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          PressableScale(
            onTap: () => ref.read(filterProvider.notifier).toggleViewMode(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Icon(
                state.isGrid
                    ? Icons.view_list_rounded
                    : Icons.grid_view_rounded,
                color: const Color(0xFFC8A96E),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterSortSheet(
        filterProvider: filterProvider,
        availableCountries: availableCountries,
        availableFlavors: availableFlavors,
        availableProcesses: availableProcesses,
      ),
    );
  }
}

class _ActionButton extends ConsumerWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PressableScale(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFC8A96E)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.black : const Color(0xFFC8A96E),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.black : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
