import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../navigation/main_scaffold.dart';
import 'specialty_article_detail_screen.dart';
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
    final contentHtml = widget.article.contentHtml;
    final imageUrl = widget.article.imageUrl;
    const gold = Color(0xFFC8A96E);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0908),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            backgroundColor: Colors.black,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.black,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey[900]),
                    )
                  else
                    Container(color: Colors.grey[900]),
                  // Gradient Overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Color(0xFF0A0908),
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: gold.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      widget.moduleName.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: gold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: gold.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  // Content
                  Html(
                    data: contentHtml,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: FontSize(17),
                        lineHeight: LineHeight.number(1.7),
                        fontFamily: 'Inter',
                      ),
                      "h1": Style(
                        color: Colors.white,
                        fontSize: FontSize(28),
                        fontWeight: FontWeight.w800,
                        margin: Margins.only(top: 32, bottom: 16),
                      ),
                      "h3": Style(
                        color: gold,
                        fontSize: FontSize(22),
                        fontWeight: FontWeight.w700,
                        margin: Margins.only(top: 24, bottom: 12),
                      ),
                      "p": Style(
                        margin: Margins.only(bottom: 16),
                      ),
                      "b": Style(color: gold),
                      "li": Style(
                        margin: Margins.only(bottom: 8),
                        color: Colors.white.withValues(alpha: 0.8),
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
    );
  }
}
