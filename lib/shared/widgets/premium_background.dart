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
        const DecoratedBox(decoration: BoxDecoration(color: Color(0xFF0A0908))),

        // 2. Minimal Ambient Depth
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Colors.black.withValues(alpha: 0.05), // Purely neutral
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
