import 'package:flutter_test/flutter_test.dart';
import 'package:specialty_tracker/core/l10n/flavor_descriptions.dart';

void main() {
  group('FlavorDescriptions Coverage Test', () {
    final supportedLocales = [
      'en',
      'uk',
      'de',
      'fr',
      'es',
      'it',
      'pt',
      'pl',
      'nl',
      'sv',
      'tr',
      'ja',
      'ko',
      'zh',
      'ar',
      'ru',
      'ro',
    ];

    test('All supported locales should have descriptions for all keys', () {
      // In a real scenario, we would iterate over all keys defined in ScaFlavorWheelL10n
      // For this test, let's check a few critical ones first to identify gaps

      for (var locale in supportedLocales) {
        final description = FlavorDescriptions.getDescription(
          'wheel_cat_green_veg',
          locale,
        );
        expect(
          description,
          isNot(equals('Description not available')),
          reason: 'Missing description for wheel_cat_green_veg in $locale',
        );
      }
    });

    test('Verify no English placeholders in non-English locales', () {
      // This is a harder check: we want to make sure 'uk' doesn't just contain the 'en' string
      final enDesc = FlavorDescriptions.getDescription(
        'wheel_note_molasses',
        'en',
      );
      final ukDesc = FlavorDescriptions.getDescription(
        'wheel_note_molasses',
        'uk',
      );
      final deDesc = FlavorDescriptions.getDescription(
        'wheel_note_molasses',
        'de',
      );

      expect(
        ukDesc,
        isNot(equals(enDesc)),
        reason: 'UK description for molasses is still in English',
      );
      expect(
        deDesc,
        isNot(equals(enDesc)),
        reason: 'DE description for molasses is still in English',
      );
    });
  });
}
