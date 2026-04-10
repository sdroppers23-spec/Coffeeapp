import 'package:flutter/material.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Solid black background
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),

        // Content
        child,
      ],
    );
  }
}
