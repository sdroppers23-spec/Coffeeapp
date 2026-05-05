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
    final currentLocale = ref.watch(localeProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Set size to fit available space while maintaining circular shape
        final currentSize = math.min(
          constraints.maxWidth,
          constraints.maxHeight,
        );

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
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 0.5,
                                sigmaY: 0.5,
                              ),
                              child: RepaintBoundary(
                                child: CustomPaint(
                                  size: Size(currentSize, currentSize),
                                  painter: _ScaWheelPainter(
                                    data: _data,
                                    animationValue: _animation.value,
                                    selectedCategory: _selectedCategory,
                                    locale: currentLocale,
                                  ),
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
  final String locale;

  _ScaWheelPainter({
    required this.data,
    required this.animationValue,
    this.selectedCategory,
    required this.locale,
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
    final r0 = fullRadius * 0.12; // Even smaller inner white hole
    final r1 = fullRadius * 0.43; // Category ring (was 0.45)
    final r2 = fullRadius * 0.66; // Subcategory ring (was 0.68)
    final r3 = fullRadius * 0.94; // Notes ring (was 0.96)

    final currentLocale = locale;
    final double baseScaleSize = fullRadius;

    // Розрахунок адаптивних розмірів шрифтів
    final catFontSize = _calculateBaseFontSize(baseScaleSize, 11.5);
    final subFontSize = _calculateBaseFontSize(baseScaleSize, 8.0);
    final noteFontSize = _calculateBaseFontSize(baseScaleSize, 9.0);

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
        catFontSize,
        true,
        isOtherSection: cat.key == 'wheel_cat_others',
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
            subFontSize,
            true,
            isOtherSection: cat.key == 'wheel_cat_others',
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
                noteFontSize,
                false,
                isOtherSection: cat.key == 'wheel_cat_others',
                noteKey: noteKey,
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

  double _calculateBaseFontSize(double radius, double baseSize) {
    // radius тут — це fullRadius (половина ширини колеса)
    // baseSize — ідеальний розмір для мобільних пристроїв
    if (radius < 180) {
      return (radius / 180.0) * baseSize;
    }
    // На великих екранах (планшетах) додаємо невеликий коефіцієнт зростання
    return baseSize + (radius - 180) * 0.035 * (baseSize / 11.5);
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
    double rStart,
    double rEnd,
    Color color,
    double baseFontSize,
    bool bold, {
    bool isOtherSection = false,
    String? noteKey,
  }) {
    final middleAngle = startAngle + sweepAngle / 2;
    final middleRadius = (rStart + rEnd) / 2;

    final actualFontWeight = bold ? FontWeight.w500 : FontWeight.w400;
    const actualFontFamily = 'Outfit';

    // Handle multi-line wrapping for long names or specific delimiters
    List<String> lines = [text];
    if (text.contains(' / ')) {
      lines = text.split(' / ').map((e) => e.trim()).toList();
    } else if (text.length > 10 && text.contains(' ')) {
      // Very simple heuristic for wrapping at spaces
      final mid = text.length ~/ 2;
      int spaceIdx = text.indexOf(' ', mid);
      if (spaceIdx == -1) spaceIdx = text.lastIndexOf(' ', mid);
      if (spaceIdx != -1) {
        lines = [text.substring(0, spaceIdx), text.substring(spaceIdx + 1)];
      }
    }

    final List<TextPainter> painters = lines.map((line) {
      return TextPainter(
        text: TextSpan(
          text: line,
          style: GoogleFonts.getFont(
            actualFontFamily,
            color: color,
            fontSize: baseFontSize,
            fontWeight: actualFontWeight,
            letterSpacing: 0.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
    }).toList();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(middleAngle);
    canvas.translate(middleRadius, 0);

    // Flip text if it's in the bottom half of the circle
    // If it's the "Others" section, we FORCE flip as per user request to have it "upside down"
    // Also flip "Clove" specifically as per user request
    bool shouldFlip =
        isOtherSection ||
        (middleAngle > (math.pi / 2 + 0.2) &&
            middleAngle < (3 * math.pi / 2 - 0.2));

    if (noteKey == 'wheel_note_clove') {
      shouldFlip = !shouldFlip;
    }

    if (shouldFlip) {
      canvas.rotate(math.pi);
    }

    // Розрахунок максимально допустимої ширини тексту на дузі (з невеликим відступом 10%)
    final double maxAllowedWidth = sweepAngle * middleRadius * 0.9;

    // Масштабуємо шрифт вниз, якщо текст занадто широкий для дуги
    final double maxWidth = painters.fold<double>(
      0,
      (max, p) => math.max(max, p.width),
    );
    double scale = 1.0;
    if (maxWidth > maxAllowedWidth) {
      scale = (maxAllowedWidth / maxWidth).clamp(0.6, 1.0);
    }

    if (scale < 1.0) {
      canvas.scale(scale, scale);
    }

    // Stack lines vertically
    final totalHeight = painters.fold<double>(0, (sum, p) => sum + p.height);
    double currentY = -totalHeight / 2;

    for (var tp in painters) {
      tp.paint(canvas, Offset(-tp.width / 2, currentY));
      currentY += tp.height;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ScaWheelPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.selectedCategory != selectedCategory ||
        oldDelegate.data != data ||
        oldDelegate.locale != locale;
  }
}
