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
  'v60': 'assets/images/methods/v60.png',
  'chemex': 'assets/images/methods/chemex.png',
  'aeropress': 'assets/images/methods/aeropress.png',
  'espresso': 'assets/images/methods/espresso.png',
  'cold_brew': 'assets/images/methods/cold_brew.png',
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
    final assetPath = _methodMeta[widget.recipe.methodKey] ?? 'assets/images/methods/v60.png';

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

  @override
  double get minExtent => 160;
  @override
  double get maxExtent => 160;

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
                const Color(0xFF0F0E0D).withValues(alpha: 0.7),
                const Color(0xFF0F0E0D).withValues(alpha: 0.9),
                const Color(0xFF0F0E0D),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36, // Slightly smaller for sticky
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                width: 1,
              ),
              color: const Color(0xFF1A1918).withValues(alpha: 0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ParameterItem(
                  label: t('ratio'),
                  value:
                      '1:${(1 / (recipe.ratioGramsPerMl ?? 0.066)).toStringAsFixed(0)}',
                ),
                _ParameterItem(
                  label: t('timer'),
                  value: _formatTime(recipe.totalTimeSec ?? 180),
                ),
                _ParameterItem(
                  label: t('difficulty'),
                  value: recipe.difficulty ?? t('difficulty_med'),
                ),
                _ParameterItem(
                  label: t('intensity'),
                  value: recipe.flavorProfile ?? t('balanced'),
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

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) => true;
}

// ─── Parameter Item ──────────────────────────────────────────────────────────
class _ParameterItem extends StatelessWidget {
  final String label;
  final String value;
  const _ParameterItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 9,
            color: const Color(0xFFC8A96E),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
