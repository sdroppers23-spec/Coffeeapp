import 'package:flutter/material.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF2A2422), // 7/10 darkness level of our Hearth & Bean palette
          ),
        ),

        // Content
        child,
      ],
    );
  }
}
