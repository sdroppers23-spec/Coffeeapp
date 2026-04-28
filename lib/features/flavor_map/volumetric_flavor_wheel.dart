import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';

class FlavorNode {
  final String nameKey;
  final Color color;
  final List<FlavorNode> children;

  const FlavorNode({
    required this.nameKey,
    required this.color,
    this.children = const [],
  });
}

// Hierarchical data for the Volumetric Flavor Wheel (Radio Kava Style)
final List<FlavorNode> volumetricFlavorData = [
  const FlavorNode(
    nameKey: 'flavor_fruity',
    color: Color(0xFFFF5252),
    children: [
      FlavorNode(
        nameKey: 'note_berry',
        color: Color(0xFFFF4081),
        children: [
          FlavorNode(nameKey: 'note_strawberry', color: Color(0xFFF06292)),
          FlavorNode(nameKey: 'note_raspberry', color: Color(0xFFEC407A)),
          FlavorNode(nameKey: 'note_blueberry', color: Color(0xFFD81B60)),
        ],
      ),
      FlavorNode(
        nameKey: 'note_citrus',
        color: Color(0xFFFFAB40),
        children: [
          FlavorNode(nameKey: 'note_orange', color: Color(0xFFFFB74D)),
          FlavorNode(nameKey: 'note_lime', color: Color(0xFFCDDC39)),
          FlavorNode(nameKey: 'note_lemon', color: Color(0xFFFFF176)),
        ],
      ),
      FlavorNode(
        nameKey: 'note_tropical',
        color: Color(0xFFFFD54F),
        children: [
          FlavorNode(nameKey: 'note_mango', color: Color(0xFFFFE082)),
          FlavorNode(nameKey: 'note_pineapple', color: Color(0xFFFFD54F)),
        ],
      ),
    ],
  ),
  const FlavorNode(
    nameKey: 'flavor_sweet',
    color: Color(0xFFFF9100),
    children: [
      FlavorNode(
        nameKey: 'note_caramel',
        color: Color(0xFFFFAB40),
        children: [
          FlavorNode(nameKey: 'note_honey', color: Color(0xFFFFD180)),
          FlavorNode(nameKey: 'note_vanilla', color: Color(0xFFFFE57F)),
        ],
      ),
    ],
  ),
  const FlavorNode(
    nameKey: 'flavor_floral',
    color: Color(0xFFE040FB),
    children: [
      FlavorNode(
        nameKey: 'note_jasmine',
        color: Color(0xFFEA80FC),
        children: [FlavorNode(nameKey: 'note_tea', color: Color(0xFFBCAAA4))],
      ),
    ],
  ),
  const FlavorNode(
    nameKey: 'flavor_nutty',
    color: Color(0xFF795548),
    children: [
      FlavorNode(
        nameKey: 'note_chocolate',
        color: Color(0xFF5D4037),
        children: [
          FlavorNode(nameKey: 'note_cocoa', color: Color(0xFF3E2723)),
          FlavorNode(nameKey: 'note_hazelnut', color: Color(0xFF8D6E63)),
        ],
      ),
    ],
  ),
];

class VolumetricFlavorWheel extends ConsumerStatefulWidget {
  const VolumetricFlavorWheel({super.key});

  @override
  ConsumerState<VolumetricFlavorWheel> createState() =>
      _VolumetricFlavorWheelState();
}

class _VolumetricFlavorWheelState extends ConsumerState<VolumetricFlavorWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _expansionController;
  FlavorNode? _selectedNode;

  @override
  void initState() {
    super.initState();
    _expansionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _expansionController.dispose();
    super.dispose();
  }

  void _handleTap(Offset localPosition, double size) {
    final center = Offset(size / 2, size / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    // Adjust angle to match painter (-pi/2 offset)
    double angle = math.atan2(dy, dx) + math.pi / 2;
    if (angle < 0) angle += 2 * math.pi;

    final maxRadius = size / 2;
    final centerRadius = maxRadius * 0.25;
    final ringWidth = (maxRadius - centerRadius) / 3;

    if (distance < centerRadius) {
      setState(() {
        _selectedNode = null;
      });
      return;
    }

    // Determine ring
    final int ring = ((distance - centerRadius) / ringWidth).floor() + 1;
    if (ring < 1 || ring > 3) return;

    double currentAngle = 0.0;
    const totalAngle = 2 * math.pi;
    final totalWeight = volumetricFlavorData.fold(
      0.0,
      (acc, n) => acc + _nodeWeight(n),
    );

    for (final node in volumetricFlavorData) {
      final sweep = totalAngle * _nodeWeight(node) / totalWeight;

      if (angle >= currentAngle && angle <= currentAngle + sweep) {
        if (ring == 1) {
          setState(() {
            _selectedNode = node;
          });
        } else if (ring == 2 && node.children.isNotEmpty) {
          double cAngle = currentAngle;
          for (final child in node.children) {
            final cSweep = sweep * _nodeWeight(child) / _nodeWeight(node);
            if (angle >= cAngle && angle <= cAngle + cSweep) {
              setState(() {
                _selectedNode = child;
              });
              break;
            }
            cAngle += cSweep;
          }
        } else if (ring == 3 && node.children.isNotEmpty) {
          // Deep check (simplified for now)
        }
        break;
      }
      currentAngle += sweep;
    }
  }

  double _nodeWeight(FlavorNode node) {
    if (node.children.isEmpty) return 1.0;
    return node.children.fold(0.0, (acc, n) => acc + _nodeWeight(n));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final size = math.min(constraints.maxWidth, 450.0);
            return GestureDetector(
              onTapUp: (d) => _handleTap(d.localPosition, size),
              child: AnimatedBuilder(
                animation: _expansionController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(size, size),
                    painter: _VolumetricPainter(
                      data: volumetricFlavorData,
                      expansion: _expansionController.value,
                      ref: ref,
                      selectedNode: _selectedNode,
                    ),
                  );
                },
              ),
            );
          },
        ),
        if (_selectedNode != null) ...[
          const SizedBox(height: 20),
          Text(
            ref.t(_selectedNode!.nameKey).toUpperCase(),
            style: GoogleFonts.orbitron(
              color: _selectedNode!.color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Відчуйте нотки ${ref.t(_selectedNode!.nameKey).toLowerCase()} у вашій каві. Цей дескриптор характерний для високогірних лотів з особливою ферментацією.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _VolumetricPainter extends CustomPainter {
  final List<FlavorNode> data;
  final double expansion;
  final WidgetRef ref;
  final FlavorNode? selectedNode;

  _VolumetricPainter({
    required this.data,
    required this.expansion,
    required this.ref,
    this.selectedNode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = (size.width / 2) * expansion;
    final centerRadius = maxRadius * 0.25;
    final ringWidth = (maxRadius - centerRadius) / 3;

    final totalWeight = data.fold(0.0, (acc, n) => acc + _totalWeight(n));

    // We draw from outside in or handle layers carefully for glassmorphism
    // But for a sunburst, we draw rings 1, 2, 3

    // Ring 1 (Inner)
    double angle1 = -math.pi / 2;
    for (final node in data) {
      final sweep = (2 * math.pi) * _totalWeight(node) / totalWeight;
      _drawArcSegment(
        canvas,
        center,
        centerRadius,
        ringWidth,
        angle1,
        sweep,
        node,
        1,
      );
      angle1 += sweep;
    }

    // Ring 2 (Middle)
    double angle2 = -math.pi / 2;
    for (final node in data) {
      final sweep = (2 * math.pi) * _totalWeight(node) / totalWeight;
      if (node.children.isNotEmpty) {
        double subAngle = angle2;
        for (final child in node.children) {
          final subSweep = sweep * _totalWeight(child) / _totalWeight(node);
          _drawArcSegment(
            canvas,
            center,
            centerRadius + ringWidth,
            ringWidth,
            subAngle,
            subSweep,
            child,
            2,
          );

          // Ring 3 (Outer)
          if (child.children.isNotEmpty) {
            double subSubAngle = subAngle;
            for (final grandchild in child.children) {
              final subSubSweep =
                  subSweep * _totalWeight(grandchild) / _totalWeight(child);
              _drawArcSegment(
                canvas,
                center,
                centerRadius + ringWidth * 2,
                ringWidth,
                subSubAngle,
                subSubSweep,
                grandchild,
                3,
              );
              subSubAngle += subSubSweep;
            }
          }
          subAngle += subSweep;
        }
      }
      angle2 += sweep;
    }

    // Center "Glass" Cap
    final glassPaint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        centerRadius,
        [
          const Color(0xFFC8A96E).withValues(alpha: 0.3),
          const Color(0xFF1A1A1A).withValues(alpha: 0.8),
        ],
        [0.0, 1.0],
      );
    canvas.drawCircle(center, centerRadius, glassPaint);
    canvas.drawCircle(
      center,
      centerRadius,
      Paint()
        ..color = Colors.white10
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final tp = TextPainter(
      text: TextSpan(
        text: 'CHOOSER',
        style: GoogleFonts.orbitron(
          color: const Color(0xFFC8A96E),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawArcSegment(
    Canvas canvas,
    Offset center,
    double innerR,
    double width,
    double startAngle,
    double sweep,
    FlavorNode node,
    int level,
  ) {
    if (sweep < 0.01) return;

    final outerR = innerR + width;
    final isSelected = selectedNode == node;
    final alpha = isSelected ? 0.9 : 0.4 / (level * 0.5);

    final path = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: outerR),
        startAngle,
        sweep,
      )
      ..arcTo(
        Rect.fromCircle(center: center, radius: innerR),
        startAngle + sweep,
        -sweep,
        false,
      )
      ..close();

    // Volumetric Gradient
    final gradient = ui.Gradient.radial(
      center,
      outerR,
      [node.color, node.color.withValues(alpha: alpha * 0.5)],
      [0.8, 1.0],
    );

    canvas.drawPath(path, Paint()..shader = gradient);

    // Glass Border
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white24
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );

    // Text (Simplified - only if sweep is large enough)
    if (sweep > 0.15) {
      _drawRadialText(
        canvas,
        center,
        startAngle + sweep / 2,
        innerR + width / 2,
        ref.t(node.nameKey),
        level,
      );
    }
  }

  void _drawRadialText(
    Canvas canvas,
    Offset center,
    double angle,
    double distance,
    String text,
    int level,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text.toUpperCase(),
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.95),
          fontSize: level == 1 ? 9.5 : 7.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: distance * 0.7);

    final x = center.dx + distance * math.cos(angle);
    final y = center.dy + distance * math.sin(angle);

    canvas.save();
    canvas.translate(x, y);

    // Always rotate so text reads outward from center.
    // For the right half (cos >= 0): angle points outward → rotate to angle.
    // For the left half (cos < 0): flip by π so text isn't upside-down.
    double rot = angle;
    if (math.cos(angle) < 0) {
      rot += math.pi;
    }
    canvas.rotate(rot);
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  double _totalWeight(FlavorNode node) {
    if (node.children.isEmpty) return 1.0;
    return node.children.fold(0.0, (acc, n) => acc + _totalWeight(n));
  }

  @override
  bool shouldRepaint(covariant _VolumetricPainter old) => true;
}
