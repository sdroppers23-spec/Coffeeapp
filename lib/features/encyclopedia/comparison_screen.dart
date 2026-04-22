import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../navigation/navigation_providers.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../shared/widgets/premium_background.dart';
import 'encyclopedia_providers.dart';

class ComparisonScreen extends ConsumerStatefulWidget {
  final ComparisonSource source;

  const ComparisonScreen({
    super.key,
    this.source = ComparisonSource.encyclopedia,
  });

  @override
  ConsumerState<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends ConsumerState<ComparisonScreen> {
  ComparableCoffee? _coffeeA;
  ComparableCoffee? _coffeeB;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    ref.read(navBarVisibleProvider.notifier).show();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncComparable = ref.watch(allComparableCoffeesProvider(widget.source));

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PremiumAppBar(
          title: ref.t('compare_coffees'),
        ),
        body: PremiumBackground(
          child: asyncComparable.when(
            loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
            error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
            data: (coffees) {
              if (coffees.isEmpty) {
                return Center(
                  child: Text(
                    'No coffees available to compare.',
                    style: GoogleFonts.outfit(color: Colors.white70),
                  ),
                );
              }

              // Use selected IDs if they exist
              final selectedIdsProvider = widget.source == ComparisonSource.encyclopedia
                  ? encyclopediaSelectedIdsProvider
                  : myLotsSelectedIdsProvider;
              final selectedIds = ref.watch(selectedIdsProvider);
              
              if (_coffeeA == null && _coffeeB == null) {
                if (selectedIds.isNotEmpty) {
                  final list = selectedIds.toList();
                  _coffeeA = coffees.firstWhere((e) => e.id == list[0], orElse: () => coffees.first);
                  if (list.length > 1) {
                    _coffeeB = coffees.firstWhere((e) => e.id == list[1], orElse: () => coffees.length > 1 ? coffees[1] : coffees.first);
                  } else {
                    _coffeeB = coffees.firstWhere((e) => e.id != _coffeeA?.id, orElse: () => coffees.first);
                  }
                } else {
                  // Default selections if none selected
                  _coffeeA = coffees.isNotEmpty ? coffees.first : null;
                  _coffeeB = coffees.length > 1 ? coffees[1] : (coffees.isNotEmpty ? coffees.first : null);
                }
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 120, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- Selectors ---
                    Row(
                      children: [
                        Expanded(
                          child: _CoffeeSelector(
                            value: _coffeeA,
                            items: coffees,
                            onChanged: (val) {
                              setState(() {
                                _coffeeA = val;
                                // Prevent self-comparison
                                if (_coffeeA?.id == _coffeeB?.id) {
                                  _coffeeB = coffees.firstWhere(
                                    (e) => e.id != _coffeeA?.id,
                                    orElse: () => coffees.first,
                                  );
                                }
                              });
                            },
                            color: Colors.white.withOpacity(0.1),
                            borderColor: const Color(0xFFC8A96E).withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _CoffeeSelector(
                            value: _coffeeB,
                            items: coffees,
                            onChanged: (val) {
                              setState(() {
                                _coffeeB = val;
                                // Prevent self-comparison
                                if (_coffeeB?.id == _coffeeA?.id) {
                                  _coffeeA = coffees.firstWhere(
                                    (e) => e.id != _coffeeB?.id,
                                    orElse: () => coffees.first,
                                  );
                                }
                              });
                            },
                            color: Colors.white.withOpacity(0.1),
                            borderColor: const Color(0xFFC8A96E).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- Comparison Table ---
                    if (_coffeeA != null && _coffeeB != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              _CompareRow(
                                ref.t('score_sca'),
                                _coffeeA!.score,
                                _coffeeB!.score,
                                highlightWinner: true,
                              ),
                              _CompareRow(
                                ref.t('origin'),
                                '${_coffeeA!.countryEmoji ?? ""} ${_coffeeA!.country}',
                                '${_coffeeB!.countryEmoji ?? ""} ${_coffeeB!.country}',
                              ),
                              _CompareRow(
                                ref.t('region'),
                                _coffeeA!.region,
                                _coffeeB!.region,
                              ),
                              _CompareRow(
                                ref.t('altitude'),
                                _coffeeA!.altitude,
                                _coffeeB!.altitude,
                              ),
                              _CompareRow(
                                ref.t('varieties'),
                                _coffeeA!.varieties,
                                _coffeeB!.varieties,
                                isTextHeavy: true,
                              ),
                              _CompareRow(
                                ref.t('process'),
                                _coffeeA!.process,
                                _coffeeB!.process,
                              ),
                              _CompareRow(
                                ref.t('harvest'),
                                _coffeeA!.harvest,
                                _coffeeB!.harvest,
                              ),
                              _CompareRow(
                                ref.t('flavor_notes'),
                                _coffeeA!.flavorNotes,
                                _coffeeB!.flavorNotes,
                                isTextHeavy: true,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}

class _CoffeeSelector extends StatelessWidget {
  final ComparableCoffee? value;
  final List<ComparableCoffee> items;
  final ValueChanged<ComparableCoffee?> onChanged;
  final Color color;
  final Color borderColor;

  const _CoffeeSelector({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ComparableCoffee>(
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E1E),
          icon: Icon(Icons.keyboard_arrow_down, color: borderColor),
          value: value,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                '${e.countryEmoji ?? ""} ${e.name}',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  final String title;
  final String valA;
  final String valB;
  final bool isTextHeavy;
  final bool highlightWinner;
  final bool isLast;

  const _CompareRow(
    this.title,
    this.valA,
    this.valB, {
    this.isTextHeavy = false,
    this.highlightWinner = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color colorA = Colors.white;
    Color colorB = Colors.white;

    if (highlightWinner) {
      final aNum = double.tryParse(valA) ?? 0;
      final bNum = double.tryParse(valB) ?? 0;
      if (aNum > bNum) {
        colorA = const Color(0xFFC8A96E);
      } else if (bNum > aNum) {
        colorB = const Color(0xFFC8A96E);
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
      ),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.outfit(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  valA,
                  style: GoogleFonts.outfit(
                    color: colorA,
                    fontSize: isTextHeavy ? 13 : 15,
                    fontWeight: isTextHeavy ? FontWeight.normal : FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.white12,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: Text(
                  valB,
                  style: GoogleFonts.outfit(
                    color: colorB,
                    fontSize: isTextHeavy ? 13 : 15,
                    fontWeight: isTextHeavy ? FontWeight.normal : FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
