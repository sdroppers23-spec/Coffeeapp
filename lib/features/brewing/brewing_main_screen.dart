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
    _tabController.addListener(() {
      if (mounted) {
        if (_tabController.index == 1) {
          ref.read(navBarVisibleProvider.notifier).hide();
        } else {
          ref.read(navBarVisibleProvider.notifier).show();
        }
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (_tabController.index == 1) {
          ref.read(navBarVisibleProvider.notifier).hide();
        } else {
          ref.read(navBarVisibleProvider.notifier).show();
        }
      }
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
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: PremiumAppBar(
        title: ref.t('alternative_brewing'),
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

        // Group recipes by category and methodKey
        Map<String, List<BrewingRecipeDto>> groupByMethod(List<BrewingRecipeDto> list) {
          final grouped = <String, List<BrewingRecipeDto>>{};
          for (var r in list) {
            grouped.putIfAbsent(r.methodKey, () => []).add(r);
          }
          return grouped;
        }

        final espressoMethods = groupByMethod(recipes.where((r) => r.category == 'espresso').toList()).values.toList();
        final filterMethods = groupByMethod(recipes.where((r) => r.category != 'espresso').toList()).values.toList();

        return CustomScrollView(
          slivers: [
            // Top spacer (replaces padding.top)
            const SliverToBoxAdapter(child: SizedBox(height: 160)),

              if (espressoMethods.isNotEmpty) ...[
              if (isGrid)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) => MethodTile(methodRecipes: espressoMethods[i]),
                      childCount: espressoMethods.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          height: 180,
                          child: MethodTile(methodRecipes: espressoMethods[i]),
                        ),
                      ),
                      childCount: espressoMethods.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],

            if (filterMethods.isNotEmpty) ...[
              if (isGrid)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) => MethodTile(methodRecipes: filterMethods[i]),
                      childCount: filterMethods.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          height: 180,
                          child: MethodTile(methodRecipes: filterMethods[i]),
                        ),
                      ),
                      childCount: filterMethods.length,
                    ),
                  ),
                ),
            ],

            // Bottom spacer (replaces padding.bottom)
            SliverToBoxAdapter(child: SizedBox(height: navHeight + 48)),
          ],
        );
      },

    );
  }
}
