import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';

class FlavorValuesNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return {
      'bitterness': 1.0,
      'acidity': 1.0,
      'sweetness': 1.0,
      'body': 1.0,
      'intensity': 1.0,
      'aftertaste': 1.0,
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
  final bool interactive;
  final bool isLocked;
  final Map<String, double>? staticValues;
  final double height;
  final double labelFontSize;

  const SensoryRadarChart({
    super.key,
    this.interactive = true,
    this.isLocked = false,
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
    final Map<String, double> values =
        widget.staticValues ?? ref.watch(flavorValuesProvider);
    final theme = Theme.of(context);

    return Column(
      children: [
        if (widget.interactive && widget.staticValues == null) ...[
          // Educational templates
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _TemplateChip(ref.t('process_washed_label'), 'Clean & Bright', {
                  'bitterness': 0.3,
                  'acidity': 0.8,
                  'sweetness': 0.6,
                  'body': 0.4,
                  'intensity': 0.5,
                  'aftertaste': 0.6,
                }),
                const SizedBox(width: 8),
                _TemplateChip(
                  ref.t('process_natural_label'),
                  'Fruity & Sweet',
                  {
                    'bitterness': 0.4,
                    'acidity': 0.5,
                    'sweetness': 0.9,
                    'body': 0.7,
                    'intensity': 0.8,
                    'aftertaste': 0.8,
                  },
                ),
                const SizedBox(width: 8),
                _TemplateChip(
                  ref.t('process_honey_label'),
                  'Sticky & Balanced',
                  {
                    'bitterness': 0.5,
                    'acidity': 0.6,
                    'sweetness': 0.8,
                    'body': 0.6,
                    'intensity': 0.7,
                    'aftertaste': 0.7,
                  },
                ),
              ],
            ),
          ),
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
              final bool canInteract = widget.interactive && !widget.isLocked;

              return GestureDetector(
                onPanStart: canInteract
                    ? (details) => _handleDragStart(
                        details.localPosition,
                        center,
                        radius,
                        values,
                      )
                    : null,
                onPanUpdate: canInteract
                    ? (details) => _handleDragUpdate(
                        details.localPosition,
                        center,
                        radius,
                      )
                    : null,
                onPanEnd: canInteract
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
    
    // STRICT ORDER of the 6 axes
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

    // 4. Vertex dots for better visibility
    final dotPaint = Paint()..color = primaryColor;
    for (var point in points) {
      canvas.drawCircle(point, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}

class _TemplateChip extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Map<String, double> values;
  const _TemplateChip(this.title, this.subtitle, this.values);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(flavorValuesProvider.notifier).setValues(values),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFC8A96E),
                fontSize: 12,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 9, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
