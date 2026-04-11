import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/dtos.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../shared/widgets/sensory_radar_chart.dart';
import '../../encyclopedia/comparison_screen.dart';
import '../../encyclopedia/custom_lot_detail_screen.dart';
import '../../../core/providers/settings_provider.dart';

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
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                Text(
                  (lot.roasteryName ?? 'Personal').toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    color: Colors.white24,
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
                  style: GoogleFonts.outfit(fontSize: 9, color: Colors.white38),
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
                color: Colors.white38,
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
                      color: isFilled ? theme.colorScheme.primary : Colors.white.withValues(alpha: 0.1),
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

  const MyLotListCard({
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PressableScale(
        onLongPress: () => onLongPress(lot.id),
        onTap: () => onTap(lot.id),
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          opacity: isSelected ? 0.2 : 0.1,
          borderRadius: 20,
          borderColor: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.08),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lot.coffeeName ?? 'Unnamed',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${lot.roasteryName} • ${lot.originCountry}',
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              PressableScale(
                onTap: () => onFavoriteToggle(lot),
                child: Icon(
                  lot.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 20,
                  color: lot.isFavorite ? Colors.redAccent : Colors.white24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
