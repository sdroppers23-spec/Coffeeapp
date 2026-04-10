import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class SettingsNotifier extends Notifier<bool> {
  static const String _vibrationKey = 'vibration_enabled';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_vibrationKey) ?? true;
  }

  Future<void> toggleVibration(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_vibrationKey, value);
    state = value;
    if (value) {
      HapticFeedback.lightImpact();
      Vibration.vibrate(duration: 50);
    }
  }

  void triggerHaptic() {
    if (state) {
      HapticFeedback.mediumImpact();
    }
  }

  void triggerSelectionVibrate() {
    if (state) {
      Vibration.vibrate(duration: 30);
    }
  }

  void triggerVibrate() {
    if (state) {
      Vibration.vibrate(duration: 50);
    }
  }

  void triggerHeavyVibrate() {
    if (state) {
      // For heavy actions like deletion, use a longer duration
      Vibration.vibrate(duration: 100);
    }
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Should be overridden in ProviderScope
});

final settingsProvider = NotifierProvider<SettingsNotifier, bool>(() {
  return SettingsNotifier();
});
