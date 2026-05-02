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
  double Function()? getExtent;
  BoxConstraints? constraints;
  bool Function(Offset localPosition)? isWithinHandle;
  bool isGripMode = false;

  _CustomHorizontalDragRecognizer() : super(debugOwner: 'CustomHorizontalDragRecognizer');

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (getExtent == null || isWithinHandle == null) {
      super.addAllowedPointer(event);
      return;
    }

    // If we're starting a new gesture and Grip Mode is ON, we enforce the handle check
    // if the card is mostly closed. We use a 20px threshold to allow for minor jitter
    // while still strictly enforcing the handle for new swipes.
    final bool isMostlyClosed = getExtent!().abs() < 20.0;
    
    if (isGripMode && isMostlyClosed) {
      if (!isWithinHandle!(event.localPosition)) {
        return; // Do not allow this pointer to start the gesture
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

  bool _ignoreCurrentDrag = false;
  
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
    
    // Safety: if we were very close to zero, just snap to zero to prevent jitter
    if (_dragExtent.abs() < 5.0) {
      setState(() => _dragExtent = 0.0);
    }

    // Double-check grip mode constraints in onStart (second line of defense)
    if (widget.isGripMode && _dragExtent.abs() < 15.0) {
      final dx = details.localPosition.dx;
      const handleWidth = 85.0; // Slightly wider for the second-line check
      final isOnHandle = dx < handleWidth || dx > (context.size?.width ?? 0) - handleWidth;
      
      if (!isOnHandle) {
        _ignoreCurrentDrag = true;
        return;
      }
    }
    
    _ignoreCurrentDrag = false;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.isSwipeEnabled || _ignoreCurrentDrag) return;
    
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
    if (!widget.isSwipeEnabled || _ignoreCurrentDrag) {
      _ignoreCurrentDrag = false;
      if (_dragExtent != 0.0) _snapBack();
      return;
    }
    _ignoreCurrentDrag = false;

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
    _ignoreCurrentDrag = false;
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
    
    _controller.forward(from: 0.0).then((_) {
      if (mounted && !_isDragging) {
        setState(() {
          _dragExtent = 0.0;
        });
      }
    });
  }

  Widget _buildBackground() {
    // Low threshold to provide immediate visual feedback while avoiding noise during scrolling
    if (_dragExtent.abs() < 15.0) return const SizedBox.shrink();
    
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
        return RawGestureDetector(
          key: ValueKey('swipe_detector_${widget.isGripMode}_${constraints.maxWidth}'),
          behavior: HitTestBehavior.opaque,
          gestures: {
            _CustomHorizontalDragRecognizer: GestureRecognizerFactoryWithHandlers<_CustomHorizontalDragRecognizer>(
              () => _CustomHorizontalDragRecognizer(),
              (_CustomHorizontalDragRecognizer instance) {
                instance.getExtent = () => _dragExtent;
                instance.constraints = constraints;
                instance.isGripMode = widget.isGripMode;
                instance.isWithinHandle = (localPosition) {
                  final dx = localPosition.dx;
                  final width = constraints.maxWidth;
                  const handleWidth = 80.0; // Very wide handle for maximum reliability
                  return dx < handleWidth || dx > width - handleWidth;
                };
                instance.dragStartBehavior = DragStartBehavior.down;
                instance.onStart = _handleDragStart;
                instance.onUpdate = _handleDragUpdate;
                instance.onEnd = _handleDragEnd;
                instance.onCancel = _handleDragCancel;
              },
            ),
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background Layer
              Positioned.fill(
                child: _buildBackground(),
              ),
              
              // Moving Child Layer
              Transform.translate(
                offset: Offset(_dragExtent, 0),
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}
