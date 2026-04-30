import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_database.dart';
import 'sync_service.dart';
import 'coffee_data_seed.dart';
import 'dtos.dart';
import '../l10n/app_localizations.dart';
import '../supabase/supabase_provider.dart';

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
    } else {}
  } catch (e) {
    // Silent fail in production as per hardening guidelines
  }

  final syncService = ref.read(syncServiceProvider);
  syncService.startAutoSync();

  // Initial sync
  debugPrint('DatabaseProvider: Starting background sync...');
  unawaited(syncService.syncAll());

  // Listen for auth changes to trigger sync (e.g. login)
  ref.listen(authStateProvider, (previous, next) {
    final event = next.value?.event;
    if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.userUpdated) {
      debugPrint('DatabaseProvider: Auth change detected ($event), triggering sync...');
      unawaited(syncService.pushLocalUserContent().then((_) => syncService.syncAll()));
    }
  });
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

final userLotRecipesForLotProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, lotId) {
  final db = ref.watch(databaseProvider);
  return db.watchUserLotRecipesForLot(lotId);
});

final encyclopediaRecipesForLotProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, lotId) {
  final db = ref.watch(databaseProvider);
  final cleanId = lotId.replaceAll('encyclopedia_', '');
  return db.watchEncyclopediaRecipesForLot(cleanId);
});

final userLotRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, methodKey) {
  final db = ref.watch(databaseProvider);
  return db.watchUserLotRecipesForMethod(methodKey);
});

final encyclopediaRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, methodKey) {
  final db = ref.watch(databaseProvider);
  return db.watchEncyclopediaRecipesForMethod(methodKey);
});

final alternativeRecipesForMethodProvider =
    StreamProvider.family<List<CustomRecipeDto>, String>((ref, methodKey) {
  final db = ref.watch(databaseProvider);
  return db.watchAlternativeRecipes(methodKey);
});

final allCustomRecipesForMethodProvider =
    Provider.family<AsyncValue<List<CustomRecipeDto>>, String>(
        (ref, methodKey) {
  final s1 = ref.watch(userLotRecipesForMethodProvider(methodKey));
  // Removed s2 (encyclopedia recipes) to prevent duplication in Alternative Brewing list
  final s3 = ref.watch(alternativeRecipesForMethodProvider(methodKey));

  if (s1.isLoading || s3.isLoading) {
    return const AsyncValue.loading();
  }
  if (s1.hasError) return AsyncValue.error(s1.error!, s1.stackTrace!);
  if (s3.hasError) return AsyncValue.error(s3.error!, s3.stackTrace!);

  final List<CustomRecipeDto> all = [
    ...(s1.value ?? []),
    ...(s3.value ?? []),
  ];
  // Sort by date descending
  all.sort((a, b) {
    final dateA = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    final dateB = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    return dateB.compareTo(dateA);
  });
  return AsyncValue.data(all);
});

final userLotRecipesProvider = StreamProvider<List<CustomRecipeDto>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllUserLotRecipes();
});

final encyclopediaRecipesProvider = StreamProvider<List<CustomRecipeDto>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllEncyclopediaRecipes();
});

final alternativeRecipesProvider = StreamProvider<List<CustomRecipeDto>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAlternativeRecipes();
});

final globalCustomRecipesProvider =
    Provider<AsyncValue<List<CustomRecipeDto>>>((ref) {
  final s1 = ref.watch(userLotRecipesProvider);
  final s2 = ref.watch(encyclopediaRecipesProvider);
  final s3 = ref.watch(alternativeRecipesProvider);

  if (s1.isLoading || s2.isLoading || s3.isLoading) {
    return const AsyncValue.loading();
  }
  if (s1.hasError) return AsyncValue.error(s1.error!, s1.stackTrace!);
  if (s2.hasError) return AsyncValue.error(s2.error!, s2.stackTrace!);
  if (s3.hasError) return AsyncValue.error(s3.error!, s3.stackTrace!);

  final List<CustomRecipeDto> all = [
    ...(s1.value ?? []),
    ...(s2.value ?? []),
    ...(s3.value ?? []),
  ];
  all.sort((a, b) {
    final dateA = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    final dateB = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    return dateB.compareTo(dateA);
  });
  return AsyncValue.data(all);
});
