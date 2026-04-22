import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/database/dtos.dart';
import 'custom_recipe_list.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';

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

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get _formattedRatio {
    final ratio = widget.recipe.ratioGramsPerMl ?? 0.0;
    if (ratio >= 1) return '1:${(1 / ratio).toStringAsFixed(0)}';
    return '${(ratio * 100).toStringAsFixed(0)}g per 100ml';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PremiumBackground(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => [
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
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
                    }
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.recipe.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      const Shadow(blurRadius: 10, color: Colors.black45),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildHeroImage(widget.recipe.imageUrl),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: GlassContainer(
                  padding: const EdgeInsets.all(16),
                  opacity: 0.1,
                  blur: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoChip(
                        icon: Icons.thermostat_outlined,
                        label: '${widget.recipe.tempC?.toInt() ?? 0}°C',
                      ),
                      _InfoChip(
                        icon: Icons.balance_outlined,
                        label: _formattedRatio,
                      ),
                      _InfoChip(
                        icon: Icons.timer_outlined,
                        label: _formatTime(widget.recipe.totalTimeSec ?? 0),
                      ),
                      _InfoChip(
                        icon: Icons.signal_cellular_alt_outlined,
                        label: widget.recipe.difficulty ?? 'Medium',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: CustomRecipeListTab(
            methodKey: widget.recipe.methodKey,
            showFab: true,
          ),
        ),
      ),
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

// ─── Info Chip ────────────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFC8A96E), size: 20),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
