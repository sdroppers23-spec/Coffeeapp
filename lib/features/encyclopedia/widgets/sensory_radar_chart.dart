import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class SensoryRadarChart extends StatelessWidget {
  final Map<String, double> values;
  final double size;
  final Color? color;

  const SensoryRadarChart({
    super.key,
    required this.values,
    this.size = 200,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: RadarChartPainter(values, color: color),
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final Map<String, double> values;
  final Color? color;

  RadarChartPainter(this.values, {this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    // Leave room for labels
    final radius = math.min(size.width / 2, size.height / 2) * 0.7;
    
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final keys = values.keys.toList();
    final angleStep = (2 * math.pi) / keys.length;

    // 1. Draw background circles/polygons
    for (var i = 1; i <= 5; i++) {
      final r = radius * (i / 5);
      final path = Path();
      for (var j = 0; j < keys.length; j++) {
        final angle = j * angleStep - math.pi / 2;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, bgPaint);
    }

    // 2. Draw axes and labels
    final labelStyle = GoogleFonts.outfit(
      fontSize: 8,
      color: Colors.white38,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.5,
    );

    for (var j = 0; j < keys.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      final axisEnd = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      
      // Axis line
      canvas.drawLine(center, axisEnd, bgPaint);

      // Label
      final label = keys[j].toUpperCase();
      final textPainter = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      // Position label slightly outside the radius
      final labelRadius = radius + 12;
      final labelPos = Offset(
        center.dx + labelRadius * math.cos(angle) - textPainter.width / 2,
        center.dy + labelRadius * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, labelPos);
    }

    // 3. Value painting (stroke and fill)
    final mainColor = color ?? const Color(0xFFC8A96E);
    final valueStrokePaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final valueFillPaint = Paint()
      ..color = mainColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    // Detect scale automatically or default to 5
    double maxPossibleValue = 5.0;
    for (var v in values.values) {
      if (v > 5.0) maxPossibleValue = 10.0;
      if (v > 10.0) maxPossibleValue = 100.0;
    }

    final valuePath = Path();
    for (var j = 0; j < keys.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      // If values are already in 0-1 range but maxPossible is 5, we might need correction
      // But let's assume if any value > 1, it's absolute, else it's normalized
      double valRaw = values[keys[j]] ?? 0.0;
      double normalizedVal = valRaw / maxPossibleValue;
      if (valRaw <= 1.0 && maxPossibleValue == 5.0) {
         // Keep normalized as is if it's already 0-1
         normalizedVal = valRaw;
      }
      
      final r = radius * normalizedVal.clamp(0.0, 1.0);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      
      if (j == 0) {
        valuePath.moveTo(x, y);
      } else {
        valuePath.lineTo(x, y);
      }
    }
    valuePath.close();
    
    canvas.drawPath(valuePath, valueFillPaint);
    canvas.drawPath(valuePath, valueStrokePaint);
    
    // Draw dots at vertices
    final dotPaint = Paint()..color = mainColor;
    for (var j = 0; j < keys.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      double valRaw = values[keys[j]] ?? 0.0;
      double normalizedVal = valRaw / maxPossibleValue;
      if (valRaw <= 1.0 && maxPossibleValue == 5.0) normalizedVal = valRaw;
      
      final r = radius * normalizedVal.clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle)),
        2.5,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) => true;
}
