import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/lot_design_debug_provider.dart';

class LotDesignDebugMenu extends ConsumerWidget {
  const LotDesignDebugMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(lotDesignDebugProvider);
    final notifier = ref.read(lotDesignDebugProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: Colors.white10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lot Card Diagnostic',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: config.isDebugMode,
                  onChanged: (val) => notifier.toggleDebug(val),
                  activeTrackColor: const Color(0xFFC8A96E),
                  activeThumbColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.white10),
            const SizedBox(height: 16),
            
            _SectionHeader(title: 'Presets'),
            Row(
              children: [
                _PresetButton(
                  label: 'Original White',
                  isSelected: config.tintColor == Colors.white,
                  onTap: () => notifier.reset(),
                ),
                const SizedBox(width: 8),
                _PresetButton(
                  label: 'Gold Aesthetic',
                  isSelected: config.tintColor == const Color(0xFFC8A96E),
                  onTap: () => notifier.updateConfig(config.copyWith(
                    tintColor: const Color(0xFFC8A96E),
                    borderColor: const Color(0xFFC8A96E),
                    baseOpacity: 0.5,
                    tintOpacity: 0.4,
                  )),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _SectionHeader(title: 'Base Layer (Layer 1)'),
            _DebugSlider(
              label: 'Base Opacity',
              value: config.baseOpacity,
              min: 0,
              max: 1,
              onChanged: (val) => notifier.updateConfig(config.copyWith(baseOpacity: val)),
            ),
            
            _SectionHeader(title: 'Blur Layer (Layer 2)'),
            _DebugSlider(
              label: 'Blur Level',
              value: config.blur,
              min: 0,
              max: 30,
              onChanged: (val) => notifier.updateConfig(config.copyWith(blur: val)),
            ),

            _SectionHeader(title: 'Glass Tint (Layer 3)'),
            _DebugSlider(
              label: 'Tint Opacity',
              value: config.tintOpacity,
              min: 0,
              max: 1,
              onChanged: (val) => notifier.updateConfig(config.copyWith(tintOpacity: val)),
            ),
            _DebugSlider(
              label: 'Border Opacity',
              value: config.borderOpacity,
              min: 0,
              max: 1,
              onChanged: (val) => notifier.updateConfig(config.copyWith(borderOpacity: val)),
            ),

            _SectionHeader(title: 'Geometry'),
            _DebugSlider(
              label: 'Border Radius',
              value: config.borderRadius,
              min: 0,
              max: 40,
              onChanged: (val) => notifier.updateConfig(config.copyWith(borderRadius: val)),
            ),

            _SectionHeader(title: 'Shadows'),
            _DebugSlider(
              label: 'Shadow Alpha',
              value: 0.3, // Static for now or add to config
              min: 0,
              max: 1,
              onChanged: (_) {}, // Future toggle
            ),
            _DebugSlider(
              label: 'Shadow Blur',
              value: config.shadowBlur,
              min: 0,
              max: 50,
              onChanged: (val) => notifier.updateConfig(config.copyWith(shadowBlur: val)),
            ),
            _DebugSlider(
              label: 'Shadow Y Offset',
              value: config.shadowOffsetY,
              min: -20,
              max: 20,
              onChanged: (val) => notifier.updateConfig(config.copyWith(shadowOffsetY: val)),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          color: Colors.white38,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _DebugSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _DebugSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
              ),
              Text(
                value.toStringAsFixed(2),
                style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFC8A96E),
              inactiveTrackColor: Colors.white10,
              thumbColor: const Color(0xFFC8A96E),
              trackHeight: 2,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PresetButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC8A96E).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFC8A96E) : Colors.white10,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected ? const Color(0xFFC8A96E) : Colors.white70,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
