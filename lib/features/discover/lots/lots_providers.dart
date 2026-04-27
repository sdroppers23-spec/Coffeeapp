import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
final userLotsProvider = FutureProvider<List<CoffeeLotDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id ?? 'guest';
  return db.getUserLots(userId);
});

final userLotsStreamProvider = StreamProvider<List<CoffeeLotDto>>((ref) {
  final db = ref.watch(databaseProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id ?? 'guest';
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

