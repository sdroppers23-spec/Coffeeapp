import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';
import '../encyclopedia/encyclopedia_screen.dart';

final brandLotsProvider = FutureProvider.family<List<CoffeeLotDto>, int>((ref, brandId) async {
  final db = ref.watch(databaseProvider);
  return db.getLotsForBrand(brandId);
});

class BrandDetailsScreen extends ConsumerWidget {
  final Brand brand;

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotsAsync = ref.watch(brandLotsProvider(brand.id));
    debugPrint('UI: BrandDetailsScreen for ${brand.name} (ID: ${brand.id})');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(brand.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Brand header / Logo
            if (brand.logoUrl.isNotEmpty)
              Center(
                child: Hero(
                  tag: 'brand_logo_${brand.id}',
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    child: _BrandLogo(
                      url: brand.logoUrl,
                      height: 80,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                brand.fullDesc,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 13, height: 1.6),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white10),
            Expanded(
              child: lotsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error loading lots: $e')),
                data: (lots) {
                  if (lots.isEmpty) {
                    return Center(
                      child: Text(ref.t('no_lots_found'), style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54))),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: lots.length,
                    itemBuilder: (context, i) => _BrandProductCard(entry: lots[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandProductCard extends ConsumerWidget {
  final CoffeeLotDto entry;
  const _BrandProductCard({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(entry.originCountry?.substring(0, 2) ?? '☕', style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.coffeeName ?? entry.roasteryName ?? 'Unknown Lot',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        entry.originCountry ?? entry.roasteryCountry ?? '',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    entry.scaScore ?? '',
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              entry.coffeeName ?? entry.originCountry ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9), fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 16),
            // Sensory info from lot
            if (entry.process != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.science_outlined, size: 14, color: Colors.white30),
                  const SizedBox(width: 4),
                  Text(entry.process ?? '', style: const TextStyle(color: Colors.white30, fontSize: 11)),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(ref.t('details'), style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String url;
  final double? height;

  const _BrandLogo({
    required this.url,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (url.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        url,
        height: height,
        placeholderBuilder: (ctx) => const SizedBox(
          width: 20,
          height: 20,
          child: Center(child: CircularProgressIndicator(strokeWidth: 1)),
        ),
      );
    }
    return Image.network(
      url,
      height: height,
      errorBuilder: (_, __, ___) => _FallbackIcon(height: height),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  final double? height;
  const _FallbackIcon({this.height});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.coffee_maker_outlined,
      size: height != null ? height! * 0.7 : 24,
      color: Colors.white24,
    );
  }
}

class _SensoryProfile extends ConsumerWidget {
  final CoffeeLotDto entry;
  const _SensoryProfile({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink(); // CoffeeLotDto sensory not displayed here
  }
}

class _SensoryScale extends StatelessWidget {
  final String label;
  final num value;

  const _SensoryScale({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.white60)),
          ),
          ...List.generate(5, (index) {
            final isFilled = index < value;
            return Container(
              margin: const EdgeInsets.only(right: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? const Color(0xFFC8A96E) : Colors.white10,
                border: isFilled ? null : Border.all(color: Colors.white24, width: 0.5),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 11, height: 1.4),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(color: Colors.white38)),
            TextSpan(text: value, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

void _showProcessDetailSheet(BuildContext context, CoffeeLotDto entry, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (ctx2, scrollController) => Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.history_edu, color: Color(0xFFC8A96E)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(ref.t('process_detail').toUpperCase(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(entry.processMethod.toUpperCase(), style: const TextStyle(color: Colors.white38, letterSpacing: 1.2, fontSize: 12)),
          ),
          const Divider(height: 32, color: Colors.white10),
          Expanded(
            child: Markdown(
              controller: scrollController,
              data: _translateDetailedDescription(entry, ref),
              styleSheet: MarkdownStyleSheet(
                h3: GoogleFonts.poppins(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 16),
                p: const TextStyle(color: Colors.white70, height: 1.6, fontSize: 14),
                listBullet: const TextStyle(color: Color(0xFFC8A96E)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String _translateDetailedDescription(CoffeeLotDto entry, WidgetRef ref) {
  final p = (entry.process ?? '').toLowerCase();
  if (p.contains('natural') || p.contains('натур')) return ref.t('process_natural_desc');
  if (p.contains('washed') || p.contains('мит')) return ref.t('process_washed_desc');
  if (p.contains('anaerobic') || p.contains('анаероб')) return ref.t('process_anaerobic_desc');
  if (p.contains('thermal') || p.contains('термал')) return ref.t('process_thermal_desc');
  if (p.contains('honey') || p.contains('хані')) return ref.t('process_honey_desc');
  return entry.process ?? '';
}
