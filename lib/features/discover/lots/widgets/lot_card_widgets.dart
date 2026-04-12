import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/dtos.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/pressable_scale.dart';

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
      onTap: () => onTap(lot.id),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        opacity: isSelected ? 0.2 : 0.1,
        borderRadius: 24,
        borderColor: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.08),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Score Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lot.scaScore ?? '85',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'SCA',
                        style: GoogleFonts.outfit(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  lot.coffeeName ?? 'Unnamed',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC8A96E),
                    height: 1.1,
                  ),
                ),
                Text(
                  (lot.roasteryName ?? 'Personal').toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.24),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                // Sensory Bars
                _SensoryFiveSegmentBarSmall(
                  label: isUk ? 'Гіркота' : 'Bitterness',
                  value: (lot.sensoryPoints['bitterness'] ?? 3).toDouble(),
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
                const Spacer(),
                // Bottom Info
                Text(
                  '${lot.originCountry} • ${lot.process}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(fontSize: 9, color: const Color(0xFFC8A96E).withValues(alpha: 0.38)),
                ),
              ],
            ),
            // Heart or Selection Mark
            Positioned(
              top: 0,
              right: 0,
              child: isSelectionMode
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colorScheme.primary : Colors.transparent,
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
                  : PressableScale(
                      onTap: () => onFavoriteToggle(lot),
                      child: Icon(
                        lot.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 14,
                        color: lot.isFavorite ? Colors.redAccent : Colors.white24,
                      ),
                    ),
            ),
          ],
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
class MyLotListCard extends ConsumerWidget {
  final CoffeeLotDto lot;
  final bool isSelected;
  final bool isSelectionMode;
  final Function(String) onLongPress;
  final Function(String) onTap;
  final Function(CoffeeLotDto) onFavoriteToggle;
  final Function(CoffeeLotDto)? onEditSwipe;
  final Future<bool> Function(CoffeeLotDto)? onDeleteSwipe;

  const MyLotListCard({
    super.key,
    required this.lot,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
    required this.onFavoriteToggle,
    this.onEditSwipe,
    this.onDeleteSwipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    final card = PressableScale(
      onLongPress: () => onLongPress(lot.id),
      onTap: () => isSelectionMode ? onLongPress(lot.id) : onTap(lot.id),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        opacity: isSelected ? 0.2 : 0.05, 
        borderRadius: 20,
        borderColor: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Title, Subtitle, Heart
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
                  isSelectionMode
                      ? const SizedBox.shrink()
                      : PressableScale(
                          onTap: () => onFavoriteToggle(lot),
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
                  // Score Circle
                  Container(
                    width: 48,
                    height: 48,
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
                  const SizedBox(width: 16),
                  // Traits and Tags
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Traits Row
                        Row(
                          children: [
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'ГІРКОТА' : 'BITTERNESS', value: (lot.sensoryPoints['bitterness'] ?? 3).toDouble(), theme: theme)),
                            const SizedBox(width: 8),
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'КИСЛОТНІСТЬ' : 'ACIDITY', value: (lot.sensoryPoints['acidity'] ?? 3).toDouble(), theme: theme)),
                            const SizedBox(width: 8),
                            Expanded(child: _HorizontalSensoryBar(label: isUk ? 'СОЛОДКІСТЬ' : 'SWEETNESS', value: (lot.sensoryPoints['sweetness'] ?? 3).toDouble(), theme: theme)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Tags Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _TagChip(icon: Icons.star_border_rounded, text: '${lot.scaScore ?? 85} SCA', theme: theme),
                              const SizedBox(width: 8),
                              _TagChip(icon: Icons.location_on_outlined, text: null, theme: theme),
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
              const SizedBox(height: 16),
              // Freshness Bar
              _FreshnessProgressBar(lot: lot, isUk: isUk, theme: theme),
            ],
          ),
        ),
      );

      final dismissibleCard = isSelectionMode ? card : Dismissible(
        key: Key(lot.id),
        direction: DismissDirection.horizontal,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Delete
            if (onDeleteSwipe != null) {
              return await onDeleteSwipe!(lot);
            }
          } else if (direction == DismissDirection.startToEnd) {
            // Edit
            if (onEditSwipe != null) {
              onEditSwipe!(lot);
            }
            return false; // Don't actually dismiss the item off screen for info edits
          }
          return false;
        },
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF62D39F).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.edit_rounded, color: Colors.black, size: 32),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 32),
        ),
        child: card,
      );

      if (isSelectionMode) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onLongPress(lot.id),
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

  const _TagChip({required this.icon, this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
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

    final Color statusColor = isExpired ? Colors.redAccent : Colors.tealAccent;
    final String labelText;
    if (isExpired) {
      labelText = isUk ? 'ТЕРМІН ВИЙШОВ' : 'EXPIRED';
    } else {
      final int daysLeft = limit - ageDays;
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
        const SizedBox(height: 6),
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
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2DD4BF), // Fresh Teal
                const Color(0xFFFACC15), // Vibrant Gold
                const Color(0xFFEF4444), // Critical Red
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              if (!isExpired)
                BoxShadow(
                  color: (factor > 0.5 ? const Color(0xFFFACC15) : const Color(0xFF2DD4BF)).withValues(alpha: 0.3),
                  blurRadius: 6,
                  spreadRadius: 0.5
                )
            ],
          ),
        ),
      ),
    );
  }
}
