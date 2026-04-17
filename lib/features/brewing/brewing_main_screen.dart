import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/profile_button.dart';
import '../navigation/navigation_providers.dart';
import 'brewing_guide_screen.dart';
import 'custom_recipe_list.dart';
import 'method_tile.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../core/database/dtos.dart';

class BrewingViewModeNotifier extends Notifier<bool> {
  @override
  bool build() => true; // true = grid, false = list
  
  void toggle() => state = !state;
  void setMode(bool isGrid) => state = isGrid;
}

final brewingViewModeProvider = NotifierProvider<BrewingViewModeNotifier, bool>(() => BrewingViewModeNotifier());

class BrewingMainScreen extends ConsumerStatefulWidget {
  const BrewingMainScreen({super.key});

  @override
  ConsumerState<BrewingMainScreen> createState() => _BrewingMainScreenState();
}

class _BrewingMainScreenState extends ConsumerState<BrewingMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PremiumAppBar(
        title: ref.t('alternative'),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(brewingViewModeProvider)
                  ? Icons.view_list_rounded
                  : Icons.grid_view_rounded,
              color: accentColor,
            ),
            onPressed: () => ref.read(brewingViewModeProvider.notifier).toggle(),
          ),
          const ProfileButton(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            height: 44,
            margin: const EdgeInsets.only(bottom: 12),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: accentColor,
              ),
              // Most styles now come from global tabBarTheme in AppTheme
              tabs: [
                Tab(text: ref.t('alternative')),
                Tab(text: ref.t('my_recipes')),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_BrewingMethodsContent(), GlobalCustomRecipeList()],
      ),
    );
  }
}

class _BrewingMethodsContent extends ConsumerWidget {
  const _BrewingMethodsContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(brewingRecipesProvider);
    final navHeight = ref.watch(navBarHeightProvider);

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text('Error: $e')),
      data: (recipes) {
        final isGrid = ref.watch(brewingViewModeProvider);

        // Group recipes by method for "Method-First" UI
        final grouped = <String, List<BrewingRecipeDto>>{};
        for (var r in recipes) {
          grouped.putIfAbsent(r.methodKey, () => []).add(r);
        }
        final methods = grouped.keys.toList();

        if (isGrid) {
          return GridView.builder(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 120, // Space for the blurred app bar
              bottom: navHeight + 48,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.82,
            ),
            itemCount: methods.length,
            itemBuilder: (context, i) {
              final methodKey = methods[i];
              return MethodTile(methodRecipes: grouped[methodKey]!);
            },
          );
        }

        return ListView.builder(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 120,
            bottom: navHeight + 48,
          ),
          itemCount: methods.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 180,
              child: MethodTile(methodRecipes: grouped[methods[i]]!),
            ),
          ),
        );
      },
    );
  }
}
