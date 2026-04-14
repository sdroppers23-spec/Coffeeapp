/// Utilities for cleaning and parsing specialty coffee related content.
/// Handles HTML tags, custom technical keys ({p1}, {li}, etc.), and escaping.
class ContentUtils {
  /// Robust regex to match any technical key in formats like {p1}, {/p1}, [li], etc.
  /// Robust regex to match any technical key in formats like {p1}, {/p1}, [li], etc.
  /// EXCLUDES our new styling tags: {gold}, {serif}, {accent}, {size}
  static final RegExp _technicalKeyRegex = RegExp(r'\{/?(?!(gold|serif|accent|size))[\w\d]+\}|\[/?[\w\d]+\]');
  
  /// Matches any standard HTML tag
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');

  /// Cleans raw content from Supabase, converting keys to Markdown and removing artifacts.
  static String cleanCoffeeContent(String raw) {
    if (raw.isEmpty) return '';

    String cleaned = raw;

    // 1. Handle common escaping issues from DB strings
    cleaned = cleaned.replaceAll('\\"', '"').replaceAll('\\n', '\n');

    // 2. Map specific keys to Markdown equivalents BEFORE stripping all keys
    // Handle opening keys
    cleaned = cleaned.replaceAll(RegExp(r'\{p\d+\}'), '\n\n');
    cleaned = cleaned.replaceAll('{li}', '\n* ');
    cleaned = cleaned.replaceAll('{h1}', '\n# ');
    cleaned = cleaned.replaceAll('{h2}', '\n## ');
    cleaned = cleaned.replaceAll('{h3}', '\n### ');
    
    // 3. Strip all remaining opening/closing technical keys and HTML tags
    cleaned = cleaned.replaceAll(_technicalKeyRegex, '');
    cleaned = cleaned.replaceAll(_htmlTagRegex, '');

    // 4. Robust artifact removal
    // We only remove a Markdown character at the end of a line if it's isolated 
    // or looks like a stray decorator from a removed key.
    cleaned = cleaned.split('\n').map((line) {
      String trimmed = line.trimRight();
      // Only strip trailing hashes/stars if they were likely ornaments (surrounded by space or at end of line)
      // We don't want to kill valid Markdown titles that might have trailing space
      while (trimmed.length > 2 && (trimmed.endsWith(' #') || trimmed.endsWith(' *') || trimmed.endsWith(' _'))) {
        trimmed = trimmed.substring(0, trimmed.length - 2).trimRight();
      }
      return trimmed;
    }).join('\n');

    // 5. Final sanitation: normalize multiple newlines to max 2
    cleaned = cleaned.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return cleaned.trim();
  }

  /// Specialized version for text previews (strips all formatting, headers, etc.)
  static String getPreviewText(String raw, {int limit = 150}) {
    if (raw.isEmpty) return '';
    
    // First clean keys and HTML
    String cleaned = cleanCoffeeContent(raw);
    
    // Then strip specific Markdown symbols for the preview list view
    cleaned = cleaned
        .replaceAll(RegExp(r'^#+\s*', multiLine: true), '') // Headers at start of lines
        .replaceAll(RegExp(r'\*\*|\*|__|_'), '') // Bold/Italic
        .replaceAll(RegExp(r'^\s*[\*\-]\s+', multiLine: true), '') // List markers
        .replaceAll('\n', ' ') // Flatten newlines
        .replaceAll(RegExp(r'\s{2,}'), ' ') // Normalize spaces
        .trim();

    if (cleaned.length <= limit) return cleaned;
    return '${cleaned.substring(0, limit).trim()}...';
  }
}
