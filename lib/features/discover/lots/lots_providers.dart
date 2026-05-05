import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';

import '../../../core/supabase/supabase_provider.dart';

final userLotsProvider = NotifierProvider<UserLotsNotifier, List<CoffeeLotDto>>(
  () {
    return UserLotsNotifier();
  },
);

class UserLotsNotifier extends Notifier<List<CoffeeLotDto>> {
  @override
  List<CoffeeLotDto> build() {
    final stream = ref.watch(userLotsStreamProvider);
    return stream.value ?? [];
  }

  Future<void> toggleFavorite(String lotId) async {
    final db = ref.read(databaseProvider);
    final lot = state.firstWhere((l) => l.id == lotId);
    await db.toggleLotFavorite(lotId, !lot.isFavorite);
  }
}

final userLotsStreamProvider = StreamProvider<List<CoffeeLotDto>>((ref) {
  final db = ref.watch(databaseProvider);
  final user = ref.watch(currentUserProvider);
  final userId = user?.id ?? 'guest';
  return db.watchUserLots(userId);
});

final favoriteLotsStreamProvider = StreamProvider<List<CoffeeLotDto>>((ref) {
  final lotsAsync = ref.watch(userLotsStreamProvider);
  return lotsAsync.when(
    data: (lots) => Stream.value(lots.where((l) => l.isFavorite).toList()),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.value([]),
  );
});
