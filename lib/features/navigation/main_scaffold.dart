import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import '../../l10n/app_localizations.dart' show AppLocalizations; // Removed unused import
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import 'package:flutter/services.dart';

// ─── Nav bar visibility provider ────────────────────────────────────────────
final navBarVisibleProvider = NotifierProvider<_NavBarVisibleNotifier, bool>(
  () => _NavBarVisibleNotifier(),
);

class _NavBarVisibleNotifier extends Notifier<bool> {
  @override
  bool build() => true;
  void show() => state = true;
  void hide() => state = false;
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

class MainScaffold extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  final GlobalKey _navBarKey = GlobalKey();
  DateTime? _lastBackPressTime;

  @override
  void initState() {
    super.initState();
    // Measure nav bar after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateNavBarHeight());

    // Auto-show nav bar when switching tabs
    // This fixes the issue where full-screen pages might leave it hidden
    _setupNavListener();
  }

  void _setupNavListener() {
    // We can't directly listen to StatefulNavigationShell, but we can check if it changed
    // In GoRouter, a branch switch is a rebuild of this widget.
    // So we just force show() in every build or when onTap is called.
  }

  void _updateNavBarHeight() {
    final ctx = _navBarKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final height = box.size.height;
    // We use a fixed offset now, so we just report the actual height plus some margin
    ref.read(navBarHeightProvider.notifier).update(height + 36);
  }

  @override
  void didUpdateWidget(MainScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If branch index changed, force show the bar
    if (widget.navigationShell.currentIndex !=
        oldWidget.navigationShell.currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(navBarVisibleProvider.notifier).show();
      });
    }
  }

  void _onTap(int index) {
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();

    // Force show bar when tapping a tab
    ref.read(navBarVisibleProvider.notifier).show();

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navVisible = ref.watch(navBarVisibleProvider);

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) return;

            // 1. Prioritize nested navigation (detail screens, etc.)
            final nav = Navigator.maybeOf(context);
            if (nav != null && nav.canPop()) {
              nav.pop();
              return;
            }

            // 2. If not on the first tab, go to it first
            if (widget.navigationShell.currentIndex != 0) {
              _onTap(0);
              return;
            }

            // 3. Double tap exit logic
            final now = DateTime.now();
            final backButtonHasNotBeenPressedOrSnackBarHasExpired =
                _lastBackPressTime == null ||
                now.difference(_lastBackPressTime!) > const Duration(seconds: 2);

            if (backButtonHasNotBeenPressedOrSnackBarHasExpired) {
              _lastBackPressTime = now;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Натисніть ще раз щоб вийти',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xFFC8A96E).withValues(alpha: 0.8),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }

            // 4. Exit the app
            await SystemNavigator.pop();
          },
          child: Stack(
            children: [
              // Main Content
              Positioned.fill(
                child: AnimatedBranchContainer(
                  currentIndex: widget.navigationShell.currentIndex,
                  child: widget.navigationShell,
                ),
              ),

              // Floating Navigation Bar Area
              Positioned(
                left: 0,
                right: 0,
                bottom: 50, // Raised from 45 to 50
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  offset: navVisible ? Offset.zero : const Offset(0, 1.5),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: navVisible ? 1.0 : 0.0,
                    child: Padding(
                      key: _navBarKey,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Main Capsule Bar
                          Flexible(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 330),
                              child: GlassContainer(
                                borderRadius: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 6,
                                ),
                                blur: 60,
                                opacity: 0.1, // Reduced for better transparency
                                backgroundGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.15),
                                    const Color(
                                      0xFFFFF9E3,
                                    ).withValues(alpha: 0.08), // Softer Milk
                                  ],
                                ),
                                borderColor: Colors.white.withValues(alpha: 0.15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _NavBarItem(
                                      icon: Icons.track_changes_rounded,
                                      label: 'Спешелті',
                                      isSelected:
                                          widget.navigationShell.currentIndex ==
                                          0,
                                      onTap: () => _onTap(0),
                                    ),
                                    const SizedBox(width: 24),
                                    _NavBarItem(
                                      icon: Icons.explore_outlined,
                                      label: 'Відкриття',
                                      isSelected:
                                          widget.navigationShell.currentIndex ==
                                          1,
                                      onTap: () => _onTap(1),
                                    ),
                                    const SizedBox(width: 24),
                                    _NavBarItem(
                                      icon: Icons.local_cafe_outlined,
                                      label: 'Альтернатива',
                                      isSelected:
                                          widget.navigationShell.currentIndex ==
                                          2,
                                      onTap: () => _onTap(2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Separate Settings Island - Now Milky Glass
                          PressableScale(
                            onTap: () {
                              ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                              context.push('/settings');
                            },
                              child: GlassContainer(
                                width: 52,
                                height: 52,
                                borderRadius: 26,
                                blur: 60,
                                opacity: 0.1,
                                backgroundGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.15),
                                    const Color(
                                      0xFFFFF9E3,
                                    ).withValues(alpha: 0.08),
                                  ],
                                ),
                                borderColor: Colors.white.withValues(alpha: 0.15),
                              child: const Center(
                                child: Icon(
                                  Icons.settings_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends ConsumerStatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  ConsumerState<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends ConsumerState<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _oscillator;

  @override
  void initState() {
    super.initState();
    _oscillator = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.isSelected) {
      _oscillator.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _oscillator.repeat(reverse: true);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _oscillator.stop();
      _oscillator.reset();
    }
  }

  @override
  void dispose() {
    _oscillator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _oscillator,
            builder: (context, child) {
              final scale = 1.0 + (_oscillator.value * 0.1);
              return Transform.scale(
                scale: widget.isSelected ? scale : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        widget.isSelected
                            ? Colors.white.withValues(alpha: 0.1) // Subtle mask
                            : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow:
                        widget.isSelected
                            ? [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.15),
                                blurRadius: 25, // Softer, more diffuse
                                spreadRadius: 2,
                              ),
                            ]
                            : [],
                  ),
                  child: Icon(
                    widget.icon,
                    color:
                        widget.isSelected
                            ? const Color(0xFFC8A96E) // Gold for active
                            : Colors.white54,
                    size: 22,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 2),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 10,
              color:
                  widget.isSelected ? const Color(0xFFC8A96E) : Colors.white54,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

mixin NavBarAwareMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  EdgeInsets get navBarPadding {
    final navHeight = ref.watch(navBarHeightProvider);
    return EdgeInsets.only(bottom: navHeight);
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.02, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: ValueKey<int>(currentIndex), child: child),
    );
  }
}
