import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
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

/// A custom horizontal drag recognizer that allows configuring swipe thresholds
/// and optional "grip zones" to prevent interference with TabBar scrolling.
class _CustomHorizontalDragRecognizer extends HorizontalDragGestureRecognizer {
  final bool isGripMode;
  final BoxConstraints constraints;

  _CustomHorizontalDragRecognizer({
    required this.isGripMode,
    required this.constraints,
  });

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (isGripMode) {
      final dx = event.localPosition.dx;
      // In grip mode, reject any touch outside the 60 logical pixel edge zones
      if (dx > 60 && dx < constraints.maxWidth - 60) {
        return; // Reject gesture immediately, allowing Scrollables to take it
      }
    }
    super.addAllowedPointer(event);
  }

  @override
  bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop) {
    // Using standard touch slop (usually 8.0) instead of the previous 18.0 for better responsiveness
    final double slop = (deviceTouchSlop ?? 8.0);
    return globalDistanceMoved.abs() > slop;
  }
}

/// A premium swipe-reveal wrapper with "Ultimate Glass" architecture.
///
/// Fully custom gesture handling allows setting drag handles and strict 
/// swipe thresholds to resolve interaction conflicts with TabBars.
class GlassSwipeWrapper extends StatefulWidget {
  final Widget child;
  final GlassSwipeAction? leftAction;
  final GlassSwipeAction? rightAction;
  final double borderRadius;
  final bool isSwipeEnabled;
  final bool isGripMode;
  final Key? dismissibleKey;

  const GlassSwipeWrapper({
    super.key,
    required this.child,
    this.leftAction,
    this.rightAction,
    this.borderRadius = 20.0,
    this.isSwipeEnabled = true,
    this.isGripMode = false,
    this.dismissibleKey,
  });

  @override
  State<GlassSwipeWrapper> createState() => _GlassSwipeWrapperState();
}

class _GlassSwipeWrapperState extends State<GlassSwipeWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragExtent = 0.0;
  bool _isDragging = false;
  
  static const double _maxReveal = 80.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void didUpdateWidget(GlassSwipeWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dismissibleKey != widget.dismissibleKey) {
      _controller.value = 0.0;
      _dragExtent = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _controller.stop();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.isSwipeEnabled) return;
    
    double newExtent = _dragExtent + details.primaryDelta!;
    
    // Restrict direction based on available actions
    if (newExtent > 0 && widget.leftAction == null) newExtent = 0;
    if (newExtent < 0 && widget.rightAction == null) newExtent = 0;

    // Apply friction if dragging beyond _maxReveal to create elasticity
    if (newExtent.abs() > _maxReveal) {
      final overscroll = newExtent.abs() - _maxReveal;
      final friction = math.max(0.1, 1.0 - (overscroll / 100.0));
      newExtent = _dragExtent + (details.primaryDelta! * friction);
    }

    setState(() {
      _dragExtent = newExtent;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    _isDragging = false;
    if (!widget.isSwipeEnabled) return;

    final isTriggered = _dragExtent.abs() > _maxReveal * 0.7 || 
                        (details.primaryVelocity?.abs() ?? 0) > 500;

    if (isTriggered) {
      if (_dragExtent > 0 && widget.leftAction != null) {
        widget.leftAction!.onTap();
      } else if (_dragExtent < 0 && widget.rightAction != null) {
        widget.rightAction!.onTap();
      }
    }

    _snapBack();
  }
  
  void _handleDragCancel() {
    _isDragging = false;
    _snapBack();
  }

  void _snapBack() {
    if (!mounted) return;
    
    final startExtent = _dragExtent;
    _controller.value = 0.0;
    
    final Animation<double> anim = Tween<double>(begin: startExtent, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)
    );
    
    anim.addListener(() {
      if (mounted && !_isDragging) {
        setState(() {
          _dragExtent = anim.value;
        });
      }
    });
    
    _controller.forward(from: 0.0);
  }

  Widget _buildBackground() {
    if (_dragExtent == 0) return const SizedBox.shrink();
    
    final isLeft = _dragExtent > 0;
    final action = isLeft ? widget.leftAction : widget.rightAction;
    if (action == null) return const SizedBox.shrink();

    final alignment = isLeft ? Alignment.centerLeft : Alignment.centerRight;

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: action.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(widget.borderRadius),
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
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSwipeEnabled || (widget.leftAction == null && widget.rightAction == null)) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Background Reveal
            Positioned.fill(
              child: _buildBackground(),
            ),
            
            // Interactive Layer
            RawGestureDetector(
              behavior: HitTestBehavior.opaque,
              gestures: {
                _CustomHorizontalDragRecognizer: GestureRecognizerFactoryWithHandlers<_CustomHorizontalDragRecognizer>(
                  () => _CustomHorizontalDragRecognizer(
                    isGripMode: widget.isGripMode,
                    constraints: constraints,
                  ),
                  (_CustomHorizontalDragRecognizer instance) {
                    instance
                      ..onStart = _handleDragStart
                      ..onUpdate = _handleDragUpdate
                      ..onEnd = _handleDragEnd
                      ..onCancel = _handleDragCancel;
                  },
                ),
              },
              child: Transform.translate(
                offset: Offset(_dragExtent, 0),
                child: widget.child,
              ),
            ),
          ],
        );
      }
    );
  }
}
