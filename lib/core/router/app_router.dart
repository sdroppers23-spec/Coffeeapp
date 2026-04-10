import 'package:flutter/widgets.dart';
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
import '../../features/settings/settings_screen.dart';
import '../../features/navigation/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorSpecialtyKey = GlobalKey<NavigatorState>(
  debugLabel: 'specialty',
);
final _shellNavigatorDiscoverKey = GlobalKey<NavigatorState>(
  debugLabel: 'discover',
);
final _shellNavigatorRecipesKey = GlobalKey<NavigatorState>(
  debugLabel: 'recipes',
);

final routerProvider = Provider<GoRouter>((ref) {
  final supabase = ref.watch(supabaseProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSpecialtyKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const FlavorMapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDiscoverKey,
            routes: [
              GoRoute(
                path: '/discover',
                builder: (context, state) => const DiscoverScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRecipesKey,
            routes: [
              GoRoute(
                path: '/brewing',
                builder: (context, state) => const BrewingGuideScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
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
        path: '/compare',
        builder: (context, state) => const ComparisonScreen(),
      ),
      GoRoute(
        path: '/specialty',
        builder: (context, state) => const SpecialtyEducationScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
