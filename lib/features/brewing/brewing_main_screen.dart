import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../../shared/widgets/profile_button.dart';
import '../navigation/navigation_providers.dart';
import 'brewing_guide_screen.dart';
import 'custom_recipe_list.dart';
import 'method_tile.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../core/database/dtos.dart';
import '../../core/utils/responsive_utils.dart';

class BrewingViewModeNotifier extends Notifier<bool> {
  @override
  bool build() => true; // true = grid, false = list

  void toggle() => state = !state;
  void setMode(bool isGrid) => state = isGrid;
}

final brewingViewModeProvider = NotifierProvider<BrewingViewModeNotifier, bool>(
  () => BrewingViewModeNotifier(),
);

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
    _tabController.addListener(_handleTabChange);
    
    // Initial check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _tabController.index == 1) {
        ref.read(navBarVisibleProvider.notifier).hide();
      }
    });
  }

  void _handleTabChange() {
    if (!mounted) return;
    if (_tabController.index == 1) {
      ref.read(navBarVisibleProvider.notifier).hide();
    } else {
      ref.read(navBarVisibleProvider.notifier).show();
    }
    setState(() {}); // Rebuild for FAB visibility
  }

  @override
  void dispose() {
    // Force show nav bar when leaving the screen
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    _tabController.removeListener(_handleTabChange);
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
                onPressed: () =>
                    ref.read(brewingViewModeProvider.notifier).toggle(),
              );
            },
          ),
          const ProfileButton(),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          dividerColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: accentColor,
          ),
          tabs: [
            Tab(text: ref.t('brewing_methods')),
            Tab(text: ref.t('my_recipes')),
          ],
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _tabController,
        builder: (context, _) {
          final isNavVisible = ref.watch(navBarVisibleProvider);
          final navHeight = ref.watch(navBarHeightProvider);
          return _tabController.index == 1
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: isNavVisible ? navHeight + 8 : 16,
                  ),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => const AddRecipeDialog(
                          recipeSegment: RecipeSegment.alternative,
                        ),
                      );
                      if (result == true) {
                        ref.invalidate(alternativeRecipesProvider);
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
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Alternative wall.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: const [_BrewingMethodsContent(), GlobalCustomRecipeList()],
          ),
        ],
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
                // HARD FILTER: Encyclopedia recipes MUST NOT appear here
                if (cr.segment == RecipeSegment.encyclopedia) {
                  debugPrint(
                    'BrewingMainScreen: Filtering out encyclopedia recipe: ${cr.name} (ID: ${cr.id})',
                  );
                  continue;
                }

                // Determine if this custom recipe belongs to an existing guide method or is a new one
                if (grouped.containsKey(cr.methodKey)) {
                  grouped[cr.methodKey]!.add(
                    BrewingRecipeDto(
                      id: cr.id.hashCode,
                      methodKey: cr.methodKey,
                      name: cr.name,
                      description: cr.notes,
                      contentHtml: cr.contentHtml,
                      imageUrl: '',
                      category: cr.recipeType,
                      difficulty: cr.difficulty ?? 'Intermediate',
                      totalTimeSec: cr.extractionTimeSeconds,
                      tempC: cr.brewTempC,
                      ratioGramsPerMl: cr.brewRatio,
                      coffeeGrams: cr.coffeeGrams,
                      isGuide: false,
                    ),
                  );
                }
              }
              return grouped;
            }

            final allGrouped = groupByMethod(guideRecipes, customRecipes);

            // Convert to list of method groups
            final allMethods = allGrouped.values.toList();

            // Sort by sortOrder of the guide recipe in each group
            allMethods.sort((a, b) {
              final sortA = a
                  .firstWhere((r) => r.isGuide, orElse: () => a.first)
                  .sortOrder;
              final sortB = b
                  .firstWhere((r) => r.isGuide, orElse: () => b.first)
                  .sortOrder;
              return sortA.compareTo(sortB);
            });

            return CustomScrollView(
              slivers: [
                // Top spacer (replaces padding.top)
                const SliverToBoxAdapter(child: SizedBox(height: 170)),

                if (allMethods.isNotEmpty) ...[
                  if (isGrid)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (c, i) => MethodTile(methodRecipes: allMethods[i]),
                          childCount: allMethods.length,
                        ),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.gridColumnCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (c, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MethodTile(methodRecipes: allMethods[i]),
                          ),
                          childCount: allMethods.length,
                        ),
                      ),
                    ),
                ],

                // Bottom spacer for navbar
                SliverToBoxAdapter(child: SizedBox(height: navHeight + 20)),
              ],
            );
          },
        );
      },
    );
  }
}
