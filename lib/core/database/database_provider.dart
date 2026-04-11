import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'sync_service.dart';
import 'coffee_data_seed.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final coffeeDataSeedProvider = Provider<CoffeeDataSeed>((ref) {
  final db = ref.watch(databaseProvider);
  return CoffeeDataSeed(db);
});

final databaseInitializerProvider = FutureProvider<void>((ref) async {
  final seeder = ref.watch(coffeeDataSeedProvider);
  await seeder.seedAll();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db, Supabase.instance.client);
});
