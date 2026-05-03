import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../discovery_filter_provider.dart';
import 'filter_sort_sheet.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../navigation/navigation_providers.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/providers/preferences_provider.dart';

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
  final bool showSwipeModeToggle;
  final String? searchHint;
  final bool isMatte;

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
    this.showSwipeModeToggle = true,
    this.searchHint,
    this.isMatte = false,
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
            isMatte
                ? GlassContainer(
                    height: 48,
                    borderRadius: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    opacity: 0.12,
                    blur: 15,
                    borderWidth: 1.5,
                    borderColor: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                    child: _buildSearchField(ref),
                  )
                : Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: _buildSearchField(ref),
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
                isMatte: isMatte,
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
                  isMatte: isMatte,
                ),
              ],
              const Spacer(),
              if (showViewModeToggle) ...[
                if (showSwipeModeToggle) ...[
                  const _SwipeModeToggle(),
                  const SizedBox(width: 8),
                ],
                _ViewModeToggle(
                  isGrid: state.isGrid,
                  onTap: () {
                    ref.read(settingsProvider.notifier).triggerHaptic();
                    ref.read(filterProvider.notifier).toggleViewMode();
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          // ── Row 2: Sub-Tabs (Capsule Container) ────────────────────────────
          isMatte
              ? GlassContainer(
                  height: 48,
                  borderRadius: 24,
                  padding: const EdgeInsets.all(4),
                  opacity: 0.05,
                  blur: 10,
                  borderColor: Colors.white.withValues(alpha: 0.2),
                  child: _buildSubTabs(context, ref, state),
                )
              : Container(
                  height: 48,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: _buildSubTabs(context, ref, state),
                ),
        ],
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref) {
    return TextField(
      onChanged: (v) => ref.read(filterProvider.notifier).updateSearch(v),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: searchHint,
        hintStyle: GoogleFonts.outfit(
          color: Colors.white24,
          fontSize: 14,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        filled: false,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFFC8A96E),
          size: 20,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 48,
        ),
      ),
    );
  }

  Widget _buildSubTabs(
      BuildContext context, WidgetRef ref, DiscoveryFilterState state) {
    return Row(
      children: [
        Expanded(
          child: _SubTabCapsule(
            label: context.t('all'),
            isSelected: !state.showFavoritesOnly && !state.showArchivedOnly,
            onTap: () => ref.read(filterProvider.notifier).showAll(),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: _SubTabCapsule(
            label: context.t('favorites'),
            isSelected: state.showFavoritesOnly,
            onTap: () => ref.read(filterProvider.notifier).showFavorites(),
            icon: Icons.favorite_rounded,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: _SubTabCapsule(
            label: context.t('archive'),
            isSelected: state.showArchivedOnly,
            onTap: () => ref.read(filterProvider.notifier).showArchived(),
            icon: Icons.archive_rounded,
          ),
        ),
      ],
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

  final bool isMatte;

  const _ControlChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.isMatte = false,
  });

  @override
  Widget build(BuildContext context) {
    final chipContent = Row(
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
    );

    return PressableScale(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: isMatte && !isActive
          ? GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              borderRadius: 12,
              opacity: 0.1,
              blur: 10,
              borderColor: Colors.white.withValues(alpha: 0.1),
              child: chipContent,
            )
          : Container(
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
              child: chipContent,
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

class _SwipeModeToggle extends ConsumerWidget {
  const _SwipeModeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(preferencesProvider).lotSwipeMode;

    IconData getIconForMode(LotSwipeMode mode) {
      switch (mode) {
        case LotSwipeMode.swipe:
          return Icons.swipe_rounded;
        case LotSwipeMode.grip:
          return Icons.drag_indicator_rounded;
        case LotSwipeMode.disabled:
          return Icons.do_not_touch_rounded;
      }
    }

    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
      ),
      child: PopupMenuButton<LotSwipeMode>(
        initialValue: mode,
        onSelected: (newMode) {
          ref.read(settingsProvider.notifier).triggerHaptic();
          ref.read(preferencesProvider.notifier).setLotSwipeMode(newMode);
        },
        offset: const Offset(0, 40),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: LotSwipeMode.swipe,
            child: Row(
              children: [
                Icon(
                  Icons.swipe_rounded,
                  color: mode == LotSwipeMode.swipe
                      ? const Color(0xFFC8A96E)
                      : Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  context.t('swipe_mode_normal'),
                  style: GoogleFonts.outfit(
                    color: mode == LotSwipeMode.swipe
                        ? const Color(0xFFC8A96E)
                        : Colors.white70,
                    fontWeight: mode == LotSwipeMode.swipe
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: LotSwipeMode.grip,
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator_rounded,
                  color: mode == LotSwipeMode.grip
                      ? const Color(0xFFC8A96E)
                      : Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  context.t('swipe_mode_grip'),
                  style: GoogleFonts.outfit(
                    color: mode == LotSwipeMode.grip
                        ? const Color(0xFFC8A96E)
                        : Colors.white70,
                    fontWeight: mode == LotSwipeMode.grip
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: LotSwipeMode.disabled,
            child: Row(
              children: [
                Icon(
                  Icons.do_not_touch_rounded,
                  color: mode == LotSwipeMode.disabled
                      ? const Color(0xFFC8A96E)
                      : Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  context.t('swipe_mode_disabled'),
                  style: GoogleFonts.outfit(
                    color: mode == LotSwipeMode.disabled
                        ? const Color(0xFFC8A96E)
                        : Colors.white70,
                    fontWeight: mode == LotSwipeMode.disabled
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Icon(
            getIconForMode(mode),
            color: const Color(0xFFC8A96E),
            size: 20,
          ),
        ),
      ),
    );
  }
}
