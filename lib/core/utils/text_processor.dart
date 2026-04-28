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

    // 2. Handle Custom Tags ({tag} -> <span class="tag">, {/tag} -> </span>)
    // Supports: gold, serif, accent, accent-gold, white, etc.
    output = output.replaceAllMapped(RegExp(r'\{([a-zA-Z0-9\-]+)\}'), (match) {
      final tagName = match.group(1);
      return '<span class="coffee-$tagName">';
    });
    output = output.replaceAll(RegExp(r'\{/[a-zA-Z0-9\-]+\}'), '</span>');

    // 3. Handle Paragraphs (double newline -> <p>)
    // We split by double newlines, then wrap each block if it doesn't start with a tag like <h1>
    final blocks = output.split(RegExp(r'\n\s*\n'));
    final processedBlocks = blocks
        .map((block) {
          final trimmed = block.trim();
          if (trimmed.isEmpty) return '';

          // If it already starts with an HTML block tag, don't wrap in <p>
          if (trimmed.startsWith('<h') ||
              trimmed.startsWith('<div') ||
              trimmed.startsWith('<p')) {
            return trimmed;
          }

          // Convert single newlines within a paragraph to <br>
          final withLineBreaks = trimmed.replaceAll('\n', '<br/>');
          return '<p>$withLineBreaks</p>';
        })
        .where((b) => b.isNotEmpty)
        .toList();

    return processedBlocks.join('\n');
  }

  /// Optional: Helper to generate the CSS styles we use in Html widget
  static Map<String, String> getStyles() {
    return {
      '.coffee-gold': 'color: #C8A96E; font-weight: bold;',
      '.coffee-accent': 'color: #C8A96E; opacity: 0.6;',
      '.coffee-accent-gold': 'color: #C8A96E; font-weight: bold;',
      '.coffee-serif': 'font-family: "Cormorant Garamond", serif;',
      '.coffee-white': 'color: #FFFFFF;',
      'p':
          'margin-bottom: 16px; line-height: 1.6; color: rgba(255,255,255,0.85);',
      'h1, h2, h3':
          'color: #C8A96E; font-family: "Cormorant Garamond", serif; margin-top: 24px; margin-bottom: 12px;',
    };
  }
}
