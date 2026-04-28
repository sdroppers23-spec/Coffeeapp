import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
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
        setState(() {}); // Rebuild for FAB visibility
        if (_tabController.index == 1) {
          ref.read(navBarVisibleProvider.notifier).hide();
        } else {
          ref.read(navBarVisibleProvider.notifier).show();
        }
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
        title: ref.t('alternative'),
        toolbarHeight: 48,
        actions: [
          ListenableBuilder(
            listenable: _tabController,
            builder: (context, _) {
              if (_tabController.index != 0) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  ref.watch(brewingViewModeProvider)
                      ? Icons.view_list_rounded
                      : Icons.grid_view_rounded,
                  color: accentColor,
                ),
                onPressed: () => ref.read(brewingViewModeProvider.notifier).toggle(),
              );
            },
          ),
          const ProfileButton(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: SizedBox(
            height: 44,
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
                Tab(text: ref.t('brewing_methods')),
                Tab(text: ref.t('my_recipes')),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _tabController,
        builder: (context, _) => _tabController.index == 1
          ? FloatingActionButton.extended(
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => const AddRecipeDialog(),
                );
                if (result == true) {
                  ref.invalidate(globalCustomRecipesProvider);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: Text(
                ref.t('add_recipe'),
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              ),
              backgroundColor: const Color(0xFFC8A96E),
              foregroundColor: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            )
          : const SizedBox.shrink(),
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
    final customRecipesAsync = ref.watch(globalCustomRecipesProvider);
    final navHeight = ref.watch(navBarHeightProvider);

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text('Error: $e')),
      data: (guideRecipes) {
        return customRecipesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, stack) => Center(child: Text('Error: $e')),
          data: (customRecipes) {
            final isGrid = ref.watch(brewingViewModeProvider);

            // Group recipes by category and methodKey
            Map<String, List<BrewingRecipeDto>> groupByMethod(
              List<BrewingRecipeDto> guideList,
              List<CustomRecipeDto> customList,
            ) {
              final grouped = <String, List<BrewingRecipeDto>>{};
              
              // 1. Add guide recipes
              for (var r in guideList) {
                final guide = r.copyWith(isGuide: true);
                grouped.putIfAbsent(guide.methodKey, () => []).add(guide);
              }
              
              // 2. Add custom recipes (mapped to DTO)
              for (var cr in customList) {
                // Determine if this custom recipe belongs to an existing guide method or is a new one
                // For simplicity, we only show custom recipes that match guide method keys on these tiles
                if (grouped.containsKey(cr.methodKey)) {
                  grouped[cr.methodKey]!.add(BrewingRecipeDto(
                    id: cr.id.hashCode,
                    methodKey: cr.methodKey,
                    name: cr.name,
                    description: cr.notes,
                    imageUrl: '', 
                    category: cr.recipeType,
                    difficulty: 'Medium',
                    totalTimeSec: cr.extractionTimeSeconds,
                    tempC: cr.brewTempC,
                    ratioGramsPerMl: cr.brewRatio,
                    isGuide: false,
                  ));
                }
              }
              return grouped;
            }

            final espressoGrouped = groupByMethod(
              guideRecipes.where((r) => r.category == 'espresso').toList(),
              customRecipes,
            );
            final filterGrouped = groupByMethod(
              guideRecipes.where((r) => r.category != 'espresso').toList(),
              customRecipes,
            );

            final espressoMethods = espressoGrouped.values.toList();
            final filterMethods = filterGrouped.values.toList();

        return CustomScrollView(
          slivers: [
            // Top spacer (replaces padding.top)
            const SliverToBoxAdapter(child: SizedBox(height: 170)),

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
      },
    );
  }
}
