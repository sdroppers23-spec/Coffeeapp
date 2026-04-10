import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

// ─── Data Models ───────────────────────────────────────────────────────────────

class GeoPoint {
  final double lat; // -90 to 90
  final double lon; // -180 to 180
  const GeoPoint(this.lat, this.lon);
}

final sphereRegionsProvider =
    FutureProvider<List<SphereRegionDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(localeProvider);
  return db.getAllSphereRegions(lang);
});

// ─── 3D Engine ─────────────────────────────────────────────────────────────────

class Point3D {
  final double x, y, z;
  Point3D(this.x, this.y, this.z);

  Point3D rotateY(double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    return Point3D(x * c + z * s, y, -x * s + z * c);
  }

  Point3D rotateX(double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    return Point3D(x, y * c - z * s, y * s + z * c);
  }

  Offset project(double w, double h, double focal) {
    final zOff = z + focal;
    if (zOff <= 0) return const Offset(-1000, -1000);
    final factor = focal / zOff;
    return Offset(w / 2 + x * factor, h / 2 + y * factor);
  }
}

Point3D _geoTo3D(double lat, double lon, double r) {
  final phi = (90 - lat) * (math.pi / 180);
  final theta = (lon + 180) * (math.pi / 180);
  return Point3D(
    r * math.sin(phi) * math.cos(theta),
    -r * math.cos(phi),
    r * math.sin(phi) * math.sin(theta),
  );
}

// ─── Painters ──────────────────────────────────────────────────────────────────

class GlobePainter extends CustomPainter {
  final double yaw, pitch;
  final ui.FragmentShader? shader;
  final ui.Image? landMask;
  final double time;
  final WidgetRef ref;

  GlobePainter({
    required this.yaw,
    required this.pitch,
    this.regions = const [],
    this.shader,
    this.landMask,
    required this.time,
    required this.ref,
    this.hitPoint,
    this.hitIntensity = 0.0,
  });

  final List<SphereRegionDto> regions;
  final Point3D? hitPoint;
  final double hitIntensity;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.width, size.height) * 0.45;
    final focal = radius * 4.0;
    final center = Offset(size.width / 2, size.height / 2);

    // 1. Procedural Hex Shader with Texture Mask
    if (shader != null) {
      shader!
        ..setFloat(0, time) // uTime
        ..setFloat(1, size.width) // uSize.x
        ..setFloat(2, size.height) // uSize.y
        ..setFloat(3, yaw) // uYaw
        ..setFloat(4, pitch); // uPitch

      shader!
        ..setFloat(5, hitPoint?.x ?? 0.0)
        ..setFloat(6, hitPoint?.y ?? 0.0)
        ..setFloat(7, hitPoint?.z ?? 0.0)
        ..setFloat(8, hitIntensity);

      if (landMask != null) {
        shader!.setImageSampler(0, landMask!);
      }

      canvas.drawRect(
        Rect.fromCircle(center: center, radius: radius * 1.5),
        Paint()..shader = shader,
      );
    }

    // 2. Atmospheric Glow
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = const Color(0xFFC8A96E).withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10));

    // 3. Coordinate Grid (Subtle)
    _drawGrid(canvas, center, radius, focal);

    // 4. Localized Markers
    _drawMarkers(canvas, size, radius, focal);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius, double focal) {
    final gridPaint = Paint()
      ..color = const Color(0xFFC8A96E).withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw longitudes
    for (int i = 0; i < 12; i++) {
      final lon = i * 30.0;
      final path = Path();
      for (int lat = -90; lat <= 90; lat += 10) {
        final p3d =
            _geoTo3D(lat.toDouble(), lon, radius).rotateY(yaw).rotateX(pitch);
        final cp = p3d.project(center.dx * 2, center.dy * 2, focal);
        if (p3d.z < 0) {
          if (lat == -90) {
            path.moveTo(cp.dx, cp.dy);
          } else {
            path.lineTo(cp.dx, cp.dy);
          }
        }
      }
      canvas.drawPath(path, gridPaint);
    }
  }

  void _drawMarkers(Canvas canvas, Size size, double radius, double focal) {
    for (final reg in regions) {
      if (!reg.isActive) continue;

      final currentYaw = yaw;
      final p3d = _geoTo3D(reg.latitude, reg.longitude, radius * 1.05)
          .rotateY(currentYaw)
          .rotateX(pitch);

      if (p3d.z < 0) {
        final cp = p3d.project(size.width, size.height, focal);
        Color markerColor = const Color(0xFFC8A96E);

        // Aroma Pillar
        final pillarPaint = Paint()
          ..shader = ui.Gradient.linear(cp - const Offset(0, 30), cp, [
            markerColor.withValues(alpha: 0.0),
            markerColor.withValues(alpha: 0.8)
          ])
          ..strokeWidth = 1.5;
        canvas.drawLine(cp - const Offset(0, 30), cp, pillarPaint);

        // Marker Point
        canvas.drawCircle(cp, 3, Paint()..color = markerColor);
        canvas.drawCircle(
            cp,
            6,
            Paint()
              ..color = markerColor.withValues(alpha: 0.3)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));

        // Continent Title
        final tp = TextPainter(textDirection: TextDirection.ltr);
        final title = reg.name;

        tp.text = TextSpan(
          text: title.toUpperCase(),
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        );
        tp.layout();
        tp.paint(canvas, cp + const Offset(8, -12));
      }
    }
  }

  @override
  bool shouldRepaint(GlobePainter old) => true;
}

class FlavorWheel extends ConsumerStatefulWidget {
  final Function(SphereRegionDto)? onRegionTap;
  const FlavorWheel({super.key, this.onRegionTap});
  @override
  ConsumerState<FlavorWheel> createState() => _TerroirGlobeState();
}

class _TerroirGlobeState extends ConsumerState<FlavorWheel>
    with TickerProviderStateMixin {
  double _yaw = 0.0;
  final double _pitch = 0.15;

  ui.FragmentShader? _nebulaShader;
  ui.Image? _landMask;

  late AnimationController _timeCtrl;
  late AnimationController _autoRotateCtrl;

  Point3D? _lastHitPoint;
  final double _hitIntensity = 0.0;

  @override
  void initState() {
    super.initState();
    _timeCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 40))
          ..repeat();
    _autoRotateCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 120))
          ..repeat();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    try {
      final data = await rootBundle.load('assets/images/earth_texture.png');
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (mounted) setState(() => _landMask = frame.image);

      final program = await ui.FragmentProgram.fromAsset(
          'assets/shaders/nebula_globe.frag');
      if (mounted) setState(() => _nebulaShader = program.fragmentShader());
    } catch (e) {
      debugPrint('Globe Asset Load Error: $e');
    }
  }

  @override
  void dispose() {
    _timeCtrl.dispose();
    _autoRotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sphereRegionsAsync = ref.watch(sphereRegionsProvider);

    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxWidth * 0.9);
      return GestureDetector(
        onPanUpdate: (d) => setState(() => _yaw -= d.delta.dx * 0.005),
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: Listenable.merge([_timeCtrl, _autoRotateCtrl]),
            builder: (context, _) => CustomPaint(
              size: size,
              painter: GlobePainter(
                yaw: _yaw + (_autoRotateCtrl.value * 2 * math.pi),
                pitch: _pitch,
                regions: sphereRegionsAsync.value ?? [],
                shader: _nebulaShader,
                landMask: _landMask,
                time: _timeCtrl.value * 6.283,
                ref: ref,
                hitPoint: _lastHitPoint,
                hitIntensity: _hitIntensity,
              ),
            ),
          ),
        ),
      );
    });
  }
}
