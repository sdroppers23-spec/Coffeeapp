import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/network/connectivity_provider.dart';
import '../../core/database/sync_service.dart';
import '../../core/database/database_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../features/encyclopedia/encyclopedia_providers.dart';
import '../../features/specialty/specialty_encyclopedia_provider.dart';
import '../../features/discover/discovery_providers.dart';
import '../../features/discover/farmers_screen.dart';
import '../../features/brewing/brewing_guide_screen.dart';

class SyncStatusData {
  final SyncState state;
  final String? lastError;
  final String? lastMessage;
  final double currentProgress;

  SyncStatusData({
    required this.state,
    this.lastError,
    this.lastMessage,
    this.currentProgress = 0.0,
  });

  SyncStatusData copyWith({
    SyncState? state,
    String? lastError,
    String? lastMessage,
    double? currentProgress,
  }) {
    return SyncStatusData(
      state: state ?? this.state,
      lastError: lastError ?? this.lastError,
      lastMessage: lastMessage ?? this.lastMessage,
      currentProgress: currentProgress ?? this.currentProgress,
    );
  }
}

enum SyncState { idle, syncing, success, error, offline }

class SyncStatusNotifier extends Notifier<SyncStatusData> {
  bool _hasInitializedSubscriptions = false;
  bool _hasPerformedSessionSync = false;

  @override
  SyncStatusData build() {
    final isOnline = ref.watch(isOnlineProvider);
    final prefs = ref.watch(sharedPreferencesProvider);

    // 1. Initialize Real-time Subscriptions (Once)
    if (isOnline && !_hasInitializedSubscriptions) {
      _hasInitializedSubscriptions = true;
      Future.microtask(() {
        _syncService.subscribeToRealtimeUpdates();
        _syncService.dataUpdateStream.listen((_) => invalidateData());
      });
    }

    // 2. Continuous Sync Logic
    const resyncKey = 'force_resync_v20_unified_content'; 
    final hasResyncedVersion = prefs.getBool(resyncKey) ?? false;

    if (isOnline) {
      if (!hasResyncedVersion) {
        Future.microtask(() async {
          await syncEverything(force: true);
          await prefs.setBool(resyncKey, true);
          _hasPerformedSessionSync = true;
          debugPrint('SYNC: Version Guard completed.');
        });
      } else if (!_hasPerformedSessionSync) {
        _hasPerformedSessionSync = true;
        Future.microtask(() => pullFromCloud());
        debugPrint('SYNC: Standard session-start sync triggered.');
      }
    }

    // 3. Connectivity Recovery Sync (via ref.listen for side effects)
    ref.listen(connectivityProvider, (previous, next) {
      final prevList = previous?.value;
      final nextList = next.value;

      final wasOffline = prevList == null || prevList.contains(ConnectivityResult.none);
      final isNowOnline = nextList != null && !nextList.contains(ConnectivityResult.none);

      if (wasOffline && isNowOnline && _hasPerformedSessionSync) {
        debugPrint('SYNC: Connectivity recovered. Triggering sync...');
        Future.microtask(() => syncEverything());
      }
    });

    if (!isOnline) {
      return SyncStatusData(state: SyncState.offline, lastMessage: 'OFFLINE MODE');
    }
    
    // For initial return, we use idle or syncing based on _hasPerformedSessionSync
    if (!_hasPerformedSessionSync && isOnline) {
      return SyncStatusData(state: SyncState.syncing, lastMessage: 'Initializing...');
    }
    
    return SyncStatusData(state: SyncState.idle);
  }

  SyncService get _syncService => ref.read(syncServiceProvider);

  void invalidateData() {
    debugPrint('SYNC: Invalidating all data providers for immediate UI update...');
    ref.invalidate(farmersProvider);
    ref.invalidate(specialtyArticlesProvider);
    ref.invalidate(specialtyEncyclopediaProvider);
    ref.invalidate(encyclopediaDataProvider);
    ref.invalidate(brandsProvider);
    ref.invalidate(articlesProvider);
    ref.invalidate(brewingRecipesProvider);
  }

  Future<void> syncEverything({bool force = false}) async {
    state = state.copyWith(state: SyncState.syncing, lastError: null);
    
    // 1. Tiny delay to ensure UI updates before heavy sync work begins
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      await _syncService.syncAll(
        force: force,
        onProgress: (m, p) {
          state = state.copyWith(
            state: SyncState.syncing,
            lastMessage: m,
            currentProgress: p,
          );
        },
      );
      
      // 2. Perform vital invalidation
      invalidateData();
      
      state = state.copyWith(state: SyncState.success, currentProgress: 1.0);
      await Future.delayed(const Duration(seconds: 3));
      state = state.copyWith(state: SyncState.idle);
    } catch (e) {
      state = state.copyWith(state: SyncState.error, lastError: e.toString());
    }
  }

  // Deprecated individual methods (pointing to syncEverything)
  Future<void> pushToCloud() => syncEverything();
  Future<void> pullFromCloud() => syncEverything();
}

final syncStatusProvider = NotifierProvider<SyncStatusNotifier, SyncStatusData>(() {
  return SyncStatusNotifier();
});

class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncData = ref.watch(syncStatusProvider);

    late Color color;
    late IconData icon;
    late String label;

    switch (syncData.state) {
      case SyncState.idle:
        color = Colors.greenAccent;
        icon = Icons.sensors; // Changed to indicate active listening
        label = 'Cloud Active';
        break;
      case SyncState.offline:
        color = Colors.redAccent;
        icon = Icons.cloud_off;
        label = 'Offline Mode';
        break;
      case SyncState.syncing:
        color = const Color(0xFFC8A96E);
        icon = Icons.sync;
        final pct = (syncData.currentProgress * 100).toInt();
        label = '${syncData.lastMessage ?? 'Syncing'} ($pct%)';
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
      message: syncData.lastError ?? label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (syncData.state == SyncState.syncing)
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: const Color(0xFFC8A96E),
                  value: syncData.currentProgress > 0.05 ? syncData.currentProgress : null,
                  backgroundColor: const Color(0xFFC8A96E).withOpacity(0.2),
                ),
              )
            else
              Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
