import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/dtos.dart';
import 'recipe_card.dart';
import '../navigation/navigation_providers.dart';
import '../../core/l10n/app_localizations.dart';

class MethodRecipesScreen extends ConsumerStatefulWidget {
  final String methodKey;
  final String methodName;
  final List<BrewingRecipeDto> recipes;

  const MethodRecipesScreen({
    super.key,
    required this.methodKey,
    required this.methodName,
    required this.recipes,
  });

  @override
  ConsumerState<MethodRecipesScreen> createState() =>
      _MethodRecipesScreenState();
}

class _MethodRecipesScreenState extends ConsumerState<MethodRecipesScreen> {
  @override
  void dispose() {
    // Restore nav bar when leaving the screen
    Future.microtask(() {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);
    const bg = Colors.black;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(navBarVisibleProvider.notifier).show();
        }
      },
      child: Scaffold(
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
                    ref.t('brewing_method'),
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      color: gold.withValues(alpha: 0.7),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    widget.methodName,
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
                      colors: [gold.withValues(alpha: 0.4), Colors.transparent],
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
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: gold.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.menu_book_rounded,
                            size: 13,
                            color: Color(0xFFC8A96E),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.recipes.length} ${_getPluralLabel(ref, widget.recipes.length)}',
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
                    child: RecipeCard(recipe: widget.recipes[i]),
                  ),
                  childCount: widget.recipes.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPluralLabel(WidgetRef ref, int count) {
    final String key = count == 1
        ? 'recipe_1'
        : (count >= 2 && count <= 4)
        ? 'recipe_2_4'
        : 'recipe_5_plus';
    return ref.t(key);
  }
}
