import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_provider.dart';

enum AppDesignTheme { glass, coffee }

class DesignThemeNotifier extends Notifier<AppDesignTheme> {
  static const String _themeKey = 'app_design_theme';

  @override
  AppDesignTheme build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme == 'coffee') return AppDesignTheme.coffee;
    return AppDesignTheme.glass;
  }

  Future<void> setTheme(AppDesignTheme theme) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeKey, theme.name);
    state = theme;
  }
}

final designThemeProvider = NotifierProvider<DesignThemeNotifier, AppDesignTheme>(() {
  return DesignThemeNotifier();
});
