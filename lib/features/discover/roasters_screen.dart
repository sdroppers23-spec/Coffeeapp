import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/coffee_data_seed.dart';
import '../../core/database/sync_service.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../encyclopedia/encyclopedia_screen.dart';
import '../specialty/specialty_screen.dart';
import '../latte_art/latte_art_screen.dart';
import 'brand_details_screen.dart';
import 'farmers_screen.dart';

// ─── Provider ─────────────────────────────────────────────────────────────────
final brandsProvider = FutureProvider<List<Brand>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllBrands();
});

final brandByIdProvider = FutureProvider.family<Brand?, int>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getBrandById(id);
});

class RoastersScreen extends ConsumerWidget {
  const RoastersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ref.t('premium_roasters'),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  Text(
                    ref.t('specialty'),
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          brandsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) =>
                SliverFillRemaining(child: Center(child: Text('Error: $e'))),
            data: (brands) {
              if (brands.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      ref.t('no_results'),
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.4),
                      ),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _RoasterCard(brand: brands[i]),
                    ),
                    childCount: brands.length,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: const Color(0xFF1A1A1A),
              title: Text(
                ref.t('sync_options'),
                style: const TextStyle(color: Colors.white),
              ),
              content: Text(
                ref.t('sync_choice_desc'),
                style: const TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    _handleSync(ref, context, isPush: false);
                  },
                  child: Text(
                    ref.t('cloud_sync'),
                    style: const TextStyle(color: Color(0xFFC8A96E)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    _handleSync(ref, context, isPush: true);
                  },
                  child: Text(
                    ref.t('push_local'),
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: const Color(0xFFC8A96E),
        child: const Icon(Icons.cloud_sync, color: Colors.black),
      ),
    );
  }

  Future<void> _handleSync(
    WidgetRef ref,
    BuildContext context, {
    required bool isPush,
  }) async {
    final db = ref.read(databaseProvider);
    final syncService = ref.read(syncServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          isPush ? 'Pushing to Cloud...' : 'Connecting to Cloud Sync...',
        ),
        duration: const Duration(seconds: 1),
      ),
    );

    try {
      if (isPush) {
        // Ensure we have local data to push by seeding once if empty
        final localBrands = await db.getAllBrands();
        if (localBrands.isEmpty) {
          await CoffeeDataSeed(db).seedAll(
            onProgress: (m) => messenger.showSnackBar(
              SnackBar(
                content: Text(m),
                duration: const Duration(milliseconds: 500),
              ),
            ),
          );
        }
        await syncService.pushLocalToCloud(
          onProgress: (msg) {
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Text(msg),
                duration: const Duration(seconds: 2),
                backgroundColor: msg.contains('[STABLE]')
                    ? Colors.green
                    : Colors.orange,
              ),
            );
          },
        );
      } else {
        await syncService.syncAll(
          clearLocal: true,
          onProgress: (msg) {
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Text(msg),
                duration: const Duration(seconds: 2),
                backgroundColor: msg.contains('[STABLE]')
                    ? Colors.green
                    : const Color(0xFFC8A96E),
              ),
            );
          },
        );
      }
      ref.invalidate(brandsProvider);
      ref.invalidate(farmersProvider);
      ref.invalidate(encyclopediaProvider);
      ref.invalidate(specialtyArticlesProvider);
      ref.invalidate(latteArtPatternsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Action failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _RoasterCard extends ConsumerStatefulWidget {
  final Brand brand;
  const _RoasterCard({required this.brand});

  @override
  ConsumerState<_RoasterCard> createState() => _RoasterCardState();
}

class _RoasterCardState extends ConsumerState<_RoasterCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BrandDetailsScreen(brand: widget.brand),
        ),
      ),
      child: GlassContainer(
        padding: EdgeInsets.zero,
        opacity: 0.1,
        child: Column(
          children: [
            // Header Image/Video Placeholder
            Stack(
              children: [
                Hero(
                  tag: 'brand_bg_${widget.brand.id}',
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                    ),
                    child: widget.brand.logoUrl.isNotEmpty
                        ? Opacity(
                            opacity: 0.15,
                            child: _BrandLogo(url: widget.brand.logoUrl),
                          )
                        : const Icon(
                            Icons.business,
                            size: 40,
                            color: Colors.white24,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Hero(
                    tag: 'brand_logo_${widget.brand.id}',
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: widget.brand.logoUrl.isNotEmpty
                          ? _BrandLogo(url: widget.brand.logoUrl, height: 40)
                          : const Icon(
                              Icons.coffee,
                              color: Colors.black,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.brand.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        icon: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.brand.shortDesc,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.8),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox(height: 8),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        widget.brand.fullDesc,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.white30,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.brand.location,
                        style: const TextStyle(
                          color: Colors.white30,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ref.t('browse_lots'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
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
      errorBuilder: (context, error, stackTrace) {
        debugPrint('LOGO ERROR: $url - $error');
        return _FallbackIcon(height: height);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 1,
          ),
        );
      },
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
