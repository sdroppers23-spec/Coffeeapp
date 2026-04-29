import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:flutter_html/flutter_html.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import 'custom_recipe_list.dart';
import '../../core/database/dtos.dart';
import '../../core/utils/text_processor.dart';

class BrewingDetailScreen extends ConsumerStatefulWidget {
  final BrewingRecipeDto recipe;

  const BrewingDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  ConsumerState<BrewingDetailScreen> createState() => _BrewingDetailScreenState();
}

class _BrewingDetailScreenState extends ConsumerState<BrewingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 280,
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
                      _buildHeroImage(widget.recipe.imageUrl),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC8A96E),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.recipe.methodKey.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.recipe.name,
                              style: GoogleFonts.outfit(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
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
                        ),
                      );
                      if (result == true) {
                        ref.invalidate(
                          customRecipesForMethodProvider(
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
                  recipe: widget.recipe,
                  t: ref.t,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFFC8A96E),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ref.t('about_method').toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFC8A96E),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (widget.recipe.contentHtml != null &&
                          widget.recipe.contentHtml!.isNotEmpty) ...[
                        Html(
                          data: CoffeeTextProcessor.process(
                            widget.recipe.contentHtml!,
                          ),
                          style: {
                            'body': Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              fontSize: FontSize(15),
                              lineHeight: const LineHeight(1.6),
                              color: Colors.white.withValues(alpha: 0.8),
                              fontFamily: GoogleFonts.outfit().fontFamily,
                            ),
                            'strong': Style(
                              color: const Color(0xFFC8A96E),
                              fontWeight: FontWeight.w700,
                            ),
                          },
                        ),
                        const SizedBox(height: 24),
                      ] else if (widget.recipe.description.isNotEmpty) ...[
                        Text(
                          widget.recipe.description,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoPoint(
                              ref.t('recommended_roast'),
                              widget.recipe.methodKey.toLowerCase().contains('espresso')
                                  ? ref.t('roast_medium_dark')
                                  : ref.t('roast_light_medium'),
                              Icons.local_fire_department_rounded,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildInfoPoint(
                              ref.t('flavor_profile_label'),
                              ref.t('profile_balanced'),
                              Icons.analytics_rounded,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: CustomRecipeListTab(
              methodKey: widget.recipe.methodKey,
              showFab: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPoint(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFFC8A96E), size: 14),
            const SizedBox(width: 6),
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  label.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: const Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(String url) {
    if (url.isEmpty) {
      return Container(color: Colors.black);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.black,
        child: const Icon(Icons.coffee_rounded, color: Colors.white24, size: 64),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BrewingRecipeDto recipe;
  final String Function(String, {Map<String, String>? args}) t;

  _StickyHeaderDelegate({
    required this.recipe,
    required this.t,
  });

  String _formattedTime() {
    final s = recipe.totalTimeSec ?? 0;
    if (s >= 3600) return '${(s / 3600).toStringAsFixed(1)} h';
    final minutes = s ~/ 60;
    final seconds = s % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String get _formattedRatio {
    final r = recipe.ratioGramsPerMl ?? 0.0;
    if (r > 0 && r.isFinite) {
      final inverse = (1 / r).round();
      return '1:$inverse';
    }
    return '—';
  }

  String _getDifficultyLabel(String? difficulty) {
    switch ((difficulty ?? 'Medium').toLowerCase()) {
      case 'easy':
      case 'beginner':
        return t('difficulty_easy');
      case 'medium':
      case 'intermediate':
        return t('difficulty_med');
      case 'hard':
        return t('difficulty_hard');
      case 'advanced':
        return t('difficulty_advanced');
      case 'master':
        return t('difficulty_master');
      default:
        return t('difficulty_med');
    }
  }

  Color _getDifficultyColor(String? difficulty) {
    switch ((difficulty ?? 'Medium').toLowerCase()) {
      case 'easy':
      case 'beginner':
        return const Color(0xFF00FF88); // Neon Emerald
      case 'medium':
      case 'intermediate':
        return const Color(0xFFFFEE00); // Neon Yellow
      case 'hard':
        return const Color(0xFFFF3366); // Neon Pink/Red
      case 'advanced':
        return const Color(0xFFCC00FF); // Neon Purple
      case 'master':
        return const Color(0xFF00D1FF); // Neon Sky Blue
      default:
        return const Color(0xFFFFEE00);
    }
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
          height: 105,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A).withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: Padding(
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
                    value: '${recipe.coffeeGrams?.toInt() ?? 0}g',
                    label: t('stat_coffee'),
                    color: const Color(0xFFFFD740), // Neon Amber
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.balance_rounded,
                    value: _formattedRatio,
                    label: t('stat_ratio'),
                    color: const Color(0xFF69F0AE), // Neon Green
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.bolt_rounded,
                    value: _getDifficultyLabel(recipe.difficulty),
                    label: t('difficulty_label'),
                    color: _getDifficultyColor(recipe.difficulty),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 105;
  @override
  double get minExtent => 105;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _HeaderStat({
    required this.icon,
    required this.value,
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
              Shadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
              shadows: [
                Shadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 6,
                ),
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


