import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/glass_container.dart';
import '../../core/providers/settings_provider.dart';
import 'terroir_globe.dart';
import 'sca_flavor_wheel.dart';
import '../../core/l10n/app_localizations.dart';

class FlavorValuesNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return {
      'АРОМАТ': 0.7,
      'СМАК': 0.8,
      'КИСЛОТНІСТЬ': 0.6,
      'ТІЛО': 0.5,
      'ПІСЛЯСМАК': 0.6,
      'БАЛАНС': 0.8,
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
  int _selectedTab = 0; // Default to Profile/Radar Chart
  String? _selectedFlavorKey;
  Color? _selectedFlavorColor;
  List<String>? _selectedFlavorItems;

  void _setTab(int index) {
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
    setState(() {
      _selectedTab = index;
      if (index != 2) {
        _selectedFlavorKey = null;
      }
    });
  }

  void _onFlavorSelect(String key, Color color, List<String> items) {
    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
    setState(() {
      _selectedFlavorKey = key;
      _selectedFlavorColor = color;
      _selectedFlavorItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Matches Screenshot
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    'Мапа смаків',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: const Color(0xFFC8A96E),
                    ),
                  ),
                  const Spacer(),
                  // Connected Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B231F), // Very dark green-grey
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.greenAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.cloud_done,
                          size: 14,
                          color: Color(0xFF62D39F), // Brighter green
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Connected',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF62D39F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/placeholder_avatar.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Internal Tab Bar Segmented Control: Matches Screenshot
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B1A), // Dark brown matte
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
              child: Stack(
                children: [
                  IndexedStack(
                    index: _selectedTab,
                    children: [
                      // Tab 0: Profile - Matching Screenshot
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF171312),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              Text(
                                'СЕНСОРНИЙ ПРОФІЛЬ',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFC8A96E),
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Expanded(child: InteractiveSpiderChart()),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),

                      // Tab 1: Sphere
                      const TerroirGlobe(),

                      // Tab 2: Flavor Wheel
                      Column(
                        children: [
                          Expanded(
                            child: ScaFlavorWheel(
                              onSelect: _onFlavorSelect,
                            ),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ],
                  ),

                  // Overlay Info Card if a flavor is selected
                  if (_selectedFlavorKey != null && _selectedTab == 2)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 140, // Above bottom nav
                      child: _FlavorInfoCard(
                        flavorKey: _selectedFlavorKey!,
                        color: _selectedFlavorColor!,
                        relatedItems: _selectedFlavorItems!,
                        onClose: () => setState(() => _selectedFlavorKey = null),
                      ),
                    ),
                ],
              ),
            ),

            // Simple Legend at the bottom of the stack or column as seen in screenshot
            if (_selectedTab == 0)
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 140),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LegendItem(color: const Color(0xFFFFEB3B), label: 'Кислотність'),
                    const SizedBox(width: 20),
                    _LegendItem(color: const Color(0xFF8D6E63), label: 'Тіло'),
                    const SizedBox(width: 20),
                    _LegendItem(color: const Color(0xFFE91E63), label: 'Солодкість'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _FlavorInfoCard extends ConsumerWidget {
  final String flavorKey;
  final Color color;
  final List<String> relatedItems;
  final VoidCallback onClose;

  const _FlavorInfoCard({
    required this.flavorKey,
    required this.color,
    required this.relatedItems,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    ref.t(flavorKey).toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: Colors.white54, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getFlavorDescription(flavorKey, ref),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'RELATED:',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: relatedItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            ref.t(item),
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFlavorDescription(String key, WidgetRef ref) {
    // Ideally this comes from l10n or a mapping
    if (key.contains('fruity')) return 'Яскрава фруктова кислотність, що нагадує про свіжі плоди та ягоди. Характерна для кави світлого обсмаження.';
    if (key.contains('floral')) return 'Делікатні квіткові ноти, часто асоціюються з жасмином, чаєм або квітами кави. Ознака високої якості.';
    if (key.contains('sweet')) return 'Переважаюча солодкість, від карамелі до коричневого цукру. Свідчить про зрілість зерна та баланс.';
    if (key.contains('roasted')) return 'Ноти карамелізації та смаження. Від солодових хлібних відтінків до темного шоколаду.';
    
    return 'Цей смаковий дескриптор описує унікальний характер вибраного сорту кави, що визначається його терруаром та обробкою.';
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: const Color(0xFFC8A96E), width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? const Color(0xFFC8A96E) : Colors.white24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFFC8A96E) : Colors.white24,
              ),
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
    // Watch these exact labels to match screenshot
    final values = ref.watch(flavorValuesProvider);

    return Column(
      children: [
        // Educational template selectors - styled as per screenshot
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const _TemplateChip(
                'Митий',
                'Clean & Bright',
                {
                  'АРОМАТ': 0.7,
                  'СМАК': 0.8,
                  'КИСЛОТНІСТЬ': 0.9,
                  'ТІЛО': 0.4,
                  'ПІСЛЯСМАК': 0.7,
                  'БАЛАНС': 0.8,
                },
              ),
              const _TemplateChip(
                'Натуральний',
                'Fruity & Sweet',
                {
                  'АРОМАТ': 0.9,
                  'СМАК': 0.9,
                  'КИСЛОТНІСТЬ': 0.5,
                  'ТІЛО': 0.7,
                  'ПІСЛЯСМАК': 0.6,
                  'БАЛАНС': 0.7,
                },
              ),
              const _TemplateChip(
                'Хані',
                'Sticky & Balanced',
                {
                  'АРОМАТ': 0.8,
                  'СМАК': 0.8,
                  'КИСЛОТНІСТЬ': 0.6,
                  'ТІЛО': 0.6,
                  'ПІСЛЯСМАК': 0.7,
                  'БАЛАНС': 0.9,
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
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
                    primaryColor: const Color(0xFFC8A96E),
                    textColor: Colors.white54,
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
    final distance = (localPosition - center).distance;
    double newValue = distance / maxRadius;
    newValue = newValue.clamp(0.0, 1.0);
    ref
        .read(flavorValuesProvider.notifier)
        .updateValue(_draggingLabel!, newValue);
  }
}

class RadarPainter extends CustomPainter {
  final Map<String, double> values;
  final Color primaryColor;
  final Color textColor;

  RadarPainter({
    required this.values,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2 - 40;

    final labels = values.keys.toList();
    final angleStep = 2 * pi / labels.length;

    // 1. Draw gridLines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

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
      final val = values[labels[i]] ?? 0.5;
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

    canvas.drawPath(
      dataPath,
      Paint()
        ..color = primaryColor.withValues(alpha: 0.25)
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      dataPath,
      Paint()
        ..color = primaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // 3. Dots and Labels
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < labels.length; i++) {
      final point = points[i];
      final angle = angleStep * i - pi / 2;

      canvas.drawCircle(point, 4, Paint()..color = primaryColor);

      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      );
      textPainter.layout();

      final labelR = maxRadius + 22;
      final labelX = center.dx + labelR * cos(angle);
      final labelY = center.dy + labelR * sin(angle);

      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}

class _TemplateChip extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Map<String, double> templateValues;

  const _TemplateChip(this.title, this.subtitle, this.templateValues);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        for (final entry in templateValues.entries) {
          ref
              .read(flavorValuesProvider.notifier)
              .updateValue(entry.key, entry.value);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1B1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: const Color(0xFFC8A96E),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(color: Colors.white24, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
