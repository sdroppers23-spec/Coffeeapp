import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../supabase/supabase_provider.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/flavor_map/flavor_map_screen.dart';
import '../../features/discover/discover_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/latte_art/latte_art_screen.dart';
import '../../features/bean_eye/bean_eye_screen.dart';
import '../../features/brewing/brewing_guide_screen.dart';
import '../../features/encyclopedia/comparison_screen.dart';
import '../../features/specialty/specialty_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final supabase = ref.watch(supabaseProvider);
  
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(supabase.auth.onAuthStateChange),
    redirect: (context, state) {
      final session = supabase.auth.currentSession;
      final isLoggedIn = session != null;
      final isLoggingIn = state.matchedLocation == '/auth';

      if (!isLoggedIn && !isLoggingIn) return '/auth';
      if (isLoggedIn && isLoggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      GoRoute(path: '/', builder: (context, state) => const FlavorMapScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/discover',
        builder: (context, state) => const DiscoverScreen(),
      ),
      GoRoute(
        path: '/latte_art',
        builder: (context, state) => const LatteArtScreen(),
      ),
      GoRoute(
        path: '/bean_eye',
        builder: (context, state) => const BeanEyeScreen(),
      ),
      GoRoute(
        path: '/brewing',
        builder: (context, state) => const BrewingGuideScreen(),
      ),
      GoRoute(
        path: '/compare',
        builder: (context, state) => const ComparisonScreen(),
      ),
      GoRoute(
        path: '/specialty',
        builder: (context, state) => const SpecialtyEducationScreen(),
      ),
    ],
  );
});
