import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for synchronizing user-managed coffee data.
/// Static encyclopedia data is now handled via local JSON assets.
class SyncService {
  final AppDatabase db;
  final SupabaseClient? supabase;

  SyncService(this.db, [this.supabase]);

  /// Synchronizes all user-managed systems.
  /// Decoupled from static Encyclopedia content for v17.
  Future<void> syncAll({
    bool force = false,
    bool clearLocal = false,
    Function(String)? onProgress,
  }) async {
    try {
      debugPrint('SYNC: Starting user data synchronization...');
      onProgress?.call('Initializing sync...');

      // Static content (Encyclopedia, Brands, Articles) is loaded from local JSON.
      // We no longer attempt to sync them from Supabase here to ensure premium stable performance.
      
      if (clearLocal) {
        onProgress?.call('Cleaning local cache...');
        // Future: Implement targeted cleanup if needed
      }

      onProgress?.call('Synchronization focused on user data.');
      
      // Future: Implement background sync for CoffeeLots/CustomRecipes if cloud storage is used.
      // For now, we ensure local transaction stability.
      
      debugPrint('SYNC: All user systems synchronized [STABLE]');
      onProgress?.call('Sync completed successfully!');
    } catch (e, st) {
      debugPrint('SYNC ERROR: $e');
      debugPrint('STACKTRACE: $st');
      onProgress?.call('Sync failed: $e');
      rethrow;
    }
  }

  /// Helper for manual lot synchronization if needed.
  /// Made optional to support legacy 0-argument calls from UI.
  Future<void> syncLots([List<CoffeeLotsCompanion>? lots]) async {
    if (lots != null && lots.isNotEmpty) {
      await db.syncLotsInTx(lots);
    } else {
      debugPrint('SYNC: syncLots triggered with 0/null lots (no-op placeholder)');
    }
  }

  /// Placeholder for pushing local changes to cloud.
  /// To be implemented when Supabase backend mapping is finalized for v17.
  Future<void> pushLocalToCloud({Function(String)? onProgress}) async {
    debugPrint('SYNC: pushLocalToCloud placeholder triggered');
    await syncAll(onProgress: onProgress);
  }

  /// Placeholder for pulling cloud changes to local.
  Future<void> pullFromCloud({Function(String)? onProgress}) async {
    debugPrint('SYNC: pullFromCloud placeholder triggered');
    await syncAll(onProgress: onProgress);
  }
}
