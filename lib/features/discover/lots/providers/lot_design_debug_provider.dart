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
  final double navBarBaseOpacity;
  final double flavorCardOpacity;
  final double flavorCardBlur;
  final double flavorCardBaseOpacity;
  final double profileOpacity;
  final double profileBlur;
  final double profileBaseOpacity;

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
    this.isDebugMode = true,
    this.navBarOpacity = 0.12,
    this.navBarBlur = 20.0,
    this.navBarBaseOpacity = 0.1,
    this.flavorCardOpacity = 0.15,
    this.flavorCardBlur = 25.0,
    this.flavorCardBaseOpacity = 0.1,
    this.profileOpacity = 0.15,
    this.profileBlur = 20.0,
    this.profileBaseOpacity = 0.1,
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
    double? navBarBaseOpacity,
    double? flavorCardOpacity,
    double? flavorCardBlur,
    double? flavorCardBaseOpacity,
    double? profileOpacity,
    double? profileBlur,
    double? profileBaseOpacity,
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
      navBarBaseOpacity: navBarBaseOpacity ?? this.navBarBaseOpacity,
      flavorCardOpacity: flavorCardOpacity ?? this.flavorCardOpacity,
      flavorCardBlur: flavorCardBlur ?? this.flavorCardBlur,
      flavorCardBaseOpacity: flavorCardBaseOpacity ?? this.flavorCardBaseOpacity,
      profileOpacity: profileOpacity ?? this.profileOpacity,
      profileBlur: profileBlur ?? this.profileBlur,
      profileBaseOpacity: profileBaseOpacity ?? this.profileBaseOpacity,
    );
  }

  static const defaultWhiteGlass = LotDesignConfig(
    baseColor: Colors.black,
    baseOpacity: 0.1,
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
    isDebugMode: true,
    navBarOpacity: 0.12,
    navBarBlur: 20.0,
    navBarBaseOpacity: 0.1,
    flavorCardOpacity: 0.15,
    flavorCardBlur: 25.0,
    flavorCardBaseOpacity: 0.1,
    profileOpacity: 0.15,
    profileBlur: 20.0,
    profileBaseOpacity: 0.1,
  );
}

class LotDesignDebugNotifier extends Notifier<LotDesignConfig> {
  @override
  LotDesignConfig build() => LotDesignConfig.defaultWhiteGlass;

  void updateConfig(LotDesignConfig config) {
    state = config;
  }

  void updateNavBar(double tintOpacity, double blur, double baseOpacity) {
    state = state.copyWith(navBarOpacity: tintOpacity, navBarBlur: blur, navBarBaseOpacity: baseOpacity);
  }

  void updateFlavorCard(double tintOpacity, double blur, double baseOpacity) {
    state = state.copyWith(flavorCardOpacity: tintOpacity, flavorCardBlur: blur, flavorCardBaseOpacity: baseOpacity);
  }

  void updateProfile(double tintOpacity, double blur, double baseOpacity) {
    state = state.copyWith(profileOpacity: tintOpacity, profileBlur: blur, profileBaseOpacity: baseOpacity);
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
