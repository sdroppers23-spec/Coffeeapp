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

    return PressableScale(
      onTap: selectedIds.isNotEmpty ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id) : onTap,
      onLongPress: () {
        ref.read(settingsProvider.notifier).triggerVibrate();
        ref.read(selectedLotIdsProvider.notifier).toggle(entry.id);
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        opacity: 0.1,
        borderRadius: 24,
        borderColor: Colors.white.withValues(alpha: 0.08),
        child: Stack(
          children: [
            // Main content column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flag Badge row
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: entry.effectiveFlagUrl,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.public, size: 28, color: Colors.white24),
                        ),
                      ),
                    ),
                    // Space so heart button doesn't overlap content
                    const Spacer(),
                    const SizedBox(width: 32),
                  ],
                ),
                const SizedBox(height: 16),
                // Title (Varieties / Country)
                Text(
                  entry.varieties.isNotEmpty ? entry.varieties : entry.country,
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
                  entry.region.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.24),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                // Sensory Bars
                if (entry.sensoryPoints.isNotEmpty) ...[
                  _SensoryFiveSegmentBarSmall(
                    label: isUk ? 'Гіркота' : 'Bitterness',
                    value: (entry.sensoryPoints['bitterness'] ?? 3).toDouble(),
                    theme: theme,
                  ),
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
                ],
                const Spacer(),
                // Bottom Info
                Text(
                  '${entry.country} ${entry.countryEmoji ?? ''} • ${entry.processMethod}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
                  ),
                ),
              ],
            ),

            // Favorite heart button (top-right overlay)
            Positioned(
              top: -4,
              right: -4,
              child: GestureDetector(
                onTap: () async {
                  ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                  final db = ref.read(databaseProvider);
                  await db.toggleFavorite(entry.id, !entry.isFavorite);
                  ref.invalidate(encyclopediaDataProvider);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      entry.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: entry.isFavorite
                          ? Colors.redAccent
                          : Colors.white38,
                      size: isSelected ? 24 : 20, // Slightly larger when selected to indicate focus
                    ),
                  ),
                ),
              ),
            ),

            // Selection indicator (top-left)
            if (isSelected)
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFC8A96E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 12,
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
    final isUk = LocaleService.currentLocale == 'uk';

    final selectedIds = ref.watch(selectedLotIdsProvider);
    final isSelected = selectedIds.contains(entry.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PressableScale(
        onTap: selectedIds.isNotEmpty ? () => ref.read(selectedLotIdsProvider.notifier).toggle(entry.id) : onTap,
        onLongPress: () {
          ref.read(settingsProvider.notifier).triggerVibrate();
          ref.read(selectedLotIdsProvider.notifier).toggle(entry.id);
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          opacity: 0.05,
          borderRadius: 20,
          borderColor: Colors.white.withValues(alpha: 0.08),
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
                          entry.varieties.isNotEmpty
                              ? entry.varieties
                              : entry.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFC8A96E),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          entry.region,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Favorite heart button
                  GestureDetector(
                    onTap: () async {
                      ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                      final db = ref.read(databaseProvider);
                      await db.toggleFavorite(entry.id, !entry.isFavorite);
                      ref.invalidate(encyclopediaDataProvider);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        entry.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: entry.isFavorite
                            ? Colors.redAccent
                            : Colors.white38,
                        size: 26, // Larger heart for better visibility
                      ),
                    ),
                  ),
                ],
              ),
              if (isSelected) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFC8A96E)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFFC8A96E)),
                          const SizedBox(width: 6),
                          Text(
                            isUk ? 'ОБРАНО ДЛЯ ПОРІВНЯННЯ' : 'SELECTED FOR COMPARISON',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC8A96E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              // Body: Flag + Traits/Tags
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flag Circle
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: entry.effectiveFlagUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.public, size: 48, color: Colors.white24),
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
                        if (entry.sensoryPoints.isNotEmpty)
                          Row(
                            children: [
                              Expanded(
                                child: _HorizontalSensoryBar(
                                  label: isUk ? 'ГІРКОТА' : 'BITTERNESS',
                                  value: (entry.sensoryPoints['bitterness'] ?? 3)
                                      .toDouble(),
                                  theme: theme,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _HorizontalSensoryBar(
                                  label: isUk ? 'КИСЛОТНІСТЬ' : 'ACIDITY',
                                  value: (entry.sensoryPoints['acidity'] ?? 3)
                                      .toDouble(),
                                  theme: theme,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _HorizontalSensoryBar(
                                  label: isUk ? 'СОЛОДКІСТЬ' : 'SWEETNESS',
                                  value: (entry.sensoryPoints['sweetness'] ?? 3)
                                      .toDouble(),
                                  theme: theme,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 12),
                        // Tags Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _TagChip(
                                icon: Icons.public_rounded,
                                text: entry.country,
                                theme: theme,
                              ),
                              const SizedBox(width: 8),
                              if (entry.processMethod.isNotEmpty)
                                _TagChip(
                                  icon: Icons.water_drop_outlined,
                                  text: entry.processMethod,
                                  theme: theme,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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

class _HorizontalSensoryBar extends StatelessWidget {
  final String label;
  final double value;
  final ThemeData theme;

  const _HorizontalSensoryBar({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: GoogleFonts.outfit(
            fontSize: 8,
            color: const Color(0xFFC8A96E).withValues(alpha: 0.38),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
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
                  color: isFilled
                      ? theme.colorScheme.primary
                      : const Color(0xFFC8A96E).withValues(alpha: 0.1),
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
        border: Border.all(
          color: const Color(0xFFC8A96E).withValues(alpha: 0.03),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: theme.colorScheme.primary),
          if (text != null) ...[
            const SizedBox(width: 4),
            Text(
              text!,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: const Color(0xFFC8A96E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
