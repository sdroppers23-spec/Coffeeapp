import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/pressable_scale.dart';

class LotDesignDebugScreen extends StatelessWidget {
  const LotDesignDebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock lot for testing
    final mockLot = CoffeeLotDto(
      id: 'debug_lot',
      coffeeName: 'Ethiopia Yirgacheffe',
      roasteryName: 'Artisan Roasters',
      originCountry: 'Ethiopia',
      process: 'Washed',
      scaScore: '89',
      roastLevel: 'Light',
      sensoryPoints: {'acidity': 4, 'body': 3, 'sweetness': 5, 'flavor': 4},
      pricing: {},
      isDecaf: false,
      isFavorite: true,
      isArchived: false,
      createdAt: DateTime.now(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0D),
      appBar: AppBar(
        title: Text(
          'Lot Design Lab: Phase 5',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader(
            'PHASE 5: FOCUS ON VARIANT 18',
            'Isolating the Contrast Test to solve corner artifacts.',
          ),

          const _SectionHeader(
            '18. Contrast Background Test',
            'Forces a bright background under the swipable area to identify gaps.',
          ),
          _DebugLotCard(
            lot: mockLot,
            swipeColor: Colors.pinkAccent,
            variant: _CardVariant.contrastTest,
            label: 'PINK: Contrast Test',
          ),
          const _SectionHeader(
            '19. Naked Container Test',
            'Completely removes glass/blur to see if rectangular artifacts persist.',
          ),
          _DebugLotCard(
            lot: mockLot,
            swipeColor: Colors.orangeAccent,
            variant: _CardVariant.nakedContainer,
            label: 'NAKED: No Glass',
          ),
          const _SectionHeader(
            '20. Layered Stack (The Fix)',
            'Static rounded background under transparent dismissible.',
          ),
          _DebugLotCard(
            lot: mockLot,
            swipeColor: Colors.orangeAccent,
            variant: _CardVariant.variant20,
            label: 'ARCHIVE/DELETE: Blue & Red',
          ),
          const _SectionHeader(
            '21. Edit / Delete Variant',
            'Neon Green for editing, following Roaster patterns.',
          ),
          _DebugLotCard(
            lot: mockLot,
            swipeColor: Colors.greenAccent,
            variant: _CardVariant.variant21,
            label: 'EDIT/DELETE: Green & Red',
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

enum _CardVariant { contrastTest, nakedContainer, variant20, variant21 }

class _DebugLotCard extends StatefulWidget {
  final CoffeeLotDto lot;
  final Color swipeColor;
  final _CardVariant variant;
  final String label;

  const _DebugLotCard({
    required this.lot,
    required this.swipeColor,
    required this.variant,
    required this.label,
  });

  @override
  State<_DebugLotCard> createState() => _DebugLotCardState();
}

class _DebugLotCardState extends State<_DebugLotCard> {
  final ValueNotifier<DismissDirection?> _swipeDir = ValueNotifier(null);

  @override
  void dispose() {
    _swipeDir.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isV20 = widget.variant == _CardVariant.variant20;
    final isV21 = widget.variant == _CardVariant.variant21;

    if (isV20 || isV21) {
      final card = _buildCard();

      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              // 1. ДИНАМІЧНА ПІДКЛАДКА (Відстежує напрямок)
              Positioned.fill(
                child: ValueListenableBuilder<DismissDirection?>(
                  valueListenable: _swipeDir,
                  builder: (context, dir, child) {
                    Color bgColor = Colors.black;
                    IconData? icon;
                    String? label;
                    Alignment alignment = Alignment.center;

                    if (dir == DismissDirection.startToEnd) {
                      // LEFT SIDE ACTION
                      if (isV20) {
                        bgColor = const Color(0xFF3A7BBF).withOpacity(0.8);
                        icon = Icons.archive_outlined;
                        label = 'Архів';
                      } else {
                        bgColor = const Color(0xFF39FF14).withOpacity(0.8);
                        icon = Icons.edit_outlined;
                        label = 'Редагувати';
                      }
                      alignment = Alignment.centerLeft;
                    } else if (dir == DismissDirection.endToStart) {
                      // RIGHT SIDE ACTION (Delete for both)
                      bgColor = Colors.redAccent.withOpacity(0.8);
                      icon = Icons.delete_outline_rounded;
                      label = 'Видалити';
                      alignment = Alignment.centerRight;
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: bgColor.withOpacity(0.3),
                              width: 1.0,
                            ),
                          ),
                          alignment: alignment,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: (icon != null && label != null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon, 
                                    color: bgColor, // Колір іконки тепер такий же, як у обсмажчиках
                                    size: 26,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    label,
                                    style: GoogleFonts.outfit(
                                      color: bgColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ) 
                            : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 2. DISMISSIBLE (ПРОЗОРИЙ)
              Dismissible(
                key: ValueKey('lot_${widget.lot.id}_${widget.variant.name}'),
                direction: DismissDirection.horizontal,
                background: Container(color: Colors.transparent),
                secondaryBackground: Container(color: Colors.transparent),
                onUpdate: (details) {
                  if (details.progress > 0) {
                    if (_swipeDir.value != details.direction) {
                      _swipeDir.value = details.direction;
                    }
                  } else {
                    _swipeDir.value = null;
                  }
                },
                onDismissed: (_) {},
                child: card,
              ),
            ],
          ),
        ),
      );
    }

    final variant = widget.variant;

    Widget dismissible = Dismissible(
      key: Key('${widget.lot.id}_${variant.name}'),
      background: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: _buildSwipeBackground(Alignment.centerLeft),
      ),
      secondaryBackground: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: _buildSwipeBackground(Alignment.centerRight),
      ),
      child: _buildCard(),
    );

    Widget item = Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // [FIX] Synced radius
        clipBehavior: Clip.antiAliasWithSaveLayer, // [FIX] Layer clipping
        child: dismissible,
      ),
    );

    if (variant == _CardVariant.contrastTest) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            115,
            255,
            0,
          ), // Bright background to see gaps
          borderRadius: BorderRadius.circular(20), // [FIX] Synced radius
        ),
        child: item,
      );
    }

    return item;
  }

  Widget _buildSwipeBackground(Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: widget.swipeColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20), // [FIX] Rounded background
      ),
      child: Icon(Icons.delete_outline, color: widget.swipeColor),
    );
  }

  Widget _buildCard() {
    final isSelected = _getDebugSelectionState();
    final lot = widget.lot;
    final label = widget.label;
    final variant = widget.variant;

    if (variant == _CardVariant.nakedContainer) {
      return PressableScale(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.0,
            ),
          ),
          child: _CardContent(lot: lot, label: label),
        ),
      );
    }

    return PressableScale(
      onTap: () {},
      child: Container(
        // БАЗА-ЩИТ: Абсолютний чорний для максимального контрасту
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              // СКЛО НА ВЕСЬ РОЗМІР
              padding: const EdgeInsets.all(16), // Паддінг тепер ТУТ, всередині
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFC8A96E).withOpacity(0.15)
                    : Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFC8A96E).withOpacity(0.8)
                      : Colors.white.withOpacity(0.12),
                  width: 1.0,
                ),
              ),
              child: _CardContent(lot: lot, label: label),
            ),
          ),
        ),
      ),
    );
  }

  bool _getDebugSelectionState() => false;
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final CoffeeLotDto lot;
  final String label;
  const _CardContent({required this.lot, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lot.coffeeName ?? '',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lot.roasteryName ?? '',
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 14,
              color: Colors.white24,
            ),
            const SizedBox(width: 4),
            Text(
              lot.originCountry ?? '',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.water_drop_outlined,
              size: 14,
              color: Colors.white24,
            ),
            const SizedBox(width: 4),
            Text(
              lot.process ?? '',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
