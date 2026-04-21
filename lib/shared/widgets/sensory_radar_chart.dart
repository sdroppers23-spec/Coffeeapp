import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';

class FlavorValuesNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return {
      'bitterness': 3.0,
      'acidity': 3.0,
      'sweetness': 3.0,
      'body': 3.0,
      'intensity': 3.0,
      'aftertaste': 3.0,
    };
  }

  void setValues(Map<String, double> newValues) {
    state = newValues;
  }

  void updateValue(String label, double newValue) {
    state = {...state, label: newValue};
  }
}

final flavorValuesProvider =
    NotifierProvider<FlavorValuesNotifier, Map<String, double>>(() {
      return FlavorValuesNotifier();
    });

class SensoryRadarChart extends ConsumerStatefulWidget {
  final bool isReadOnly;
  final bool interactive;
  final Map<String, double>? staticValues;
  final double height;
  final double labelFontSize;

  const SensoryRadarChart({
    super.key,
    this.interactive = true,
    this.isReadOnly = false,
    this.staticValues,
    this.height = 350,
    this.labelFontSize = 9,
  });

  @override
  ConsumerState<SensoryRadarChart> createState() => _SensoryRadarChartState();
}

class _SensoryRadarChartState extends ConsumerState<SensoryRadarChart> {
  String? _draggingLabel;

  @override
  Widget build(BuildContext context) {
    final bool canEdit = widget.interactive && !widget.isReadOnly && widget.staticValues == null;
    final theme = Theme.of(context);
    final Map<String, double> values = widget.staticValues ?? ref.watch(flavorValuesProvider);

    return Column(
      children: [
        if (canEdit) ...[
          // Educational templates (Removed in favor of unified processing selection)
          const SizedBox(height: 16),
        ],
        SizedBox(
          height: widget.height - (widget.interactive ? 60 : 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final center = Offset(
                constraints.maxWidth / 2,
                constraints.maxHeight / 2,
              );
              final radius =
                  min(constraints.maxWidth, constraints.maxHeight) / 2 -
                  60; // Increased padding

              return GestureDetector(
                onPanStart: canEdit
                    ? (details) => _handleDragStart(
                        details.localPosition,
                        center,
                        radius,
                        values,
                      )
                    : null,
                onPanUpdate: canEdit
                    ? (details) => _handleDragUpdate(
                        details.localPosition,
                        center,
                        radius,
                      )
                    : null,
                onPanEnd: canEdit
                    ? (_) => setState(() => _draggingLabel = null)
                    : null,
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: RadarPainter(
                    values: values,
                    primaryColor: theme.colorScheme.primary,
                    gridColor: theme.colorScheme.surface,
                    textColor: theme.colorScheme.onSurface,
                    labelFontSize: widget.labelFontSize,
                    ref: ref,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleDragStart(
    Offset localPosition,
    Offset center,
    double maxRadius,
    Map<String, double> values,
  ) {
    final labels = values.keys.toList();
    final angleStep = 2 * pi / labels.length;

    for (int i = 0; i < labels.length; i++) {
      final angle = angleStep * i - pi / 2;
      final val = values[labels[i]]!;
      final pointX = center.dx + maxRadius * val * cos(angle);
      final pointY = center.dy + maxRadius * val * sin(angle);

      if ((Offset(pointX, pointY) - localPosition).distance < 40.0) {
        setState(() => _draggingLabel = labels[i]);
        break;
      }
    }
  }

  void _handleDragUpdate(
    Offset localPosition,
    Offset center,
    double maxRadius,
  ) {
    if (_draggingLabel == null) return;
    final distance = (localPosition - center).distance;
    // Snap to 5 discrete levels (0.2, 0.4, 0.6, 0.8, 1.0)
    double newValue = ((distance / maxRadius * 5).round() / 5.0).clamp(
      0.2,
      1.0,
    ); // Minimum 1/5
    ref
        .read(flavorValuesProvider.notifier)
        .updateValue(_draggingLabel!, newValue);
  }
}

class RadarPainter extends CustomPainter {
  final Map<String, double> values;
  final Color primaryColor;
  final Color gridColor;
  final Color textColor;
  final double labelFontSize;
  final WidgetRef ref;

  RadarPainter({
    required this.values,
    required this.primaryColor,
    required this.gridColor,
    required this.textColor,
    required this.labelFontSize,
    required this.ref,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    // Adjust padding for labels to prevent clipping
    final maxRadius = min(size.width, size.height) / 2 - 48;
    // Use ordered keys to maintain same axis positions
    final labels = [
      'bitterness',
      'acidity',
      'sweetness',
      'body',
      'intensity',
      'aftertaste',
    ];
    final angleStep = 2 * pi / labels.length;

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15) // Force subtle white for grid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final axisPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3) // Force visible white for axes
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 1. Draw Axis Background (Circles/Polygons)
    for (int level = 1; level <= 5; level++) {
      final r = maxRadius * (level / 5);
      final path = Path();
      for (int i = 0; i < labels.length; i++) {
        final angle = angleStep * i - pi / 2;
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
        if (level == 5) canvas.drawLine(center, Offset(x, y), axisPaint);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // 2. Localized Labels at Axes Tips
    final labelStyle = GoogleFonts.outfit(
      color: const Color(0xFFC8A96E), // Premium gold for labels
      fontSize: labelFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );

    for (int i = 0; i < labels.length; i++) {
      final angle = angleStep * i - pi / 2;
      final text = ref.t(labels[i].toLowerCase()).toUpperCase();
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: labelStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      // Position label slightly further out
      final labelRadius = maxRadius + 22;
      final labelX =
          center.dx + labelRadius * cos(angle) - textPainter.width / 2;
      final labelY =
          center.dy + labelRadius * sin(angle) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(labelX, labelY));
    }

    // 3. Data Painting (Stroke and Fill)
    final dataPath = Path();
    final points = <Offset>[];

    // Safety check for normalization
    double maxValInSet = 0.0;
    for (var v in values.values) {
      if (v > maxValInSet) maxValInSet = v;
    }

    for (int i = 0; i < labels.length; i++) {
      final angle = angleStep * i - pi / 2;

      // If values are on 1-10 or 1-5 scale, normalize to 0-1
      double rawVal = values[labels[i]] ?? 0.0;
      double normalized = rawVal;
      if (maxValInSet > 1.2 && maxValInSet <= 5.0) {
        normalized = rawVal / 5.0;
      } else if (maxValInSet > 5.0) {
        normalized = rawVal / 10.0;
      }

      final r = maxRadius * normalized.clamp(0.0, 1.0);
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      points.add(Offset(x, y));
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    final fillPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    // 4. Vertex dots and Labels
    final dotPaint = Paint()..color = primaryColor;
    for (int i = 0; i < labels.length; i++) {
      final angle = angleStep * i - pi / 2;
      final point = points[i];
      canvas.drawCircle(point, 3, dotPaint);

      // Draw Label Text
      final labelText = _getLabelText(labels[i]);
      final textPainter = TextPainter(
        text: TextSpan(
          text: labelText.toUpperCase(),
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: labelFontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Position label outside the radius
      final labelRadius = maxRadius + 20;
      final lx = center.dx + labelRadius * cos(angle) - textPainter.width / 2;
      final ly = center.dy + labelRadius * sin(angle) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(lx, ly));
    }
  }

  String _getLabelText(String key) {
    switch (key) {
      case 'bitterness': return ref.t('bitterness');
      case 'acidity': return ref.t('acidity');
      case 'sweetness': return ref.t('sweetness');
      case 'body': return ref.t('body');
      case 'intensity': return ref.t('intensity');
      case 'aftertaste': return ref.t('aftertaste');
      default: return key;
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}
