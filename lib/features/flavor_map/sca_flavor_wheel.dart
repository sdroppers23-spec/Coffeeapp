import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sca_flavor_wheel_data.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/l10n/sca_flavor_wheel_l10n.dart';

class ScaFlavorWheel extends ConsumerStatefulWidget {
  final double size;
  final Function(String key, Color color, List<String> items)? onSelect;

  const ScaFlavorWheel({super.key, this.size = 350, this.onSelect});

  @override
  ConsumerState<ScaFlavorWheel> createState() => _ScaFlavorWheelState();
}

class _ScaFlavorWheelState extends ConsumerState<ScaFlavorWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late TransformationController _transformationController;
  String? _selectedCategory;

  final List<WheelCategory> _data = ScaFlavorData.localizedData;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ), // Slightly longer for elegance
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic, // Much smoother than linear
    );
    _transformationController = TransformationController();
    _transformationController.addListener(() {
      setState(() {}); // Rebuild to update panEnabled if needed
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleTap(Offset localPosition, double currentSize) {
    final center = Offset(currentSize / 2, currentSize / 2);
    final distance = (localPosition - center).distance;
    final fullRadius = currentSize / 2;

    // Ring radii must match _ScaWheelPainter (r0, r1, r2, r3)
    final r0 = fullRadius * 0.15;
    final r1 = fullRadius * 0.45;
    final r2 = fullRadius * 0.68;
    final r3 = fullRadius * 0.96;

    if (distance <= r0 || distance >= r3) return;

    final isCatRing = distance > r0 && distance < r1;
    final isSubRing = distance > r1 && distance < r2;
    final isNoteRing = distance > r2 && distance < r3;

    if (!isCatRing && !isSubRing && !isNoteRing) return;

    final angle =
        (math.atan2(
              localPosition.dy - center.dy,
              localPosition.dx - center.dx,
            ) +
            (math.pi / 2)) %
        (2 * math.pi);

    double currentAngle = 0;
    final totalNotesCount = _data.fold(
      0,
      (sum, cat) => sum + cat.sub.fold(0, (s, sub) => s + sub.noteKeys.length),
    );
    final angleStep = (2 * math.pi) / totalNotesCount;

    for (var cat in _data) {
      final catNotesCount = cat.sub.fold(
        0,
        (s, sub) => s + sub.noteKeys.length,
      );
      final catAngle = catNotesCount * angleStep;

      if (angle >= currentAngle && angle < currentAngle + catAngle) {
        if (isCatRing) {
          widget.onSelect?.call(
            cat.key,
            cat.color,
            cat.sub.map((s) => s.key).toList(),
          );
          setState(() => _selectedCategory = cat.key);
          return;
        }

        double subAngleStart = currentAngle;
        for (var sub in cat.sub) {
          final subAngle = sub.noteKeys.length * angleStep;
          if (angle >= subAngleStart && angle < subAngleStart + subAngle) {
            if (isSubRing) {
              widget.onSelect?.call(sub.key, sub.color, sub.noteKeys);
              setState(() => _selectedCategory = sub.key);
              return;
            }

            double noteAngleStart = subAngleStart;
            for (var noteKey in sub.noteKeys) {
              if (angle >= noteAngleStart &&
                  angle < noteAngleStart + angleStep) {
                widget.onSelect?.call(noteKey, sub.color, [sub.key, cat.key]);
                setState(() => _selectedCategory = noteKey);
                return;
              }
              noteAngleStart += angleStep;
            }
          }
          subAngleStart += subAngle;
        }
      }
      currentAngle += catAngle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Set size to fit screen width exactly
        final currentSize = constraints.maxWidth;

        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black,
                    Colors.black,
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.02, 0.88, 0.96, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: InteractiveViewer(
                transformationController: _transformationController,
                minScale: 0.8, // Allow slight zoom out
                maxScale: 4.0,
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(40),
                constrained: true, // Change to true for centering
                child: Center(
                  child: GestureDetector(
                    onTapUp: (details) =>
                        _handleTap(details.localPosition, currentSize),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          width: currentSize,
                          height: currentSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: RepaintBoundary(
                              child: CustomPaint(
                                size: Size(currentSize, currentSize),
                                painter: _ScaWheelPainter(
                                  data: _data,
                                  animationValue: _animation.value,
                                  selectedCategory: _selectedCategory,
                                  ref: ref,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScaWheelPainter extends CustomPainter {
  final List<WheelCategory> data;
  final double animationValue;
  final String? selectedCategory;
  final WidgetRef ref;

  _ScaWheelPainter({
    required this.data,
    required this.animationValue,
    this.selectedCategory,
    required this.ref,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final totalNotesCount = data.fold<int>(
      0,
      (sum, cat) =>
          sum + cat.sub.fold<int>(0, (s, sub) => s + sub.noteKeys.length),
    );
    final fullRadius = size.width / 2;
    final angleStep = (2 * math.pi) / totalNotesCount;

    // Rings layout
    final r0 = fullRadius * 0.15; // Smaller inner white hole
    final r1 = fullRadius * 0.45; // Category ring
    final r2 = fullRadius * 0.68; // Subcategory ring
    final r3 = fullRadius * 0.96; // Notes ring (pushed outer)

    final currentLocale = ref.watch(localeProvider);

    double currentAngle = -math.pi / 2; // Start from top

    for (var cat in data) {
      final catNotesCount = cat.sub.fold<int>(
        0,
        (s, sub) => s + sub.noteKeys.length,
      );
      final catSweepAngle = catNotesCount * angleStep * animationValue;

      // 1. Draw Inner Ring (Category)
      final catPaint = Paint()
        ..color = cat.color.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;
      final borderPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      _drawFlatArc(
        canvas,
        center,
        r0,
        r1,
        currentAngle,
        catSweepAngle,
        catPaint,
      );
      _drawFlatArc(
        canvas,
        center,
        r0,
        r1,
        currentAngle,
        catSweepAngle,
        borderPaint,
      );

      // Label for Cat
      _drawTextInsideArc(
        canvas,
        ScaFlavorWheelL10n.translate(currentLocale, cat.name),
        center,
        currentAngle,
        catSweepAngle,
        r0,
        r1,
        Colors.white,
        9.0,
        true,
      );

      // 2. Draw Middle Ring (Subcategory)
      double subStartAngle = currentAngle;
      for (var sub in cat.sub) {
        final subSweepAngle = sub.noteKeys.length * angleStep * animationValue;
        final subPaint = Paint()
          ..color = sub.color.withValues(alpha: 0.7)
          ..style = PaintingStyle.fill;

        _drawFlatArc(
          canvas,
          center,
          r1,
          r2,
          subStartAngle,
          subSweepAngle,
          subPaint,
        );
        _drawFlatArc(
          canvas,
          center,
          r1,
          r2,
          subStartAngle,
          subSweepAngle,
          borderPaint,
        );

        // Label for Subcategory (only if wide enough)
        if (subSweepAngle > 0.05) {
          _drawTextInsideArc(
            canvas,
            ScaFlavorWheelL10n.translate(currentLocale, sub.name),
            center,
            subStartAngle,
            subSweepAngle,
            r1,
            r2,
            Colors.white,
            8.0,
            true,
          );
        }

        // 3. Draw Outer Ring (Notes)
        double noteStartAngle = subStartAngle;
        for (var noteKey in sub.noteKeys) {
          final noteSweepAngle = angleStep * animationValue;
          final notePaint = Paint()
            ..color = sub.color.withValues(alpha: 0.7)
            ..style = PaintingStyle.fill;

          _drawFlatArc(
            canvas,
            center,
            r2,
            r3,
            noteStartAngle,
            noteSweepAngle,
            notePaint,
          );
          _drawFlatArc(
            canvas,
            center,
            r2,
            r3,
            noteStartAngle,
            noteSweepAngle,
            borderPaint,
          );

          // Label for Note (Inside tile) with smooth fade-in - DELAYED for performance
          final labelOpacity = ((animationValue - 0.85) / 0.15).clamp(0.0, 1.0);
          if (labelOpacity > 0.05) {
            if (noteSweepAngle > 0.01) {
              _drawTextInsideArc(
                canvas,
                ScaFlavorWheelL10n.translate(currentLocale, noteKey),
                center,
                noteStartAngle,
                noteSweepAngle,
                r2,
                r3,
                Colors.white.withValues(alpha: 0.9 * labelOpacity),
                7.2,
                false,
              );
            }
          }

          noteStartAngle += noteSweepAngle;
        }

        subStartAngle += subSweepAngle;
      }

      currentAngle += catSweepAngle;
    }

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawCircle(center, r0, gridPaint);
    canvas.drawCircle(center, r1, gridPaint);
    canvas.drawCircle(center, r2, gridPaint);
    canvas.drawCircle(center, r3, gridPaint);
  }

  void _drawFlatArc(
    Canvas canvas,
    Offset center,
    double innerR,
    double outerR,
    double startAngle,
    double sweepAngle,
    Paint paint,
  ) {
    canvas.drawPath(
      Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: outerR),
          startAngle,
          sweepAngle,
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: innerR),
          startAngle + sweepAngle,
          -sweepAngle,
          false,
        )
        ..close(),
      paint,
    );
  }

  void _drawTextInsideArc(
    Canvas canvas,
    String text,
    Offset center,
    double startAngle,
    double sweepAngle,
    double innerRadius,
    double outerRadius,
    Color color,
    double fontSize,
    bool isBold,
  ) {
    if (sweepAngle < 0.01) return;

    final middleRadius = (innerRadius + outerRadius) / 2;
    final maxAllowedWidth = sweepAngle * middleRadius * 0.9;

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    );

    tp.layout();

    // Scale if too wide
    double scale = 1.0;
    if (tp.width > maxAllowedWidth) {
      scale = maxAllowedWidth / tp.width;
      if (scale < 0.5) return; // Too small to read
    }

    final angle = startAngle + sweepAngle / 2;
    canvas.save();

    // Position at the center of the arc
    canvas.translate(
      center.dx + middleRadius * math.cos(angle),
      center.dy + middleRadius * math.sin(angle),
    );

    // Rotate to align with the arc
    canvas.rotate(angle + math.pi / 2);

    // Flip text if it's in the bottom half of the circle to keep it upright
    bool shouldFlip =
        (angle % (2 * math.pi)) > 0 && (angle % (2 * math.pi)) < math.pi;
    if (shouldFlip) {
      canvas.rotate(math.pi);
    }

    if (scale < 1.0) {
      canvas.scale(scale, scale);
    }

    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ScaWheelPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.selectedCategory != selectedCategory ||
        oldDelegate.data != data;
  }
}
