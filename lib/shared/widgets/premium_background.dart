import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/design_theme_provider.dart';

class PremiumBackground extends ConsumerWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designTheme = ref.watch(designThemeProvider);
    final isCoffee = designTheme == AppDesignTheme.coffee;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Base Color
        DecoratedBox(
          decoration: BoxDecoration(
            color: isCoffee ? const Color(0xFF0C0B0A) : const Color(0xFF0F0E0D), 
          ),
        ),

        // 2. Minimal Ambient Depth
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  (isCoffee ? const Color(0xFFC8A96E) : const Color(0xFFC8A96E))
                      .withValues(alpha: isCoffee ? 0.05 : 0.03),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // 4. Content
        child,
      ],
    );
  }
}
