import 'package:flutter/material.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Base Color (Lab Sync: 0xFF0F0E0D)
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF0F0E0D), 
          ),
        ),

        // 2. Minimal Ambient Depth (Transparent top glow)
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  const Color(0xFFC8A96E).withOpacity(0.03),
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
