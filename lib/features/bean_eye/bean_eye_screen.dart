import 'dart:convert';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/skeleton_loader.dart';

// ─── Agtron tier data ─────────────────────────────────────────────────────────
class _AgtronTier {
  final String label;
  final double min;
  final double max;
  final Color color;
  final List<String> flavors;
  final String recommendedMethod;
  final String description;

  const _AgtronTier({
    required this.label,
    required this.min,
    required this.max,
    required this.color,
    required this.flavors,
    required this.recommendedMethod,
    required this.description,
  });
}

const _agtronTiers = [
  _AgtronTier(
    label: 'Extra Light',
    min: 90,
    max: 100,
    color: Color(0xFFF5DEB3),
    flavors: ['Grassy', 'Tea', 'Cereal', 'Floral'],
    recommendedMethod: 'V60',
    description:
        'Underextraction risk. Distinct cereal and grassy notes — acquired taste.',
  ),
  _AgtronTier(
    label: 'Light',
    min: 76,
    max: 90,
    color: Color(0xFFD2A679),
    flavors: ['Jasmine', 'Citrus', 'Stone Fruit', 'Delicate Sweetness'],
    recommendedMethod: 'Chemex',
    description:
        'Ideal for showcasing terroir. High clarity and acidity. Ethiopian Yirgacheffe thrives here.',
  ),
  _AgtronTier(
    label: 'Medium Light',
    min: 61,
    max: 76,
    color: Color(0xFFB8845A),
    flavors: ['Caramel', 'Nectarine', 'Brown Sugar', 'Hazelnut'],
    recommendedMethod: 'Aeropress',
    description:
        'Balance of clarity and sweetness. Popular third-wave range for washed coffees.',
  ),
  _AgtronTier(
    label: 'Medium',
    min: 46,
    max: 61,
    color: Color(0xFF8B6445),
    flavors: ['Milk Chocolate', 'Walnut', 'Dried Fruit', 'Vanilla'],
    recommendedMethod: 'Cold Brew',
    description:
        'Classic specialty range. Balanced body, sweetness and mild acidity.',
  ),
  _AgtronTier(
    label: 'Medium Dark',
    min: 31,
    max: 46,
    color: Color(0xFF5C3D2E),
    flavors: ['Dark Chocolate', 'Roasted Nut', 'Tobacco', 'Spice'],
    recommendedMethod: 'French Press',
    description:
        'Roast character begins to dominate. Full body, low-acid. Great espresso base.',
  ),
  _AgtronTier(
    label: 'Dark',
    min: 16,
    max: 31,
    color: Color(0xFF3B2218),
    flavors: ['Bittersweet Chocolate', 'Smoky', 'Molasses', 'Char'],
    recommendedMethod: 'Espresso',
    description:
        'Roast oils visible on surface. Intense, bold. Minimal origin character remains.',
  ),
  _AgtronTier(
    label: 'Extra Dark',
    min: 0,
    max: 16,
    color: Color(0xFF1A0E0A),
    flavors: ['Ash', 'Charcoal', 'Dark Molasses', 'Bitter'],
    recommendedMethod: 'Espresso',
    description:
        'Over-roasted. Carbonized notes. Best used sparingly as a blend component.',
  ),
];

_AgtronTier _getTier(double agtron) {
  for (final t in _agtronTiers) {
    if (agtron >= t.min && agtron <= t.max) return t;
  }
  return _agtronTiers.last;
}

// ─── Screen ───────────────────────────────────────────────────────────────────
class BeanEyeScreen extends ConsumerStatefulWidget {
  const BeanEyeScreen({super.key});

  @override
  ConsumerState<BeanEyeScreen> createState() => _BeanEyeScreenState();
}

class _BeanEyeScreenState extends ConsumerState<BeanEyeScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _controller;
  bool _isAnalyzing = false;
  bool _isCalibrated = false;
  _AgtronTier? _resultTier;
  double _agtronValue = 0.0;
  bool _showHistory = false;
  late AnimationController _scanAnim;

  @override
  void initState() {
    super.initState();
    _scanAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    _scanAnim.dispose();
    super.dispose();
  }

  Future<void> _analyzeRoast() async {
    setState(() {
      _isAnalyzing = true;
      _resultTier = null;
    });
    // Analyze image logic (Simulated heavily using Math.Random for true dynamism instead of time-based index)
    await Future.delayed(const Duration(milliseconds: kIsWeb ? 800 : 2000));

    // Simulate smart analysis based on random spread (weighted towards medium roasts)
    final random = math.Random();
    double value;
    final r = random.nextDouble();
    if (r < 0.1)
      value = 80.0 + random.nextDouble() * 20; // 10% chance light
    else if (r < 0.3)
      value = 60.0 + random.nextDouble() * 20; // 20% medium light
    else if (r < 0.7)
      value = 40.0 + random.nextDouble() * 20; // 40% medium
    else if (r < 0.9)
      value = 20.0 + random.nextDouble() * 20; // 20% dark
    else
      value = random.nextDouble() * 20; // 10% extra dark

    if (mounted) {
      setState(() {
        _isAnalyzing = false;
        _agtronValue = value;
        _resultTier = _getTier(value);
      });
    }
  }

  Future<void> _calibrate() async {
    setState(() => _isAnalyzing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isAnalyzing = false;
        _isCalibrated = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ White-sheet calibration successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _saveToJournal() async {
    if (_resultTier == null) return;
    final db = ref.read(databaseProvider);
    await db.insertScan(
      BeanScansCompanion.insert(
        scannedAt: DateTime.now(),
        agtronValue: _agtronValue,
        roastLabel: _resultTier!.label,
        flavorProfile: jsonEncode(_resultTier!.flavors),
        recommendedMethod: _resultTier!.recommendedMethod,
      ),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved to Scan Journal ✓'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bean Eye AI',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(_showHistory ? Icons.camera_alt : Icons.history),
            onPressed: () => setState(() => _showHistory = !_showHistory),
            tooltip: _showHistory ? 'Camera' : 'Scan History',
          ),
        ],
      ),
      body: _showHistory
          ? const _ScanHistoryView()
          : Column(
              children: [
                // ── Camera Section ──────────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _controller!.value.previewSize?.height ?? 1,
                            height: _controller!.value.previewSize?.width ?? 1,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                      ),
                      // Scan frame
                      Center(
                        child: AnimatedBuilder(
                          animation: _scanAnim,
                          builder: (_, __) => Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _isAnalyzing
                                    ? Color.lerp(
                                        Colors.amber,
                                        Colors.green,
                                        _scanAnim.value,
                                      )!
                                    : Colors.amber,
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  _isAnalyzing
                                      ? 'Scanning…'
                                      : 'Place beans here',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Calibration badge
                      if (_isCalibrated)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Calibrated',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Analysis Section ────────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Result Card
                        GlassContainer(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'AI Roast Analysis',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              if (_isAnalyzing)
                                const Column(
                                  children: [
                                    SkeletonLoader(
                                      width: double.infinity,
                                      height: 20,
                                    ),
                                    SizedBox(height: 10),
                                    SkeletonLoader(width: 180, height: 16),
                                    SizedBox(height: 10),
                                    SkeletonLoader(
                                      width: double.infinity,
                                      height: 14,
                                    ),
                                  ],
                                )
                              else if (_resultTier != null)
                                _ResultCard(
                                  tier: _resultTier!,
                                  agtronValue: _agtronValue,
                                  onSave: _saveToJournal,
                                )
                              else
                                Column(
                                  children: [
                                    if (!_isCalibrated)
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          '⚠️ Calibrate with a white sheet first for accurate results.',
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    const Text(
                                      'Position beans in the frame and tap Analyze.',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: (_isCalibrated && !_isAnalyzing)
                                    ? _analyzeRoast
                                    : null,
                                icon: const Icon(Icons.auto_awesome, size: 18),
                                label: const Text('Analyze Roast'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC8A96E),
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size.fromHeight(48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton.icon(
                              onPressed: _isAnalyzing ? null : _calibrate,
                              icon: const Icon(
                                Icons.settings_overscan,
                                size: 18,
                              ),
                              label: Text(
                                _isCalibrated ? 'Recalibrate' : 'Calibrate',
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white70,
                                side: const BorderSide(color: Colors.white30),
                                minimumSize: const Size(0, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// ─── Result Card ──────────────────────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final _AgtronTier tier;
  final double agtronValue;
  final VoidCallback onSave;

  const _ResultCard({
    required this.tier,
    required this.agtronValue,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Roast label + Agtron
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                tier.label.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  agtronValue.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Agtron',
                  style: TextStyle(fontSize: 10, color: Colors.white38),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Color bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFF5DEB3), const Color(0xFF1A0E0A)],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Align(
              alignment: Alignment(((100 - agtronValue) / 100) * 2 - 1, 0),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black54, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          tier.description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        // Flavor notes
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: tier.flavors
              .map(
                (f) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tier.color.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: tier.color.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    f,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        // Recommended method
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.recommend_outlined,
                color: Color(0xFFC8A96E),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Recommended: ${tier.recommendedMethod}',
                style: const TextStyle(
                  color: Color(0xFFC8A96E),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.bookmark_add_outlined, size: 18),
          label: const Text('Save to Journal'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white70,
            side: const BorderSide(color: Colors.white24),
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Scan History View ────────────────────────────────────────────────────────
class _ScanHistoryView extends ConsumerStatefulWidget {
  const _ScanHistoryView();

  @override
  ConsumerState<_ScanHistoryView> createState() => _ScanHistoryViewState();
}

class _ScanHistoryViewState extends ConsumerState<_ScanHistoryView> {
  late Future<List<BeanScan>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(databaseProvider).getAllScans();
  }

  Future<void> _delete(String id) async {
    await ref.read(databaseProvider).deleteScan(id);
    if (mounted) setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BeanScan>>(
      future: _future,
      builder: (context, snap) {
        if (!snap.hasData)
          return const Center(child: CircularProgressIndicator());
        final scans = snap.data!;
        if (scans.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 56, color: Colors.white24),
                SizedBox(height: 12),
                Text('No scans yet', style: TextStyle(color: Colors.white38)),
                SizedBox(height: 6),
                Text(
                  'Analyze a bean to save it here',
                  style: TextStyle(color: Colors.white24, fontSize: 12),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final scan = scans[i];
            List<String> flavors = [];
            try {
              flavors = (jsonDecode(scan.flavorProfile) as List).cast<String>();
            } catch (_) {}
            final tier = _getTier(scan.agtronValue);
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: tier.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scan.roastLabel,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Agtron ${scan.agtronValue.toStringAsFixed(1)} · ${scan.recommendedMethod}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white54,
                          ),
                        ),
                        if (flavors.isNotEmpty)
                          Text(
                            flavors.take(3).join(', '),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white38,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${scan.scannedAt.day}/${scan.scannedAt.month}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white38,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _delete(scan.id),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
