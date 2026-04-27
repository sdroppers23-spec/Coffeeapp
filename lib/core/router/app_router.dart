import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase/supabase_provider.dart';
import '../providers/settings_provider.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/discover/discover_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/brewing/brewing_guide_screen.dart';
import '../../features/encyclopedia/encyclopedia_providers.dart';
import '../../features/encyclopedia/comparison_screen.dart';
import '../../features/specialty/specialty_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/flavor_map/flavor_map_screen.dart';
import '../../features/discover/lots/add_lot_screen.dart';
import '../../core/database/dtos.dart';
import '../../features/navigation/main_scaffold.dart';
import '../../features/brewing/brewing_main_screen.dart';
import '../../shared/widgets/lot_detail_view.dart';


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

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    _subscription = ref.listen(authStateProvider, (_, next) {
      final event = next.value?.event;
      if (event == AuthChangeEvent.signedIn || 
          event == AuthChangeEvent.signedOut || 
          event == AuthChangeEvent.initialSession) {
        notifyListeners();
      }
    });
    // Listen to guest mode changes
    _guestSubscription = ref.listen(isGuestProvider, (_, _) {
      notifyListeners();
    });
  }

  late final ProviderSubscription _subscription;
  late final ProviderSubscription _guestSubscription;

  @override
  void dispose() {
    _subscription.close();
    _guestSubscription.close();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final supabase = ref.watch(supabaseProvider);
  final refreshNotifier = RouterRefreshNotifier(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/specialty_hub',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final session = supabase.auth.currentSession;
      final isLoggedIn = session != null;
      final isGuest = ref.read(isGuestProvider);
      final isLoggingIn = state.matchedLocation == '/auth';

      if (!isLoggedIn && !isGuest && !isLoggingIn) return '/auth';
      if ((isLoggedIn || isGuest) && isLoggingIn) return '/specialty_hub';

      return null;
    },
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
    routes: [
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      // Catch legacy/invalid recipe routes and redirect to recipes tab
      GoRoute(path: '/add_recipe', redirect: (context, state) => '/recipes'),
      GoRoute(path: '/edit_recipe', redirect: (context, state) => '/recipes'),
      GoRoute(path: '/add-recipe', redirect: (context, state) => '/recipes'),
      GoRoute(path: '/edit-recipe', redirect: (context, state) => '/recipes'),
      
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
        builder: (context, state) {
          final source = state.extra as ComparisonSource? ?? ComparisonSource.encyclopedia;
          return ComparisonScreen(source: source);
        },
      ),
      GoRoute(
        path: '/specialty',
        builder: (context, state) => const SpecialtyEducationScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/add_lot',
        builder: (context, state) => const AddLotScreen(openAsAdd: true),
      ),
      GoRoute(
        path: '/edit_lot',
        builder: (context, state) {
          final lot = state.extra as CoffeeLotDto?;
          return AddLotScreen(initialLot: lot);
        },
      ),
      GoRoute(
        path: '/lot_details',
        builder: (context, state) {
          // Gracefully handle null extra (web refresh)
          final extra = state.extra as Map<String, dynamic>?;
          final lot = extra?['lot'] as CoffeeLotDto?;
          final entry = extra?['entry'] as EncyclopediaEntry?;
          
          if (lot == null && entry == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Lot Detail')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Lot data is no longer available.'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Return Home'),
                    ),
                  ],
                ),
              ),
            );
          }
          
          return LotDetailView(
            lot: lot,
            entry: entry,
          );
        },
      ),

    ],
  );
});
