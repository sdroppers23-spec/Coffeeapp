import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import '../navigation/main_scaffold.dart';

import '../../core/database/dtos.dart';
import '../../shared/widgets/scroll_to_top_button.dart';

class SpecialtyArticleDetailScreen extends ConsumerStatefulWidget {
  final SpecialtyArticleDto article;
  final String moduleName;

  const SpecialtyArticleDetailScreen({
    super.key,
    required this.article,
    required this.moduleName,
  });

  @override
  ConsumerState<SpecialtyArticleDetailScreen> createState() =>
      _SpecialtyArticleDetailScreenState();
}

class _SpecialtyArticleDetailScreenState
    extends ConsumerState<SpecialtyArticleDetailScreen> {
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
    final title = widget.article.title;
    final content = widget.article.contentHtml;
    final imageUrl = widget.article.effectiveImageUrl;
    const gold = Color(0xFFC8A96E);
    const bg = Color(0xFF0A0908);

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Hero Image AppBar ──────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 400,
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (imageUrl.isNotEmpty)
                        _buildHeroImage(imageUrl)
                      else
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF1A1208), Color(0xFF0D0D0D)],
                            ),
                          ),
                        ),
                      // Multi-stop gradient overlay for readability
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
                            stops: [0.0, 0.2, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Content ───────────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Module chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: gold.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          widget.moduleName.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: gold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        title,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Read time & Share row
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: gold.withValues(alpha: 0.7)),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.article.readTimeMin} хв читання',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              gold.withValues(alpha: 0.35),
                              gold.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Content: supports full HTML + custom serif processing
                      Html(
                        data: _processContent(content),
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(17),
                            lineHeight: LineHeight(1.8),
                            color: Colors.white.withValues(alpha: 0.9),
                            fontFamily: GoogleFonts.outfit().fontFamily,
                          ),
                          "h1": Style(
                            fontSize: FontSize(36),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: GoogleFonts.cormorantGaramond().fontFamily,
                          ),
                          "h2": Style(
                            fontSize: FontSize(28),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: GoogleFonts.cormorantGaramond().fontFamily,
                          ),
                          "h3": Style(
                            fontSize: FontSize(16),
                            fontWeight: FontWeight.w700,
                            color: gold,
                            letterSpacing: 1.0,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                          "strong": Style(
                            color: gold,
                            fontWeight: FontWeight.w700,
                          ),
                          ".serif": Style(
                            fontFamily: GoogleFonts.cormorantGaramond().fontFamily,
                            fontWeight: FontWeight.w600,
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
    );
  }

  String _processContent(String text) {
    // Convert custom {serif} tags to HTML spans with a class
    String processed = text.replaceAllMapped(
      RegExp(r'\{serif\}([\s\S]*?)\{\/serif\}'),
      (match) => '<span class="serif">${match.group(1)}</span>',
    );
    
    // Support potential legacy gold tags if they exist in DB
    processed = processed.replaceAllMapped(
      RegExp(r'\{gold\}([\s\S]*?)\{\/gold\}'),
      (match) => '<span style="color: #C8A96E; font-weight: bold;">${match.group(1)}</span>',
    );

    return processed;
  }

  Widget _buildHeroImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1208), Color(0xFF0D0D0D)],
          ),
        ),
      ),
    );
  }
}
