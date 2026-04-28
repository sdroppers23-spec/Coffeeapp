
import 'dart:io';

void main() {
  final file = File('d:/Games/Coffeeapp/lib/core/l10n/app_localizations.dart');
  final content = file.readAsStringSync();
  
  // Find the 'en' and 'uk' maps
  final enMatch = RegExp(r"'en':\s*\{(.*?)\},", dotAll: true).firstMatch(content);
  final ukMatch = RegExp(r"'uk':\s*\{(.*?)\},", dotAll: true).firstMatch(content);
  
  if (enMatch != null) {
    print('Checking EN keys:');
    checkDuplicates(enMatch.group(1)!);
  }
  
  if (ukMatch != null) {
    print('\nChecking UK keys:');
    checkDuplicates(ukMatch.group(1)!);
  }
}

void checkDuplicates(String mapContent) {
  final lines = mapContent.split('\n');
  final keys = <String>{};
  for (var line in lines) {
    final match = RegExp(r"^\s*'([^']+)'").firstMatch(line);
    if (match != null) {
      final key = match.group(1)!;
      if (keys.contains(key)) {
        print('Duplicate key found: $key');
      }
      keys.add(key);
    }
  }
}
