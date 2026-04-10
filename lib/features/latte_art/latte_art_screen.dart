import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final latteArtPatternsProvider = FutureProvider<List<LatteArtPatternDto>>((
  ref,
) async {
  final lang = ref.watch(localeProvider);
  return ref.watch(databaseProvider).getAllLatteArtPatterns(lang);
});

// ─── Screen ───────────────────────────────────────────────────────────────────
class LatteArtScreen extends ConsumerStatefulWidget {
  const LatteArtScreen({super.key});

  @override
  ConsumerState<LatteArtScreen> createState() => _LatteArtScreenState();
}

class _LatteArtScreenState extends ConsumerState<LatteArtScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _controller;
  double opacity = 0.6;
  LatteArtPatternDto? _activePattern;
  int _activeStepIndex = 0;
  bool _showSteps = true;
  late AnimationController _drawController;

  @override
  void initState() {
    super.initState();
    _drawController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    _drawController.dispose();
    super.dispose();
  }

  // Steps are already parsed in the DTO

  Widget _buildDifficultyStars(int d) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < d ? Icons.star_rounded : Icons.star_outline_rounded,
          color: const Color(0xFFC8A96E),
          size: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patternsAsync = ref.watch(latteArtPatternsProvider);

    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(
                'Initializing camera…',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: patternsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (patterns) {
          if (_activePattern == null && patterns.isNotEmpty) {
            _activePattern = patterns.first;
          }

          final steps = _activePattern != null
              ? _activePattern!.steps
              : <dynamic>[];

          return Stack(
            fit: StackFit.expand,
            children: [
              // ── Camera ─────────────────────────────────────────────────────
              CameraPreview(_controller!),

              // ── Stencil Overlay ──────────────────────────────────────────────
              if (_activePattern != null)
                Center(
                  child: Opacity(
                    opacity: opacity,
                    child: AnimatedBuilder(
                      animation: _drawController,
                      builder: (_, __) => CustomPaint(
                        size: const Size(280, 280),
                        painter: AdvancedStencilPainter(
                          patternName: _activePattern!.name,
                          progress: _drawController.value,
                        ),
                      ),
                    ),
                  ),
                ),

              // ── App Bar area ─────────────────────────────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: [
                      BackButton(
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Latte Art Trainer',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          _showSteps ? Icons.info_outline : Icons.info,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            setState(() => _showSteps = !_showSteps),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bottom Controls ───────────────────────────────────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Step guide
                      if (_showSteps && steps.isNotEmpty) ...[
                        _StepGuide(
                          steps: steps,
                          activeIndex: _activeStepIndex,
                          onPrev: _activeStepIndex > 0
                              ? () => setState(() => _activeStepIndex--)
                              : null,
                          onNext: _activeStepIndex < steps.length - 1
                              ? () => setState(() => _activeStepIndex++)
                              : null,
                        ),
                        const SizedBox(height: 12),
                      ],

                      // Pattern selector
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: patterns.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, i) {
                            final p = patterns[i];
                            final isActive = _activePattern?.id == p.id;
                            return GestureDetector(
                              onTap: () => setState(() {
                                _activePattern = p;
                                _activeStepIndex = 0;
                              }),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 80,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(
                                          0xFFC8A96E,
                                        ).withValues(alpha: 0.25)
                                      : Colors.black54,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isActive
                                        ? const Color(0xFFC8A96E)
                                        : Colors.white24,
                                    width: isActive ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      p.name.split(' ').first,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isActive
                                            ? const Color(0xFFC8A96E)
                                            : Colors.white70,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    _buildDifficultyStars(p.difficulty),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Opacity slider
                      Row(
                        children: [
                          const Icon(
                            Icons.opacity,
                            size: 18,
                            color: Colors.white60,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: const Color(0xFFC8A96E),
                                thumbColor: const Color(0xFFC8A96E),
                                inactiveTrackColor: Colors.white24,
                                trackHeight: 3,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8,
                                ),
                              ),
                              child: Slider(
                                value: opacity,
                                onChanged: (v) => setState(() => opacity = v),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.visibility,
                            size: 18,
                            color: Colors.white60,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Step Guide ───────────────────────────────────────────────────────────────
class _StepGuide extends StatelessWidget {
  final List<dynamic> steps;
  final int activeIndex;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _StepGuide({
    required this.steps,
    required this.activeIndex,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final step = steps[activeIndex];
    final String instruction = step is Map
        ? (step['instruction'] ?? '')
        : step.toString();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step progress dots
          Row(
            children: [
              Text(
                'Step ${activeIndex + 1}/${steps.length}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFC8A96E),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: List.generate(
                    steps.length,
                    (i) => Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: i <= activeIndex
                              ? const Color(0xFFC8A96E)
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            instruction,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: onPrev,
                icon: const Icon(Icons.chevron_left, size: 18),
                label: const Text('Prev'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white54,
                  padding: EdgeInsets.zero,
                ),
              ),
              TextButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right, size: 18),
                label: const Text('Next'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFC8A96E),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Advanced Stencil Painter ─────────────────────────────────────────────────
class AdvancedStencilPainter extends CustomPainter {
  final String patternName;
  final double progress; // 0.0 to 1.0 continuously

  AdvancedStencilPainter({required this.patternName, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw glowing guide circle
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    final guidePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, r - 10, guidePaint);

    // 2. Build the full path for the pattern
    late Path fullPath;
    switch (patternName) {
      case 'Heart':
        fullPath = _createHeartPath(center, r);
      case 'Tulip':
        fullPath = _createTulipPath(center, r);
      case 'Rosetta':
        fullPath = _createRosettaPath(center, r);
      case 'Leaf':
        fullPath = _createLeafPath(center, r);
      case 'Phoenix Tail':
        fullPath = _createPhoenixPath(center, r);
      case 'Swan':
        fullPath = _createSwanPath(center, r);
      case 'Dragon':
        fullPath = _createDragonPath(center, r);
      case 'Free Pour Circle':
      default:
        fullPath = _createFreeCircle(center, r);
    }

    // 3. Draw outline (faint, complete) so user sees the whole structure
    final outlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(fullPath, outlinePaint);

    // 4. Animate the 'milk pouring' progressive line using PathMetrics
    final pourPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.solid,
        2.0,
      ); // Slight soft edge

    final metrics = fullPath.computeMetrics().toList();
    if (metrics.isEmpty) return;

    // We want the total animation to smooth over all contours sequentially
    double totalLength = metrics.fold(
      0.0,
      (prev, metric) => prev + metric.length,
    );
    double currentLength = totalLength * progress;

    final animatedPath = Path();
    for (final metric in metrics) {
      if (currentLength <= 0.0) break;
      if (metric.length <= currentLength) {
        animatedPath.addPath(
          metric.extractPath(0.0, metric.length),
          Offset.zero,
        );
        currentLength -= metric.length;
      } else {
        animatedPath.addPath(
          metric.extractPath(0.0, currentLength),
          Offset.zero,
        );
        currentLength = 0.0;
      }
    }

    canvas.drawPath(animatedPath, pourPaint);

    // Draw a prominent "milk stream tip" at the leading edge
    if (progress < 1.0 && progress > 0.0) {
      final tipPaint = Paint()
        ..color = const Color(0xFFC8A96E)
        ..style = PaintingStyle.fill;
      double checkLen = totalLength * progress;
      for (final metric in metrics) {
        if (checkLen <= metric.length) {
          final pos = metric.getTangentForOffset(checkLen)?.position;
          if (pos != null) canvas.drawCircle(pos, 6, tipPaint);
          break;
        }
        checkLen -= metric.length;
      }
    }
  }

  Path _createHeartPath(Offset c, double size) {
    final path = Path();
    final top = c.dy - 40;
    final bottom = c.dy + 80;
    // Right lobe
    path.moveTo(c.dx, top + 20);
    path.cubicTo(c.dx + 80, top - 40, c.dx + 100, top + 60, c.dx, bottom);
    // Left lobe
    path.moveTo(c.dx, bottom);
    path.cubicTo(c.dx - 100, top + 60, c.dx - 80, top - 40, c.dx, top + 20);
    // Strike through
    path.moveTo(c.dx, top + 10);
    path.lineTo(c.dx, bottom + 20);
    return path;
  }

  Path _createTulipPath(Offset c, double size) {
    final path = Path();
    // 3 stacked wrappers
    _addWrapper(path, Offset(c.dx, c.dy + 30), 60);
    _addWrapper(path, Offset(c.dx, c.dy), 50);
    _addWrapper(path, Offset(c.dx, c.dy - 30), 40);
    // Final heart top
    path.moveTo(c.dx, c.dy - 50);
    path.cubicTo(c.dx + 30, c.dy - 70, c.dx + 20, c.dy - 20, c.dx, c.dy - 10);
    path.moveTo(c.dx, c.dy - 10);
    path.cubicTo(c.dx - 20, c.dy - 20, c.dx - 30, c.dy - 70, c.dx, c.dy - 50);
    // Strike through
    path.moveTo(c.dx, c.dy - 55);
    path.lineTo(c.dx, c.dy + 60);
    return path;
  }

  void _addWrapper(Path path, Offset base, double width) {
    path.moveTo(base.dx - width, base.dy - width * 0.5);
    path.quadraticBezierTo(
      base.dx,
      base.dy + width * 0.5,
      base.dx + width,
      base.dy - width * 0.5,
    );
  }

  Path _createRosettaPath(Offset c, double size) {
    final path = Path();
    // Start pouring at bottom, moving up while wiggling
    double startY = c.dy + 70;
    double topY = c.dy - 70;
    path.moveTo(c.dx, startY);

    int wiggles = 24; // Increased for more "wavy" lines
    for (int i = 0; i <= wiggles; i++) {
      double t = i / wiggles;
      double y = startY - (startY - topY) * t;
      // Envelope tapers slightly, but remains wavy
      double envelope = 85.0 * (1.0 - t * 0.4);
      // Higher frequency sin wave for the "wiggle"
      double dx = math.sin(t * math.pi * (wiggles / 1.5)) * envelope;

      if (i == 0) {
        path.moveTo(c.dx + dx * 0.2, y);
      } else {
        path.quadraticBezierTo(c.dx + dx * 1.2, y + 2, c.dx + dx, y);
      }
    }
    // Strike through stem
    path.moveTo(c.dx, topY - 10);
    path.lineTo(c.dx, startY + 20);
    return path;
  }

  Path _createLeafPath(Offset c, double size) {
    final path = Path();
    double startY = c.dy + 60;
    double topY = c.dy - 60;

    // Tighter, highly symmetric wiggle
    // Tighter, highly symmetric wiggle with quadratic curves
    int wiggles = 28;
    for (int i = 0; i <= wiggles; i++) {
      double t = i / wiggles;
      double y = startY - (startY - topY) * t;
      // Diamond/Leaf envelope: starts narrow, widens in middle, narrows at top
      double envelope = math.sin(t * math.pi) * 75.0;
      double dx = math.sin(t * math.pi * (wiggles / 2)) * envelope;
      if (i == 0) {
        path.moveTo(c.dx + dx, y);
      } else {
        path.quadraticBezierTo(c.dx + dx * 1.1, y + 1, c.dx + dx, y);
      }
    }
    // Deep straight strike
    path.moveTo(c.dx, topY - 5);
    path.lineTo(c.dx, startY + 30);
    return path;
  }

  Path _createPhoenixPath(Offset c, double size) {
    final path = Path();
    // Asymmetric curved rosetta base
    double startY = c.dy + 70;
    int wiggles = 14;
    for (int i = 0; i <= wiggles; i++) {
      double t = i / wiggles;
      // Curve to the left
      double baseX = c.dx - math.sin(t * math.pi) * 40;
      double y = startY - 120 * t;
      double envelope = 60.0 * (1.0 - t * 0.5);
      double dx = math.sin(t * math.pi * wiggles) * envelope;
      if (i == 0)
        path.moveTo(baseX + dx, y);
      else
        path.lineTo(baseX + dx, y);
    }
    // The swooping tail
    path.moveTo(c.dx - 20, c.dy - 60);
    path.quadraticBezierTo(c.dx + 80, c.dy - 90, c.dx + 60, c.dy + 50);
    path.quadraticBezierTo(c.dx + 50, c.dy + 90, c.dx, c.dy + 80);
    // Small head flourish
    path.addOval(
      Rect.fromCircle(center: Offset(c.dx + 65, c.dy - 50), radius: 8),
    );
    return path;
  }

  Path _createSwanPath(Offset c, double size) {
    final path = Path();
    // Body (Left-leaning half rosetta)
    double startY = c.dy + 50;
    int wiggles = 10;
    for (int i = 0; i <= wiggles; i++) {
      double t = i / wiggles;
      double y = startY - 80 * t;
      double baseX = c.dx + 20;
      double envelope = 50.0 * math.sin(t * math.pi);
      double dx = math.sin(t * math.pi * wiggles) * envelope;
      if (i == 0)
        path.moveTo(baseX + dx, y);
      else
        path.lineTo(baseX + dx, y);
    }
    // Base strike
    path.moveTo(c.dx + 20, c.dy - 40);
    path.lineTo(c.dx + 20, c.dy + 70);

    // Sweeping Neck
    path.moveTo(c.dx + 20, c.dy + 40);
    path.cubicTo(
      c.dx - 80,
      c.dy + 30,
      c.dx - 80,
      c.dy - 60,
      c.dx - 30,
      c.dy - 60,
    );
    // Head and beak
    path.addOval(
      Rect.fromCircle(center: Offset(c.dx - 20, c.dy - 60), radius: 10),
    );
    path.moveTo(c.dx - 30, c.dy - 60);
    path.lineTo(c.dx - 50, c.dy - 55);
    return path;
  }

  Path _createDragonPath(Offset c, double size) {
    final path = Path();
    // Central undulating body
    int wiggles = 18;
    for (int i = 0; i <= wiggles; i++) {
      double t = i / wiggles;
      double y = c.dy + 80 - 150 * t;
      // Body S-curve
      double baseX = c.dx + math.sin(t * math.pi * 2) * 30;
      double envelope = 40.0;
      double dx = math.sin(t * math.pi * wiggles * 1.5) * envelope;
      if (i == 0)
        path.moveTo(baseX + dx, y);
      else
        path.lineTo(baseX + dx, y);
    }
    // Wings
    path.moveTo(c.dx - 20, c.dy);
    path.quadraticBezierTo(c.dx - 90, c.dy - 40, c.dx - 70, c.dy - 80);
    path.quadraticBezierTo(c.dx - 50, c.dy - 40, c.dx - 10, c.dy - 20);

    path.moveTo(c.dx + 20, c.dy);
    path.quadraticBezierTo(c.dx + 90, c.dy - 40, c.dx + 70, c.dy - 80);
    path.quadraticBezierTo(c.dx + 50, c.dy - 40, c.dx + 10, c.dy - 20);

    // Horned Head
    path.addOval(Rect.fromCircle(center: Offset(c.dx, c.dy - 90), radius: 12));
    path.moveTo(c.dx - 10, c.dy - 95);
    path.lineTo(c.dx - 25, c.dy - 110);
    path.moveTo(c.dx + 10, c.dy - 95);
    path.lineTo(c.dx + 25, c.dy - 110);
    return path;
  }

  Path _createFreeCircle(Offset c, double size) {
    final path = Path();
    // A spiraling thick circle pour to mimic "monk's head"
    for (int i = 0; i <= 100; i++) {
      double t = i / 100.0;
      double r = 60.0 * t;
      double angle = t * math.pi * 8; // 4 full turns
      double x = c.dx + math.cos(angle) * r;
      double y = c.dy + math.sin(angle) * r;
      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }
    return path;
  }

  @override
  bool shouldRepaint(AdvancedStencilPainter old) =>
      old.patternName != patternName || old.progress != progress;
}
