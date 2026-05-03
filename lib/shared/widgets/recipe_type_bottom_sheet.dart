import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';
import 'glass_container.dart';

class RecipeTypeBottomSheet extends StatelessWidget {
  final Function(String type) onTypeSelected;
  final String title;
  final int filterCount;
  final int espressoCount;
  final int limit;

  const RecipeTypeBottomSheet({
    super.key,
    required this.onTypeSelected,
    required this.title,
    this.filterCount = 0,
    this.espressoCount = 0,
    this.limit = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 0, // Fill the bottom sheet area
      opacity: 0.1,
      blur: 20,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title.toUpperCase(),
            style: GoogleFonts.outfit(
              color: const Color(0xFFC8A96E),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _RecipeTypeCard(
                title: context.t('filter'),
                icon: Icons.coffee_rounded,
                count: filterCount,
                limit: limit,
                onTap: () => onTypeSelected('filter'),
              ),
              const SizedBox(width: 16),
              _RecipeTypeCard(
                title: context.t('espresso'),
                icon: Icons.coffee_maker_rounded,
                count: espressoCount,
                limit: limit,
                onTap: () => onTypeSelected('espresso'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecipeTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final int limit;
  final VoidCallback onTap;

  const _RecipeTypeCard({
    required this.title,
    required this.icon,
    required this.count,
    required this.limit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLimitReached = count >= limit;
    
    return Expanded(
      child: GestureDetector(
        onTap: isLimitReached ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isLimitReached
                  ? Colors.red.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isLimitReached
                    ? Colors.red.withValues(alpha: 0.5)
                    : const Color(0xFFC8A96E),
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                title.toUpperCase(),
                style: GoogleFonts.outfit(
                  color: isLimitReached ? Colors.white24 : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count / $limit',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: isLimitReached ? Colors.redAccent : Colors.white38,
                ),
              ),
              if (isLimitReached) ...[
                const SizedBox(height: 8),
                Text(
                  context.t('limit'),
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
