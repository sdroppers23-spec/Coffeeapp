import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/dtos.dart';
import '../../../../shared/widgets/sync_indicator.dart';
import '../../../../core/supabase/supabase_provider.dart';

/// Raw stream of the user roasters record from the database.
final _userRoastersRecordStreamProvider = StreamProvider<UserRoaster?>((ref) {
  final db = ref.watch(databaseProvider);
  final user = ref.watch(currentUserProvider);
  final userId = user?.id;
  if (userId == null) return const Stream.empty();
  return db.watchUserRoastersRecord(userId);
});

final userRoastersProvider =
    NotifierProvider<UserRoastersNotifier, List<UserRoasterDto>>(() {
      return UserRoastersNotifier();
    });

class UserRoastersNotifier extends Notifier<List<UserRoasterDto>> {
  @override
  List<UserRoasterDto> build() {
    // Watch the stream and update state when it changes
    final recordAsync = ref.watch(_userRoastersRecordStreamProvider);

    return recordAsync.when(
      data: (record) {
        if (record != null) {
          final List<dynamic> data = jsonDecode(record.dataJson);
          return data
              .map((e) => UserRoasterDto.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
      loading: () =>
          [], // Clear state while loading to prevent seeing previous user's data
      error: (_, _) => [],
    );
  }

  Future<void> saveRoaster(UserRoasterDto roaster) async {
    final userId = ref.read(currentUserProvider)?.id;
    if (userId == null) return;

    final index = state.indexWhere((e) => e.id == roaster.id);
    List<UserRoasterDto> newList;
    if (index >= 0) {
      newList = [...state];
      newList[index] = roaster;
    } else {
      newList = [...state, roaster];
    }

    // Optimistic update
    state = newList;

    await _saveLocal(userId, newList);
  }

  Future<void> deleteRoaster(String roasterId) async {
    final userId = ref.read(currentUserProvider)?.id;
    if (userId == null) return;

    final newList = state.where((e) => e.id != roasterId).toList();
    state = newList;

    await _saveLocal(userId, newList);
  }

  Future<void> toggleFavorite(String roasterId) async {
    final userId = ref.read(currentUserProvider)?.id;
    if (userId == null) return;

    final index = state.indexWhere((e) => e.id == roasterId);
    if (index < 0) return;

    final updated = state[index].copyWith(
      isFavorite: !state[index].isFavorite,
      updatedAt: DateTime.now(),
    );
    final newList = [...state];
    newList[index] = updated;
    state = newList;

    await _saveLocal(userId, newList);
  }

  Future<void> toggleArchive(String roasterId, bool archive) async {
    final userId = ref.read(currentUserProvider)?.id;
    if (userId == null) return;

    final index = state.indexWhere((e) => e.id == roasterId);
    if (index < 0) return;

    final updated = state[index].copyWith(
      isArchived: archive,
      updatedAt: DateTime.now(),
    );
    final newList = [...state];
    newList[index] = updated;
    state = newList;

    await _saveLocal(userId, newList);
  }

  Future<void> _saveLocal(String userId, List<UserRoasterDto> list) async {
    final db = ref.read(databaseProvider);
    final dataJson = jsonEncode(list.map((e) => e.toJson()).toList());
    await db.saveUserRoastersRecord(
      UserRoastersCompanion(
        userId: Value(userId),
        dataJson: Value(dataJson),
        isSynced: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );

    // Trigger sync
    ref.read(syncStatusProvider.notifier).syncEverything();
  }
}
