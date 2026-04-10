import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/network/connectivity_provider.dart';
import '../../core/database/sync_service.dart';

enum SyncState { idle, syncing, success, error, offline }

class SyncStatusNotifier extends Notifier<SyncState> {
  String? lastError;
  String? lastMessage;
  List<ConnectivityResult>? _lastConnectivity;

  @override
  SyncState build() {
    // Listen to connectivity changes
    final conn = ref.watch(connectivityProvider).value;
    final isOnline = ref.watch(isOnlineProvider);

    if (_lastConnectivity != null &&
        _lastConnectivity!.contains(ConnectivityResult.none) &&
        !conn!.contains(ConnectivityResult.none)) {
      // Transition from offline to online -> Auto-sync
      Future.microtask(() => pullFromCloud());
    }

    _lastConnectivity = conn;

    if (!isOnline) return SyncState.offline;
    return SyncState.idle;
  }

  SyncService get _syncService => ref.read(syncServiceProvider);

  Future<void> syncEverything() async {
    lastError = null;
    state = SyncState.syncing;
    try {
      await _syncService.syncAll(onProgress: (m) {
        state = SyncState.syncing;
        lastMessage = m;
      });
      state = SyncState.success;
      await Future.delayed(const Duration(seconds: 3));
      state = SyncState.idle;
    } catch (e) {
      lastError = e.toString();
      state = SyncState.error;
    }
  }

  // Deprecated individual methods (pointing to syncEverything)
  Future<void> pushToCloud() => syncEverything();
  Future<void> pullFromCloud() => syncEverything();
}

final syncStatusProvider = NotifierProvider<SyncStatusNotifier, SyncState>(() {
  return SyncStatusNotifier();
});

class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncStatusProvider);
    final notifier = ref.read(syncStatusProvider.notifier);

    late Color color;
    late IconData icon;
    late String label;

    switch (syncState) {
      case SyncState.idle:
        color = Colors.greenAccent;
        icon = Icons.cloud_done_outlined;
        label = 'Cloud Connected';
        break;
      case SyncState.offline:
        color = Colors.redAccent;
        icon = Icons.cloud_off;
        label = 'Offline Mode';
        break;
      case SyncState.syncing:
        color = const Color(0xFFC8A96E);
        icon = Icons.sync;
        label = notifier.lastMessage ?? 'Syncing...';
        break;
      case SyncState.success:
        color = Colors.greenAccent;
        icon = Icons.cloud_done;
        label = 'Sync Completed';
        break;
      case SyncState.error:
        color = Colors.redAccent;
        icon = Icons.error_outline;
        label = 'Sync Error';
        break;
    }

    return Tooltip(
      message: notifier.lastError ?? label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (syncState == SyncState.syncing)
              const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Color(0xFFC8A96E)),
              )
            else
              Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                  color: color, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
