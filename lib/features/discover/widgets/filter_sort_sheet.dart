import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../discovery_filter_provider.dart';
import '../../../core/config/flag_constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../navigation/navigation_providers.dart';

class FilterSortSheet extends ConsumerStatefulWidget {
  final NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>
  filterProvider;
  final List<String> availableCountries;
  final List<String> availableFlavors;
  final List<String> availableProcesses;

  const FilterSortSheet({
    super.key,
    required this.filterProvider,
    required this.availableCountries,
    required this.availableFlavors,
    required this.availableProcesses,
  });

  @override
  ConsumerState<FilterSortSheet> createState() => _FilterSortSheetState();
}

class _FilterSortSheetState extends ConsumerState<FilterSortSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    // Force show nav bar when sheet is closed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.filterProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1614),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(ref.t('sort_by')),
            const SizedBox(height: 12),
            _buildSortGrid(ref),
            const SizedBox(height: 24),
            _buildSectionTitle(ref.t('countries')),
            const SizedBox(height: 12),
            _buildFilterChips(
              ref,
              widget.availableCountries,
              state.selectedCountries,
              (val) =>
                  ref.read(widget.filterProvider.notifier).toggleCountry(val),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(ref.t('flavor_profile')),
            const SizedBox(height: 12),
            _buildFilterChips(
              ref,
              widget.availableFlavors,
              state.selectedFlavorNotes,
              (val) => ref
                  .read(widget.filterProvider.notifier)
                  .toggleFlavorNote(val),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(ref.t('processing')),
            const SizedBox(height: 12),
            _buildFilterChips(
              ref,
              widget.availableProcesses,
              state.selectedProcesses,
              (val) =>
                  ref.read(widget.filterProvider.notifier).toggleProcess(val),
            ),
            const SizedBox(height: 32),
            SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8A96E),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        ref.t('apply_changes'),
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      ref.read(widget.filterProvider.notifier).clearFilters();
                      Navigator.pop(context);
                    },
                    child: Text(
                      ref.t('reset_all'),
                      style: GoogleFonts.outfit(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSortGrid(WidgetRef ref) {
    final state = ref.watch(widget.filterProvider);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _SortChip(
          label: ref.t('sort_az'),
          type: SortType.alphabetAsc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
        _SortChip(
          label: ref.t('sort_za'),
          type: SortType.alphabetDesc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
        _SortChip(
          label: ref.t('price_asc'),
          type: SortType.priceAsc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
        _SortChip(
          label: ref.t('price_desc'),
          type: SortType.priceDesc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
        _SortChip(
          label: ref.t('newest_first'),
          type: SortType.dateDesc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
        _SortChip(
          label: ref.t('oldest_first'),
          type: SortType.dateAsc,
          current: state.sortType,
          provider: widget.filterProvider,
        ),
      ],
    );
  }

  Widget _buildFilterChips(
    WidgetRef ref,
    List<String> options,
    Set<String> selected,
    Function(String) onToggle,
  ) {
    if (options.isEmpty) {
      return Text(
        ref.t('no_options'),
        style: const TextStyle(color: Colors.white24, fontSize: 12),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final isSelected = selected.contains(opt);
        final flagUrl = FlagConstants.getFlag(opt);

        return FilterChip(
          avatar: flagUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    imageUrl: flagUrl,
                    width: 20,
                    height: 14,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          label: Text(opt),
          selected: isSelected,
          onSelected: (_) => onToggle(opt),
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          selectedColor: const Color(0xFFC8A96E),
          labelStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.white10,
            ),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}

class _SortChip extends ConsumerWidget {
  final String label;
  final SortType type;
  final SortType current;
  final NotifierProvider<DiscoveryFilterNotifier, DiscoveryFilterState>
  provider;

  const _SortChip({
    required this.label,
    required this.type,
    required this.current,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = type == current;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => ref.read(provider.notifier).updateSort(type),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFC8A96E)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.white10,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: isSelected ? Colors.black : Colors.white70,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
