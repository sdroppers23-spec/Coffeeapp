import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/glass_container.dart';
import '../../core/l10n/app_localizations.dart';
import 'terroir_globe.dart';

class FlavorValuesNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return {
      'Acidity': 0.6,
      'Sweetness': 0.8,
      'Body': 0.5,
      'Bitterness': 0.3,
      'Aroma': 0.7,
      'Finish': 0.4,
    };
  }

  void updateValue(String label, double newValue) {
    state = {...state, label: newValue};
  }
}

final flavorValuesProvider =
    NotifierProvider<FlavorValuesNotifier, Map<String, double>>(() {
      return FlavorValuesNotifier();
    });

class FlavorMapScreen extends ConsumerWidget {
  const FlavorMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Let premium background show through
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            title: Text(
              ref.t('specialty'),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: const Color(0xFFC8A96E),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Sensory Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 350,
                          child: const InteractiveSpiderChart(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Add Globe Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Global Terroir',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFC8A96E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // The New Terroir Globe Container
                  GlassContainer(
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SizedBox(
                        height: 500, // Fixed height or could be aspect ratio
                        child: const TerroirGlobe(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ), // Padding to account for the MainScaffold nav bar capsule
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveSpiderChart extends ConsumerStatefulWidget {
  const InteractiveSpiderChart({super.key});

  @override
  ConsumerState<InteractiveSpiderChart> createState() =>
      _InteractiveSpiderChartState();
}

class _InteractiveSpiderChartState
    extends ConsumerState<InteractiveSpiderChart> {
  String? _draggingLabel;

  @override
  Widget build(BuildContext context) {
    final values = ref.watch(flavorValuesProvider);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Educational selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _TemplateChip('Washed', 'Clean & Bright', {
                'Acidity': 0.8,
                'Sweetness': 0.6,
                'Body': 0.4,
                'Bitterness': 0.3,
                'Aroma': 0.7,
                'Finish': 0.6,
              }),
              const SizedBox(width: 8),
              _TemplateChip('Natural', 'Fruity & Sweet', {
                'Acidity': 0.5,
                'Sweetness': 0.9,
                'Body': 0.7,
                'Bitterness': 0.2,
                'Aroma': 0.9,
                'Finish': 0.5,
              }),
              const SizedBox(width: 8),
              _TemplateChip('Honey', 'Sticky & Balanced', {
                'Acidity': 0.6,
                'Sweetness': 0.8,
                'Body': 0.6,
                'Bitterness': 0.2,
                'Aroma': 0.7,
                'Finish': 0.7,
              }),
              const SizedBox(width: 8),
              _TemplateChip('Ethiopia', 'Floral & Tea-like', {
                'Acidity': 0.9,
                'Sweetness': 0.7,
                'Body': 0.3,
                'Bitterness': 0.2,
                'Aroma': 1.0,
                'Finish': 0.8,
              }),
              const SizedBox(width: 8),
              _TemplateChip('Brazil', 'Nutty & Chocolatey', {
                'Acidity': 0.4,
                'Sweetness': 0.7,
                'Body': 0.8,
                'Bitterness': 0.4,
                'Aroma': 0.6,
                'Finish': 0.6,
              }),
              const SizedBox(width: 8),
              _TemplateChip('Anaerobic', 'Funky & Complex', {
                'Acidity': 0.7,
                'Sweetness': 0.8,
                'Body': 0.6,
                'Bitterness': 0.4,
                'Aroma': 0.8,
                'Finish': 0.9,
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final center = Offset(
                constraints.maxWidth / 2,
                constraints.maxHeight / 2,
              );
              final radius =
                  min(constraints.maxWidth, constraints.maxHeight) / 2 - 40;

              return GestureDetector(
                onPanStart: (details) => _handleDragStart(
                  details.localPosition,
                  center,
                  radius,
                  values,
                ),
                onPanUpdate: (details) =>
                    _handleDragUpdate(details.localPosition, center, radius),
                onPanEnd: (_) => setState(() => _draggingLabel = null),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: RadarPainter(
                    values: values,
                    primaryColor: theme.colorScheme.secondary,
                    gridColor: theme.colorScheme.surface,
                    textColor: theme.colorScheme.onSurface,
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

      // Check if touch is near this point
      if ((Offset(pointX, pointY) - localPosition).distance < 35.0) {
        setState(() {
          _draggingLabel = labels[i];
        });
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

    // Calculate distance from center
    final distance = (localPosition - center).distance;

    // Normalize to 0.0 - 1.0 range
    double newValue = distance / maxRadius;
    newValue = newValue.clamp(0.0, 1.0);

    // Snap to grid (optional 0.1 increments)
    // newValue = (newValue * 10).roundToDouble() / 10;

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

  RadarPainter({
    required this.values,
    required this.primaryColor,
    required this.gridColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2 - 40;

    final labels = values.keys.toList();
    final angleStep = 2 * pi / labels.length;

    // 1. Draw grid (concentric polygons)
    final gridPaint = Paint()
      ..color = textColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int level = 1; level <= 5; level++) {
      final r = maxRadius * (level / 5);
      final path = Path();
      for (int i = 0; i < labels.length; i++) {
        final angle =
            angleStep * i - pi / 2; // Offset by -90 deg so first point is up
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }

        // Draw axis lines from center to outer edge
        if (level == 5) {
          canvas.drawLine(center, Offset(x, y), gridPaint);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // 2. Draw data shape
    final dataPath = Path();
    final points = <Offset>[];

    for (int i = 0; i < labels.length; i++) {
      final angle = angleStep * i - pi / 2;
      final val = values[labels[i]]!;
      final x = center.dx + maxRadius * val * cos(angle);
      final y = center.dy + maxRadius * val * sin(angle);

      points.add(Offset(x, y));
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();

    // Fill
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = primaryColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill,
    );

    // Stroke
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = primaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Data points & Labels
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < labels.length; i++) {
      final point = points[i];
      final angle = angleStep * i - pi / 2;

      // Draw point
      canvas.drawCircle(
        point,
        6,
        Paint()
          ..color = primaryColor
          ..style = PaintingStyle.fill,
      );

      // Draw label
      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();

      // Calculate label position slightly outside the max radius
      final labelR = maxRadius + 20;
      final labelX = center.dx + labelR * cos(angle);
      final labelY = center.dy + labelR * sin(angle);

      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.textColor != textColor;
  }
}

class _SensoryLegend extends StatelessWidget {
  const _SensoryLegend();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _LegendItem(label: 'Fruits', color: Colors.orange),
        _LegendItem(label: 'Acidity', color: Colors.yellow),
        _LegendItem(label: 'Body', color: Colors.brown),
        _LegendItem(label: 'Sweetness', color: Colors.pink),
        _LegendItem(label: 'Aftertaste', color: Colors.purple),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _TemplateChip extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Map<String, double> values;

  const _TemplateChip(this.title, this.subtitle, this.values);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        for (final entry in values.entries) {
          ref
              .read(flavorValuesProvider.notifier)
              .updateValue(entry.key, entry.value);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFC8A96E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
