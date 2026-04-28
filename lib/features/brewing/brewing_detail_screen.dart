import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import 'widgets/custom_recipe_card.dart';
import 'widgets/custom_recipe_list_tab.dart';
import '../../core/database/app_database.dart';
import '../../shared/providers/recipe_provider.dart';

class BrewingDetailScreen extends ConsumerStatefulWidget {
  final Recipe recipe;

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1412),
              const Color(0xFF0A0A0A),
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
                backgroundColor: const Color(0xFF1A1412),
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
                      if (widget.recipe.description.isNotEmpty) ...[
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
              child: Text(
                label.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: const Color(0xFFC8A96E),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(String url) {
    if (url.isEmpty) {
      return Container(color: const Color(0xFF1A1412));
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFF1A1412),
        child: const Icon(Icons.coffee_rounded, color: Colors.white24, size: 64),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Recipe recipe;
  final String Function(String, {Map<String, dynamic>? args}) t;

  _StickyHeaderDelegate({required this.recipe, required this.t});

  Color _getDifficultyColor(String? difficulty) {
    switch ((difficulty ?? 'Medium').toLowerCase()) {
      case 'easy':
      case 'beginner':
        return const Color(0xFF4CAF50);
      case 'medium':
      case 'intermediate':
        return const Color(0xFFFFC107);
      case 'hard':
        return const Color(0xFFF44336);
      case 'pro':
      case 'advanced':
        return const Color(0xFFE91E63);
      case 'master':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFFFFC107);
    }
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
      case 'pro':
      case 'advanced':
        return t('difficulty_advanced');
      case 'master':
        return t('difficulty_master');
      default:
        return t('difficulty_med');
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
          height: 90,
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.timer_outlined,
                    value: '${recipe.extractionTimeSeconds ~/ 60}:${(recipe.extractionTimeSeconds % 60).toString().padLeft(2, '0')}',
                    label: t('stat_time'),
                    color: Colors.white,
                  ),
                ),
                _HeaderDivider(),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.thermostat_rounded,
                    value: '${recipe.brewTempC.toInt()}°C',
                    label: t('stat_temp'),
                    color: const Color(0xFFFFAB91),
                  ),
                ),
                _HeaderDivider(),
                Expanded(
                  child: _HeaderStat(
                    icon: Icons.balance_rounded,
                    value: '1:${(1 / (recipe.ratioGramsPerMl ?? 0.066)).toStringAsFixed(1)}',
                    label: t('stat_ratio'),
                    color: const Color(0xFFC8A96E),
                  ),
                ),
                _HeaderDivider(),
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
  double get maxExtent => 90;
  @override
  double get minExtent => 90;
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
        Icon(icon, size: 18, color: color.withValues(alpha: 0.7)),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.white38,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.white10,
    );
  }
}
