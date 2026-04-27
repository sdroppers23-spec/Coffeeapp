import 'dart:ui';
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
import '../../shared/widgets/sensory_radar_chart.dart';
import '../../shared/models/processing_methods_repository.dart';

// Duplicates removed, using shared versions from sensory_radar_chart.dart

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
  String _selectedMethodId = 'natural'; // Default to natural

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
    final values = ref.watch(flavorValuesProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Matches Discover Screen Style
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ref.t('specialty').toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC8A96E),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const SyncIndicator(),
                      ],
                    ),
                  ),
                  const UserProfileAvatar(radius: 17),
                ],
              ),
            ),

            // Internal Tab Bar Segmented Control: Matches Screenshot
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 390,
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
                                  ref.t('sensory_profile'),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFC8A96E),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Process Selection chips - All 10 methods
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      _buildMethodChip('natural'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('washed'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('honey'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('anaerobic'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('carbonic'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('thermal'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('lactic'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('yeast'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('koji'),
                                      const SizedBox(width: 8),
                                      _buildMethodChip('wet_hulled'),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),
                                Expanded(
                                  child: (() {
                                    final method =
                                        ProcessingMethodsRepository.getById(
                                          _selectedMethodId,
                                        );
                                    return SensoryRadarChart(
                                      interactive: true,
                                      isLocked: true, // Educational locking
                                      staticValues:
                                          method?.sensoryPreset ?? values,
                                      height: 280,
                                    );
                                  })(),
                                ),
                                const SizedBox(height: 3),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Tab 1: Sphere
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          const TerroirGlobe(),
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.4),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(
                                              0xFFC8A96E,
                                            ).withValues(alpha: 0.5),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          'COMING SOON',
                                          style: GoogleFonts.outfit(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFFC8A96E),
                                            letterSpacing: 6,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Interactive Terroir Globe',
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Tab 2: Flavor Wheel
                      Column(
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            ref.t('tab_wheel').toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC8A96E),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: ScaFlavorWheel(onSelect: _onFlavorSelect),
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
                        onClose: () =>
                            setState(() => _selectedFlavorKey = null),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodChip(String id) {
    final isSelected = _selectedMethodId == id;
    final method = ProcessingMethodsRepository.getById(id);
    final label = method != null ? ref.t(method.nameKey) : id;

    return ChoiceChip(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: isSelected ? Colors.black : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedMethodId = id;
          });
        }
      },
      selectedColor: const Color(0xFFC8A96E),
      backgroundColor: Colors.white.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFFC8A96E) : Colors.white10,
        ),
      ),
      showCheckmark: false,
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
            FlavorDescriptions.getDescription(
              flavorKey,
              ref.watch(localeProvider),
            ),
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
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFFC8A96E)
                        : Colors.white24,
                  ),
                ),
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
  @override
  Widget build(BuildContext context) {
    // Watch these exact labels to match screenshot

    return Column(
      children: [
        // Educational template selectors - styled as per screenshot
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TemplateChip(ref.t('process_washed_label'), 'Clean & Bright', {
                'bitterness': 0.2,
                'acidity': 0.9,
                'sweetness': 0.4,
                'body': 0.3,
                'intensity': 0.4,
                'aftertaste': 0.7,
              }),
              _TemplateChip(ref.t('process_natural_label'), 'Fruity & Sweet', {
                'bitterness': 0.4,
                'acidity': 0.4,
                'sweetness': 0.9,
                'body': 0.8,
                'intensity': 0.8,
                'aftertaste': 0.7,
              }),
              _TemplateChip(ref.t('process_honey_label'), 'Sticky & Balanced', {
                'bitterness': 0.3,
                'acidity': 0.6,
                'sweetness': 0.8,
                'body': 0.6,
                'intensity': 0.6,
                'aftertaste': 0.7,
              }),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SensoryRadarChart(interactive: true, height: 400),
          ),
        ),
      ],
    );
  }
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
          ref
              .read(flavorValuesProvider.notifier)
              .updateValue(entry.key, entry.value);
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
