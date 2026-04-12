import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/database/app_database.dart';
import '../../core/database/coffee_data_seed.dart';
import '../../shared/widgets/glass_container.dart';
import 'brewing_detail_screen.dart';
import 'method_recipes_screen.dart';

// ─── Method metadata ─────────────────────────────────────────────────────────
class _MethodMeta {
  final String name;
  final String nameUk;
  final String assetPath;
  final List<Color> gradient;
  final IconData icon;
  const _MethodMeta({
    required this.name,
    required this.nameUk,
    required this.assetPath,
    required this.gradient,
    this.icon = Icons.coffee_outlined,
  });
}

const _methodMeta = <String, _MethodMeta>{
  'v60': _MethodMeta(
    name: 'V60 Pour Over',
    nameUk: 'V60 Пур-овер',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/v60.png',
    gradient: [Color(0xFFD4A574), Color(0xFF8B5E3C)],
  ),
  'chemex': _MethodMeta(
    name: 'Chemex',
    nameUk: 'Chemex',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/chemex.png',
    gradient: [Color(0xFFE8D5B7), Color(0xFF9C7048)],
  ),
  'aeropress': _MethodMeta(
    name: 'Aeropress',
    nameUk: 'Аеропрес',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/aeropress.png',
    gradient: [Color(0xFFB8C4CC), Color(0xFF5A7A8A)],
  ),
  'french_press': _MethodMeta(
    name: 'French Press',
    nameUk: 'Французький прес',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/french_press.png',
    gradient: [Color(0xFFC8A96E), Color(0xFF7A5C2E)],
  ),
  'espresso': _MethodMeta(
    name: 'Espresso',
    nameUk: 'Еспресо',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/espresso.png',
    gradient: [Color(0xFF8B2635), Color(0xFF4A1520)],
  ),
  'clever': _MethodMeta(
    name: 'Clever Dripper',
    nameUk: 'Clever Dripper',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/clever_dripper.png', 
    gradient: [Color(0xFFB8860B), Color(0xFF556B2F)],
  ),
  'cold_brew': _MethodMeta(
    name: 'Cold Brew',
    nameUk: 'Холодна екстракція',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/cold_brew.png',
    gradient: [Color(0xFF4A90D9), Color(0xFF1A3A5C)],
    icon: Icons.ac_unit_outlined,
  ),
  'siphon': _MethodMeta(
    name: 'Siphon',
    nameUk: 'Сифон',
    assetPath: '${CoffeeDataSeed.bucketUrl}/methods/siphon.png',
    gradient: [Color(0xFF9370DB), Color(0xFF4B0082)],
    icon: Icons.science_outlined,
  ),
};

// ─── MethodTile ───────────────────────────────────────────────────────────────
class MethodTile extends StatelessWidget {
  final List<BrewingRecipe> methodRecipes;

  const MethodTile({
    super.key,
    required this.methodRecipes,
  });

  BrewingRecipe get _firstRecipe => methodRecipes.first;
  int get _count => methodRecipes.length;

  @override
  Widget build(BuildContext context) {
    final key = _firstRecipe.methodKey;
    final meta = _methodMeta[key] ??
        _MethodMeta(
          name: key.toUpperCase(),
          nameUk: meta.nameUk,
          assetPath: '${CoffeeDataSeed.bucketUrl}/methods/v60.png',
          gradient: const [Color(0xFFD4A574), Color(0xFF8B5E3C)],
        );

    return GestureDetector(
      onTap: () {
        if (_count > 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MethodRecipesScreen(
                methodKey: key,
                methodNameUk: meta.name, // Use English name
                recipes: methodRecipes,
              ),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BrewingDetailScreen(recipe: _firstRecipe),
            ),
          );
        }
      },
      child: _TileCard(meta: meta, count: _count, methodKey: key),
    );
  }
}

// ─── Card Visual ─────────────────────────────────────────────────────────────
class _TileCard extends StatelessWidget {
  final _MethodMeta meta;
  final int count;
  final String methodKey;

  const _TileCard({
    required this.meta,
    required this.count,
    required this.methodKey,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);

    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // ── Background image with gradient fallback ──────────────────
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: meta.assetPath,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: meta.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white24),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: meta.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(meta.icon, color: Colors.white24, size: 48),
                ),
              ),
            ),

            // ── Dark gradient bottom overlay ─────────────────────────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.35, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.88),
                    ],
                  ),
                ),
              ),
            ),

            // ── Top-right recipe count badge ─────────────────────────────
            if (count > 1)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: gold.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$count',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

            // ── Bottom content ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  Text(
                    meta.name,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Recipe count chip
                  _RecipeCountChip(count: count),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeCountChip extends StatelessWidget {
  final int count;
  const _RecipeCountChip({required this.count});

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? '1 рецепт'
        : count < 5
            ? '$count рецепти'
            : '$count рецептів';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.menu_book_rounded, size: 11, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
