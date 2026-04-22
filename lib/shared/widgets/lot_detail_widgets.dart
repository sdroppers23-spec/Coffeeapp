import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotBadge extends StatelessWidget {
  final String label;
  final ThemeData theme;
  final bool isPrimary;

  const LotBadge({
    super.key,
    required this.label,
    required this.theme,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary
            ? theme.colorScheme.primary.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPrimary
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: isPrimary ? theme.colorScheme.primary : Colors.white70,
        ),
      ),
    );
  }
}

class LotDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const LotDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    // If value is null, empty or just whitespace, we use "N/A" as requested by the user
    final displayValue = (value.trim().isEmpty) ? "N/A" : value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              displayValue,
              textAlign: TextAlign.right,
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LotCompactStat extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const LotCompactStat({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = (value.trim().isEmpty) ? "N/A" : value;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 9,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displayValue,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.info_outline_rounded,
                  size: 10,
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
