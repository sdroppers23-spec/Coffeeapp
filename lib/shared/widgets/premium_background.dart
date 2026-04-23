import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PremiumBackground extends ConsumerWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Base Color
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF0F0E0D), 
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
                  const Color(0xFFC8A96E).withValues(alpha: 0.03),
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
