import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:flutter_html/flutter_html.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import 'custom_recipe_list.dart';
import '../../core/database/dtos.dart';
import '../../core/utils/text_processor.dart';
import '../../shared/widgets/modals/description_glass_modal.dart';
import 'brewing_guide_screen.dart';
import '../navigation/navigation_providers.dart';
import '../../core/utils/responsive_utils.dart';


class BrewingDetailScreen extends ConsumerStatefulWidget {
  final BrewingRecipeDto recipe;

  const BrewingDetailScreen({super.key, required this.recipe});

  @override
  ConsumerState<BrewingDetailScreen> createState() =>
      _BrewingDetailScreenState();
}

class _BrewingDetailScreenState extends ConsumerState<BrewingDetailScreen> {
  void _showFullDescription(BuildContext context, BrewingRecipeDto recipe) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) {
        return DescriptionGlassModal(
          title: ref.t('about_method'),
          content: recipe.description,
          contentHtml: recipe.contentHtml,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim1),
            child: child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Restore nav bar when leaving
    Future.microtask(() {
      if (mounted) {
        ref.read(navBarVisibleProvider.notifier).show();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(brewingRecipesProvider);
    final currentRecipe =
        recipesAsync.whenOrNull(
          data:
              (list) => list.where(
                (r) => r.methodKey == widget.recipe.methodKey,
              ).firstOrNull,
        ) ??
        widget.recipe;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final double expandedHeight = math.min(screenWidth * 1.0, 950.0);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF0A0A0A)],
          ),
        ),
        child: SafeArea(
          top: false,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: expandedHeight,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildHeroImage(currentRecipe.imageUrl),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: context.isTablet ? 40 : 20,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Golden Tablet Header
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC8A96E),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFC8A96E,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  currentRecipe.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Icon(Icons.add_rounded, color: Colors.white),
                    ),
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AddRecipeDialog(
                          lotId: '',
                          initialMethod: widget.recipe.methodKey,
                          recipeSegment: RecipeSegment.alternative,
                        ),
                      );
                      if (result == true) {
                        ref.invalidate(
                          alternativeRecipesForMethodProvider(
                            widget.recipe.methodKey,
                          ),
                        );
                        ref.invalidate(globalCustomRecipesProvider);
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  recipe: currentRecipe,
                  t: ref.t,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About Method Header
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFFC8A96E),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ref.t('about_method').toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFC8A96E),
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Spacer(),
                          if (currentRecipe.description.length > 100 ||
                              (currentRecipe.contentHtml?.isNotEmpty ?? false))
                            GestureDetector(
                              onTap: () => _showFullDescription(context, currentRecipe),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(
                                    alpha: 0.05,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.open_in_full_rounded,
                                  color: Color(0xFFC8A96E),
                                  size: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Description or Content HTML
                          if (currentRecipe.contentHtml?.isNotEmpty ?? false)
                            Html(
                              data: CoffeeTextProcessor.process(
                                currentRecipe.contentHtml ?? '',
                              ),
                              style:
                                  CoffeeTextProcessor.getHtmlStyles(
                                    baseFontSize: 15,
                                  )..addAll({
                                    'html': Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                    ),
                                    'body': Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                      fontSize: FontSize(15),
                                      lineHeight: const LineHeight(1.6),
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      fontFamily: 'Outfit',
                                      maxLines: 3,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  }),
                            )
                          else if (currentRecipe.description.isNotEmpty)
                            Text(
                              currentRecipe.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                color: Colors.white.withValues(alpha: 0.7),
                                height: 1.6,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
            body: Transform.translate(
              offset: const Offset(0, -25),
              child: CustomRecipeListTab(
                methodKey: widget.recipe.methodKey,
                showFab: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String url) {
    if (url.isEmpty) {
      return Container(color: Colors.black);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.black,
        child: const Icon(
          Icons.coffee_rounded,
          color: Colors.white24,
          size: 64,
        ),
      ),
    );
  }
}

int _getDifficultyStars(String? difficulty) {
  final d = (difficulty ?? 'intermediate').toLowerCase().trim();
  switch (d) {
    case '1':
    case 'easy':
    case 'beginner':
      return 1;
    case '2':
    case 'medium':
    case 'intermediate':
      return 2;
    case '3':
    case 'hard':
    case 'advanced':
      return 3;
    case '4':
    case 'expert':
      return 4;
    case '5':
    case 'master':
      return 5;
    default:
      final n = int.tryParse(d);
      if (n != null && n >= 1 && n <= 5) return n;
      return 2;
  }
}

Color _getDifficultyColor(String? difficulty) {
  final d = (difficulty ?? 'intermediate').toLowerCase().trim();
  switch (d) {
    case '1':
    case 'easy':
    case 'beginner':
      return const Color(0xFF00FF88);
    case '2':
    case 'intermediate':
    case 'medium':
      return const Color(0xFFFFEE00);
    case '3':
    case 'advanced':
    case 'hard':
      return const Color(0xFFFF3333);
    case '4':
    case 'expert':
      return const Color(0xFFFF3366);
    case '5':
    case 'master':
      return const Color(0xFFCC00FF);
    default:
      return const Color(0xFFFFEE00);
  }
}

String _getDifficultyLabel(
  String? difficulty,
  String Function(String, {Map<String, String>? args}) t,
) {
  final d = (difficulty ?? 'intermediate').toLowerCase().trim();
  switch (d) {
    case '1':
    case 'easy':
    case 'beginner':
      return t('difficulty_beginner');
    case '2':
    case 'medium':
    case 'intermediate':
      return t('difficulty_intermediate');
    case '3':
    case 'hard':
    case 'advanced':
      return t('difficulty_advanced');
    case '4':
    case 'expert':
      return t('difficulty_expert');
    case '5':
    case 'master':
      return t('difficulty_master');
    default:
      final n = int.tryParse(d);
      if (n == 1) return t('difficulty_beginner');
      if (n == 2) return t('difficulty_intermediate');
      if (n == 3) return t('difficulty_advanced');
      if (n == 4) return t('difficulty_expert');
      if (n == 5) return t('difficulty_master');
      return t('difficulty_intermediate');
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BrewingRecipeDto recipe;
  final String Function(String, {Map<String, String>? args}) t;

  _StickyHeaderDelegate({required this.recipe, required this.t});

  String _formattedTime() {
    final s = recipe.totalTimeSec ?? 0;
    if (s >= 3600) return '${(s / 3600).toStringAsFixed(1)} h';
    final minutes = s ~/ 60;
    final seconds = s % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A).withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, bottom: 4),
                child: Text(
                  t('stat_base_characteristics').toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white38,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _HeaderStat(
                        icon: Icons.timer_outlined,
                        value: _formattedTime(),
                        label: t('stat_time'),
                        color: const Color(0xFF00E5FF), // Neon Cyan
                      ),
                    ),
                    Expanded(
                      child: _HeaderStat(
                        icon: Icons.thermostat_rounded,
                        value: '${recipe.tempC?.toInt() ?? 0}°C',
                        label: t('stat_temp'),
                        color: const Color(0xFFFF5252), // Neon Red
                      ),
                    ),
                    Expanded(
                      child: _HeaderStat(
                        icon: Icons.coffee_rounded,
                        value:
                            '${recipe.coffeeGrams != null ? (recipe.coffeeGrams! % 1 == 0 ? recipe.coffeeGrams!.toInt() : recipe.coffeeGrams) : 0}${t('grams')}',
                        label: t('stat_coffee'),
                        color: const Color(0xFFFFD740), // Neon Amber
                      ),
                    ),
                    Expanded(
                      child: _HeaderStat(
                        icon: Icons.water_drop_rounded,
                        value:
                            '${recipe.weight != null ? (recipe.weight! % 1 == 0 ? recipe.weight!.toInt() : recipe.weight) : 0}${t('grams')}',
                        label: t('stat_yield'),
                        color: const Color(0xFF69F0AE), // Neon Green
                      ),
                    ),
                    Expanded(
                      child: _HeaderStat(
                        icon: Icons.bolt_rounded,
                        value: '',
                        customValue: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                final stars = _getDifficultyStars(
                                  recipe.difficulty,
                                );
                                final color = _getDifficultyColor(
                                  recipe.difficulty,
                                );
                                return Icon(
                                  index < stars
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 9,
                                  color: index < stars
                                      ? color
                                      : color.withValues(alpha: 0.2),
                                );
                              }),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getDifficultyLabel(recipe.difficulty, t),
                              style: GoogleFonts.outfit(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _getDifficultyColor(recipe.difficulty),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        label: t('stat_difficulty'),
                        color: _getDifficultyColor(recipe.difficulty),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 130;
  @override
  double get minExtent => 130;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Widget? customValue;
  final String label;
  final Color color;

  const _HeaderStat({
    required this.icon,
    required this.value,
    this.customValue,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.02),
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: 0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
            shadows: [
              Shadow(color: color.withValues(alpha: 0.5), blurRadius: 8),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child:
              customValue ??
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color,
                  shadows: [
                    Shadow(color: color.withValues(alpha: 0.4), blurRadius: 6),
                  ],
                ),
              ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.white38,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}
