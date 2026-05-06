import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';
import '../../features/navigation/navigation_providers.dart';
import 'glass_container.dart';

/// A widget that handles the double-back-to-exit logic.
/// Should be used as the root of the main screens of the app branches.
class DoubleBackPopScope extends ConsumerStatefulWidget {
  final Widget child;
  final bool isFirstTab;

  const DoubleBackPopScope({
    super.key,
    required this.child,
    this.isFirstTab = false,
  });

  @override
  ConsumerState<DoubleBackPopScope> createState() => _DoubleBackPopScopeState();
}

class _DoubleBackPopScopeState extends ConsumerState<DoubleBackPopScope> {
  DateTime? _lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        // 1. If not on index 0, switch to it
        if (!widget.isFirstTab) {
          try {
            final shell = StatefulNavigationShell.of(context);
            ref.read(navBarVisibleProvider.notifier).show();
            shell.goBranch(0);
            return;
          } catch (e) {
            // Fallback if not inside a shell
            if (context.canPop()) {
              context.pop();
              return;
            }
          }
        }

        // 2. Double-tap exit logic for the first tab
        final now = DateTime.now();
        final isFirstPressOrExpired = _lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2);

        if (isFirstPressOrExpired) {
          _lastBackPressTime = now;
          if (!kIsWeb && !Platform.isWindows) {
            await HapticFeedback.lightImpact();
          }
          if (context.mounted) _showFrostedExitToast(context);
          return;
        }

        // 3. Final Exit
        if (!kIsWeb && !Platform.isWindows) {
          await HapticFeedback.mediumImpact();
        }
        await SystemNavigator.pop();
      },
      child: widget.child,
    );
  }

  void _showFrostedExitToast(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _FrostedCapsuleToast(
        message: ref.t('exit_confirm'),
        onFinished: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _FrostedCapsuleToast extends StatefulWidget {
  final String message;
  final VoidCallback onFinished;

  const _FrostedCapsuleToast({required this.message, required this.onFinished});

  @override
  State<_FrostedCapsuleToast> createState() => _FrostedCapsuleToastState();
}

class _FrostedCapsuleToastState extends State<_FrostedCapsuleToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onFinished());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Positioned(
      bottom: 110 + bottomPadding,
      left: 0,
      right: 0,
      child: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Material(
              color: Colors.transparent,
              child: GlassContainer(
                borderRadius: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundGradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                borderColor: Colors.white.withValues(alpha: 0.2),
                child: Text(
                  widget.message,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
