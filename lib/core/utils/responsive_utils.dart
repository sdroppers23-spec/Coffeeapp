import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint;

  /// Returns recommended column count for grids based on screen width
  static int getGridColumnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 400) return 2;
    if (width < 600) return 2;
    if (width < 900) return 3;
    if (width < 1200) return 4;
    return 5;
  }

  /// Returns recommended maximum content width to keep reading comfortable
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1000;
  }
}

extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isWide => ResponsiveUtils.isWide(this);
  int get gridColumnCount => ResponsiveUtils.getGridColumnCount(this);
  double get maxContentWidth => ResponsiveUtils.getMaxContentWidth(this);
}
