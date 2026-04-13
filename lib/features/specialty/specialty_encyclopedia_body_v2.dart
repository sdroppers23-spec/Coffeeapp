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
            padding: const EdgeInsets.all(24),
            borderRadius: 28,
            imageUrl: imageUrl,
            imageOpacity: 0.5, // Increased for premium look as per Image 2
            blur: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Premium Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100), // Pill shape
                    border: Border.all(color: gold.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '${moduleName.toLowerCase()} • #$index',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: gold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Premium Title
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 32, // Larger per Image 2
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.05,
                    letterSpacing: -0.5,
                  ),
                ),
                
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: gold.withValues(alpha: 0.85),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                
                // Preview text
                Text(
                  content.replaceAll(
                    RegExp(r'<[^>]*>'),
                    '',
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                
                const Spacer(),
                
                // Read More Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Читати далі',
                      style: GoogleFonts.cormorantGaramond( // Premium font for action too
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
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
