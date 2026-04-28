
import 'dart:io';

void main() {
  final file = File('lib/core/l10n/app_localizations.dart');
  final lines = file.readAsLinesSync();
  
  Map<String, List<int>> enKeys = {};
  Map<String, List<int>> ukKeys = {};
  
  bool inEn = false;
  bool inUk = false;
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (line.contains("'en': {")) {
      inEn = true;
      continue;
    }
    if (line.contains("'uk': {")) {
      inEn = false;
      inUk = true;
      continue;
    }
    if (line.startsWith('},')) {
      inEn = false;
      inUk = false;
      continue;
    }
    
    if (inEn || inUk) {
      final match = RegExp(r"'([^']+)':").firstMatch(line);
      if (match != null) {
        final key = match.group(1)!;
        if (inEn) {
          enKeys.putIfAbsent(key, () => []).add(i + 1);
        } else if (inUk) {
          ukKeys.putIfAbsent(key, () => []).add(i + 1);
        }
      }
    }
  }
  
  print('EN Duplicates:');
  enKeys.forEach((key, lines) {
    if (lines.length > 1) {
      print('$key: $lines');
    }
  });
  
  print('\nUK Duplicates:');
  ukKeys.forEach((key, lines) {
    if (lines.length > 1) {
      print('$key: $lines');
    }
  });
}
