import 'dart:async';
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
import '../../features/discover/lots/lots_providers.dart';

class SyncStatusData {
  final SyncState state;
  final double currentProgress;
  final String? lastMessage;
  final String? lastError;
  final DateTime? lastSyncedAt;

  SyncStatusData({
    required this.state,
    this.currentProgress = 0.0,
    this.lastMessage,
    this.lastError,
    this.lastSyncedAt,
  });

  SyncStatusData copyWith({
    SyncState? state,
    double? currentProgress,
    String? lastMessage,
    String? lastError,
    DateTime? lastSyncedAt,
  }) {
    return SyncStatusData(
      state: state ?? this.state,
      currentProgress: currentProgress ?? this.currentProgress,
      lastMessage: lastMessage ?? this.lastMessage,
      lastError: lastError ?? this.lastError,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
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
    final syncService = ref.watch(syncServiceProvider);

    // 1. Initialize Real-time Subscriptions (Once)
    if (isOnline && !_hasInitializedSubscriptions) {
      _hasInitializedSubscriptions = true;
      Future.microtask(() {
        syncService.subscribeToRealtimeUpdates();
        syncService.dataUpdateStream.listen((_) => invalidateData());
      });
    }

    // 2. Listen to SyncService internal state for "FACTUAL" updates
    syncService.isSyncing.addListener(_onSyncingChanged);
    syncService.lastSyncResult.addListener(_onSyncResultChanged);

    // Cleanup listeners when disposed
    ref.onDispose(() {
      syncService.isSyncing.removeListener(_onSyncingChanged);
      syncService.lastSyncResult.removeListener(_onSyncResultChanged);
    });

    // 3. Continuous Sync Logic
    const resyncKey = 'force_resync_v20_unified_content';
    final hasResyncedVersion = prefs.getBool(resyncKey) ?? false;

    if (isOnline) {
      if (!hasResyncedVersion) {
        Future.microtask(() async {
          await syncEverything(force: true);
          await prefs.setBool(resyncKey, true);
          _hasPerformedSessionSync = true;
        });
      } else if (!_hasPerformedSessionSync) {
        _hasPerformedSessionSync = true;
        Future.microtask(() => pullFromCloud());
      }
    }

    // 4. Connectivity Recovery Sync
    ref.listen(connectivityProvider, (previous, next) {
      final prevList = previous?.value;
      final nextList = next.value;

      final wasOffline =
          prevList == null || prevList.contains(ConnectivityResult.none);
      final isNowOnline =
          nextList != null && !nextList.contains(ConnectivityResult.none);

      if (wasOffline && isNowOnline && _hasPerformedSessionSync) {
        Future.microtask(() => syncEverything());
      }
    });

    if (!isOnline) {
      return SyncStatusData(
        state: SyncState.offline,
        lastMessage: 'OFFLINE MODE',
      );
    }

    final lastSyncedMillis = prefs.getInt('last_synced_at_v2');
    final lastSyncedAt = lastSyncedMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastSyncedMillis)
        : null;

    return SyncStatusData(state: SyncState.idle, lastSyncedAt: lastSyncedAt);
  }

  void invalidateData() {
    ref.invalidate(farmersProvider);
    ref.invalidate(specialtyArticlesProvider);
    ref.invalidate(specialtyEncyclopediaProvider);
    ref.invalidate(encyclopediaDataProvider);
    ref.invalidate(brandsProvider);
    ref.invalidate(articlesProvider);
    ref.invalidate(brewingRecipesProvider);

    // Add missing user data providers
    ref.invalidate(userLotsStreamProvider);
    ref.invalidate(userLotsProvider);
    ref.invalidate(userLotRecipesProvider);
    ref.invalidate(encyclopediaRecipesProvider);
    ref.invalidate(alternativeRecipesProvider);
  }

  Future<void> syncEverything({bool force = false}) async {
    try {
      state = state.copyWith(
        state: SyncState.syncing,
        currentProgress: 0.0,
        lastError: null,
      );

      final syncService = ref.read(syncServiceProvider);
      await syncService.syncAll(
        force: force,
        onProgress: (m, p) {
          if (state.state != SyncState.syncing) return;
          state = state.copyWith(
            state: SyncState.syncing,
            lastMessage: m,
            currentProgress: p,
          );
        },
      );

      // 2. Perform vital invalidation
      invalidateData();

      final now = DateTime.now();
      await ref
          .read(sharedPreferencesProvider)
          .setInt('last_synced_at_v2', now.millisecondsSinceEpoch);

      state = state.copyWith(
        state: SyncState.success,
        currentProgress: 1.0,
        lastSyncedAt: now,
      );
      await Future.delayed(const Duration(seconds: 3));
      state = state.copyWith(state: SyncState.idle);
    } catch (e) {
      state = state.copyWith(state: SyncState.error, lastError: e.toString());
    }
  }

  // Deprecated individual methods (pointing to syncEverything)
  Future<void> pushToCloud() => syncEverything();
  Future<void> pullFromCloud() => syncEverything();

  void _onSyncingChanged() {
    final syncService = ref.read(syncServiceProvider);
    if (syncService.isSyncing.value) {
      if (state.state != SyncState.syncing) {
        state = state.copyWith(
          state: SyncState.syncing,
          lastMessage: 'Syncing...',
          currentProgress: 0.0,
        );
      }
    } else if (state.state == SyncState.syncing) {
      state = state.copyWith(state: SyncState.idle);
    }
  }

  void _onSyncResultChanged() {
    final syncService = ref.read(syncServiceProvider);
    final result = syncService.lastSyncResult.value;
    final prefs = ref.read(sharedPreferencesProvider);
    final lastSyncedMillis = prefs.getInt('last_synced_at_v2');
    final lastSyncedAt = lastSyncedMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastSyncedMillis)
        : null;

    if (result == SyncResult.success) {
      invalidateData();
      state = state.copyWith(
        state: SyncState.success,
        lastMessage: 'Sync successful',
        lastSyncedAt: lastSyncedAt,
      );
      // Back to idle after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (state.state == SyncState.success) {
          state = state.copyWith(state: SyncState.idle);
        }
      });
    } else if (result == SyncResult.error) {
      state = state.copyWith(
        state: SyncState.error,
        lastMessage: 'Sync failed',
      );
    }
  }
}

final syncStatusProvider = NotifierProvider<SyncStatusNotifier, SyncStatusData>(
  () {
    return SyncStatusNotifier();
  },
);

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
        icon = Icons.sensors;
        if (syncData.lastSyncedAt != null) {
          final time =
              '${syncData.lastSyncedAt!.hour}:${syncData.lastSyncedAt!.minute.toString().padLeft(2, '0')}';
          label = 'Synced $time';
        } else {
          label = 'Cloud Active';
        }
        break;
      case SyncState.offline:
        color = Colors.redAccent;
        icon = Icons.cloud_off;
        label = 'Offline';
        break;
      case SyncState.syncing:
        color = const Color(0xFFC8A96E);
        icon = Icons.sync;
        final pct = (syncData.currentProgress * 100).toInt();
        label = syncData.lastMessage ?? 'Syncing...';
        if (pct > 0) label += ' ($pct%)';
        break;
      case SyncState.success:
        color = Colors.greenAccent;
        icon = Icons.cloud_done;
        label = 'Sync Success';
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
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
                  value: syncData.currentProgress > 0.05
                      ? syncData.currentProgress
                      : null,
                  backgroundColor: const Color(
                    0xFFC8A96E,
                  ).withValues(alpha: 0.2),
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
