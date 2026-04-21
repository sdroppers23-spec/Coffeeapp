import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LotDesignConfig {
  final Color baseColor;
  final double baseOpacity;
  final double blur;
  final Color tintColor;
  final double tintOpacity;
  final double borderRadius;
  final Color borderColor;
  final double borderOpacity;
  final Color shadowColor;
  final double shadowBlur;
  final double shadowSpread;
  final double shadowOffsetY;
  final bool isDebugMode;

  // Specific overrides
  final double navBarOpacity;
  final double navBarBlur;
  final double flavorCardOpacity;
  final double flavorCardBlur;
  final double profileOpacity;
  final double profileBlur;

  const LotDesignConfig({
    required this.baseColor,
    required this.baseOpacity,
    required this.blur,
    required this.tintColor,
    required this.tintOpacity,
    required this.borderRadius,
    required this.borderColor,
    required this.borderOpacity,
    required this.shadowColor,
    required this.shadowBlur,
    required this.shadowSpread,
    required this.shadowOffsetY,
    this.isDebugMode = false,
    this.navBarOpacity = 0.12,
    this.navBarBlur = 20.0,
    this.flavorCardOpacity = 0.15,
    this.flavorCardBlur = 25.0,
    this.profileOpacity = 0.15,
    this.profileBlur = 20.0,
  });

  LotDesignConfig copyWith({
    Color? baseColor,
    double? baseOpacity,
    double? blur,
    Color? tintColor,
    double? tintOpacity,
    double? borderRadius,
    Color? borderColor,
    double? borderOpacity,
    Color? shadowColor,
    double? shadowBlur,
    double? shadowSpread,
    double? shadowOffsetY,
    bool? isDebugMode,
    double? navBarOpacity,
    double? navBarBlur,
    double? flavorCardOpacity,
    double? flavorCardBlur,
    double? profileOpacity,
    double? profileBlur,
  }) {
    return LotDesignConfig(
      baseColor: baseColor ?? this.baseColor,
      baseOpacity: baseOpacity ?? this.baseOpacity,
      blur: blur ?? this.blur,
      tintColor: tintColor ?? this.tintColor,
      tintOpacity: tintOpacity ?? this.tintOpacity,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderOpacity: borderOpacity ?? this.borderOpacity,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      shadowSpread: shadowSpread ?? this.shadowSpread,
      shadowOffsetY: shadowOffsetY ?? this.shadowOffsetY,
      isDebugMode: isDebugMode ?? this.isDebugMode,
      navBarOpacity: navBarOpacity ?? this.navBarOpacity,
      navBarBlur: navBarBlur ?? this.navBarBlur,
      flavorCardOpacity: flavorCardOpacity ?? this.flavorCardOpacity,
      flavorCardBlur: flavorCardBlur ?? this.flavorCardBlur,
      profileOpacity: profileOpacity ?? this.profileOpacity,
      profileBlur: profileBlur ?? this.profileBlur,
    );
  }

  static const defaultWhiteGlass = LotDesignConfig(
    baseColor: Colors.black,
    baseOpacity: 0.5,
    blur: 15.0,
    tintColor: Colors.white,
    tintOpacity: 0.1,
    borderRadius: 20.0,
    borderColor: Colors.white,
    borderOpacity: 0.12,
    shadowColor: Colors.black,
    shadowBlur: 20.0,
    shadowSpread: 0.0,
    shadowOffsetY: 4.0,
    isDebugMode: false,
    navBarOpacity: 0.12,
    navBarBlur: 20.0,
    flavorCardOpacity: 0.15,
    flavorCardBlur: 25.0,
    profileOpacity: 0.15,
    profileBlur: 20.0,
  );
}

class LotDesignDebugNotifier extends Notifier<LotDesignConfig> {
  @override
  LotDesignConfig build() => LotDesignConfig.defaultWhiteGlass;

  void updateConfig(LotDesignConfig config) {
    state = config;
  }

  void updateNavBar(double opacity, double blur) {
    state = state.copyWith(navBarOpacity: opacity, navBarBlur: blur);
  }

  void updateFlavorCard(double opacity, double blur) {
    state = state.copyWith(flavorCardOpacity: opacity, flavorCardBlur: blur);
  }

  void updateProfile(double opacity, double blur) {
    state = state.copyWith(profileOpacity: opacity, profileBlur: blur);
  }

  void reset() {
    state = LotDesignConfig.defaultWhiteGlass;
  }

  void toggleDebug(bool value) {
    state = state.copyWith(isDebugMode: value);
  }
}

final lotDesignDebugProvider = NotifierProvider<LotDesignDebugNotifier, LotDesignConfig>(() {
  return LotDesignDebugNotifier();
});
