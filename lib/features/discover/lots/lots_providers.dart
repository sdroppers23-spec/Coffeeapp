import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
final userLotsProvider = FutureProvider<List<CoffeeLotDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return [];
  return db.getUserLots(userId);
});
