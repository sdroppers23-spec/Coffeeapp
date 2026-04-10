import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/glass_container.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';
import 'terroir_globe.dart';
import 'sca_flavor_wheel.dart';

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

class FlavorMapScreen extends ConsumerStatefulWidget {
  const FlavorMapScreen({super.key});

  @override
  ConsumerState<FlavorMapScreen> createState() => _FlavorMapScreenState();
}

class _FlavorMapScreenState extends ConsumerState<FlavorMapScreen> {
  int _selectedTab = 1; // Default to Sphere to match screenshot

  void _setTab(int index) {
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
    setState(() => _selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Let premium background show through
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered Title
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Мапа смаків',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: const Color(0xFFC8A96E), // Gold text
                      ),
                    ),
                  ),
                  // Right aligned badges
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Connected Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // Very slight outline
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.greenAccent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.cloud_done,
                                size: 14,
                                color: Colors.greenAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Connected',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Avatar
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/placeholder_avatar.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.transparent,
                          ), // Fallback shape
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar Segmented Control
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _TabOption(
                      icon: Icons.radar,
                      label: 'Профіль',
                      isSelected: _selectedTab == 0,
                      onTap: () => _setTab(0),
                    ),
                  ),
                  Expanded(
                    child: _TabOption(
                      icon: Icons.public,
                      label: 'Сфера',
                      isSelected: _selectedTab == 1,
                      onTap: () => _setTab(1),
                    ),
                  ),
                  Expanded(
                    child: _TabOption(
                      icon: Icons.pie_chart_outline,
                      label: 'Коло смаків',
                      isSelected: _selectedTab == 2,
                      onTap: () => _setTab(2),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Content Area
            Expanded(
              child: IndexedStack(
                index: _selectedTab,
                children: [
                  // Tab 0: Profile
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
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
                      const SizedBox(height: 120), // Bottom nav padding
                    ],
                  ),

                  // Tab 1: Sphere
                  const TerroirGlobe(),

                  // Tab 2: Flavor Wheel
                  Column(
                    children: [
                      Expanded(
                        child:
                            ScaFlavorWheel(), // Assume it takes available space
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFC8A96E).withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? const Color(0xFFC8A96E) : Colors.white54,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFFC8A96E) : Colors.white54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
                    primaryColor: const Color(
                      0xFFC8A96E,
                    ), // Gold instead of secondary
                    gridColor: theme.colorScheme.surface,
                    textColor: Colors.white,
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
