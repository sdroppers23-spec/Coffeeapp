import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Nav bar visibility provider ────────────────────────────────────────────
final navBarVisibleProvider = NotifierProvider<_NavBarVisibleNotifier, bool>(
  () => _NavBarVisibleNotifier(),
);

class _NavBarVisibleNotifier extends Notifier<bool> {
  @override
  bool build() => true;
  void show() => state = true;
  void hide() => state = false;
  void toggle() => state = !state;
}

// ─── Nav bar height provider ─────────────────────────────────────────────────
// Each child screen should watch this to add correct bottom padding.
final navBarHeightProvider = NotifierProvider<_NavBarHeightNotifier, double>(
  () => _NavBarHeightNotifier(),
);

class _NavBarHeightNotifier extends Notifier<double> {
  @override
  double build() => 80.0;
  void update(double height) => state = height;
}
