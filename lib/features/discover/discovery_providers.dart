import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';

final brandsProvider = FutureProvider<List<LocalizedBrandDto>>((ref) async {
  await ref.watch(databaseInitializerProvider.future);
  final db = ref.watch(databaseProvider);
  return db.getAllBrands('uk');
});

final brandByIdProvider = FutureProvider.family<LocalizedBrandDto?, int>((
  ref,
  id,
) async {
  final db = ref.watch(databaseProvider);
  return db.getBrandById(id, 'uk');
});
