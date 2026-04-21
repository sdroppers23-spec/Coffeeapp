import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/dtos.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/pressable_scale.dart';
import '../../../../shared/widgets/sensory_radar_chart.dart';
import '../../../../shared/utils/sensory_utils.dart';
import 'package:vibration/vibration.dart';
import '../../../../shared/widgets/glass_swipe_wrapper.dart';

class MyLotGridCard extends ConsumerWidget {
  final CoffeeLotDto lot;
  final bool isSelected;
  final bool isSelectionMode;
  final Function(String) onLongPress;
  final Function(String) onTap;
  final Function(CoffeeLotDto) onFavoriteToggle;

  const MyLotGridCard({
    super.key,
    required this.lot,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    return PressableScale(
      onLongPress: () => onLongPress(lot.id),
      onTap: () {
        if (isSelectionMode) {
          onLongPress(lot.id); // Toggle selection
        } else {
          onTap(lot.id);
        }
      },
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GlassContainer(
          padding: const EdgeInsets.all(12),
          opacity: isSelected ? 0.35 : 0.20,
          borderRadius: 24,
          color: isSelected ? const Color(0xFFC8A96E) : Colors.white10,
          borderColor: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Avatar + Score and Favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Circular Avatar
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                          border: Border.all(
                            color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: lot.imageUrl != null && lot.imageUrl!.isNotEmpty
                              ? (lot.imageUrl!.startsWith('http')
                                  ? Image.network(lot.imageUrl!, fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) => const Icon(Icons.coffee_rounded, size: 20, color: Color(0xFFC8A96E)))
                                  : Image.file(File(lot.imageUrl!), fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) => const Icon(Icons.coffee_rounded, size: 20, color: Color(0xFFC8A96E))))
                              : const Icon(Icons.coffee_rounded, size: 20, color: Color(0xFFC8A96E)),
                        ),
                      ),
                      // Floating SCA Score Badge
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1714),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            lot.scaScore ?? '85',
                            style: GoogleFonts.outfit(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Favorite / Selection
                  if (isSelectionMode)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colorScheme.primary : Colors.black45,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : Colors.white24,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 10,
                        color: isSelected ? Colors.black : Colors.transparent,
                      ),
                    )
                  else
                    PressableScale(
                      onTap: () {
                        if (!kIsWeb && !Platform.isWindows) {
                          Vibration.vibrate(duration: 40, amplitude: 100);
                        }
                        onFavoriteToggle(lot);
                      },
                      child: Icon(
                        lot.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 20,
                        color: lot.isFavorite ? Colors.redAccent : Colors.white24,
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 16),
            // Coffee Name
            Text(
              lot.coffeeName ?? 'Unnamed',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFC8A96E),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            // Roastery Name
            Text(
              (lot.roasteryName ?? 'Personal').toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 8.5,
                color: const Color(0xFFC8A96E).withValues(alpha: 0.45),
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            // Sensory Info
            Expanded(
              child: Column(
                children: [
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Смак' : 'Flavor',
                    value: (lot.sensoryPoints['flavor'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Кислотність' : 'Acidity',
                    value: (lot.sensoryPoints['acidity'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Солодкість' : 'Sweetness',
                    value: (lot.sensoryPoints['sweetness'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                ],
              ),
            ),
            
            // Bottom Traits
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${lot.originCountry} • ${lot.process}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 7.5, 
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    ),
  );
}
}

class _SensoryFiveSegmentBarSmall extends StatelessWidget {
  final String label;
  final double value;
  final ThemeData theme;

  const _SensoryFiveSegmentBarSmall({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 55,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 8.5,
                color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                final isFilled = index < value.toInt();
                return Expanded(
                  child: Container(
                    height: 3.5,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: isFilled ? theme.colorScheme.primary : const Color(0xFFC8A96E).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value.toInt().toString(),
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class MyLotListCard extends ConsumerStatefulWidget {
  final CoffeeLotDto lot;
  final bool isSelected;
  final bool isSelectionMode;
  final Function(String) onLongPress;
  final Function(String) onTap;
  final Function(CoffeeLotDto) onFavoriteToggle;
  final Function(CoffeeLotDto)? onEditSwipe;
  final Future<void> Function(CoffeeLotDto)? onRestoreSwipe;
  final Future<bool> Function(CoffeeLotDto)? onDeleteSwipe;
  final Function(bool)? onExpansionChanged;

  const MyLotListCard({
    super.key,
    required this.lot,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
    required this.onFavoriteToggle,
    this.onEditSwipe,
    this.onRestoreSwipe,
    this.onDeleteSwipe,
    this.onExpansionChanged,
  });

  @override
  ConsumerState<MyLotListCard> createState() => _MyLotListCardState();
}

class _MyLotListCardState extends ConsumerState<MyLotListCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    if (_isExpanded) {
      // Small delay to let the animation start before scrolling
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignment: 0.1, // Scroll so it's near the top
          );
        }
      });
    }
    widget.onExpansionChanged?.call(_isExpanded);
    if (!kIsWeb && !Platform.isWindows) {
      Vibration.vibrate(duration: 10, amplitude: 50);
    }
  }

  @override
  void dispose() {
    if (_isExpanded) {
      widget.onExpansionChanged?.call(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lot = widget.lot;
    final isUk = LocaleService.currentLocale == 'uk';
    final theme = Theme.of(context);
    final isSelected = widget.isSelected;
    final isSelectionMode = widget.isSelectionMode;
    
    // Normalize sensory data
    final mappedSensory = SensoryUtils.map4To6Axis(lot.sensoryPoints);
    final radarValues = mappedSensory.map((key, value) => MapEntry(key, value / 5.0));

    final card = PressableScale(
      onLongPress: () => widget.onLongPress(lot.id),
      onTap: () {
        if (isSelectionMode) {
          widget.onLongPress(lot.id);
        } else {
          widget.onTap(lot.id);
        }
      },
      child: RepaintBoundary(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            opacity: 1.0, 
            blur: 10, 
            borderRadius: 20,
            color: isSelected 
                ? const Color(0xFFC8A96E).withValues(alpha: 0.15) 
                : Colors.white.withValues(alpha: 0.1),
            borderColor: isSelected
                ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Header: Title, Subtitle, Heart + NEW: Expand Arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lot.coffeeName ?? 'Unnamed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFC8A96E),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (lot.roasteryName != null && lot.roasteryName!.isNotEmpty)
                          Text(
                            lot.roasteryName!,
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isSelectionMode)
                    PressableScale(
                      onTap: () {
                        if (!kIsWeb && !Platform.isWindows) {
                          Vibration.vibrate(duration: 40, amplitude: 100);
                        }
                        widget.onFavoriteToggle(lot);
                      },
                      child: Icon(
                        lot.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 20,
                        color: lot.isFavorite ? Colors.redAccent : Colors.white24,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              // Body: Score + Traits/Tags
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      if (lot.imageUrl != null && lot.imageUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24), // Circular-ish but consistent
                          child: lot.imageUrl!.startsWith('http')
                              ? Image.network(
                                  lot.imageUrl!,
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 54,
                                    height: 54,
                                    color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                                    child: const Icon(Icons.coffee_rounded, color: Color(0xFFC8A96E), size: 18),
                                  ),
                                )
                              : Image.file(
                                  File(lot.imageUrl!),
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 54,
                                    height: 54,
                                    color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                                    child: const Icon(Icons.coffee_rounded, color: Color(0xFFC8A96E), size: 18),
                                  ),
                                ),
                        )
                      else
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              lot.scaScore ?? '85',
                              style: GoogleFonts.outfit(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      
                      // Small floating score if image is present
                      if (lot.imageUrl != null && lot.imageUrl!.isNotEmpty)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1714),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.4), width: 1),
                            ),
                            child: Text(
                              lot.scaScore ?? '85',
                              style: GoogleFonts.outfit(
                                color: theme.colorScheme.primary,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Traits and Tags
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'СМАК' : 'FLAVOR', value: (mappedSensory['flavor'] ?? 3).toDouble(), theme: theme)),
                            const SizedBox(width: 8),
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'КИСЛОТНІСТЬ' : 'ACIDITY', value: (mappedSensory['acidity'] ?? 3).toDouble(), theme: theme)),
                            const SizedBox(width: 8),
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'СОЛОДКІСТЬ' : 'SWEETNESS', value: (mappedSensory['sweetness'] ?? 3).toDouble(), theme: theme)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Tags Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (lot.roastLevel != null && lot.roastLevel!.isNotEmpty)
                                _TagChip(
                                  icon: Icons.local_fire_department_rounded, 
                                  text: lot.roastLevel!.toUpperCase(), 
                                  theme: theme,
                                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                                ),
                              const SizedBox(width: 8),
                              _TagChip(icon: Icons.location_on_outlined, text: lot.originCountry, theme: theme),
                              const SizedBox(width: 8),
                              if (lot.process != null && lot.process!.isNotEmpty)
                                _TagChip(icon: Icons.water_drop_outlined, text: lot.process, theme: theme),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // EXPANDABLE AREA
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 16),
                    _LotPropertyGrid(lot: lot),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: SensoryRadarChart(
                        interactive: false,
                        height: 200,
                        staticValues: radarValues,
                      ),
                    ),
                  ],
                ),
              ),
  
              const SizedBox(height: 16),
              // Freshness Bar + Expand Arrow below
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _FreshnessProgressBar(lot: lot, isUk: isUk, theme: theme),
                  if (!isSelectionMode)
                    GestureDetector(
                      onTap: _toggleExpanded,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: _isExpanded ? 0.5 : 0,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 24,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

    final dismissibleCard = isSelectionMode 
      ? card 
      : GlassSwipeWrapper(
          isSwipeEnabled: !_isExpanded,
          dismissibleKey: Key('glass_swipe_${lot.id}'),
          leftAction: widget.onRestoreSwipe != null
            ? GlassSwipeAction(
                icon: Icons.unarchive_outlined,
                label: isUk ? 'Відновити' : 'Restore',
                color: const Color(0xFF3A7BBF),
                onTap: () => widget.onRestoreSwipe!(lot),
              )
            : widget.onEditSwipe != null
              ? GlassSwipeAction(
                  icon: Icons.edit_outlined,
                  label: isUk ? 'Редагувати' : 'Edit',
                  color: const Color(0xFF39FF14),
                  onTap: () => widget.onEditSwipe!(lot),
                )
              : null,
          rightAction: widget.onDeleteSwipe != null
            ? GlassSwipeAction(
                icon: Icons.delete_outline_rounded,
                label: isUk ? 'Видалити' : 'Delete',
                color: Colors.redAccent,
                onTap: () => widget.onDeleteSwipe!(lot),
              )
            : null,
          child: card,
        );

    if (isSelectionMode) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => widget.onLongPress(lot.id),
              child: Container(
                margin: const EdgeInsets.only(left: 4, right: 12),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFC8A96E) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFFC8A96E) : const Color(0xFFC8A96E).withValues(alpha: 0.38),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
              ),
            ),
            Expanded(child: dismissibleCard),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: dismissibleCard,
    );
  }
}

class _HorizontalSensoryBar extends StatelessWidget {
  final String label;
  final double value;
  final ThemeData theme;

  const _HorizontalSensoryBar({required this.label, required this.value, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: GoogleFonts.outfit(fontSize: 8, color: const Color(0xFFC8A96E).withValues(alpha: 0.38), fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Row(
          children: List.generate(5, (index) {
            final isFilled = index < value.toInt();
            return Expanded(
              child: Container(
                height: 2.5,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: isFilled ? theme.colorScheme.primary : const Color(0xFFC8A96E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final IconData icon;
  final String? text;
  final ThemeData theme;
  final Color? color;

  const _TagChip({required this.icon, this.text, required this.theme, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFC8A96E).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: theme.colorScheme.primary),
          if (text != null) ...[
            const SizedBox(width: 4),
            Text(
              text!,
              style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFFC8A96E), fontWeight: FontWeight.w500),
            ),
          ]
        ],
      ),
    );
  }
}

class _FreshnessProgressBar extends StatelessWidget {
  final CoffeeLotDto lot;
  final bool isUk;
  final ThemeData theme;

  const _FreshnessProgressBar({required this.lot, required this.isUk, required this.theme});

  @override
  Widget build(BuildContext context) {
    // 1. Determine Limit
    final int limit;
    if (lot.isGround) {
      limit = 5;
    } else if (lot.isOpen) {
      limit = 7;
    } else {
      limit = 90;
    }

    // 2. Determine Reference Date & Age
    final DateTime refDate = (lot.isOpen || lot.isGround) 
        ? (lot.openedAt ?? lot.roastDate ?? DateTime.now()) 
        : (lot.roastDate ?? DateTime.now());
    
    int ageDays = DateTime.now().difference(refDate).inDays;
    if (ageDays < 0) ageDays = 0; // Safeguard against future dates

    // 3. Calculate factor
    double factor = 1.0 - (ageDays / limit.toDouble());
    bool isExpired = ageDays >= limit;
    
    if (factor < 0.0) factor = 0.0;
    if (factor > 1.0) factor = 1.0;

    // 4. Determine Smooth Dynamic Color (Color.lerp)
    Color getSmoothColor(double f) {
      if (f > 0.5) {
        // Interpolate between Yellow (0.5) and Teal (1.0)
        return Color.lerp(const Color(0xFFFACC15), const Color(0xFF2DD4BF), (f - 0.5) / 0.5)!;
      } else if (f > 0.25) {
        // Interpolate between Orange (0.25) and Yellow (0.5)
        return Color.lerp(const Color(0xFFFB923C), const Color(0xFFFACC15), (f - 0.25) / 0.25)!;
      } else {
        // Interpolate between Red (0.0) and Orange (0.25)
        return Color.lerp(const Color(0xFFEF4444), const Color(0xFFFB923C), f / 0.25)!;
      }
    }

    final Color statusColor = getSmoothColor(factor);
    final String labelText;
    if (isExpired) {
      labelText = isUk ? 'ТЕРМІН ВИЙШОВ' : 'EXPIRED';
    } else {
      final int daysLeft = (limit - ageDays).clamp(0, limit);
      labelText = '$daysLeft ${isUk ? 'дн. лишилось' : 'd. left'}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(isUk ? 'Свіжість' : 'Freshness', 
              style: GoogleFonts.outfit(
                fontSize: 10, 
                color: const Color(0xFFC8A96E).withValues(alpha: 0.38)
              )
            ),
            Text(labelText, 
              style: GoogleFonts.outfit(
                fontSize: 10, 
                color: statusColor, 
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
        Container(
          height: 3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: factor,
            child: Container(
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  if (!isExpired)
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.3),
                      blurRadius: 6,
                      spreadRadius: 0.5
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class _LotPropertyGrid extends StatelessWidget {
  final CoffeeLotDto lot;

  const _LotPropertyGrid({required this.lot});

  @override
  Widget build(BuildContext context) {
    final isUk = LocaleService.currentLocale == 'uk';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(isUk ? 'ПОХОДЖЕННЯ ТА ФЕРМА' : 'ORIGIN & FARM'),
        const SizedBox(height: 12),
        _buildGrid([
          _InfoItem(label: isUk ? 'Країна' : 'Country', value: lot.originCountry),
          _InfoItem(label: isUk ? 'Регіон' : 'Region', value: lot.region),
          _InfoItem(label: isUk ? 'Ферма' : 'Farm', value: lot.farm),
          _InfoItem(label: isUk ? 'Станція' : 'Station', value: lot.washStation),
          _InfoItem(label: isUk ? 'Фермер' : 'Farmer', value: lot.farmer),
          _InfoItem(label: isUk ? 'Висота' : 'Altitude', value: lot.altitude != null ? '${lot.altitude}m' : null),
        ]),
        const SizedBox(height: 20),
        _buildSectionHeader(isUk ? 'КАВА ТА ОБРОБКА' : 'COFFEE & PROCESS'),
        const SizedBox(height: 12),
        _buildGrid([
          _InfoItem(label: isUk ? 'Різновид' : 'Varieties', value: lot.varieties),
          _InfoItem(label: isUk ? 'Оброба' : 'Process', value: lot.process),
          _InfoItem(label: isUk ? 'Декаф' : 'Decaf', value: lot.isDecaf ? (isUk ? 'Так' : 'Yes') : (isUk ? 'Ні' : 'No')),
          _InfoItem(label: isUk ? 'Мелена' : 'Ground', value: lot.isGround ? (isUk ? 'Так' : 'Yes') : (isUk ? 'Ні' : 'No')),
        ]),
        const SizedBox(height: 20),
        _buildSectionHeader(isUk ? 'ОБСМАЖЕННЯ ТА КУПІВЛЯ' : 'ROAST & PURCHASE'),
        const SizedBox(height: 12),
        _buildGrid([
          _InfoItem(label: isUk ? 'Рівень' : 'Roast Level', value: lot.roastLevel),
          _InfoItem(label: isUk ? 'Дата обсмажки' : 'Roast Date', value: lot.roastDate?.toString().split(' ')[0]),
          _InfoItem(label: isUk ? 'Відкрито' : 'Opened At', value: lot.openedAt?.toString().split(' ')[0]),
          _InfoItem(label: isUk ? 'Ціна' : 'Price', value: (() {
            final p1 = lot.pricing['retail'];
            final p2 = lot.pricing['retail_1k'];
            final val = (p1 != null && p1.toString().isNotEmpty) ? p1.toString() 
                      : (p2 != null && p2.toString().isNotEmpty) ? p2.toString() : null;
            if (val == null) return null;
            return (val.contains('₴') || val.contains('\$') || val.contains('€') || val.toLowerCase().contains('uah')) ? val : '$val ₴';
          })()),
          _InfoItem(label: isUk ? 'Вага' : 'Weight', value: lot.weight != null ? '${lot.weight}g' : null),
          _InfoItem(label: isUk ? 'ID Лоту' : 'Lot ID', value: lot.lotNumber),
        ]),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildGrid(List<Widget> items) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: items.map((item) => SizedBox(width: 85, child: item)).toList(),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoItem({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 8,
            color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          (value == null || value!.isEmpty) ? 'N/A' : value!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 11,
            color: const Color(0xFFC8A96E),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
