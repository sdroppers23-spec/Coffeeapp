import 'package:specialty_tracker/core/l10n/flavor_descriptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FlavorDescriptions returns correct localized strings', () {
    // Test English
    final en = FlavorDescriptions.getDescription('wheel_note_jasmine', 'en');
    expect(en.contains('linalool'), isTrue);

    // Test Ukrainian
    final uk = FlavorDescriptions.getDescription('wheel_note_jasmine', 'uk');
    expect(
      uk.contains('ліналоол') ||
          uk.contains('Жасмин') ||
          uk.contains('квітковим'),
      isTrue,
    );

    // Test non-existent language (should fallback to en)
    final fallback = FlavorDescriptions.getDescription(
      'wheel_note_jasmine',
      'fr_CA',
    );
    expect(fallback, equals(en));

    // Test non-existent key
    final missing = FlavorDescriptions.getDescription('non_existent_key', 'en');
    expect(missing, equals('Description coming soon...'));
  });
}
