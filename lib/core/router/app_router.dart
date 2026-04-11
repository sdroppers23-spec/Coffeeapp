import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../supabase/supabase_provider.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/discover/discover_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/brewing/brewing_guide_screen.dart';
import '../../features/encyclopedia/comparison_screen.dart';
import '../../features/specialty/specialty_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/flavor_map/flavor_map_screen.dart';
import '../../features/brewing/brewing_main_screen.dart';
import '../../features/navigation/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorSpecialtyKey = GlobalKey<NavigatorState>(
  debugLabel: 'specialty_shell',
);
final _shellNavigatorDiscoverKey = GlobalKey<NavigatorState>(
  debugLabel: 'discover_shell',
);
final _shellNavigatorRecipesKey = GlobalKey<NavigatorState>(
  debugLabel: 'recipes_shell',
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
                path: '/specialty_hub',
                builder: (context, state) => const FlavorMapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDiscoverKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DiscoverScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRecipesKey,
            routes: [
              GoRoute(
                path: '/recipes',
                builder: (context, state) => const BrewingMainScreen(),
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
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
