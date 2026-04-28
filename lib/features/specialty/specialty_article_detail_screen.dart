import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import '../navigation/navigation_providers.dart';

import '../../core/database/dtos.dart';
import '../../shared/widgets/scroll_to_top_button.dart';
import '../../core/utils/text_processor.dart';

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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.read(navBarVisibleProvider.notifier).show();
        Navigator.of(context).pop();
      },
      child: Scaffold(
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
                        // Multi-stop gradient overlay for readability and smooth transition
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black45,
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xFF0A0908), // Match BG exactly
                              ],
                              stops: [0.0, 0.2, 0.5, 1.0], // Deeper bottom fade
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
                            border: Border.all(
                              color: gold.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            widget.moduleName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: gold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title
                        Text(
                          title,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Read time & Share row
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: gold.withValues(alpha: 0.7),
                            ),
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

                        // Content: supports full HTML + automatic structure processing
                        Html(
                          data: CoffeeTextProcessor.process(content),
                          style: {
                            'body': Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              fontSize: FontSize(17),
                              lineHeight: const LineHeight(1.8),
                              color: Colors.white.withValues(alpha: 0.9),
                              fontFamily: GoogleFonts.outfit().fontFamily,
                            ),
                            'h1,h2,h3': Style(
                              color: gold,
                              fontFamily:
                                  GoogleFonts.cormorantGaramond().fontFamily,
                              margin: Margins.only(top: 24, bottom: 12),
                            ),
                            'h1': Style(
                              fontSize: FontSize(36),
                              fontWeight: FontWeight.w700,
                            ),
                            'h2': Style(
                              fontSize: FontSize(28),
                              fontWeight: FontWeight.w700,
                            ),
                            'h3': Style(
                              fontSize: FontSize(20),
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
                              color: gold.withValues(alpha: 0.8),
                              fontWeight: FontWeight.bold,
                            ),
                            'ol, ul': Style(
                              margin: Margins.only(top: 16, bottom: 16),
                              padding: HtmlPaddings.only(left: 4),
                            ),
                            'li': Style(
                              fontSize: FontSize(17),
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

  Widget _buildHeroImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
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
