import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/database/dtos.dart';
import 'custom_recipe_list.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../navigation/navigation_providers.dart';

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

  @override
  void dispose() {
    // Restore nav bar when leaving the screen
    Future.microtask(() {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
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
        body: PremiumBackground(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerScrolled) => [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
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
                              Colors.black54,
                              Colors.transparent,
                              Colors.black87,
                            ],
                            stops: [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ],
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddRecipeDialog(
                          lotId: '',
                          initialMethod: widget.recipe.methodKey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recipe.name,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
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
                    ],
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
