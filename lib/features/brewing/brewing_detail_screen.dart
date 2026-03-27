import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import 'custom_recipe_list.dart';
import '../../core/database/database_provider.dart';
import '../../shared/widgets/glass_container.dart';

// ─── Method metadata (shared with BrewingGuideScreen) ──────────────────────────
const _methodMeta = {
  'v60': 'assets/images/methods/v60.png',
  'chemex': 'assets/images/methods/chemex.png',
  'aeropress': 'assets/images/methods/aeropress.png',
  'espresso': 'assets/images/methods/espresso.png',
  'cold_brew': 'assets/images/methods/cold_brew.png',
};

class BrewingDetailScreen extends ConsumerStatefulWidget {
  final BrewingRecipe recipe;
  const BrewingDetailScreen({super.key, required this.recipe});

  @override
  ConsumerState<BrewingDetailScreen> createState() => _BrewingDetailScreenState();
}

class _BrewingDetailScreenState extends ConsumerState<BrewingDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> _steps;

  // Timer state
  int _activeStep = -1;
  int _remainingSec = 0;
  bool _timerRunning = false;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _steps = (jsonDecode(widget.recipe.stepsJson) as List)
        .cast<Map<String, dynamic>>();
    _progressController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startTimer(int stepIndex) {
    final durationSec = (_steps[stepIndex]['durationSec'] as int?) ?? 30;
    setState(() {
      _activeStep = stepIndex;
      _remainingSec = durationSec;
      _timerRunning = true;
    });
    _progressController.duration = Duration(seconds: durationSec);
    _progressController.forward(from: 0);
    _runTimer();
  }

  void _runTimer() async {
    while (_timerRunning && _remainingSec > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _timerRunning) {
        setState(() => _remainingSec--);
      }
    }
    if (mounted && _remainingSec == 0 && _timerRunning) {
      setState(() => _timerRunning = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Step ${_activeStep + 1} complete! ✓'),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _stopTimer() {
    setState(() => _timerRunning = false);
    _progressController.stop();
  }

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get _formattedRatio {
    final ratio = widget.recipe.ratioGramsPerMl;
    if (ratio >= 1) return '1:${(1 / ratio).toStringAsFixed(0)}';
    return '${(ratio * 100).toStringAsFixed(0)}g per 100ml';
  }

  @override
  Widget build(BuildContext context) {
    final assetPath = _methodMeta[widget.recipe.methodKey] ?? 'assets/images/methods/v60.png';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerScrolled) => [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.recipe.name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, shadows: [const Shadow(blurRadius: 10, color: Colors.black45)])),
              background: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Image.asset(assetPath, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF121212), Color(0xFF000000)],
            ),
          ),
          child: Column(
            children: [
              // ── Info Row ──────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: GlassContainer(
                  padding: const EdgeInsets.all(16),
                  opacity: 0.1,
                  blur: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoChip(icon: Icons.thermostat_outlined,
                          label: '${widget.recipe.tempC.toInt()}°C'),
                      _InfoChip(icon: Icons.balance_outlined, label: _formattedRatio),
                      _InfoChip(icon: Icons.timer_outlined, label: _formatTime(widget.recipe.totalTimeSec)),
                      _InfoChip(icon: Icons.signal_cellular_alt_outlined, label: widget.recipe.difficulty),
                    ],
                  ),
                ),
              ),
              // ── Tabs ──────────────────────────────────────────────────────────
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Recipe Steps'),
                  Tab(text: 'Custom Versions'),
                  Tab(text: 'Recommended'),
                ],
                indicatorColor: const Color(0xFFC8A96E),
                indicatorWeight: 3,
                labelColor: const Color(0xFFC8A96E),
                unselectedLabelColor: Colors.white54,
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _StepsTab(
                      steps: _steps,
                      activeStep: _activeStep,
                      remainingSec: _remainingSec,
                      timerRunning: _timerRunning,
                      progressController: _progressController,
                      onStartTimer: _startTimer,
                      onStopTimer: _stopTimer,
                      formatTime: _formatTime,
                    ),
                    CustomRecipeListTab(methodKey: widget.recipe.methodKey),
                    _RecommendedRecipesTab(methodKey: widget.recipe.methodKey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Info Chip ────────────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFC8A96E), size: 20),
        const SizedBox(height: 6),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ─── Steps Tab ────────────────────────────────────────────────────────────────
class _StepsTab extends StatelessWidget {
  final List<Map<String, dynamic>> steps;
  final int activeStep;
  final int remainingSec;
  final bool timerRunning;
  final AnimationController progressController;
  final void Function(int) onStartTimer;
  final VoidCallback onStopTimer;
  final String Function(int) formatTime;

  const _StepsTab({
    required this.steps,
    required this.activeStep,
    required this.remainingSec,
    required this.timerRunning,
    required this.progressController,
    required this.onStartTimer,
    required this.onStopTimer,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: steps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, i) {
        final step = steps[i];
        final isActive = activeStep == i;
        final duration = (step['durationSec'] as int?) ?? 30;

        return GlassContainer(
          opacity: isActive ? 0.15 : 0.05,
          borderColor: isActive ? const Color(0xFFC8A96E).withOpacity(0.5) : null,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFC8A96E) : Colors.white10,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                        style: TextStyle(color: isActive ? Colors.black : Colors.white70, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(step['title'] ?? 'Step ${i + 1}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: isActive ? const Color(0xFFC8A96E) : Colors.white)),
                  ),
                  _DurationBadge(label: formatTime(duration)),
                ],
              ),
              const SizedBox(height: 12),
              Text(step['desc'] ?? '',
                  style: GoogleFonts.inter(color: Colors.white70, height: 1.6, fontSize: 13.5)),
              if (isActive) ...[
                const SizedBox(height: 20),
                _TimerSection(
                  remainingSec: remainingSec,
                  timerRunning: timerRunning,
                  progressController: progressController,
                  onStop: onStopTimer,
                  onRestart: () => onStartTimer(i),
                  formatTime: formatTime,
                ),
              ] else ...[
                const SizedBox(height: 16),
                Center(
                  child: TextButton.icon(
                    onPressed: () => onStartTimer(i),
                    icon: const Icon(Icons.play_arrow_rounded, color: Color(0xFFC8A96E)),
                    label: Text('START TIMER', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: const Color(0xFFC8A96E))),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _DurationBadge extends StatelessWidget {
  final String label;
  const _DurationBadge({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold)),
    );
  }
}

class _TimerSection extends StatelessWidget {
  final int remainingSec;
  final bool timerRunning;
  final AnimationController progressController;
  final VoidCallback onStop;
  final VoidCallback onRestart;
  final String Function(int) formatTime;

  const _TimerSection({
    required this.remainingSec,
    required this.timerRunning,
    required this.progressController,
    required this.onStop,
    required this.onRestart,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: progressController,
          builder: (context, _) => LinearProgressIndicator(
            value: progressController.value,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(timerRunning ? const Color(0xFFC8A96E) : Colors.white24),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatTime(remainingSec),
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFFC8A96E))),
            ElevatedButton.icon(
              onPressed: timerRunning ? onStop : onRestart,
              icon: Icon(timerRunning ? Icons.stop_rounded : Icons.replay_rounded, size: 20),
              label: Text(timerRunning ? 'STOP' : 'RESTART', style: const TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: timerRunning ? Colors.redAccent.withOpacity(0.8) : const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class _RecommendedRecipesTab extends ConsumerWidget {
  final String methodKey;
  const _RecommendedRecipesTab({required this.methodKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recommendedRecipesProvider(methodKey));

    return recipesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (recipes) {
        if (recipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_awesome_outlined, size: 48, color: Colors.white24),
                const SizedBox(height: 12),
                Text('No recommended recipes yet',
                  style: TextStyle(color: Colors.white.withOpacity(0.3))),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, i) => _RecommendedRecipeCard(recipe: recipes[i]),
        );
      },
    );
  }
}

final recommendedRecipesProvider = FutureProvider.family<List<RecommendedRecipe>, String>((ref, methodKey) async {
  final db = ref.watch(databaseProvider);
  return db.getRecommendedRecipesForMethod(methodKey);
});

class _RecommendedRecipeCard extends StatelessWidget {
  final RecommendedRecipe recipe;
  const _RecommendedRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Method Icon & Rating (Screenshot 1 style)
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.coffee_maker_outlined, color: const Color(0xFFC8A96E), size: 30),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(recipe.rating.toStringAsFixed(1), 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                ],
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Stats (Screenshot 1 style)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatLine(icon: Icons.coffee, label: '${recipe.coffeeGrams} g'),
                _StatLine(icon: Icons.water_drop, label: '${recipe.waterGrams} g'),
                _StatLine(icon: Icons.thermostat, label: '${recipe.tempC}°C'),
                _StatLine(icon: Icons.timer, label: '${recipe.timeSec} s'),
              ],
            ),
          ),
          // Radar Chart placeholder
          _RadarChart(sensoryJson: recipe.sensoryJson),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatLine({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white38),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _RadarChart extends StatelessWidget {
  final String sensoryJson;
  const _RadarChart({required this.sensoryJson});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(sensoryJson);
    } catch (_) {}

    // Expected labels: Sweetness, Acidity, Body, Balance, Aroma, Aftertaste
    final entries = [
      (data['sweetness'] ?? 3).toDouble(),
      (data['acidity'] ?? 3).toDouble(),
      (data['body'] ?? 3).toDouble(),
      (data['balance'] ?? 3).toDouble(),
      (data['aroma'] ?? 3).toDouble(),
      (data['aftertaste'] ?? 3).toDouble(),
    ];

    return SizedBox(
      width: 100,
      height: 100,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              fillColor: const Color(0xFFC8A96E).withOpacity(0.4),
              borderColor: const Color(0xFFC8A96E),
              entryRadius: 2,
              dataEntries: entries.map((v) => RadarEntry(value: v)).toList(),
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          radarBorderData: const BorderSide(color: Colors.white10),
          radarShape: RadarShape.polygon,
          getTitle: (index, angle) => const RadarChartTitle(text: ''),
          tickCount: 5,
          ticksTextStyle: const TextStyle(fontSize: 0),
          gridBorderData: const BorderSide(color: Colors.white10, width: 1),
        ),
      ),
    );
  }
}
