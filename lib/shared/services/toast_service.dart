import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_container.dart';

class ToastService {
  static void showSuccess(BuildContext context, String message) {
    _showToast(
      context,
      message,
      Icons.check_circle_rounded,
      const Color(0xFFC8A96E),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showToast(context, message, Icons.info_outline_rounded, Colors.white70);
  }

  static void showWarning(BuildContext context, String message) {
    _showToast(
      context,
      message,
      Icons.warning_amber_rounded,
      Colors.orangeAccent,
    );
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, Icons.error_outline_rounded, Colors.redAccent);
  }

  static void _showToast(
    BuildContext context,
    String message,
    IconData icon,
    Color accentColor,
  ) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _FrostedCapsuleToast(
        message: message,
        icon: icon,
        accentColor: accentColor,
        onFinished: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _FrostedCapsuleToast extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onFinished;

  const _FrostedCapsuleToast({
    required this.message,
    required this.icon,
    required this.accentColor,
    required this.onFinished,
  });

  @override
  State<_FrostedCapsuleToast> createState() => _FrostedCapsuleToastState();
}

class _FrostedCapsuleToastState extends State<_FrostedCapsuleToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
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
      bottom: 125 + bottomPadding,
      left: 20,
      right: 20,
      child: Center(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: ScaleTransition(
              scale: _scale,
              child: Material(
                color: Colors.transparent,
                child: GlassContainer(
                  borderRadius: 30,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  backgroundGradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                  ),
                  borderColor: widget.accentColor.withValues(alpha: 0.3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(widget.icon, color: widget.accentColor, size: 20),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          widget.message,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
