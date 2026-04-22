import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/dtos.dart';
import 'recipe_card.dart';

class MethodRecipesScreen extends StatelessWidget {
  final String methodKey;
  final String methodNameUk;
  final List<BrewingRecipeDto> recipes;

  const MethodRecipesScreen({
    super.key,
    required this.methodKey,
    required this.methodNameUk,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);
    const bg = Color(0xFF0A0908);

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: bg,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white10,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Спосіб заварювання',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: gold.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  methodNameUk,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gold.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Header Info Strip ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: gold.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.menu_book_rounded,
                            size: 13, color: Color(0xFFC8A96E)),
                        const SizedBox(width: 6),
                        Text(
                          '${recipes.length} ${_recipesLabel(recipes.length)}',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Recipe Cards ──────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RecipeCard(recipe: recipes[i]),
                ),
                childCount: recipes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _recipesLabel(int count) {
    if (count == 1) return 'рецепт';
    if (count >= 2 && count <= 4) return 'рецепти';
    return 'рецептів';
  }
}
