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
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 110, left: 16, right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 64,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B1A).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Countdown circle
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 1.0 - _controller.value,
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC8A96E)),
                            backgroundColor: Colors.white.withValues(alpha: 0.05),
                          ),
                          Text(
                            '$_secondsRemaining',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFC8A96E),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                        widget.onUndo();
                        ModernUndoTimer.hide();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: const Color(0xFFC8A96E),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'СКАСУВАТИ',
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
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
