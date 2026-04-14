import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:markdown/markdown.dart' as md;
import '../navigation/main_scaffold.dart';

import '../../core/database/dtos.dart';
import '../../core/utils/markdown_extensions.dart';
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

    final markdownStyle = MarkdownStyleSheet(
      p: GoogleFonts.outfit(
        fontSize: 17,
        height: 1.8,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      h1: GoogleFonts.cormorantGaramond(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.1,
      ),
      h2: GoogleFonts.cormorantGaramond(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      h3: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: gold,
        letterSpacing: 1.0,
        height: 1.4,
      ),
      h4: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: gold.withValues(alpha: 0.8),
        letterSpacing: 0.5,
      ),
      strong: GoogleFonts.outfit(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: gold,
      ),
      em: GoogleFonts.outfit(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Colors.white.withValues(alpha: 0.8),
      ),
      listBullet: GoogleFonts.outfit(
        fontSize: 17,
        color: gold,
      ),
      blockquoteDecoration: BoxDecoration(
        color: gold.withValues(alpha: 0.08),
        border: Border(
          left: BorderSide(color: gold.withValues(alpha: 0.5), width: 4),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      blockquote: GoogleFonts.outfit(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.white.withValues(alpha: 0.8),
        height: 1.7,
      ),
      code: GoogleFonts.firaCode(
        fontSize: 14,
        color: gold,
        backgroundColor: Colors.white.withValues(alpha: 0.08),
      ),
      codeblockDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: gold.withValues(alpha: 0.2), width: 1),
        ),
      ),
      h1Padding: const EdgeInsets.only(top: 32, bottom: 12),
      h2Padding: const EdgeInsets.only(top: 28, bottom: 10),
      h3Padding: const EdgeInsets.only(top: 24, bottom: 8),
      pPadding: const EdgeInsets.only(bottom: 16),
      listIndent: 24,
      blockquotePadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
    );

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

                  // Content: prefer Markdown, fall back to plain text
                  MarkdownBody(
                    data: content,
                    styleSheet: markdownStyle,
                    selectable: true,
                    softLineBreak: true,
                    shrinkWrap: true,
                    extensionSet: md.ExtensionSet.gitHubWeb,
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
    ],
  ),
  floatingActionButton: ScrollToTopButton(
    scrollController: _scrollController,
    threshold: 400,
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
