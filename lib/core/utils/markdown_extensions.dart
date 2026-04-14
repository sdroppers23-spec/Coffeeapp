import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// Syntax parser for custom style tags like {gold}text{/gold}
class StyleTagSyntax extends md.InlineSyntax {
  StyleTagSyntax()
      : super(r'\{(\w+[:\d.]*)\}([\s\S]*?)\{\/\1\}');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final tag = match.group(1);
    final content = match.group(2);
    
    final element = md.Element.text('style-tag', content ?? '');
    element.attributes['tag'] = tag ?? '';
    parser.addNode(element);
    return true;
  }
}

/// Builder for rendering our custom style tags
class StyleTagBuilder extends MarkdownElementBuilder {
  final BuildContext context;

  StyleTagBuilder(this.context);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final tag = element.attributes['tag'] ?? '';
    final text = element.textContent;
    
    TextStyle style = preferredStyle ?? const TextStyle();
    const goldColor = Color(0xFFC8A96E);

    if (tag == 'gold') {
      style = style.copyWith(color: goldColor, fontWeight: FontWeight.bold);
    } else if (tag == 'accent') {
      style = style.copyWith(color: goldColor.withValues(alpha: 0.7));
    } else if (tag == 'serif') {
      style = GoogleFonts.cormorantGaramond(
        textStyle: style,
        fontWeight: FontWeight.w600,
      );
    } else if (tag.startsWith('size:')) {
      final sizeStr = tag.split(':').last;
      final size = double.tryParse(sizeStr) ?? 16.0;
      style = style.copyWith(fontSize: size);
    }

    return Text.rich(
      TextSpan(
        text: text,
        style: style,
      ),
    );
  }
}
