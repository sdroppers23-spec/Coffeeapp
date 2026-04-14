import 'package:flutter/foundation.dart';

/// Universal utility for cleaning and formatting coffee-related content.
/// Handles HTML tags, custom technical keys ({p1}, {li}, etc.), and escaping.
class ContentUtils {
  /// Robust regex to match any technical key in formats like {p1}, {/p1}, [li], etc.
  static final RegExp _technicalKeyRegex = RegExp(r'\{/?[\w\d]+\}|\[/?[\w\d]+\]');
  
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
    
    // 3. Strip all remaining opening/closing technical keys (including things like {/h3})
    cleaned = cleaned.replaceAll(_technicalKeyRegex, '');

    // 4. Robust artifact removal (fixes fragments like "##" or "*" left at ends of lines)
    // This targets lines that end with Markdown symbols that were likely artifacts of keys
    cleaned = cleaned.split('\n').map((line) {
      String trimmed = line.trimRight();
      // Remove trailing Markdown artifacts that shouldn't be there at the end of a line
      while (trimmed.endsWith('#') || trimmed.endsWith('*') || trimmed.endsWith('_')) {
        trimmed = trimmed.substring(0, trimmed.length - 1).trimRight();
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
    
    // First clean it normally
    String cleaned = cleanCoffeeContent(raw);
    
    // Then strip Markdown symbols for the preview
    cleaned = cleaned
        .replaceAll(RegExp(r'#+\s*'), '') // Headers
        .replaceAll(RegExp(r'\*\*|\*|__|_'), '') // Bold/Italic
        .replaceAll(RegExp(r'^\s*[\*\-]\s+', multiLine: true), '') // List markers
        .replaceAll('\n', ' ')
        .trim();

    if (cleaned.length <= limit) return cleaned;
    return '${cleaned.substring(0, limit).trim()}...';
  }
}
