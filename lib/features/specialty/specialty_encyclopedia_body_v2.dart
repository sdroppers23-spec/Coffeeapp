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
    final subtitle = article.subtitle;
    final content = article.contentHtml;
    final imageUrl = article.imageUrl;

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
            padding: const EdgeInsets.all(20),
            borderRadius: 28,
            imageUrl: imageUrl,
            imageOpacity: 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: gold.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '$moduleName • #$index',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: gold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: gold.withValues(alpha: 0.9),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  content.replaceAll(
                      RegExp(r'<[^>]*>'), ''), // Strip HTML for preview
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Читати далі',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: gold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
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
