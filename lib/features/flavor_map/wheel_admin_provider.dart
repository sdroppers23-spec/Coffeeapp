import 'package:flutter_riverpod/flutter_riverpod.dart';

class WheelSettings {
  final double fontSize;
  final int fontWeight;
  final String fontFamily;
  final bool showAdmin;

  WheelSettings({
    required this.fontSize,
    required this.fontWeight,
    required this.fontFamily,
    required this.showAdmin,
  });

  WheelSettings copyWith({
    double? fontSize,
    int? fontWeight,
    String? fontFamily,
    bool? showAdmin,
  }) {
    return WheelSettings(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      showAdmin: showAdmin ?? this.showAdmin,
    );
  }
}

class WheelAdminNotifier extends Notifier<WheelSettings> {
  @override
  WheelSettings build() {
    return WheelSettings(
      fontSize: 8.5,
      fontWeight: 500,
      fontFamily: 'Outfit',
      showAdmin: false,
    );
  }

  void updateFontSize(double value) => state = state.copyWith(fontSize: value);
  void updateFontWeight(int value) => state = state.copyWith(fontWeight: value);
  void updateFontFamily(String value) => state = state.copyWith(fontFamily: value);
  void toggleAdmin() => state = state.copyWith(showAdmin: !state.showAdmin);
}

final wheelAdminProvider = NotifierProvider<WheelAdminNotifier, WheelSettings>(
  () => WheelAdminNotifier(),
);
