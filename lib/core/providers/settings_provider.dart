import 'dart:io';
import 'package:flutter/foundation.dart';
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
      if (!kIsWeb && !Platform.isWindows) {
        HapticFeedback.lightImpact();
        Vibration.vibrate(duration: 50);
      }
    }
  }

  void triggerHaptic() {
    if (state && !kIsWeb && !Platform.isWindows) {
      HapticFeedback.mediumImpact();
    }
  }

  void triggerSelectionVibrate() {
    if (state && !kIsWeb && !Platform.isWindows) {
      Vibration.vibrate(duration: 30);
    }
  }

  void triggerVibrate() {
    if (state && !kIsWeb && !Platform.isWindows) {
      Vibration.vibrate(duration: 50);
    }
  }

  void triggerHeavyVibrate() {
    if (state && !kIsWeb && !Platform.isWindows) {
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

class GuestNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setGuest(bool value) => state = value;
}

final isGuestProvider = NotifierProvider<GuestNotifier, bool>(() {
  return GuestNotifier();
});
