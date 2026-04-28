import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/database/dtos.dart';
import 'custom_recipe_list.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../navigation/navigation_providers.dart';
import '../../core/l10n/app_localizations.dart';

// ─── Method metadata (shared with BrewingGuideScreen) ──────────────────────────
const _methodMeta = {
  'v60': 'assets/images/methods/v60.webp',
  'chemex': 'assets/images/methods/chemex.webp',
  'aeropress': 'assets/images/methods/aeropress.webp',
  'espresso': 'assets/images/methods/espresso.webp',
  'cold_brew': 'assets/images/methods/cold_brew.webp',
};

class BrewingDetailScreen extends ConsumerStatefulWidget {
  final BrewingRecipeDto recipe;
  const BrewingDetailScreen({super.key, required this.recipe});

  @override
  ConsumerState<BrewingDetailScreen> createState() =>
      _BrewingDetailScreenState();
}

class _BrewingDetailScreenState extends ConsumerState<BrewingDetailScreen> {
  final _scrollController = ScrollController();
  bool _showTitleInAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      if (show != _showTitleInAppBar) {
        setState(() => _showTitleInAppBar = show);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Restore nav bar when leaving the screen
    Future.microtask(() {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(navBarVisibleProvider.notifier).show();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AddRecipeDialog(
              lotId: '',
              initialMethod: widget.recipe.methodKey,
            ),
          );
          if (result == true) {
            ref.invalidate(customRecipesForMethodProvider(widget.recipe.methodKey));
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        backgroundColor: const Color(0xFF0F0E0D),
        body: PremiumBackground(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerScrolled) => [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                title: _showTitleInAppBar
                    ? Text(
                        ref.t('alternative'),
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : null,
                centerTitle: true,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: const Color(0xFF0F0E0D).withValues(alpha: 0.6),
                      child: FlexibleSpaceBar(
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
                                    Colors.black87,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black45,
                                    Color(0xFF0F0E0D),
                                  ],
                                  stops: [0.0, 0.2, 0.6, 0.9, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 18),
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
                        // Invalidate both potential providers
                        ref.invalidate(customRecipesForMethodProvider(widget.recipe.methodKey));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline_rounded, color: Color(0xFFC8A96E), size: 20),
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
                        Text(
                          widget.recipe.description,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoPoint(
                              ref.t('recommended_roast'),
                              widget.recipe.methodKey.toLowerCase().contains('espresso') 
                                ? ref.t('roast_medium_dark') 
                                : ref.t('roast_light_medium'),
                              Icons.local_fire_department_rounded,
                            ),
                            const Spacer(),
                            _buildInfoPoint(
                              ref.t('flavor_profile_label'),
                              ref.t('profile_balanced'),
                              Icons.analytics_rounded,
                            ),
                          ],
                        ),
                      ],
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
            Text(
              label.toUpperCase(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: const Color(0xFFC8A96E),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
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
    final assetPath = _methodMeta[widget.recipe.methodKey] ?? 'assets/images/methods/v60.webp';

    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFC8A96E)),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(assetPath, fit: BoxFit.cover),
      );
    }
    
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }

    if (url.isNotEmpty) {
      return Image.file(File(url), fit: BoxFit.cover);
    }

    return Image.asset(assetPath, fit: BoxFit.cover);
  }
}

// ─── Sticky Header Delegate ──────────────────────────────────────────────────
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BrewingRecipeDto recipe;
  final String Function(String) t;

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
        return const Color(0xFFFF5722);
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
      case 'advanced':
        return t('difficulty_advanced');
      case 'master':
        return t('difficulty_master');
      default:
        return t('difficulty_med');
    }
  }

  String _getIntensityLabel(String? profile) {
    final p = (profile ?? '').toLowerCase();
    if (p.contains('light') || p.contains('легка')) {
      return t('intensity_light');
    } else if (p.contains('bold') || p.contains('сильна') || p.contains('strong')) {
      return t('intensity_bold');
    } else if (p.contains('medium') || p.contains('середня')) {
      return t('intensity_medium');
    }
    return profile ?? '';
  }

  @override
  double get minExtent => 140;
  @override
  double get maxExtent => 140;

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F0E0D).withValues(alpha: 0.4),
                const Color(0xFF0F0E0D).withValues(alpha: 0.8),
                const Color(0xFF0F0E0D),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                recipe.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 16),
              // Unified Stats Row
              Row(
                children: [
                  _HeaderStat(
                    icon: Icons.timer_outlined,
                    value: _formatTime(recipe.totalTimeSec ?? 180),
                    label: t('stat_time'),
                  ),
                  _HeaderDivider(),
                  _HeaderStat(
                    icon: Icons.balance_rounded,
                    value: '1:${(1 / (recipe.ratioGramsPerMl ?? 0.066)).toStringAsFixed(0)}',
                    label: t('stat_ratio'),
                    color: const Color(0xFFC8A96E),
                  ),
                  _HeaderDivider(),
                  _HeaderStat(
                    icon: Icons.bolt_rounded,
                    value: _getDifficultyLabel(recipe.difficulty),
                    label: t('difficulty_label'),
                    color: _getDifficultyColor(recipe.difficulty),
                  ),
                  _HeaderDivider(),
                  _HeaderStat(
                    icon: Icons.auto_awesome_rounded,
                    value: _getIntensityLabel(recipe.flavorProfile),
                    label: t('intensity'),
                    color: const Color(0xFF2DD4BF),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final int m = seconds ~/ 60;
    final int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) => true;
}

class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _HeaderStat({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.white;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 14, color: c.withValues(alpha: 0.8)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: c,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 8,
              color: Colors.white.withValues(alpha: 0.4),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.white.withValues(alpha: 0.08),
    );
  }
}
