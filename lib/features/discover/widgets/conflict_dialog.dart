import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/app_localizations.dart';

enum ConflictResult { replace, copyRestart, cancel }

class ConflictDialog extends ConsumerWidget {
  final String lotName;

  const ConflictDialog({super.key, required this.lotName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: const Color(0xFF1E293B).withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFC8A96E),
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                ref.t('conflict_detected'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.t('conflict_desc'),
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFFC8A96E),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lotName,
                      style: const TextStyle(
                        color: Color(0xFFC8A96E),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pop(context, ConflictResult.cancel),
                  child: Text(
                    ref.t('cancel_action'),
                    style: const TextStyle(color: Colors.white38),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFC8A96E),
                    side: const BorderSide(color: Color(0xFFC8A96E)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () =>
                      Navigator.pop(context, ConflictResult.copyRestart),
                  label: Text(ref.t('copy_with_suffix')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.sync_rounded, size: 18),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8A96E),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 10,
                    shadowColor: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                  ),
                  onPressed: () =>
                      Navigator.pop(context, ConflictResult.replace),
                  label: Text(
                    ref.t('replace_data'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
