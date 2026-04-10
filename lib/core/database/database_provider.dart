import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final databaseInitializerProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  // Optional: Add initialization logic or initial seeding here
  // For now, it just ensures the DB is ready
  return;
});
