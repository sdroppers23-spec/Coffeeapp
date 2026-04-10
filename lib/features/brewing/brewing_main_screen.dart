import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/profile_button.dart';
import '../navigation/main_scaffold.dart';
import 'brewing_guide_screen.dart';
import 'custom_recipe_list.dart';
import 'method_tile.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(105),
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.15),
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                ref.t('recipes'),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 22,
                ),
              ),
              actions: const [ProfileButton()],
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
                      color: const Color(0xFFC8A96E),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    unselectedLabelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    tabs: [
                      Tab(text: ref.t('alternative')),
                      Tab(text: ref.t('my_recipes')),
                    ],
                  ),
                ),
              ),
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
            childAspectRatio: 0.78,
          ),
          itemCount: recipes.length,
          itemBuilder: (context, i) => MethodTile(recipe: recipes[i]),
        );
      },
    );
  }
}
