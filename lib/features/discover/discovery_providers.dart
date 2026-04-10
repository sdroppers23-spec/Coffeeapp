import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

final brandsProvider = FutureProvider<List<LocalizedBrandDto>>((ref) async {
  await ref.watch(databaseInitializerProvider.future);
  final db = ref.watch(databaseProvider);
  final locale = ref.watch(localeProvider);
  return db.getAllBrands(locale);
});

final brandByIdProvider = FutureProvider.family<LocalizedBrandDto?, int>((
  ref,
  id,
) async {
  final db = ref.watch(databaseProvider);
  final locale = ref.watch(localeProvider);
  return db.getBrandById(id, locale);
});
