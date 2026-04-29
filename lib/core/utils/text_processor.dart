import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeTextProcessor {
  /// Transforms "Coffee-Markdown" (plain text with {tag} and newlines)
  /// into properly structured HTML.
  static String process(String input) {
    if (input.isEmpty) return '';

    String output = input;

    // 1. Handle Headers (# Header -> <h1>, ## Header -> <h2>, etc)
    output = output.replaceAllMapped(
      RegExp(r'^(#+)\s+(.+)$', multiLine: true),
      (match) {
        final level = match.group(1)!.length;
        final text = match.group(2)!;
        return '<h$level>$text</h$level>';
      },
    );

    // 2. Handle Custom Tags ({tag} -> <span class="coffee-tag">, {/tag} -> </span>)
    // Supports: gold, serif, accent, accent-gold, white, etc.
    output = output.replaceAllMapped(RegExp(r'\{([a-zA-Z0-9\-]+)\}'), (match) {
      final tagName = match.group(1);
      // Special case for closing tags if they weren't caught by the general closer
      if (tagName != null && tagName.startsWith('/')) {
        return '</span>';
      }
      return '<span class="coffee-$tagName">';
    });
    output = output.replaceAll(RegExp(r'\{/[a-zA-Z0-9\-]+\}'), '</span>');

    // 2.5 Handle Blockquotes (> Text)
    output = output.replaceAllMapped(
      RegExp(r'^>\s+(.+)$', multiLine: true),
      (match) => '<blockquote>${match.group(1)}</blockquote>',
    );

    // 3. Handle Paragraphs (double newline -> <p>)
    // If the input already looks like HTML (contains many < tags), we should be careful
    final hasHtmlTags = RegExp(r'<[a-z1-6]+[^>]*>').hasMatch(output);

    if (hasHtmlTags) {
      // If it has HTML tags, we only want to ensure it doesn't have excessive newlines
      // that flutter_html might interpret as extra space.
      return output.trim();
    }

    // Process blocks for plain text input
    final blocks = output.split(RegExp(r'\n\s*\n'));
    final processedBlocks = blocks
        .map((block) {
          final trimmed = block.trim();
          if (trimmed.isEmpty) return '';

          // If it already starts with an HTML block tag, don't wrap in <p>
          if (trimmed.startsWith('<h') ||
              trimmed.startsWith('<div') ||
              trimmed.startsWith('<p') ||
              trimmed.startsWith('<ul') ||
              trimmed.startsWith('<li') ||
              trimmed.startsWith('<blockquote') ||
              trimmed.startsWith('<hr')) {
            return trimmed;
          }

          // Convert single newlines within a paragraph to <br>
          final withLineBreaks = trimmed.replaceAll('\n', '<br/>');
          return '<p>$withLineBreaks</p>';
        })
        .where((b) => b.isNotEmpty)
        .toList();

    return processedBlocks.join('');
  }

  /// Helper to generate the Style map for Html widget
  static Map<String, Style> getHtmlStyles({
    double baseFontSize = 16.0,
    Color goldColor = const Color(0xFFC8A96E),
  }) {
    return {
      'body': Style(
        margin: Margins.zero,
        padding: HtmlPaddings.zero,
        fontSize: FontSize(baseFontSize),
        lineHeight: const LineHeight(1.6),
        color: Colors.white.withValues(alpha: 0.85),
        fontFamily: GoogleFonts.outfit().fontFamily,
      ),
      'p': Style(
        margin: Margins.only(bottom: 4),
        lineHeight: const LineHeight(1.6),
      ),
      'h1,h2,h3,h4,h5,h6': Style(
        color: goldColor,
        fontFamily: GoogleFonts.cormorantGaramond().fontFamily,
        fontWeight: FontWeight.w700,
        margin: Margins.only(top: 8, bottom: 2),
      ),
      'h1': Style(fontSize: FontSize(baseFontSize * 1.4)),
      'h2': Style(fontSize: FontSize(baseFontSize * 1.25)),
      'h3': Style(fontSize: FontSize(baseFontSize * 1.1)),
      'ul,ol': Style(
        margin: Margins.only(bottom: 4),
        padding: HtmlPaddings.only(left: 20),
      ),
      'li': Style(
        margin: Margins.only(bottom: 4),
      ),
      'hr': Style(
        margin: Margins.symmetric(vertical: 16),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      'blockquote': Style(
        margin: Margins.only(bottom: 4, left: 0, right: 0),
        padding: HtmlPaddings.only(left: 12, top: 6, bottom: 6),
        border: Border(
          left: BorderSide(color: goldColor, width: 3),
        ),
        fontStyle: FontStyle.italic,
        backgroundColor: Colors.white.withValues(alpha: 0.03),
      ),
      'strong,b': Style(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      '.coffee-gold': Style(
        color: goldColor,
        fontWeight: FontWeight.bold,
      ),
      '.coffee-accent': Style(
        color: goldColor.withValues(alpha: 0.6),
      ),
      '.coffee-accent-gold': Style(
        color: goldColor,
        fontWeight: FontWeight.bold,
      ),
      '.coffee-serif': Style(
        fontFamily: GoogleFonts.cormorantGaramond().fontFamily,
      ),
      '.coffee-white': Style(
        color: Colors.white,
      ),
    };
  }

  /// Strips all HTML and custom tags to return plain text.
  static String stripHtml(String html) {
    if (html.isEmpty) return '';
    // Strip HTML tags
    String stripped = html.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
    // Strip custom tags {tag}
    stripped = stripped.replaceAll(RegExp(r'\{[^}]*\}'), ' ');
    // Normalize spaces
    return stripped.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
