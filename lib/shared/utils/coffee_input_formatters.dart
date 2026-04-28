import 'package:flutter/services.dart';

class GlobalCoffeeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Length limit 60
    if (text.length > 60) {
      text = text.substring(0, 60);
    }

    // 2. Double space -> dot
    if (text.contains('  ')) {
      text = text.replaceAll('  ', '.');
    }

    // 3. Allowed characters: Letters, Numbers, Space and .,-()
    final allowedRe = RegExp(r'[^\p{L}\p{N}\s\.,\-\(\)]', unicode: true);
    text = text.replaceAll(allowedRe, '');

    // 4. Max 3 dots in a row
    while (text.contains('....')) {
      text = text.replaceAll('....', '...');
    }

    // 5. Build logic: sign control and capitalization
    final sb = StringBuffer();
    bool capitalizeNext = true;

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];

      // If we encounter a dot sequence
      if (char == '.') {
        int dotCount = 0;
        while (i < text.length && text[i] == '.' && dotCount < 3) {
          sb.write('.');
          dotCount++;
          i++;
        }
        i--; // Step back for main loop increment
        capitalizeNext = true;
        continue;
      }

      // Check for other signs
      final isSign = RegExp(r'[\,\-\(\)]').hasMatch(char);

      // After dot/tridot, no other sign allowed
      if (capitalizeNext && isSign) {
        continue; // Skip sign
      }

      // If it's a letter, handle capitalization
      if (RegExp(r'\p{L}', unicode: true).hasMatch(char)) {
        if (capitalizeNext) {
          sb.write(char.toUpperCase());
          capitalizeNext = false;
        } else {
          sb.write(char);
        }
      } else if (char == ' ') {
        // Space doesn't reset capitalization intent unless after dot
        sb.write(char);
      } else {
        // numbers or allowed signs (if not right after dot)
        sb.write(char);
      }
    }

    final finalResult = sb.toString();

    // Correct selection offset
    int newOffset = newValue.selection.baseOffset;
    if (finalResult.length != newValue.text.length) {
      newOffset = newOffset.clamp(0, finalResult.length);
    }

    return TextEditingValue(
      text: finalResult,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

class ScaScoreInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(',', '.').replaceAll(' ', '');
    // Strictly allow only digits and dot
    text = text.replaceAll(RegExp(r'[^0-9.]'), '');

    if (text.isEmpty) return newValue.copyWith(text: '');

    // Rule: First digit must be 1, 8, or 9
    final firstChar = text[0];
    if (firstChar != '1' && firstChar != '8' && firstChar != '9') {
      return oldValue;
    }

    // NEW Rule: Prevent dot after the first digit (e.g., prevent "8.")
    if (text.length >= 2 && text[1] == '.') {
      return oldValue;
    }

    // Rule: If starts with 1, second must be 0
    if (text.length >= 2 && text[0] == '1' && text[1] != '0') {
      return const TextEditingValue(
        text: '99.9',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Rule: Auto-dot after 2 digits if not 100
    if (text.length == 3 && !text.contains('.')) {
      if (text == '100') return newValue;
      // If 10x where x != 0, cap at 99.9
      if (text.startsWith('10') && text[2] != '0') {
        return const TextEditingValue(
          text: '99.9',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
      return TextEditingValue(
        text: '${text.substring(0, 2)}.${text.substring(2)}',
        selection: const TextSelection.collapsed(offset: 4),
      );
    }

    // Rule: Max 3 digits excluding dot (e.g. 99.9 or 100)
    final digitsOnly = text.replaceAll('.', '');
    if (digitsOnly.length > 3) return oldValue;

    // Rule: Only one dot
    if ('.'.allMatches(text).length > 1) return oldValue;

    return newValue.copyWith(text: text);
  }
}

class AltitudeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Max 8 digits total
    final digitsLength = text.replaceAll(RegExp(r'[^0-9]'), '').length;
    if (digitsLength > 8) return oldValue;

    // 2. Max 1 hyphen
    if ('-'.allMatches(text).length > 1) {
      return oldValue;
    }

    // 3. Prevent consecutive separators or invalid ones
    if (text.contains('--') ||
        text.contains('..') ||
        text.contains('.-') ||
        text.contains('-.')) {
      return oldValue;
    }

    // 4. Prevent starting with separator
    if (text.startsWith('.') || text.startsWith('-')) {
      return oldValue;
    }

    // 5. Allow ONLY digits, dot, and hyphen (as requested: "тільки крапка і дифіс")
    if (!RegExp(r'^[0-9\.\-]*$').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}

class LotNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Max 6 digits total
    final digitsLength = text.replaceAll(RegExp(r'[^0-9]'), '').length;
    if (digitsLength > 6) return oldValue;

    // 2. Prevent consecutive dots or commas (or mix)
    if (text.contains('..') ||
        text.contains(',,') ||
        text.contains('.,') ||
        text.contains(',.')) {
      return oldValue;
    }

    // 3. Prevent starting with dot or comma
    if (text.startsWith('.') || text.startsWith(',')) {
      return oldValue;
    }

    // 4. Allowed symbols: 0-9, ., ,, #, №, (, ), /, -
    final allowedRe = RegExp(r'[^0-9\.,#№\(\)\/\-\s]');
    if (allowedRe.hasMatch(text)) {
      text = text.replaceAll(allowedRe, '');
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class WeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Limit to 4 digits (up to 9999g)
    if (newValue.text.length > 4) return oldValue;

    return newValue;
  }
}
