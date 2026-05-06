import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../core/database/dtos.dart';
import '../navigation/navigation_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/widgets/scroll_to_top_button.dart';
import '../../core/utils/text_processor.dart';

class FarmerDetailScreen extends ConsumerStatefulWidget {
  final LocalizedFarmerDto farmer;

  const FarmerDetailScreen({super.key, required this.farmer});

  @override
  ConsumerState<FarmerDetailScreen> createState() => _FarmerDetailScreenState();
}

class _FarmerDetailScreenState extends ConsumerState<FarmerDetailScreen> {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  late final ScrollController _scrollController;

  @override
  void dispose() {
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);
    const bg = Colors.black;

    // Build unified Bio from description + story
    final bio = _buildBio(widget.farmer.description, widget.farmer.story);

    final screenWidth = MediaQuery.sizeOf(context).width;
    final double expandedHeight = math.min(screenWidth * 1.0, 950.0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.read(navBarVisibleProvider.notifier).show();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: bg,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Hero Portrait ─────────────────────────────────────────────────
                SliverAppBar(
                  expandedHeight: expandedHeight,
                  backgroundColor: Colors.black,
                  surfaceTintColor: Colors.transparent, // Fix white sheet
                  systemOverlayStyle:
                      SystemUiOverlayStyle.light, // Fix status bar icons
                  elevation: 0,
                  pinned: true,
                  leading: IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    onPressed: () {
                      ref.read(navBarVisibleProvider.notifier).show();
                      Navigator.of(context).pop();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (widget.farmer.effectiveImageUrl.isNotEmpty)
                          _LocalOrNetworkImage(
                            url: widget.farmer.effectiveImageUrl,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                        else
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.black, Colors.black],
                              ),
                            ),
                          ),
                        // Multi-stop gradient overlay for seamless blending
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black45,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black, // Match BG
                              ],
                              stops: [
                                0.0,
                                0.15,
                                0.5,
                                1.0,
                              ], // Deeper bottom fade
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Farmer Info ───────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Location pill
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: widget.farmer.effectiveFlagUrl,
                                width: 30,
                                height: 20,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Container(color: Colors.white10),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.public,
                                      size: 20,
                                      color: Colors.white24,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: gold.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: gold.withValues(alpha: 0.45),
                                  ),
                                ),
                                child: Text(
                                  '${widget.farmer.country}, ${widget.farmer.region}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: gold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Farmer Name
                        Text(
                          widget.farmer.name,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 46,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 0.95,
                          ),
                        ),

                        if (widget.farmer.description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            widget.farmer.description,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: gold.withValues(alpha: 0.85),
                            ),
                          ),
                        ],

                        // Divider
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gold.withValues(alpha: 0.5),
                                gold.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),

                        if (bio.isNotEmpty)
                          Html(
                            data: CoffeeTextProcessor.process(bio),
                            style: {
                              'body': Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(16.5),
                                lineHeight: const LineHeight(1.78),
                                color: Colors.white.withValues(alpha: 0.88),
                                fontFamily: GoogleFonts.outfit().fontFamily,
                              ),
                              'h1,h2,h3': Style(
                                color: gold,
                                fontFamily:
                                    GoogleFonts.cormorantGaramond().fontFamily,
                                margin: Margins.only(top: 24, bottom: 12),
                              ),
                              'h1': Style(
                                fontSize: FontSize(30),
                                fontWeight: FontWeight.w700,
                              ),
                              'h2': Style(
                                fontSize: FontSize(24),
                                fontWeight: FontWeight.w600,
                              ),
                              'h3': Style(
                                fontSize: FontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                              'p': Style(margin: Margins.only(bottom: 16)),
                              'strong': Style(
                                color: gold,
                                fontWeight: FontWeight.w700,
                              ),
                              '.coffee-serif': Style(
                                fontFamily:
                                    GoogleFonts.cormorantGaramond().fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                              '.coffee-gold': Style(
                                color: gold,
                                fontWeight: FontWeight.bold,
                              ),
                              '.coffee-accent': Style(
                                color: gold.withValues(alpha: 0.5),
                              ),
                              '.coffee-accent-gold': Style(
                                color: gold, // Solid gold for better contrast
                                fontWeight: FontWeight.bold,
                              ),
                              'ol, ul': Style(
                                margin: Margins.only(top: 16, bottom: 16),
                                padding: HtmlPaddings.only(left: 4),
                              ),
                              'li': Style(
                                fontSize: FontSize(16.5),
                                lineHeight: const LineHeight(1.6),
                                margin: Margins.only(bottom: 8),
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              'li::marker': Style(
                                color: gold,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize(18), // Larger numbering
                              ),
                            },
                          ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ScrollToTopButton(
              scrollController: _scrollController,
              threshold: 400,
            ),
          ],
        ),
      ),
    );
  }

  /// Combines description + story into one coherent Markdown document.
  String _buildBio(String description, String story) {
    final s = story.trim();
    final d = description.trim();

    // If story is empty or identical to description, fall back to description
    if (s.isEmpty || s == d) return d;

    // Otherwise, prefer showing the detailed story
    return s;
  }
}

class _LocalOrNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final Alignment alignment;

  const _LocalOrNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final isLocal =
        url.contains(':\\') || url.startsWith('/') || url.startsWith('file://');

    if (isLocal) {
      final path = url.replaceFirst('file://', '');
      return Image.file(
        File(path),
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      alignment: alignment,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(color: Colors.grey[900]),
    );
  }
}
