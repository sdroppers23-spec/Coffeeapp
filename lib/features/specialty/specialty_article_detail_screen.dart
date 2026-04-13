import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../navigation/main_scaffold.dart';

import '../../core/database/dtos.dart';

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
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.article.title;
    final subtitle = widget.article.subtitle;
    final content = widget.article.contentHtml;
    final imageUrl = widget.article.effectiveImageUrl;
    const gold = Color(0xFFC8A96E);
    const bg = Color(0xFF0A0908);

    final markdownStyle = MarkdownStyleSheet(
      p: GoogleFonts.outfit(
        fontSize: 16.5,
        height: 1.75,
        color: Colors.white.withValues(alpha: 0.88),
      ),
      h1: GoogleFonts.cormorantGaramond(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      h2: GoogleFonts.cormorantGaramond(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.25,
      ),
      h3: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: gold,
        letterSpacing: 0.8,
        height: 1.4,
      ),
      h4: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: gold.withValues(alpha: 0.85),
        letterSpacing: 0.5,
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
      code: GoogleFonts.firaCode(
        fontSize: 13,
        color: gold,
        backgroundColor: Colors.white.withValues(alpha: 0.06),
      ),
      codeblockDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero Image AppBar ──────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 360,
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
                        stops: [0.0, 0.2, 0.6, 1.0],
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
                  const SizedBox(height: 16),

                  // Module chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: gold.withValues(alpha: 0.35)),
                    ),
                    child: Text(
                      widget.moduleName.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: gold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),

                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: gold.withValues(alpha: 0.85),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Divider
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          gold.withValues(alpha: 0.5),
                          gold.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),

                  // Content: prefer Markdown, fall back to plain text
                  MarkdownBody(
                    data: content,
                    styleSheet: markdownStyle,
                    selectable: true,
                    softLineBreak: true,
                    shrinkWrap: true,
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
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
