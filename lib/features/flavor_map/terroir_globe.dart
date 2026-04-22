import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';
import '../navigation/navigation_providers.dart';
import 'world_mask_data.dart';

class TerroirGlobe extends ConsumerStatefulWidget {
  const TerroirGlobe({super.key});

  @override
  ConsumerState<TerroirGlobe> createState() => _TerroirGlobeState();
}

class _TerroirGlobeState extends ConsumerState<TerroirGlobe>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _rippleController;

  double _tiltAngle = 0.0;
  double _manualRotationY = 0.0;
  double _frozenRotationY = 0.0; // saves angle at the moment of pause
  bool _isAutoRotating = true;

  String? _selectedDescriptor;
  Offset? _hitPoint;
  Offset? _rippleCenter;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _processTap(Offset localPos, double globeSize) {
    if (_selectedDescriptor != null) {
      // Close popup — resume from current frozen angle
      setState(() {
        _selectedDescriptor = null;
        _hitPoint = null;
        _rippleCenter = null;
        if (_isAutoRotating) {
          // Keep _frozenRotationY as is — controller resumes from 0
          // so total = _frozenRotationY + controller.value * 2π (continuous)
          _rotationController.repeat();
        }
      });
      return;
    }

    final radius = globeSize / 2;
    final center = Offset(globeSize / 2, globeSize / 2);
    final dx = localPos.dx - center.dx;
    final dy = localPos.dy - center.dy;

    // Check if tap is within circle
    if (dx * dx + dy * dy > radius * radius) return;

    // 1. Find Z coordinate on sphere
    final z = math.sqrt(radius * radius - dx * dx - dy * dy);

    // 2. Normalize and apply Inverse Rotations
    // Current total rotation Y
    final rotY =
        _manualRotationY +
        (_isAutoRotating ? (_rotationController.value * 2 * math.pi) : 0);
    final rotX = _tiltAngle;

    // Rotate back by Y
    double tx = dx * math.cos(-rotY) + z * math.sin(-rotY);
    double tz = -dx * math.sin(-rotY) + z * math.cos(-rotY);
    double ty = dy;

    // Rotate back by X
    double finalY = ty * math.cos(-rotX) - tz * math.sin(-rotX);
    double finalZ = ty * math.sin(-rotX) + tz * math.cos(-rotX);
    double finalX = tx;

    // 3. Convert Cartesian to Lat/Lon
    double latRad = math.asin(-finalY / radius); // Invert Y to fix orientation
    double lonRad = math.atan2(finalZ, finalX);

    double lat = latRad * 180 / math.pi;
    double lon = lonRad * 180 / math.pi;

    // 4. Check if land
    if (WorldMaskData.isLand(lat, lon)) {
      _handlePointTap(localPos, _getRegionName(lat, lon));
    }
  }

  void _handlePointTap(Offset pos, String descriptor) {
    ref.read(settingsProvider.notifier).triggerHaptic();
    // Freeze current total rotation angle before stopping
    final currentY =
        _frozenRotationY +
        (_isAutoRotating ? (_rotationController.value * 2 * math.pi) : 0);
    setState(() {
      _frozenRotationY = currentY;
      _selectedDescriptor = descriptor;
      _hitPoint = pos;
      _rippleCenter = pos;
      _rotationController
        ..stop()
        ..value = 0; // reset so next repeat() starts from offset 0
      _rippleController.forward(from: 0.0);
    });
  }

  String _getRegionName(double lat, double lon) {
    if (lat < 12 && lat > -25 && lon > -80 && lon < -35) {
      return ref.t('desc_south_america');
    }
    if (lat < 25 && lat > 5 && lon > 32 && lon < 50) {
      return ref.t('desc_east_africa');
    }
    if (lat < 22 && lat > 10 && lon > -105 && lon < -85) {
      return ref.t('desc_central_america');
    }
    if (lat < 10 && lat > -12 && lon > 95 && lon < 145) {
      return ref.t('desc_se_asia');
    }
    if (lat < 28 && lat > 18 && lon > 100 && lon < 110) {
      return ref.t('region_se_asia');
    }
    if (lat < 5 && lat > -15 && lon > 28 && lon < 32) {
      return ref.t('desc_central_africa');
    }
    return ref.t('nav_latte_art'); // Fallback or global label
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final globeSize =
            math.min(constraints.maxWidth, constraints.maxHeight) * 0.85;

        return Stack(
          alignment: Alignment.center,
          children: [
            // The Globe interaction layer
            Positioned(
              top: 10,
              child: GestureDetector(
                onTapDown: (details) =>
                    _processTap(details.localPosition, globeSize),
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _rotationController,
                    _rippleController,
                  ]),
                  builder: (context, child) {
                    final currentRotationY =
                        _frozenRotationY +
                        (_isAutoRotating
                            ? (_rotationController.value * 2 * math.pi)
                            : 0);
                    return CustomPaint(
                      size: Size(globeSize, globeSize),
                      painter: _GlobePainter(
                        rotationX: _tiltAngle,
                        rotationY: currentRotationY,
                        theme: theme,
                        rippleValue: _rippleController.value,
                        rippleCenter: _rippleCenter,
                        selectedPoint: _hitPoint,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Control Overlay - Lifted above the Nav Bar
            Positioned(
              bottom: ref.watch(navBarHeightProvider) + 16,
              left: 10,
              right: 10,
              child: _buildControls(theme),
            ),

            // Description Popup
            if (_selectedDescriptor != null)
              Positioned(top: 40, child: _buildDescriptorPopup(theme)),
          ],
        );
      },
    );
  }

  Widget _buildControls(ThemeData theme) {
    final locked = _selectedDescriptor != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSliderRow(
            label: ref.t('tilt'),
            value: _tiltAngle,
            min: -0.785,
            max: 0.785,
            enabled: !locked,
            onChanged: (v) => setState(() => _tiltAngle = v),
          ),
          const SizedBox(height: 8),
          _buildSliderRow(
            label: ref.t('rotation'),
            value: _manualRotationY % (2 * math.pi),
            max: 2 * math.pi,
            enabled: !locked,
            onChanged: (v) => setState(() {
              _manualRotationY = v;
              _frozenRotationY = v;
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.t('auto_rotation'),
                style: GoogleFonts.outfit(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  // Reset / calibration button
                  Tooltip(
                    message: 'Reset position',
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                      onPressed: locked
                          ? null
                          : () {
                              setState(() {
                                _tiltAngle = 0.0;
                                _manualRotationY = 0.0;
                                _frozenRotationY = 0.0;
                              });
                            },
                    ),
                  ),
                  Text(
                    _isAutoRotating ? ref.t('on') : ref.t('off'),
                    style: GoogleFonts.outfit(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: _isAutoRotating,
                    onChanged: locked
                        ? null
                        : (v) {
                            setState(() => _isAutoRotating = v);
                            if (v) {
                              _rotationController.repeat();
                            } else {
                              // Save current angle before stopping
                              _frozenRotationY =
                                  _frozenRotationY +
                                  (_rotationController.value * 2 * math.pi);
                              _rotationController
                                ..stop()
                                ..value = 0;
                            }
                          },
                    activeThumbColor: theme.colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow({
    required String label,
    required double value,
    double min = 0,
    required double max,
    required ValueChanged<double> onChanged,
    bool enabled = true,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              color: enabled ? Colors.white : Colors.white38,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: enabled ? Colors.white30 : Colors.white12,
              inactiveTrackColor: Colors.white10,
              thumbColor: enabled ? Colors.white : Colors.white30,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptorPopup(ThemeData theme) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 30, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.hub_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _selectedDescriptor!,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, width: 40, color: Colors.white30),
          const SizedBox(height: 12),
          Text(
            ref.t('resume_exploration'),
            style: GoogleFonts.outfit(
              color: Colors.white60,
              fontSize: 9,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobePainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final ThemeData theme;
  final double rippleValue;
  final Offset? rippleCenter;
  final Offset? selectedPoint;

  _GlobePainter({
    required this.rotationX,
    required this.rotationY,
    required this.theme,
    required this.rippleValue,
    this.rippleCenter,
    this.selectedPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw dark chocolate/black background
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF0F0804),
          const Color(0xFF050302),
        ],
        stops: const [0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, bgPaint);

    // Grid configuration
    const int latCount = 45;
    const int lonCount = 90;

    final paint = Paint()..style = PaintingStyle.fill;

    // Draw Globe Particles
    for (int i = 0; i <= latCount; i++) {
      final latDeg = (i / latCount) * 180 - 90;
      final latRad = latDeg * math.pi / 180;

      for (int j = 0; j < lonCount; j++) {
        final lonDeg = (j / lonCount) * 360 - 180;
        final lonRad = lonDeg * math.pi / 180;

        double x = radius * math.cos(latRad) * math.cos(lonRad);
        double y = -radius * math.sin(latRad); // Invert Y for North-up
        double z = radius * math.cos(latRad) * math.sin(lonRad);

        // Rotation X (Tilt)
        double ty = y * math.cos(rotationX) - z * math.sin(rotationX);
        double tz = y * math.sin(rotationX) + z * math.cos(rotationX);
        y = ty;
        z = tz;

        // Rotation Y
        double tx = x * math.cos(rotationY) + z * math.sin(rotationY);
        tz = -x * math.sin(rotationY) + z * math.cos(rotationY);
        x = tx;
        z = tz;

        if (z > -radius * 0.4) {
          final isLand = WorldMaskData.isLand(latDeg, lonDeg);
          final depthFactor = (z + radius) / (2 * radius);
          final pos = Offset(center.dx + x, center.dy + y);

          final opacity = (depthFactor * (isLand ? 0.9 : 0.15)).clamp(
            0.05,
            1.0,
          );
          final pSize = (depthFactor * (isLand ? 2.5 : 1.0)).clamp(0.4, 3.5);

          paint.color = isLand
              ? const Color(0xFFB8955A).withOpacity(opacity)   // Rich gold-brown land
              : Colors.white.withOpacity(opacity * 0.08);      // Even fainter ocean

          canvas.drawCircle(pos, pSize, paint);

          // Hit detection on land points (only if nothing is already selected)
          if (isLand &&
              selectedPoint == null &&
              (pos - center).distance < radius) {
            // Check if global tap matches this point (simplified trigger)
            // Real trigger is handled via local logic to avoid O(N) tap checks every frame
          }
        }
      }
    }

    // Ripple Wave & Active Point Effect
    if (rippleCenter != null) {
      // Glow background for point
      final glowPaint = Paint()
        ..color = const Color(
          0xFFC8A96E,
        ).withOpacity(0.3 * (1.0 - rippleValue))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(rippleCenter!, 15, glowPaint);

      // Selected point
      canvas.drawCircle(
        rippleCenter!,
        4,
        Paint()..color = const Color(0xFFC8A96E),
      );

      // Ripple Ring
      if (rippleValue > 0) {
        final ripplePaint = Paint()
          ..color = const Color(
            0xFFC8A96E,
          ).withOpacity((1.0 - rippleValue) * 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
        canvas.drawCircle(rippleCenter!, rippleValue * 80, ripplePaint);
      }
    }

    // Draw Regional Gold Points (Mayors)
    _drawRegionalPoint(canvas, center, radius, -15.0, -60.0); // S. America
    _drawRegionalPoint(canvas, center, radius, 0.0, 38.0); // E. Africa
    _drawRegionalPoint(canvas, center, radius, 15.0, -85.0); // C. America
    _drawRegionalPoint(canvas, center, radius, -5.0, 120.0); // Asia Pacific
    _drawRegionalPoint(canvas, center, radius, 12.0, 105.0); // SE Asia
    _drawRegionalPoint(canvas, center, radius, -2.0, 30.0); // C. Africa

    // Atmosphere
    final atomShadow = Paint()
      ..shader = RadialGradient(
        colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
        stops: const [0.8, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, atomShadow);
  }

  void _drawRegionalPoint(
    Canvas canvas,
    Offset center,
    double radius,
    double latDeg,
    double lonDeg,
  ) {
    final latRad = latDeg * math.pi / 180;
    final lonRad = lonDeg * math.pi / 180;

    double x = radius * math.cos(latRad) * math.cos(lonRad);
    double y = -radius * math.sin(latRad); // Invert Y for North-up
    double z = radius * math.cos(latRad) * math.sin(lonRad);

    // Rotation X
    double ty = y * math.cos(rotationX) - z * math.sin(rotationX);
    double tz = y * math.sin(rotationX) + z * math.cos(rotationX);
    y = ty;
    z = tz;

    // Rotation Y
    double tx = x * math.cos(rotationY) + z * math.sin(rotationY);
    tz = -x * math.sin(rotationY) + z * math.cos(rotationY);
    x = tx;
    z = tz;

    if (z > 0) {
      final pos = Offset(center.dx + x, center.dy + y);

      // Glow effect
      final glowPaint = Paint()
        ..color = const Color(0xFFC8A96E).withOpacity(0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(pos, 8, glowPaint);

      // Outer Gold
      canvas.drawCircle(
        pos,
        5,
        Paint()..color = const Color(0xFFC8A96E),
      );
      
      // Inner Light Gold/White
      canvas.drawCircle(pos, 2, Paint()..color = const Color(0xFFFFE0B2));
    }
  }

  // Simplified hit check triggered from state
  @override
  bool shouldRepaint(covariant _GlobePainter oldDelegate) => true;
}

