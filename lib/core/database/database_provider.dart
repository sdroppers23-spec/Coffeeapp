import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'sync_service.dart';
import 'coffee_data_seed.dart';
import 'dtos.dart';
import '../l10n/app_localizations.dart';

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

  final seeder = ref.read(coffeeDataSeedProvider);
  
  try {
    final db = ref.read(databaseProvider);
    final brandsEmpty = await db.brandsIsEmpty();
    final farmersEmpty = await db.farmersIsEmpty();
    final encyclopediaEmpty = await db.encyclopediaIsEmpty();
    final articlesEmpty = await db.specialtyArticlesIsEmpty();

    if (brandsEmpty || farmersEmpty || encyclopediaEmpty || articlesEmpty) {
      debugPrint('DatabaseProvider: Core tables empty, triggering re-seed...');
      await seeder.seedAll();
    }
 else {

    }
  } catch (e) {
    // Silent fail in production as per hardening guidelines
  }
  
  final syncService = ref.read(syncServiceProvider);

  debugPrint('DatabaseProvider: Starting background sync...');
  unawaited(syncService.syncAll());

});

final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db, Supabase.instance.client);
});

final beanProvider = StreamProvider.family<LocalizedBeanDto?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(localeProvider);
  return db.watchBeanById(id, lang); 
});

final lotProvider = StreamProvider.family<CoffeeLotDto?, String>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.watchLotById(id);
});
