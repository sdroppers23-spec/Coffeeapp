import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_app_bar.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/utils/content_utils.dart';
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
    final flagUrl = farmer.effectiveFlagUrl;

    const gold = Color(0xFFC8A96E);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
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
          borderRadius: 28,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Farmer Portrait with Glass Border
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: gold.withValues(alpha: 0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: gold.withValues(alpha: 0.15),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _buildPortrait(farmer.effectiveImageUrl),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Name & Region
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          farmer.name,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: gold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${farmer.region}, ${farmer.country}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Mini specialization chips
                        Wrap(
                          spacing: 8,
                          children: [
                             if (farmer.description.isNotEmpty)
                               _buildMiniChip(farmer.description.split(',').first),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Country Flag
                  if (flagUrl.isNotEmpty)
                    _buildFlag(flagUrl),
                ],
              ),
              const SizedBox(height: 20),
              // Bio Snippet
              Text(
                ContentUtils.getPreviewText(farmer.story, limit: 120),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 16),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Докладно'.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: gold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: gold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortrait(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.white10),
      errorWidget: (context, url, error) => Container(
        color: const Color(0xFF1C1C1E),
        child: const Icon(Icons.person_outline_rounded, color: Colors.white24, size: 32),
      ),
    );
  }

  Widget _buildFlag(String url) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: url.startsWith('http')
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.public_rounded,
                  size: 18,
                  color: Colors.white24,
                ),
              )
            : Image.asset(url, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildMiniChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.2)),
      ),
      child: Text(
        label.trim(),
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFC8A96E),
        ),
      ),
    );
  }
}
