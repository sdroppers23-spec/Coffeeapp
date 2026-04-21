import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/user_profile_avatar.dart';
import '../../core/providers/settings_provider.dart';
import 'terroir_globe.dart';
import 'sca_flavor_wheel.dart';
import '../../shared/widgets/sync_indicator.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/l10n/flavor_descriptions.dart';
import '../navigation/navigation_providers.dart';
import '../discover/lots/providers/lot_design_debug_provider.dart';

class FlavorValuesNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return {
      'radar_aroma': 0.7,
      'radar_flavor': 0.8,
      'radar_acidity': 0.6,
      'radar_body': 0.5,
      'radar_aftertaste': 0.6,
      'radar_balance': 0.8,
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(navBarVisibleProvider.notifier).show();
    });
  }

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
              // Top Bar: Matches Discover Screen Style
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ref.t('specialty'),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const SyncIndicator(),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_rounded, color: Colors.white70),
                      onPressed: () => _showGlassSettings(context, ref),
                    ),
                    const UserProfileAvatar(radius: 17),
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
                        label: ref.t('tab_profile'),
                        isSelected: _selectedTab == 0,
                        onTap: () => _setTab(0),
                      ),
                    ),
                    Expanded(
                      child: _TabOption(
                        icon: Icons.public,
                        label: ref.t('tab_sphere'),
                        isSelected: _selectedTab == 1,
                        onTap: () => _setTab(1),
                      ),
                    ),
                    Expanded(
                      child: _TabOption(
                        icon: Icons.pie_chart_outline,
                        label: ref.t('tab_wheel'),
                        isSelected: _selectedTab == 2,
                        onTap: () => _setTab(2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

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
                                  ref.t('tab_sensory'),
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
                            const SizedBox(height: 12),
                          ],
                        ),
                      ],
                    ),

                    if (_selectedFlavorKey != null && _selectedTab == 2)
                      Positioned(
                        key: const Key('flavorCard'),
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
                  padding: const EdgeInsets.only(top: 12, bottom: 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendItem(color: const Color(0xFFFFEB3B), label: ref.t('radar_acidity')),
                      const SizedBox(width: 20),
                      _LegendItem(color: const Color(0xFF8D6E63), label: ref.t('radar_body')),
                      const SizedBox(width: 20),
                      _LegendItem(color: const Color(0xFFE91E63), label: ref.t('radar_sweetness')),
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
      debugKey: 'flavorCard',
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      blur: 25,
      opacity: 0.15,
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
            FlavorDescriptions.getDescription(flavorKey, ref.watch(localeProvider)),
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
              _TemplateChip(
                ref.t('process_washed_label'),
                'Clean & Bright',
                {
                  'radar_aroma': 0.7,
                  'radar_flavor': 0.8,
                  'radar_acidity': 0.9,
                  'radar_body': 0.4,
                  'radar_aftertaste': 0.7,
                  'radar_balance': 0.8,
                },
              ),
              _TemplateChip(
                ref.t('process_natural_label'),
                'Fruity & Sweet',
                {
                  'radar_aroma': 0.9,
                  'radar_flavor': 0.9,
                  'radar_acidity': 0.5,
                  'radar_body': 0.7,
                  'radar_aftertaste': 0.6,
                  'radar_balance': 0.7,
                },
              ),
              _TemplateChip(
                ref.t('process_honey_label'),
                'Sticky & Balanced',
                {
                  'radar_aroma': 0.8,
                  'radar_flavor': 0.8,
                  'radar_acidity': 0.6,
                  'radar_body': 0.6,
                  'radar_aftertaste': 0.7,
                  'radar_balance': 0.9,
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
                child: RepaintBoundary(
                  child: CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: RadarPainter(
                      values: values,
                      primaryColor: const Color(0xFFC8A96E),
                      textColor: Colors.white54,
                      ref: ref,
                    ),
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
  final WidgetRef ref;

  RadarPainter({
    required this.values,
    required this.primaryColor,
    required this.textColor,
    required this.ref,
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

      // Handle text wrapping/splitting if too wide
      final labelText = ref.t(labels[i]).toUpperCase();
      final maxLabelWidth = 65.0; // Restrict width to encourage wrapping
      
      textPainter.text = TextSpan(
        text: labelText,
        style: GoogleFonts.outfit( // Using Outfit for better wrapping aesthetics
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      );
      
      textPainter.layout(maxWidth: maxLabelWidth);

      // Position logic for labels around the radar
      final labelRadius = maxRadius + 22;
      final lx = center.dx + labelRadius * cos(angle);
      final ly = center.dy + labelRadius * sin(angle);

      textPainter.paint(canvas, Offset(lx - textPainter.width / 2, ly - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}

class _TemplateChip extends ConsumerWidget {
  final String label;
  final String sublabel;
  final Map<String, double> values;

  const _TemplateChip(this.label, this.sublabel, this.values);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        for (var entry in values.entries) {
          ref.read(flavorValuesProvider.notifier).updateValue(entry.key, entry.value);
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sublabel,
            style: GoogleFonts.outfit(
              fontSize: 8,
              color: Colors.white38,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}


  void _showGlassSettings(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final config = ref.watch(lotDesignDebugProvider);
          final notifier = ref.read(lotDesignDebugProvider.notifier);

          return GlassContainer(
            borderRadius: 30,
            blur: 40,
            opacity: 0.2,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Налаштування скла',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: config.isDebugMode,
                      onChanged: (val) => notifier.toggleDebug(val),
                      activeThumbColor: Colors.amber,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildGlassSection(
                          title: 'ЗАГАЛЬНІ (Увесь додаток)',
                          opacity: config.tintOpacity,
                          blur: config.blur,
                          onOpacityChanged: (val) => notifier.updateConfig(config.copyWith(tintOpacity: val)),
                          onBlurChanged: (val) => notifier.updateConfig(config.copyWith(blur: val)),
                        ),
                        const Divider(color: Colors.white10),
                        _buildGlassSection(
                          title: 'Нижня навігація',
                          opacity: config.navBarOpacity,
                          blur: config.navBarBlur,
                          onOpacityChanged: (val) => notifier.updateNavBar(val, config.navBarBlur),
                          onBlurChanged: (val) => notifier.updateNavBar(config.navBarOpacity, val),
                        ),
                        _buildGlassSection(
                          title: 'Картка смаків',
                          opacity: config.flavorCardOpacity,
                          blur: config.flavorCardBlur,
                          onOpacityChanged: (val) => notifier.updateFlavorCard(val, config.flavorCardBlur),
                          onBlurChanged: (val) => notifier.updateFlavorCard(config.flavorCardOpacity, val),
                        ),
                        _buildGlassSection(
                          title: 'Діалоги профілю',
                          opacity: config.profileOpacity,
                          blur: config.profileBlur,
                          onOpacityChanged: (val) => notifier.updateProfile(val, config.profileBlur),
                          onBlurChanged: (val) => notifier.updateProfile(config.profileOpacity, val),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => notifier.reset(),
                  child: const Text('Скинути все', style: TextStyle(color: Colors.white54)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlassSection({
    required String title,
    required double opacity,
    required double blur,
    required ValueChanged<double> onOpacityChanged,
    required ValueChanged<double> onBlurChanged,
  }) {
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        childrenPadding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
        children: [
          Row(
            children: [
              const Text('Прозорість:', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const Spacer(),
              Text(opacity.toStringAsFixed(2), style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: opacity,
            min: 0.0,
            max: 1.0,
            onChanged: onOpacityChanged,
            activeColor: Colors.amber,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Блюр:', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const Spacer(),
              Text(blur.toStringAsFixed(1), style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: blur,
            min: 0.0,
            max: 50.0,
            onChanged: onBlurChanged,
            activeColor: Colors.amber,
          ),
        ],
      ),
    );
  }
