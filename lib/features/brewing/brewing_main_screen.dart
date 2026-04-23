import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/add_recipe_dialog.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/profile_button.dart';
import '../navigation/navigation_providers.dart';
import 'brewing_guide_screen.dart';
import 'custom_recipe_list.dart';
import 'method_tile.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../core/database/dtos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

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
  bool _isSelectingType = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
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
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: PremiumAppBar(
        title: ref.t('brewing'),
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
      floatingActionButton: _isSelectingType || _tabController.index == 0 ? null : Padding(
        padding: EdgeInsets.only(bottom: ref.watch(navBarHeightProvider) + 48),
        child: _buildAddRecipeFab(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: TabBarView(
        controller: _tabController,
        children: const [_BrewingMethodsContent(), GlobalCustomRecipeList()],
      ),
    );
  }

  Widget _buildAddRecipeFab(BuildContext context) {
    return AnimatedSlide(
      offset: const Offset(0, 0),
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => _showRecipeTypeSelection(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFC8A96E),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC8A96E).withValues(alpha: 0.35),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add_rounded, color: Colors.black, size: 20),
              const SizedBox(width: 8),
              Text(
                'ДОДАТИ РЕЦЕПТ',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRecipeTypeSelection(BuildContext context) {
    setState(() => _isSelectingType = true);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1D1B1A).withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 0.5),
          ),
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Оберіть тип заварювання',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildTypeOption(
                    context,
                    'ФІЛЬТР',
                    Icons.water_drop_rounded,
                    () => _handleTypeSelected('filter'),
                  ),
                  const SizedBox(width: 16),
                  _buildTypeOption(
                    context,
                    'ЕСПРЕСО',
                    Icons.coffee_maker_rounded,
                    () => _handleTypeSelected('espresso'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      if (mounted) setState(() => _isSelectingType = false);
    });
  }

  Widget _buildTypeOption(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFFC8A96E), size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTypeSelected(String type) async {
    Navigator.pop(context);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddRecipeDialog(
        lotId: '',
        initialMethod: type == 'espresso' ? 'espresso' : 'v60',
      ),
    );
    if (result == true) {
      ref.invalidate(globalCustomRecipesProvider);
    }
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 8),
                    child: Text(
                      'ЕСПРЕСО',
                      style: GoogleFonts.outfit(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 8),
                    child: Text(
                      'ФІЛЬТР',
                      style: GoogleFonts.outfit(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
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
