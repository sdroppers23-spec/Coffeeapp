import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';

class FlavorNode {
  final String nameKey;
  final Color color;
  final String descKey;
  final List<FlavorNode> children;

  const FlavorNode({
    required this.nameKey,
    required this.color,
    required this.descKey,
    this.children = const [],
  });
}

// Minimal hierarchical representation of the SCA wheel
final List<FlavorNode> scaWheelData = [
  FlavorNode(
    nameKey: 'flavor_fruity',
    descKey: 'desc_fruity',
    color: const Color(0xFFDD2C00),
    children: [
      FlavorNode(
          nameKey: 'note_berry',
          color: const Color(0xFFC51162),
          descKey: 'desc_note_berry'),
      FlavorNode(
          nameKey: 'note_citrus',
          color: const Color(0xFFFF6D00),
          descKey: 'desc_note_citrus'),
      FlavorNode(
          nameKey: 'note_stone_fruit',
          color: const Color(0xFFFFAB00),
          descKey: 'desc_note_stone_fruit'),
    ],
  ),
  FlavorNode(
    nameKey: 'flavor_floral',
    descKey: 'desc_floral',
    color: const Color(0xFFF50057),
    children: [
      FlavorNode(
          nameKey: 'note_jasmine',
          color: const Color(0xFFFF80AB),
          descKey: 'desc_note_jasmine'),
      FlavorNode(
          nameKey: 'note_tea',
          color: const Color(0xFF8D6E63),
          descKey: 'desc_note_tea'),
    ],
  ),
  FlavorNode(
    nameKey: 'flavor_sweet',
    descKey: 'desc_sweet',
    color: const Color(0xFFFF9100),
    children: [
      FlavorNode(
          nameKey: 'note_caramel',
          color: const Color(0xFFFFAB40),
          descKey: 'desc_note_caramel'),
      FlavorNode(
          nameKey: 'note_honey',
          color: const Color(0xFFFFD180),
          descKey: 'desc_note_honey'),
      FlavorNode(
          nameKey: 'note_vanilla',
          color: const Color(0xFFFFE57F),
          descKey: 'desc_note_vanilla'),
    ],
  ),
  FlavorNode(
    nameKey: 'flavor_nutty',
    descKey: 'desc_nutty',
    color: const Color(0xFF5D4037),
    children: [
      FlavorNode(
          nameKey: 'note_chocolate',
          color: const Color(0xFF3E2723),
          descKey: 'desc_note_chocolate'),
      FlavorNode(
          nameKey: 'note_hazelnut',
          color: const Color(0xFF6D4C41),
          descKey: 'desc_note_hazelnut'),
    ],
  ),
  FlavorNode(
    nameKey: 'flavor_spicy',
    descKey: 'desc_spicy',
    color: const Color(0xFFC2185B),
    children: [
      FlavorNode(
          nameKey: 'note_cinnamon',
          color: const Color(0xFFAD1457),
          descKey: 'desc_note_cinnamon'),
      FlavorNode(
          nameKey: 'note_pepper',
          color: const Color(0xFF880E4F),
          descKey: 'desc_note_pepper'),
    ],
  ),
  FlavorNode(
    nameKey: 'flavor_earthy',
    descKey: 'desc_earthy',
    color: const Color(0xFF2E7D32),
    children: [
      FlavorNode(
          nameKey: 'note_forest',
          color: const Color(0xFF1B5E20),
          descKey: 'desc_note_forest'),
      FlavorNode(
          nameKey: 'note_tobacco',
          color: const Color(0xFF795548),
          descKey: 'desc_note_tobacco'),
    ],
  ),
];

class ScaFlavorWheelChart extends ConsumerStatefulWidget {
  const ScaFlavorWheelChart({super.key});

  @override
  ConsumerState<ScaFlavorWheelChart> createState() =>
      _ScaFlavorWheelChartState();
}

class _ScaFlavorWheelChartState extends ConsumerState<ScaFlavorWheelChart> {
  FlavorNode? _selectedNode;

  void _handleTap(Offset localPosition, double width, double height) {
    final center = Offset(width / 2, height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Calculate polar coordinates
    final distance = math.sqrt(dx * dx + dy * dy);
    // Adjust angle so 0 is at top
    late double angle = math.atan2(dy, dx) + math.pi / 2;
    if (angle < 0) angle += 2 * math.pi;

    final maxRadius = math.min(width, height) / 2;
    final centerRadius = maxRadius * 0.25;
    final ringWidth = (maxRadius - centerRadius) / 2;

    if (distance < centerRadius || distance > maxRadius) {
      if (mounted) setState(() => _selectedNode = null);
      return;
    }

    final totalAngle = 2 * math.pi;
    double currentAngle = 0.0;

    FlavorNode? tappedNode;

    for (final baseNode in scaWheelData) {
      final baseSweep =
          totalAngle * _weight(baseNode) / _totalWeight(scaWheelData);

      // Check if tap is in Base Ring
      if (distance >= centerRadius && distance <= centerRadius + ringWidth) {
        if (angle >= currentAngle && angle <= currentAngle + baseSweep) {
          tappedNode = baseNode;
          break;
        }
      }
      // Check if tap is in Outer Ring
      else if (distance > centerRadius + ringWidth && distance <= maxRadius) {
        if (angle >= currentAngle && angle <= currentAngle + baseSweep) {
          // Find which child
          if (baseNode.children.isNotEmpty) {
            double cAngle = currentAngle;
            final childSweep = baseSweep / baseNode.children.length;
            for (final child in baseNode.children) {
              if (angle >= cAngle && angle <= cAngle + childSweep) {
                tappedNode = child;
                break;
              }
              cAngle += childSweep;
            }
          } else {
            tappedNode = baseNode; // Fallback
          }
          break;
        }
      }
      currentAngle += baseSweep;
    }

    if (tappedNode != null && tappedNode != _selectedNode) {
      setState(() => _selectedNode = tappedNode);
    }
  }

  double _weight(FlavorNode node) {
    if (node.children.isEmpty) return 1.0;
    return node.children.length.toDouble();
  }

  double _totalWeight(List<FlavorNode> nodes) {
    return nodes.fold(0.0, (acc, n) => acc + _weight(n));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'SCA FLAVOR WHEEL',
                style: GoogleFonts.orbitron(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Натисніть на сегмент для пояснення смаку',
                style: TextStyle(fontSize: 11, color: Colors.white54),
              ),
              const SizedBox(height: 24),

              // Interactive Wheel
              LayoutBuilder(builder: (context, constraints) {
                final size = math.min(constraints.maxWidth, 350.0);
                return GestureDetector(
                  onTapUp: (d) => _handleTap(d.localPosition, size, size),
                  child: CustomPaint(
                    size: Size(size, size),
                    painter: _ScaWheelPainter(
                      data: scaWheelData,
                      ref: ref,
                      selectedNode: _selectedNode,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Detailed description below the wheel
        if (_selectedNode != null) ...[
          const SizedBox(height: 16),
          GlassContainer(
            padding: const EdgeInsets.all(20),
            borderColor: _selectedNode!.color.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _selectedNode!.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  _selectedNode!.color.withValues(alpha: 0.5),
                              blurRadius: 6)
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        // Try translating, fallback to the raw key if not found
                        ref.t(_selectedNode!.nameKey),
                        style: GoogleFonts.orbitron(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 20, color: Colors.white54),
                      onPressed: () => setState(() => _selectedNode = null),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  // Use untranslated string natively right now or dummy placeholder for 'descKey' until translation is ready
                  ref.t(_selectedNode!.descKey) == _selectedNode!.descKey
                      ? 'Тут буде детальний опис для "${ref.t(_selectedNode!.nameKey)}", як знайти його у каві, рецепторах та що його формує під час ферментації чи обсмажки.'
                      : ref.t(_selectedNode!.descKey),
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}

class _ScaWheelPainter extends CustomPainter {
  final List<FlavorNode> data;
  final WidgetRef ref;
  final FlavorNode? selectedNode;

  _ScaWheelPainter({
    required this.data,
    required this.ref,
    this.selectedNode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;

    final centerRadius = maxRadius * 0.25;
    final ringWidth = (maxRadius - centerRadius) / 2;

    final totalWeight = data.fold(
        0.0,
        (acc, n) =>
            acc + (n.children.isEmpty ? 1.0 : n.children.length.toDouble()));
    final totalAngle = 2 * math.pi;

    // Offset by -pi/2 so 0 is at the top
    double currentAngle = -math.pi / 2;

    // Paint Base Ring
    for (final baseNode in data) {
      final weight =
          baseNode.children.isEmpty ? 1.0 : baseNode.children.length.toDouble();
      final sweepAngle = totalAngle * weight / totalWeight;

      final isSelected =
          selectedNode == baseNode || baseNode.children.contains(selectedNode);
      final alpha = isSelected ? 1.0 : (selectedNode == null ? 0.9 : 0.4);

      final paint = Paint()
        ..color = baseNode.color.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      final rect =
          Rect.fromCircle(center: center, radius: centerRadius + ringWidth);
      canvas.drawArc(rect, currentAngle, sweepAngle, true, paint);
      canvas.drawArc(rect, currentAngle, sweepAngle, true, borderPaint);

      // Paint text
      _drawText(
          canvas,
          center,
          currentAngle + sweepAngle / 2,
          centerRadius + ringWidth / 2,
          ref.t(baseNode.nameKey),
          isSelected || selectedNode == null ? Colors.white : Colors.white54);

      currentAngle += sweepAngle;
    }

    // REDRAW STRATEGY:
    // The previous loop was conceptual. Let's do it in correct Z-order layer by layer.

    currentAngle = -math.pi / 2;
    // 1. Draw Outer Ring
    for (final baseNode in data) {
      final weight =
          baseNode.children.isEmpty ? 1.0 : baseNode.children.length.toDouble();
      final sweepAngle = totalAngle * weight / totalWeight;

      if (baseNode.children.isNotEmpty) {
        double cAngle = currentAngle;
        final childSweep = sweepAngle / baseNode.children.length;
        for (final child in baseNode.children) {
          final isChildSelected =
              selectedNode == child || selectedNode == baseNode;
          final cAlpha =
              isChildSelected ? 0.9 : (selectedNode == null ? 0.7 : 0.3);

          final rect = Rect.fromCircle(center: center, radius: maxRadius);
          canvas.drawArc(rect, cAngle, childSweep, true,
              Paint()..color = child.color.withValues(alpha: cAlpha));
          canvas.drawArc(
              rect,
              cAngle,
              childSweep,
              true,
              Paint()
                ..color = Colors.black45
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.0);

          _drawText(
            canvas,
            center,
            cAngle + childSweep / 2,
            centerRadius + ringWidth + ringWidth / 2,
            ref.t(child.nameKey),
            isChildSelected || selectedNode == null
                ? Colors.white
                : Colors.white38,
            fontSize: 8,
          );

          cAngle += childSweep;
        }
      }
      currentAngle += sweepAngle;
    }

    currentAngle = -math.pi / 2;
    // 2. Draw Inner Ring
    for (final baseNode in data) {
      final weight =
          baseNode.children.isEmpty ? 1.0 : baseNode.children.length.toDouble();
      final sweepAngle = totalAngle * weight / totalWeight;

      final isSelected =
          selectedNode == baseNode || baseNode.children.contains(selectedNode);
      final alpha = isSelected ? 1.0 : (selectedNode == null ? 0.9 : 0.4);

      final rect =
          Rect.fromCircle(center: center, radius: centerRadius + ringWidth);
      canvas.drawArc(rect, currentAngle, sweepAngle, true,
          Paint()..color = baseNode.color.withValues(alpha: alpha));
      canvas.drawArc(
          rect,
          currentAngle,
          sweepAngle,
          true,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0);

      _drawText(
        canvas,
        center,
        currentAngle + sweepAngle / 2,
        centerRadius + ringWidth / 2,
        ref.t(baseNode.nameKey),
        isSelected || selectedNode == null ? Colors.white : Colors.white70,
        fontSize: 10,
      );

      currentAngle += sweepAngle;
    }

    // 3. Draw Center Hole (Glass / Dark)
    canvas.drawCircle(
        center, centerRadius, Paint()..color = const Color(0xFF1E1E1E));
    canvas.drawCircle(
        center,
        centerRadius,
        Paint()
          ..color = const Color(0xFFC8A96E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);

    // Draw Center text
    final centerPainter = TextPainter(
      text: TextSpan(
        text: 'FLAVORS',
        style: GoogleFonts.orbitron(
          color: const Color(0xFFC8A96E),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    centerPainter.layout();
    centerPainter.paint(canvas,
        center - Offset(centerPainter.width / 2, centerPainter.height / 2));
  }

  void _drawText(Canvas canvas, Offset center, double angle, double distance,
      String text, Color color,
      {double fontSize = 10}) {
    // Determine position
    final dx = center.dx + distance * math.cos(angle);
    final dy = center.dy + distance * math.sin(angle);

    canvas.save();
    canvas.translate(dx, dy);

    // Rotate text so it faces correctly (radial)
    // Add pi/2 to make it tangent, or angle to make it radial
    late double textRot = angle;
    if (math.cos(angle) < 0) {
      textRot += math.pi; // flip text 180 deg if on left side
    }
    canvas.rotate(textRot);

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    tp.layout(maxWidth: distance); // Constrain width based on slice roughly

    // Draw centered on current rotated origin
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ScaWheelPainter old) {
    return old.selectedNode != selectedNode;
  }
}
