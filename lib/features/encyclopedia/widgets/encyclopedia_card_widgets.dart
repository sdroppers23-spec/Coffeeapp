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
    final isSelected = selectedIds.contains(entry.id);
    final isSelectionMode = selectedIds.isNotEmpty;

    return PressableScale(
      onTap: isSelectionMode ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id) : onTap,
      onLongPress: () {
        ref.read(settingsProvider.notifier).triggerVibrate();
        ref.read(selectedLotIdsProvider.notifier).toggle(entry.id);
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        opacity: isSelected ? 0.35 : 0.15,
        borderRadius: 24,
        color: isSelected ? const Color(0xFFC8A96E) : Colors.white10,
        borderColor: isSelected
            ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar (Flag) + Score and Favorite/Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Circular Avatar with Flag/Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                        border: Border.all(
                          color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: entry.effectiveFlagUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: entry.effectiveFlagUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                                errorWidget: (context, url, error) => const Icon(Icons.public, size: 20, color: Color(0xFFC8A96E)),
                              )
                            : const Icon(Icons.coffee_rounded, size: 20, color: Color(0xFFC8A96E)),
                      ),
                    ),
                    // Floating SCA Score Badge
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1714),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          entry.scaScore,
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
                  GestureDetector(
                    onTap: () async {
                      ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                      final db = ref.read(databaseProvider);
                      await db.toggleFavorite(entry.id, !entry.isFavorite);
                      ref.invalidate(encyclopediaDataProvider);
                    },
                    child: Icon(
                      entry.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      size: 20,
                      color: entry.isFavorite ? Colors.redAccent : Colors.white24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Coffee Name (Country in this case)
            Text(
              entry.country,
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
            
            // Varieties/Region
            Text(
              (entry.varieties.isNotEmpty ? entry.varieties : entry.region).toUpperCase(),
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
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${entry.processMethod} • ${entry.roastLevel}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 8, 
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
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
    final theme = Theme.of(context);

    final selectedIds = ref.watch(selectedLotIdsProvider);
    final isSelected = selectedIds.contains(entry.id);
    final isSelectionMode = selectedIds.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PressableScale(
        onTap: isSelectionMode
            ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id)
            : onTap,
        onLongPress: () {
          ref.read(settingsProvider.notifier).triggerVibrate();
          ref.read(selectedLotIdsProvider.notifier).toggle(entry.id);
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          opacity: isSelected ? 0.3 : 0.08,
          borderRadius: 24,
          color: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.1)
              : Colors.white10,
          borderColor: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.1),
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
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.15),
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
                          horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1714),
                        borderRadius: BorderRadius.circular(6),
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
                          color: theme.colorScheme.primary,
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
                      entry.country,
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
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
                        fontSize: 10,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
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
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? theme.colorScheme.primary : Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.white24,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: isSelected ? Colors.black : Colors.transparent,
                  ),
                )
              else
                IconButton(
                  onPressed: () async {
                    ref
                        .read(settingsProvider.notifier)
                        .triggerSelectionVibrate();
                    final db = ref.read(databaseProvider);
                    await db.toggleFavorite(entry.id, !entry.isFavorite);
                    ref.invalidate(encyclopediaDataProvider);
                  },
                  icon: Icon(
                    entry.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: entry.isFavorite ? Colors.redAccent : Colors.white24,
                    size: 24,
                  ),
                ),
            ],
          ),
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
                      color: isFilled
                          ? theme.colorScheme.primary
                          : const Color(0xFFC8A96E).withValues(alpha: 0.1),
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
}
