import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';
import '../../core/l10n/app_localizations.dart';

class CustomRecipeTimerScreen extends ConsumerStatefulWidget {
  final CustomRecipe recipe;

  const CustomRecipeTimerScreen({super.key, required this.recipe});

  @override
  ConsumerState<CustomRecipeTimerScreen> createState() => _CustomRecipeTimerScreenState();
}

class _CustomRecipeTimerScreenState extends ConsumerState<CustomRecipeTimerScreen> {
  bool _isRunning = false;
  int _elapsedSec = 0;
  Timer? _timer;
  late List<Map<String, dynamic>> _pours;

  @override
  void initState() {
    super.initState();
    try {
      _pours = (jsonDecode(widget.recipe.pourScheduleJson) as List)
          .cast<Map<String, dynamic>>();
      // Sort by minute just in case
      _pours.sort((a, b) => (a['atMinute'] as num).compareTo(b['atMinute'] as num));
    } catch (_) {
      _pours = [];
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _elapsedSec++;
          });
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _elapsedSec = 0;
    });
  }

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  int _getActivePourIndex() {
    for (int i = _pours.length - 1; i >= 0; i--) {
      final pourSec = ((_pours[i]['atMinute'] as num) * 60).round();
      if (_elapsedSec >= pourSec) {
        return i;
      }
    }
    return -1;
  }

  String _getActiveStepText(int activeIndex) {
    if (activeIndex < 0) return 'Ready to brew';
    if (activeIndex >= _pours.length) return 'Brewing complete';
    
    final pour = _pours[activeIndex];
    final isBloom = activeIndex == 0;
    final ml = pour['waterMl'];
    final notes = pour['notes']?.toString();
    
    String text = isBloom ? 'Bloom: Pour $ml ml' : 'Pour $ml ml';
    if (notes != null && notes.isNotEmpty) {
      text += ' - $notes';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = _getActivePourIndex();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name, style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetTimer,
            tooltip: 'Reset Timer',
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Timer Display ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFC8A96E).withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: _isRunning ? null : 0.0, // Or calculate based on step
                        strokeWidth: 8,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC8A96E)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(_elapsedSec),
                          style: GoogleFonts.poppins(
                            fontSize: 64,
                            fontWeight: FontWeight.w300,
                            color: _isRunning ? const Color(0xFFC8A96E) : Colors.white,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          _isRunning ? 'RUNNING' : 'PAUSED',
                          style: const TextStyle(fontSize: 12, letterSpacing: 4, color: Colors.white38),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _toggleTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 28),
                  label: Text(
                    _isRunning ? 'PAUSE' : 'START',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.white24 : const Color(0xFFC8A96E),
                    foregroundColor: _isRunning ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8A96E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFC8A96E).withOpacity(0.3)),
                  ),
                  child: Text(
                    _getActiveStepText(activeIndex),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFC8A96E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // ── Info Row ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatText('☕ ${widget.recipe.coffeeGrams}g'),
                _StatText('💧 ${widget.recipe.totalWaterMl.toInt()}ml'),
                if (widget.recipe.brewTempC > 0)
                  _StatText('🌡 ${widget.recipe.brewTempC.toInt()}°C'),
                if (widget.recipe.comandanteClicks > 0)
                  _StatText('🔴 ${widget.recipe.comandanteClicks} clk'),
              ],
            ),
          ),
          const Divider(color: Colors.white12),

          // ── Pours List ──────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pours.length,
              itemBuilder: (context, i) {
                final pour = _pours[i];
                final isPast = i < activeIndex;
                final isActive = i == activeIndex;
                final pourSec = ((pour['atMinute'] as num) * 60).round();
                final ml = pour['waterMl'];
                final n = pour['pourNumber'] ?? (i + 1);
                final isBloom = i == 0;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFC8A96E).withOpacity(0.15)
                        : (isPast ? Colors.white.withOpacity(0.02) : Colors.white.withOpacity(0.05)),
                    border: Border.all(
                      color: isActive ? const Color(0xFFC8A96E) : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          _formatTime(pourSec),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isPast ? Colors.white38 : (isActive ? const Color(0xFFC8A96E) : Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBloom ? ref.t('bloom') : '${ref.t('pour')} #$n',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isPast ? Colors.white38 : Colors.white,
                              ),
                            ),
                            if (pour['notes'] != null && pour['notes'].toString().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  pour['notes'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isPast ? Colors.white24 : Colors.white70,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        '+$ml ml',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isPast ? Colors.white38 : Colors.lightBlueAccent.shade100,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatText extends StatelessWidget {
  final String text;
  const _StatText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13),
    );
  }
}
