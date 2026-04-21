import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/dtos.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../encyclopedia_providers.dart';
import '../../../core/providers/settings_provider.dart';

// ─── Grid Card ────────────────────────────────────────────────────────────────
class EncyclopediaLotGridCard extends ConsumerWidget {
  final LocalizedBeanDto entry;
  final VoidCallback onTap;

  const EncyclopediaLotGridCard({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    final selectedIds = ref.watch(selectedLotIdsProvider);
    final isSelected = selectedIds.contains(entry.id.toString());
    final isSelectionMode = selectedIds.isNotEmpty;

    return PressableScale(
      onTap: isSelectionMode
          ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id.toString())
          : onTap,
      onLongPress: () {
        ref.read(settingsProvider.notifier).triggerVibrate();
        ref.read(selectedLotIdsProvider.notifier).toggle(entry.id.toString());
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        opacity: isSelected ? 0.35 : 0.12,
        borderRadius: 24,
        color: isSelected ? const Color(0xFFC8A96E) : Colors.white.withValues(alpha: 0.1),
        borderColor: isSelected
            ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar + Score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
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
                        child: entry.effectiveFlagUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: entry.effectiveFlagUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.public,
                                  size: 20,
                                  color: Color(0xFFC8A96E),
                                ),
                              )
                            : const Icon(
                                Icons.coffee_rounded,
                                size: 20,
                                color: Color(0xFFC8A96E),
                              ),
                      ),
                    ),
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
                          entry.scaScore,
                          style: GoogleFonts.outfit(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Favorite / Selection Icon
                if (isSelectionMode)
                  Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.3),
                    size: 24,
                  )
                else
                  _FavoriteIcon(bean: entry),
              ],
            ),
            const SizedBox(height: 12),
            // Coffee Name (Country)
            Text(
              entry.translatedCountry.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                color: const Color(0xFFC8A96E),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            // Varieties/Region
            Text(
              (entry.varieties.isNotEmpty ? entry.varieties : entry.region).toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 9,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Sensory Info
            Expanded(
              child: Column(
                children: [
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Кислотність' : 'Acidity',
                    value: (entry.sensoryPoints['acidity'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Солодкість' : 'Sweetness',
                    value: (entry.sensoryPoints['sweetness'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Тіло' : 'Body',
                    value: (entry.sensoryPoints['body'] ?? 3).toDouble(),
                    theme: theme,
                  ),
                ],
              ),
            ),
            // Bottom Traits
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    size: 11,
                    color: Colors.white38,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      entry.processMethod,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── List Card ────────────────────────────────────────────────────────────────
class EncyclopediaLotListCard extends ConsumerWidget {
  final LocalizedBeanDto entry;
  final VoidCallback onTap;

  const EncyclopediaLotListCard({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedIds = ref.watch(selectedLotIdsProvider);
    final isSelected = selectedIds.contains(entry.id.toString());
    final isSelectionMode = selectedIds.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PressableScale(
        onTap: isSelectionMode
            ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id.toString())
            : onTap,
        onLongPress: () {
          ref.read(settingsProvider.notifier).triggerVibrate();
          ref.read(selectedLotIdsProvider.notifier).toggle(entry.id.toString());
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          opacity: isSelected ? 0.35 : 0.12,
          borderRadius: 24,
          color: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderColor: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.12),
          child: Row(
            children: [
              // Avatar with Flag & Score
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                      border: Border.all(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: entry.effectiveFlagUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: entry.effectiveFlagUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.public,
                                  color: Color(0xFFC8A96E),
                                  size: 24),
                            )
                          : const Icon(Icons.coffee_rounded,
                              color: Color(0xFFC8A96E), size: 24),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1714),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        entry.scaScore,
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFC8A96E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.translatedCountry.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFC8A96E),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${entry.region} • ${entry.varieties}'.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white54,
                        fontSize: 10,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _TraitBadge(text: entry.processMethod),
                        const SizedBox(width: 6),
                        _TraitBadge(text: entry.roastLevel),
                      ],
                    ),
                  ],
                ),
              ),

              // Selection / Favorite
              if (isSelectionMode)
                Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
                  size: 28,
                )
              else
                _FavoriteIcon(bean: entry),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteIcon extends ConsumerWidget {
  final LocalizedBeanDto bean;
  const _FavoriteIcon({required this.bean});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        ref.read(databaseProvider).toggleFavorite(bean.id, !bean.isFavorite);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          bean.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: bean.isFavorite ? Colors.redAccent : Colors.white24,
          size: 24,
        ),
      ),
    );
  }
}

class _TraitBadge extends StatelessWidget {
  final String text;
  const _TraitBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.1)),
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 8,
          color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

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
            width: 60,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 9,
                color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                final isFilled = index < value.toInt();
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.only(right: 2.5),
                    decoration: BoxDecoration(
                      color: isFilled
                          ? const Color(0xFFC8A96E)
                          : Colors.white10,
                      borderRadius: BorderRadius.circular(2),
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
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E),
            ),
          ),
        ],
      ),
    );
  }
}
