import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';

class SensoryPreview extends ConsumerWidget {
  final Map<String, num> points;
  final bool isCentered;
  final bool isGrid;

  const SensoryPreview({
    super.key,
    required this.points,
    this.isCentered = true,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (points.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);

    // Shorten the bars by adding horizontal padding
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (!isGrid) const SizedBox(height: 12),
          ...points.entries.map(
            (e) => _SensoryBar(
              label: ref.t(e.key.toLowerCase()),
              value: e.value,
              theme: theme,
              isCompact: isGrid,
            ),
          ),
        ],
      ),
    );
  }
}

class _SensoryBar extends StatelessWidget {
  final String label;
  final num value;
  final ThemeData theme;
  final bool isCompact;

  const _SensoryBar({
    required this.label,
    required this.value,
    required this.theme,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final int intValue = value.toInt().clamp(0, 5);

    return Padding(
      padding: EdgeInsets.only(bottom: isCompact ? 8 : 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: isCompact ? 10 : 11,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$intValue / 5',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (i) {
              final bool isActive = i < intValue;

              return Expanded(
                child: Container(
                  height: isCompact ? 2 : 3,
                  margin: EdgeInsets.only(right: i == 4 ? 0 : 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? theme.colorScheme.primary
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
