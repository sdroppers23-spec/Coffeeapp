import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  try {
    return ref.watch(supabaseProvider).auth.onAuthStateChange;
  } catch (e) {
    return Stream.empty();
  }
});

final currentUserProvider = Provider<User?>((ref) {
  // Use authStateProvider to make this reactive
  ref.watch(authStateProvider);
  return ref.watch(supabaseProvider).auth.currentUser;
});

/// Helper class to convert a Stream into a Listenable for GoRouter
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
