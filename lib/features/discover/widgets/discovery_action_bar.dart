import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../discovery_filter_provider.dart';
import 'filter_sort_sheet.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../navigation/navigation_providers.dart';
import '../../../core/providers/settings_provider.dart';

class DiscoveryActionBar extends ConsumerWidget {
  final NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>
  filterProvider;
  final dynamic selectionProvider;
  final VoidCallback onCompareTap;
  final VoidCallback? onSelectAll;
  final List<String> availableCountries;
  final List<String> availableFlavors;
  final List<String> availableProcesses;
  final bool showFavoritesButton;
  final bool showComparison;
  final bool showViewModeToggle;
  final String? searchHint;

  const DiscoveryActionBar({
    super.key,
    required this.filterProvider,
    required this.selectionProvider,
    required this.onCompareTap,
    this.onSelectAll,
    this.availableCountries = const [],
    this.availableFlavors = const [],
    this.availableProcesses = const [],
    this.showFavoritesButton = true,
    this.showComparison = true,
    this.showViewModeToggle = true,
    this.searchHint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);
    final selectedLots = ref.watch(selectionProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // ── Row 0: Search Bar ──────────────────────────────────────────────
          if (searchHint != null) ...[
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                onChanged: (v) =>
                    ref.read(filterProvider.notifier).updateSearch(v),
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: searchHint,
                  hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
                  filled: false,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      Icons.search_rounded,
                      color: Color(0xFFC8A96E),
                      size: 20,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          // ── Row 1: Filters & Comparison ────────────────────────────────────
          Row(
            children: [
              _ControlChip(
                icon: Icons.tune_rounded,
                label: context.t('filters'),
                isActive: state.hasActiveFilters,
                onTap: () => _showSortSheet(context, ref),
              ),
              if (showComparison) ...[
                const SizedBox(width: 8),
                _ControlChip(
                  icon: Icons.compare_arrows_rounded,
                  label: selectedLots.isEmpty
                      ? context.t('compare')
                      : '${context.t('compare')} (${selectedLots.length})',
                  isActive: selectedLots.isNotEmpty,
                  onTap: onCompareTap,
                ),
              ],
              const Spacer(),
              if (showViewModeToggle)
                _ViewModeToggle(
                  isGrid: state.isGrid,
                  onTap: () {
                    ref.read(settingsProvider.notifier).triggerHaptic();
                    ref.read(filterProvider.notifier).toggleViewMode();
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          // ── Row 2: Sub-Tabs (Capsule Container) ────────────────────────────
          Container(
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SubTabCapsule(
                    label: context.t('all'),
                    isSelected:
                        !state.showFavoritesOnly && !state.showArchivedOnly,
                    onTap: () => ref.read(filterProvider.notifier).showAll(),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _SubTabCapsule(
                    label: context.t('favorites'),
                    isSelected: state.showFavoritesOnly,
                    onTap: () =>
                        ref.read(filterProvider.notifier).showFavorites(),
                    icon: Icons.favorite_rounded,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _SubTabCapsule(
                    label: context.t('archive'),
                    isSelected: state.showArchivedOnly,
                    onTap: () =>
                        ref.read(filterProvider.notifier).showArchived(),
                    icon: Icons.archive_rounded,
                  ),
                ),
              ],
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
    ).then((_) {
      ref.read(navBarVisibleProvider.notifier).show();
    });
  }
}

class _ControlChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _ControlChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFC8A96E)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
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

class _ViewModeToggle extends StatelessWidget {
  final bool isGrid;
  final VoidCallback onTap;

  const _ViewModeToggle({required this.isGrid, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(
          isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
          color: const Color(0xFFC8A96E),
          size: 20,
        ),
      ),
    );
  }
}

class _SubTabCapsule extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const _SubTabCapsule({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC8A96E) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.white54,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.black : Colors.white38,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
