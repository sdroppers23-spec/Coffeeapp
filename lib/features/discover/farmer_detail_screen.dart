import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/dtos.dart';
import '../navigation/main_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/utils/markdown_extensions.dart';
import '../../shared/widgets/scroll_to_top_button.dart';

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
    const bg = Color(0xFF0A0908);

    // Build unified Markdown bio from description + story
    final bio = _buildBio(widget.farmer.description, widget.farmer.story);

    final markdownStyle = MarkdownStyleSheet(
      p: GoogleFonts.outfit(
        fontSize: 16.5,
        height: 1.78,
        color: Colors.white.withValues(alpha: 0.88),
      ),
      h1: GoogleFonts.cormorantGaramond(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      h2: GoogleFonts.cormorantGaramond(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.25,
      ),
      h3: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: gold,
        letterSpacing: 0.8,
        height: 1.4,
      ),
      strong: GoogleFonts.outfit(
        fontSize: 16.5,
        fontWeight: FontWeight.w700,
        color: gold,
      ),
      em: GoogleFonts.outfit(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.white.withValues(alpha: 0.75),
      ),
      listBullet: GoogleFonts.outfit(
        fontSize: 16.5,
        color: gold,
      ),
      blockquoteDecoration: BoxDecoration(
        color: gold.withValues(alpha: 0.08),
        border: Border(
          left: BorderSide(color: gold.withValues(alpha: 0.5), width: 3),
        ),
      ),
      blockquote: GoogleFonts.outfit(
        fontSize: 15.5,
        fontStyle: FontStyle.italic,
        color: Colors.white.withValues(alpha: 0.75),
        height: 1.65,
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: gold.withValues(alpha: 0.25), width: 1),
        ),
      ),
      h1Padding: const EdgeInsets.only(top: 28, bottom: 8),
      h2Padding: const EdgeInsets.only(top: 24, bottom: 8),
      h3Padding: const EdgeInsets.only(top: 20, bottom: 6),
      pPadding: const EdgeInsets.only(bottom: 12),
      listIndent: 20,
      blockquotePadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    );

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Hero Portrait ─────────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 420,
                backgroundColor: Colors.black,
                surfaceTintColor: Colors.transparent, // Fix white sheet
                systemOverlayStyle: SystemUiOverlayStyle.light, // Fix status bar icons
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
                        )
                      else
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF1A1208), Color(0xFF120D08)],
                            ),
                          ),
                        ),
                      // Gradient overlay
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black38,
                              Colors.transparent,
                              Colors.transparent,
                              Color(0xFF0A0908),
                            ],
                            stops: [0.0, 0.15, 0.55, 1.0],
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
                              errorWidget: (context, url, error) => const Icon(
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
                                color: gold.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: gold.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                '${widget.farmer.country}, ${widget.farmer.region}'
                                    .toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: gold,
                                  letterSpacing: 1.2,
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

                      // Biography in Markdown (handles HTML tags via gitHubWeb extension set)
                      if (bio.isNotEmpty)
                        MarkdownBody(
                          data: bio,
                          extensionSet: md.ExtensionSet.gitHubWeb,
                          styleSheet: markdownStyle,
                          selectable: true,
                          softLineBreak: true,
                          shrinkWrap: true,
                          inlineSyntaxes: [StyleTagSyntax()],
                          builders: {
                            'style-tag': StyleTagBuilder(context),
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

  const _LocalOrNetworkImage({required this.url, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final isLocal =
        url.contains(':\\') || url.startsWith('/') || url.startsWith('file://');

    if (isLocal) {
      final path = url.replaceFirst('file://', '');
      return Image.file(
        File(path),
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(color: Colors.grey[900]),
    );
  }
}
