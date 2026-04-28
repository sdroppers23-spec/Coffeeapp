import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuration for a single swipe action in [GlassSwipeWrapper].
class GlassSwipeAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const GlassSwipeAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

/// A premium swipe-reveal wrapper with "Ultimate Glass" architecture.
///
/// Uses a layered stack to prevent rectangular clipping artifacts on Android
/// and provides zero-latency background updates.
class GlassSwipeWrapper extends StatefulWidget {
  final Widget child;
  final GlassSwipeAction? leftAction;
  final GlassSwipeAction? rightAction;
  final double borderRadius;
  final bool isSwipeEnabled;
  final Key? dismissibleKey;

  const GlassSwipeWrapper({
    super.key,
    required this.child,
    this.leftAction,
    this.rightAction,
    this.borderRadius = 20.0,
    this.isSwipeEnabled = true,
    this.dismissibleKey,
  });

  @override
  State<GlassSwipeWrapper> createState() => _GlassSwipeWrapperState();
}

class _GlassSwipeWrapperState extends State<GlassSwipeWrapper> {
  final ValueNotifier<DismissDirection?> _swipeDir = ValueNotifier(null);

  @override
  void didUpdateWidget(GlassSwipeWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset swipe state if the key changes (meaning it's a different item)
    if (oldWidget.dismissibleKey != widget.dismissibleKey) {
      _swipeDir.value = null;
    }
  }

  @override
  void dispose() {
    _swipeDir.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSwipeEnabled ||
        (widget.leftAction == null && widget.rightAction == null)) {
      return widget.child;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          // 1. DYNAMIC REVEAL BACKGROUND (Under the card)
          Positioned.fill(
            child: ValueListenableBuilder<DismissDirection?>(
              valueListenable: _swipeDir,
              builder: (context, dir, child) {
                if (dir == null) return const SizedBox.shrink();

                final action = dir == DismissDirection.startToEnd
                    ? widget.leftAction
                    : widget.rightAction;

                if (action == null) return const SizedBox.shrink();

                final alignment = dir == DismissDirection.startToEnd
                    ? Alignment.centerLeft
                    : Alignment.centerRight;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: action.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        border: Border.all(
                          color: action.color.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      alignment: alignment,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(action.icon, color: action.color, size: 26),
                          const SizedBox(height: 4),
                          Text(
                            action.label,
                            style: GoogleFonts.outfit(
                              color: action.color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. DISMISSIBLE LAYER (Transparent interactable)
          Dismissible(
            key: widget.dismissibleKey ?? UniqueKey(),
            direction: _getDirection(),
            background: Container(color: Colors.transparent),
            secondaryBackground: Container(color: Colors.transparent),
            onUpdate: (details) {
              if (details.progress > 0) {
                if (_swipeDir.value != details.direction) {
                  _swipeDir.value = details.direction;
                }
              } else {
                _swipeDir.value = null;
              }
            },
            confirmDismiss: (direction) async {
              final action = direction == DismissDirection.startToEnd
                  ? widget.leftAction
                  : widget.rightAction;

              if (action != null) {
                action.onTap();
              }
              // Force reset swipe state after action to prevent ghost highlights
              _swipeDir.value = null;
              return false; // We don't dismiss the widget from the tree here
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }

  DismissDirection _getDirection() {
    if (widget.leftAction != null && widget.rightAction != null) {
      return DismissDirection.horizontal;
    }
    if (widget.leftAction != null) return DismissDirection.startToEnd;
    if (widget.rightAction != null) return DismissDirection.endToStart;
    return DismissDirection.none;
  }
}
