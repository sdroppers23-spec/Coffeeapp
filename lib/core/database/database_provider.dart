import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'sync_service.dart';
import 'coffee_data_seed.dart';
import 'dtos.dart';

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
  
  // Start cloud sync immediately after seeding
  final syncService = ref.watch(syncServiceProvider);
  // We don't await here to avoid blocking app start, but fire it off
  unawaited(syncService.syncAll());
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db, Supabase.instance.client);
});

final beanProvider = StreamProvider.family<LocalizedBeanDto?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.watchBeanById(id, 'uk'); 
});

final lotProvider = StreamProvider.family<CoffeeLotDto?, String>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.watchLotById(id);
});
