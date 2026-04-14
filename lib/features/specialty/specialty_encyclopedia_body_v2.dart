import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/glass_container.dart';

import '../../core/database/dtos.dart';
import 'specialty_article_detail_screen.dart';

class SpecialtyArticleCard extends StatelessWidget {
  final SpecialtyArticleDto article;
  final String moduleName;
  final int index;

  const SpecialtyArticleCard({
    super.key,
    required this.article,
    required this.moduleName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final title = article.title;
    final content = article.contentHtml;
    final imageUrl = article.effectiveImageUrl;
    final readTime = article.readTimeMin;

    const gold = Color(0xFFC8A96E);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SpecialtyArticleDetailScreen(
                  article: article,
                  moduleName: moduleName,
                ),
              ),
            );
          },
          child: GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 28,
            imageUrl: imageUrl,
            imageOpacity: 0.5,
            blur: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Premium Tag with Read Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: gold.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        '${moduleName.toUpperCase()} • #$index',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: gold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Text(
                      '$readTime МИН',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Premium Title
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.0,
                    letterSpacing: -0.5,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Preview text (stripped HTML/Markdown)
                Text(
                  content
                      .replaceAll(RegExp(r'<[^>]*>'), '')
                      .replaceAll(RegExp(r'#+\s*'), '')
                      .replaceAll(RegExp(r'\*\*|\*|__|_'), '')
                      .replaceAll('\n', ' ')
                      .trim(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Read More Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Читати далі',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: gold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
