import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';

import '../../core/l10n/app_localizations.dart';
import 'brand_details_screen.dart';

import '../../core/database/dtos.dart';
import 'discovery_providers.dart';


// Removed redundant local brandsProvider. Using the one from discovery_providers.dart.

class RoastersScreen extends ConsumerWidget {
  const RoastersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => _showAddRoasterDialog(context, ref),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFFC8A96E),
                    ),
                  ),
                ),
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
                        ).colorScheme.onSurface.withValues(alpha: 0.4),
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
    );
  }

  Future<void> _showAddRoasterDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final shortDescController = TextEditingController();
    final locationController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Add New Roaster',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Roaster Name',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              TextField(
                controller: shortDescController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              TextField(
                controller: locationController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              ref.t('cancel'),
              style: const TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.pop(ctx, true);
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Color(0xFFC8A96E)),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      final db = ref.read(databaseProvider);
      await db.addBrand(
        nameController.text,
        locationController.text,
        shortDescController.text,
      );
      ref.invalidate(brandsProvider);
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

  Future<void> _showDeleteConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          ref.t('confirm_delete'),
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete ${widget.brand.name}? This will unlink all associated coffees.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              ref.t('cancel'),
              style: const TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final db = ref.read(databaseProvider);
        await db.deleteBrand(widget.brand.id);
        ref.invalidate(brandsProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Roaster deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BrandDetailsScreen(brand: widget.brand),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Header Image/Video Placeholder
            Stack(
              children: [
                Hero(
                  tag: 'brand_bg_${widget.brand.id}',
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.black12,
                    child: widget.brand.logoUrl.isNotEmpty
                        ? Opacity(
                            opacity: 0.15,
                            child: _BrandLogo(url: widget.brand.logoUrl),
                          )
                        : const SizedBox(),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Hero(
                    tag: 'brand_logo_${widget.brand.id}',
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D3748),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24, width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: widget.brand.logoUrl.isNotEmpty
                          ? _BrandLogo(url: widget.brand.logoUrl, height: 36)
                          : const Icon(
                              Icons.coffee_maker_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                    ),
                  ),
                ),
                // Delete button (only for user-added roasters, e.g. id > 10)
                if (widget.brand.id > 10)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: _showDeleteConfirmation,
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 20,
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
                          color: const Color(0xFFC8A96E),
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
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFC8A96E),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Color(0xFFC8A96E),
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
