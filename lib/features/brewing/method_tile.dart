import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import '../../core/l10n/app_localizations.dart';
import 'brewing_detail_screen.dart';
import 'method_recipes_screen.dart';
import '../navigation/navigation_providers.dart';

// ─── Method metadata ─────────────────────────────────────────────────────────
// ─── MethodTile ───────────────────────────────────────────────────────────────
class MethodTile extends ConsumerWidget {
  final List<BrewingRecipeDto> methodRecipes;

  const MethodTile({
    super.key,
    required this.methodRecipes,
  });

  BrewingRecipeDto get _firstRecipe => methodRecipes.first;
  int get _count => methodRecipes.length;

  String _getEffectiveName(BuildContext context) {
    return _firstRecipe.name;
  }

  String _getEffectiveImageUrl() {
    final raw = _firstRecipe.imageUrl;
    if (raw.isEmpty) return '';
    if (raw.startsWith('http')) return raw;
    if (raw.startsWith('assets/')) return raw;
    
    // Resolved from 'Methods' bucket
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/Methods/$raw';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = _getEffectiveName(context);
    final imageUrl = _getEffectiveImageUrl();
    
    // Default gradient based on key if available, else standard gold
    final List<Color> gradient = _getGradient(_firstRecipe.methodKey);

    return GestureDetector(
      onTap: () {
        // Hide nav bar when entering detail view
        ref.read(navBarVisibleProvider.notifier).hide();
        
        if (_count > 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MethodRecipesScreen(
                methodKey: _firstRecipe.methodKey,
                methodName: name, 
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
      child: GlassContainer(
        borderRadius: 24,
        height: 190,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background Image ───────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white24),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(_getIcon(_firstRecipe.methodKey),
                            color: Colors.white24, size: 48),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(_getIcon(_firstRecipe.methodKey),
                          color: Colors.white24, size: 48),
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


            // ── Bottom content ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  Text(
                    name,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Recipe count chip - only show if user has custom recipes
                  if (methodRecipes.any((r) => !r.isGuide))
                    _RecipeCountChip(
                      count: methodRecipes.where((r) => !r.isGuide).length,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradient(String key) {
    switch (key.toLowerCase()) {
      case 'v60': return [const Color(0xFFD4A574), const Color(0xFF8B5E3C)];
      case 'chemex': return [const Color(0xFFE8D5B7), const Color(0xFF9C7048)];
      case 'aeropress': return [const Color(0xFFB8C4CC), const Color(0xFF5A7A8A)];
      case 'french_press': return [const Color(0xFFC8A96E), const Color(0xFF7A5C2E)];
      case 'espresso': return [const Color(0xFF8B2635), const Color(0xFF4A1520)];
      case 'clever': return [const Color(0xFFB8860B), const Color(0xFF556B2F)];
      case 'siphon': return [const Color(0xFF9370DB), const Color(0xFF4B0082)];
      default: return [const Color(0xFF2C2C2E), const Color(0xFF1C1C1E)];
    }
  }

  IconData _getIcon(String key) {
    switch (key.toLowerCase()) {
      case 'cold_brew': return Icons.ac_unit_outlined;
      case 'siphon': return Icons.science_outlined;
      case 'aeropress': return Icons.compress_outlined;
      default: return Icons.coffee_outlined;
    }
  }
}

class _RecipeCountChip extends ConsumerWidget {
  final int count;
  const _RecipeCountChip({required this.count});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customCount = count; // Actually, I should pass the pre-filtered count or filter here
    // Wait, MethodTile passes methodRecipes.length to _RecipeCountChip.
    // I should probably change what MethodTile passes.
    
    if (customCount == 0) return const SizedBox.shrink();

    final String pluralKey = customCount == 1
        ? 'recipe_1'
        : (customCount >= 2 && customCount <= 4)
            ? 'recipe_2_4'
            : 'recipe_5_plus';
    final label = '$customCount ${ref.t(pluralKey)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
