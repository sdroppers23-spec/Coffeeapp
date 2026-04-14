import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/settings_provider.dart';

class ModernUndoTimer extends ConsumerStatefulWidget {
  final String message;
  final VoidCallback onUndo;
  final VoidCallback onDismiss;
  final Duration duration;

  const ModernUndoTimer({
    super.key,
    required this.message,
    required this.onUndo,
    required this.onDismiss,
    this.duration = const Duration(seconds: 15),
  });

  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    required VoidCallback onUndo,
    required VoidCallback onDismiss,
  }) {
    hide();
    final entry = OverlayEntry(
      builder: (context) => ModernUndoTimer(
        message: message,
        onUndo: onUndo,
        onDismiss: onDismiss,
      ),
    );
    _currentEntry = entry;
    Overlay.of(context).insert(entry);
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }

  @override
  ConsumerState<ModernUndoTimer> createState() => _ModernUndoTimerState();
}

class _ModernUndoTimerState extends ConsumerState<ModernUndoTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _secondsRemaining = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.duration.inSeconds;
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDismiss();
        ModernUndoTimer.hide();
      }
    });

    _controller.forward();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Progress from 1.0 down to 0.0
    final progress = 1.0 - _controller.value;

    // Multi-stage color interpolation (Green -> Yellow -> Orange -> Red)
    Color getInterpolatedColor(double t) {
      if (t < 0.33) {
        return Color.lerp(Colors.greenAccent, Colors.yellowAccent, t / 0.33)!;
      } else if (t < 0.66) {
        return Color.lerp(
          Colors.yellowAccent,
          Colors.orangeAccent,
          (t - 0.33) / 0.33,
        )!;
      } else {
        return Color.lerp(
          Colors.orangeAccent,
          Colors.redAccent,
          (t - 0.66) / 0.34,
        )!;
      }
    }

    // Main highlight color for the bar
    final barColor = getInterpolatedColor(_controller.value);

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 110),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                width: 320,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                decoration: BoxDecoration(
                  // Near-black coffee glass background
                  color: const Color(0xFF070504).withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: barColor.withValues(alpha: 0.3), // Dynamic neon glow
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: barColor.withValues(alpha: 0.15),
                      blurRadius: 35,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.message,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Horizontal Layout: OK? on LEFT, UNDO on RIGHT
                    Row(
                      children: [
                        // 1. The animated "OK/Timer" button (LEFT)
                        Expanded(
                          flex: 18,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .triggerSelectionVibrate();
                                widget.onDismiss();
                                ModernUndoTimer.hide();
                              },
                              borderRadius: BorderRadius.circular(26),
                              highlightColor: Colors.white.withValues(alpha: 0.1),
                              splashColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1), // More opaque
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(
                                        color: barColor.withValues(alpha: 0.5),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        // Circular Waiter indicator (Filled to Zero)
                                        Positioned(
                                          left: 12,
                                          child: Center(
                                            child: SizedBox(
                                              width: 28,
                                              height: 28,
                                              child: CircularProgressIndicator(
                                                value: progress,
                                                strokeWidth: 3,
                                                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                                                backgroundColor: Colors.white10,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // 3D Glass Shine Layer
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white.withValues(
                                                  alpha: 0.2,
                                                ),
                                                Colors.transparent,
                                                Colors.black.withValues(
                                                  alpha: 0.1,
                                                ),
                                              ],
                                              stops: const [0.0, 0.5, 1.0],
                                            ),
                                          ),
                                        ),

                                        // Text and Timer
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'OK?',
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 15,
                                                  shadows: [
                                                    const Shadow(
                                                      color: Colors.black45,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withValues(
                                                    alpha: 0.4,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: Text(
                                                  '$_secondsRemaining',
                                                  style: GoogleFonts.outfit(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
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

                        const SizedBox(width: 8),

                        // 2. Undo Button (RIGHT)
                        Expanded(
                          flex: 12,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .triggerHaptic();
                                widget.onUndo();
                                ModernUndoTimer.hide();
                              },
                              borderRadius: BorderRadius.circular(26),
                              highlightColor: Colors.white.withValues(alpha: 0.1),
                              splashColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1), // More opaque
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
                                        width: 1.0,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'UNDO',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
