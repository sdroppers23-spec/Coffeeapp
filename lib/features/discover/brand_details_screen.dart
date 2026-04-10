import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_localizations.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/glass_container.dart';

final brandLotsProvider = FutureProvider.family<List<CoffeeLotDto>, int>((
  ref,
  brandId,
) async {
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
        title: Text(
          brand.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
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
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: _BrandLogo(url: brand.logoUrl, height: 80),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                brand.fullDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontSize: 13,
                  height: 1.6,
                ),
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
                      child: Text(
                        ref.t('no_lots_found'),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.54),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: lots.length,
                    itemBuilder: (context, i) =>
                        _BrandProductCard(entry: lots[i]),
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
                Text(
                  entry.originCountry?.substring(0, 2) ?? '☕',
                  style: const TextStyle(fontSize: 24),
                ),
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
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.54),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
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
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            // Sensory info from lot
            if (entry.process != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.science_outlined,
                    size: 14,
                    color: Colors.white30,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    entry.process ?? '',
                    style: const TextStyle(color: Colors.white30, fontSize: 11),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    ref.t('details'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
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

  const _BrandLogo({required this.url, this.height});

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
      errorBuilder: (_, _, _) => _FallbackIcon(height: height),
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
