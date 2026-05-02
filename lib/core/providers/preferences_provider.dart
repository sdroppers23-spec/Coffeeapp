import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_provider.dart';

enum TempUnit { celsius, fahrenheit }

enum LengthUnit { meters, feet }

enum Currency { uah, eur, usd }

enum LotSwipeMode { swipe, grip, disabled }

class UserPreferences {
  final TempUnit tempUnit;
  final LengthUnit lengthUnit;
  final Currency currency;
  final LotSwipeMode lotSwipeMode;

  UserPreferences({
    required this.tempUnit,
    required this.lengthUnit,
    required this.currency,
    required this.lotSwipeMode,
  });

  UserPreferences copyWith({
    TempUnit? tempUnit,
    LengthUnit? lengthUnit,
    Currency? currency,
    LotSwipeMode? lotSwipeMode,
  }) {
    return UserPreferences(
      tempUnit: tempUnit ?? this.tempUnit,
      lengthUnit: lengthUnit ?? this.lengthUnit,
      currency: currency ?? this.currency,
      lotSwipeMode: lotSwipeMode ?? this.lotSwipeMode,
    );
  }
}

class PreferencesNotifier extends Notifier<UserPreferences> {
  static const String _tempKey = 'pref_temp_unit';
  static const String _lengthKey = 'pref_length_unit';
  static const String _currencyKey = 'pref_currency';
  static const String _swipeModeKey = 'pref_swipe_mode';

  @override
  UserPreferences build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    final tempIndex = prefs.getInt(_tempKey) ?? 0;
    final lengthIndex = prefs.getInt(_lengthKey) ?? 0;
    final currencyStr = prefs.getString(_currencyKey) ?? 'UAH';
    final swipeIndex = prefs.getInt(_swipeModeKey) ?? 1; // Default to grip mode

    return UserPreferences(
      tempUnit: TempUnit.values[tempIndex],
      lengthUnit: LengthUnit.values[lengthIndex],
      currency: _parseCurrency(currencyStr),
      lotSwipeMode: LotSwipeMode.values[swipeIndex],
    );
  }

  Currency _parseCurrency(String val) {
    switch (val.toUpperCase()) {
      case 'EUR':
        return Currency.eur;
      case 'USD':
        return Currency.usd;
      default:
        return Currency.uah;
    }
  }

  String _currencyToString(Currency c) {
    switch (c) {
      case Currency.eur:
        return 'EUR';
      case Currency.usd:
        return 'USD';
      case Currency.uah:
        return 'UAH';
    }
  }

  Future<void> setTempUnit(TempUnit unit) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_tempKey, unit.index);
    state = state.copyWith(tempUnit: unit);
  }

  Future<void> setLengthUnit(LengthUnit unit) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_lengthKey, unit.index);
    state = state.copyWith(lengthUnit: unit);
  }

  Future<void> setCurrency(Currency currency) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_currencyKey, _currencyToString(currency));
    state = state.copyWith(currency: currency);
  }

  Future<void> setLotSwipeMode(LotSwipeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_swipeModeKey, mode.index);
    state = state.copyWith(lotSwipeMode: mode);
  }

  // Conversion helpers
  double celsiusToFahrenheit(double c) => (c * 9 / 5) + 32;
  double fahrenheitToCelsius(double f) => (f - 32) * 5 / 9;

  double metersToFeet(double m) => m * 3.28084;
  double feetToMeters(double ft) => ft / 3.28084;
}

final preferencesProvider =
    NotifierProvider<PreferencesNotifier, UserPreferences>(() {
      return PreferencesNotifier();
    });
