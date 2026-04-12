import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/config/flag_constants.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import 'farmer_detail_screen.dart';

final farmersProvider = FutureProvider<List<LocalizedFarmerDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  final locale = ref.watch(localeProvider);
  return db.getAllFarmers(locale);
});

class FarmersBody extends ConsumerWidget {
  const FarmersBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFarms = ref.watch(farmersProvider);

    return asyncFarms.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
      ),
      data: (farmers) {
        if (farmers.isEmpty) {
          return Center(
            child: Text(
              'No farmers found. Syncing...',
              style: GoogleFonts.poppins(color: Colors.white38),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
          physics: const BouncingScrollPhysics(),
          itemCount: farmers.length,
          itemBuilder: (context, index) {
            final farmer = farmers[index];
            return _PremiumFarmerCard(farmer: farmer);
          },
        );
      },
    );
  }
}

class FarmersScreen extends ConsumerStatefulWidget {
  const FarmersScreen({super.key});

  @override
  ConsumerState<FarmersScreen> createState() => _FarmersScreenState();
}

class _FarmersScreenState extends ConsumerState<FarmersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: PremiumAppBar(
        title: ref.t('farmers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFFC8A96E)),
            onPressed: () => ref.invalidate(farmersProvider),
          ),
        ],
      ),
      body: const Column(
        children: [
          SizedBox(height: 110), // Space for PremiumAppBar
          Expanded(child: FarmersBody()),
        ],
      ),
    );
  }
}

class _PremiumFarmerCard extends ConsumerWidget {
  final LocalizedFarmerDto farmer;
  const _PremiumFarmerCard({required this.farmer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If countryEmoji starts with http, it's a bucket URL.
    final flagUrl = farmer.countryEmoji.startsWith('http') 
        ? farmer.countryEmoji 
        : (FlagConstants.getFlag(farmer.country) ?? FlagConstants.getFlag(farmer.countryEmoji));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PressableScale(
        onTap: () {
          ref.read(settingsProvider.notifier).triggerHaptic();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FarmerDetailScreen(farmer: farmer),
            ),
          );
        },
        child: GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(16),
          blur: 20,
          opacity: 0.1,
          borderColor: Colors.white.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Farmer Portrait with Glass Border
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                        image: DecorationImage(
                        image: NetworkImage(farmer.effectiveImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name & Region
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          farmer.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${farmer.region}, ${farmer.country}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Mini specialization chips
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildMiniChip(farmer.description.split(',').first),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Glass Sphere Flag
                  if (flagUrl != null)
                    CachedNetworkImage(
                      imageUrl: flagUrl,
                      width: 48,
                      height: 48,
                      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (_, __, ___) => const SizedBox(width: 48),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              // Bio Snippet
              Text(
                farmer.story,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 12),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFC8A96E),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Color(0xFFC8A96E),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        label.trim(),
        style: GoogleFonts.poppins(fontSize: 10, color: Colors.white38),
      ),
    );
  }
}
