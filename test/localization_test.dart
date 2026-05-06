import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:specialty_tracker/core/l10n/app_localizations.dart';

void main() {
  group('AppLocalizations Tests', () {
    test('Check English translations', () {
      final loc = AppLocalizations(const Locale('en'));
      expect(loc.translate('discover'), 'Discover');
      expect(loc.translate('settings'), 'Settings');
    });

    test('Check German translations', () {
      final loc = AppLocalizations(const Locale('de'));
      expect(loc.translate('discover'), 'Entdecken');
      expect(loc.translate('settings'), 'Einstellungen');
    });

    test('Check French translations', () {
      final loc = AppLocalizations(const Locale('fr'));
      expect(loc.translate('discover'), 'Découvrir');
      expect(loc.translate('settings'), 'Paramètres');
    });

    test('Check Spanish translations', () {
      final loc = AppLocalizations(const Locale('es'));
      expect(loc.translate('discover'), 'Descubrir');
      expect(loc.translate('settings'), 'Ajustes');
    });

    test('Check Japanese translations', () {
      final loc = AppLocalizations(const Locale('ja'));
      expect(loc.translate('discover'), '発見');
      expect(loc.translate('settings'), '設定');
    });

    test('Check Arabic translations', () {
      final loc = AppLocalizations(const Locale('ar'));
      expect(loc.translate('discover'), 'اكتشف');
      expect(loc.translate('settings'), 'الإعدادات');
    });

    test('Check missing key returns key name', () {
      final loc = AppLocalizations(const Locale('en'));
      expect(loc.translate('non_existent_key'), 'non_existent_key');
    });
  });
}
