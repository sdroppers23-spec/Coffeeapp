import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sync_indicator.dart';
import '../../core/network/connectivity_provider.dart';

class MiniSyncIndicator extends ConsumerWidget {
  const MiniSyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncData = ref.watch(syncStatusProvider);
    final isOnline = ref.watch(isOnlineProvider);

    Color statusColor;
    String statusText;
    IconData statusIcon;
    bool isSpinning = false;

    if (!isOnline) {
      statusColor = Colors.redAccent;
      statusText = 'Offline';
      statusIcon = Icons.cloud_off;
    } else {
      switch (syncData.state) {
        case SyncState.syncing:
          statusColor = const Color(0xFFC8A96E);
          statusText = 'Syncing...';
          statusIcon = Icons.sync;
          isSpinning = true;
          break;
        case SyncState.error:
          statusColor = Colors.orangeAccent;
          statusText = 'Sync Issue';
          statusIcon = Icons.warning_amber_rounded;
          break;
        case SyncState.success:
        case SyncState.idle:
        default:
          statusColor = Colors.greenAccent;
          statusText = 'Connected';
          statusIcon = Icons.cloud_done;
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSpinning)
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: statusColor,
              ),
            )
          else
            Icon(statusIcon, size: 14, color: statusColor),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: GoogleFonts.outfit(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
