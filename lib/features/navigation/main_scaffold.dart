import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart' show AppLocalizations;
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';

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
        body: Stack(
          children: [
            // Main Content
            Positioned.fill(
              child: AnimatedBranchContainer(
                currentIndex: widget.navigationShell.currentIndex,
                child: widget.navigationShell,
              ),
            ),

            // Floating Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 25, // Fixed position for capsule look
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                offset: navVisible ? Offset.zero : const Offset(0, 1.5),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: navVisible ? 1.0 : 0.0,
                  child: Padding(
                    key: _navBarKey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main Oval Bar
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: GlassContainer(
                              borderRadius: 40, // Oval shape
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 12,
                              ),
                              blur: 40,
                              opacity: 0.15,
                              borderColor: Colors.white.withValues(alpha: 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _NavBarItem(
                                    icon: Icons.radar,
                                    label:
                                        AppLocalizations.of(
                                          context,
                                        )?.specialty ??
                                        'Specialty',
                                    isSelected:
                                        widget.navigationShell.currentIndex ==
                                        0,
                                    onTap: () => _onTap(0),
                                  ),
                                  _NavBarItem(
                                    icon: Icons.explore_rounded,
                                    label:
                                        AppLocalizations.of(
                                          context,
                                        )?.discover ??
                                        'Discover',
                                    isSelected:
                                        widget.navigationShell.currentIndex ==
                                        1,
                                    onTap: () => _onTap(1),
                                  ),
                                  _NavBarItem(
                                    icon: Icons.coffee_rounded,
                                    label:
                                        AppLocalizations.of(context)?.recipes ??
                                        'Recipes',
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

                        // Rounded Settings Island
                        PressableScale(
                          onTap: () {
                            ref.read(settingsProvider.notifier).triggerHaptic();
                            context.push('/settings');
                          },
                          child: GlassContainer(
                            width: 56,
                            height: 56,
                            borderRadius: 28, // Perfect circle
                            padding: EdgeInsets.zero,
                            blur: 40,
                            opacity: 0.18,
                            borderColor: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.25),
                            child: const Center(
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                                size: 26,
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
    );
  }
}

class _NavBarItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return PressableScale(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFC8A96E).withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFFC8A96E) : Colors.white54,
                size: 24,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFFC8A96E) : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
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
