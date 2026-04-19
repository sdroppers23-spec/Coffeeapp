import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/supabase/supabase_provider.dart';
import 'brand_details_screen.dart';
import '../../core/database/dtos.dart';
import 'discovery_providers.dart';

class RoastersBody extends ConsumerWidget {
  const RoastersBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);

    return brandsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
      ),
      data: (brands) {
        if (brands.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.storefront_outlined,
                  size: 64,
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                ),
                const SizedBox(height: 24),
                Text(
                  ref.t('no_results'),
                  style: GoogleFonts.poppins(
                    color: Colors.white38,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                PressableScale(
                  onTap: () => RoastersScreen._showAddRoasterDialog(context, ref),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    borderRadius: 16,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Color(0xFFC8A96E), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Додати обсмажчика',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFC8A96E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return _PremiumRoasterCard(brand: brands[index]);
          },
        );
      },
    );
  }
}

class RoastersScreen extends ConsumerWidget {
  const RoastersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Наші обсмажчики',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () => _showAddRoasterDialog(context, ref),
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFFC8A96E),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const RoastersBody(),
      ),
    );
  }

  static Future<void> _showAddRoasterDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final shortDescController = TextEditingController();
    final locationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add Artisian Roaster',
          style: GoogleFonts.poppins(
            color: const Color(0xFFC8A96E),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogField(
              nameController,
              'Roastery Name',
              Icons.business_rounded,
            ),
            const SizedBox(height: 12),
            _buildDialogField(
              locationController,
              'Location',
              Icons.location_on_rounded,
            ),
            const SizedBox(height: 12),
            _buildDialogField(
              shortDescController,
              'Short Description',
              Icons.description_rounded,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.white38),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                final user = ref.read(currentUserProvider);
                await db.addBrand(
                  user?.id ?? '',
                  nameController.text,
                  locationController.text,
                  shortDescController.text,
                );
                ref.invalidate(brandsProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: const Color(0xFFC8A96E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFFC8A96E), size: 18),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _PremiumRoasterCard extends ConsumerWidget {
  final Brand brand;
  const _PremiumRoasterCard({required this.brand});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PressableScale(
        onTap: () {
          ref.read(settingsProvider.notifier).triggerHaptic();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BrandDetailsScreen(brand: brand)),
          );
        },
        child: GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Logo Container
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: _BrandLogo(url: brand.logoUrl),
                  ),
                  const SizedBox(width: 16),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brand.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 12,
                              color: Colors.white38,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              brand.location,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white24,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                brand.shortDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String url;
  const _BrandLogo({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const Icon(Icons.coffee_rounded, color: Colors.white24);
    }
    if (url.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        url,
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 1)),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.contain,
      errorWidget: (_, _, _) =>
          const Icon(Icons.coffee_rounded, color: Colors.white24),
    );
  }
}
