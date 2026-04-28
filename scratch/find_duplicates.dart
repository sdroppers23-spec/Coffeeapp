import 'dart:io';

void main() {
  final file = File('lib/core/l10n/app_localizations.dart');
  final lines = file.readAsLinesSync();

  bool inEn = false;
  bool inUk = false;

  final Map<String, int> enKeys = {};
  final Map<String, int> ukKeys = {};

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (line.contains("'en': {")) {
      inEn = true;
      inUk = false;
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
    }

    if (inEn || inUk) {
      final match = RegExp(r"^\'(.+?)\':").firstMatch(line);
      if (match != null) {
        final key = match.group(1)!;
        if (inEn) {
          if (enKeys.containsKey(key)) {
            // ignore: avoid_print
            print(
              'Duplicate EN key: $key at line ${i + 1} (previous at line ${enKeys[key]})',
            );
          }
          enKeys[key] = i + 1;
        } else {
          if (ukKeys.containsKey(key)) {
            // ignore: avoid_print
            print(
              'Duplicate UK key: $key at line ${i + 1} (previous at line ${ukKeys[key]})',
            );
          }
          ukKeys[key] = i + 1;
        }
      }
    }
  }
}
