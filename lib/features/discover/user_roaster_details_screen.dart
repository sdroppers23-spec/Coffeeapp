import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/supabase/supabase_provider.dart';
import 'lots/widgets/lot_card_widgets.dart';
import 'lots/providers/roaster_providers.dart';
import 'package:go_router/go_router.dart';

final userRoasterLotsProvider =
    FutureProvider.family<List<CoffeeLotDto>, String>((ref, roasterId) async {
      final db = ref.watch(databaseProvider);
      final userId = ref.watch(currentUserProvider)?.id;
      if (userId == null) return [];
      return db.getLotsByUserRoaster(userId, roasterId);
    });

class UserRoasterDetailsScreen extends ConsumerStatefulWidget {
  final UserRoasterDto roaster;

  const UserRoasterDetailsScreen({super.key, required this.roaster});

  @override
  ConsumerState<UserRoasterDetailsScreen> createState() =>
      _UserRoasterDetailsScreenState();
}

class _UserRoasterDetailsScreenState extends ConsumerState<UserRoasterDetailsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for updates to this specific roaster
    final allRoasters = ref.watch(userRoastersProvider);
    final currentRoaster = allRoasters.firstWhere(
      (r) => r.id == widget.roaster.id,
      orElse: () => widget.roaster,
    );

    final lotsAsync = ref.watch(userRoasterLotsProvider(currentRoaster.id));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            onPressed: () => _showEditRoasterDialog(context, ref, currentRoaster),
          ),
          IconButton(
            icon: Icon(
              currentRoaster.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: currentRoaster.isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              ref
                  .read(userRoastersProvider.notifier)
                  .toggleFavorite(currentRoaster.id);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Header (Logo)
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: _buildLogo(currentRoaster),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              currentRoaster.name,
              style: GoogleFonts.cormorantGaramond(
                color: const Color(0xFFC8A96E),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (currentRoaster.location != null &&
                currentRoaster.location!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      currentRoaster.location!,
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            if (currentRoaster.description != null &&
                currentRoaster.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Text(
                  currentRoaster.description!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.white60,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            const SizedBox(height: 32),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: context.t('search_lots'),
                    hintStyle: GoogleFonts.outfit(color: Colors.white24),
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFC8A96E),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    l10n.translate('roaster_lots_title'),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFC8A96E),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  lotsAsync.when(
                    data: (lots) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        lots.length.toString(),
                        style: const TextStyle(
                          color: Color(0xFFC8A96E),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    loading: () => const SizedBox(),
                    error: (error, _) => const SizedBox(),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white10,
              height: 32,
              indent: 24,
              endIndent: 24,
            ),
            Expanded(
              child: lotsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
                ),
                error: (error, _) => Center(child: Text(error.toString())),
                data: (lots) {
                  final filteredLots = lots.where((l) {
                    final query = _searchQuery.toLowerCase();
                    if (query.isEmpty) return true;
                    return (l.coffeeName?.toLowerCase().contains(query) ?? false) ||
                           (l.originCountry.toLowerCase().contains(query)) ||
                           (l.region.toLowerCase().contains(query));
                  }).toList();

                  if (filteredLots.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.coffee_rounded,
                            color: Colors.white10,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? l10n.translate('no_lots_linked')
                                : l10n.translate('empty_search_title'),
                            style: GoogleFonts.outfit(color: Colors.white24),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: filteredLots.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MyLotListCard(
                        lot: filteredLots[i],
                        isSelected: false,
                        isSelectionMode: false,
                        onLongPress: (_) {},
                        onFavoriteToggle: (lot) {
                          // This would normally be handled by a dedicated lots notifier
                          // For now, let's use the DB directly or a placeholder if needed
                          // But we should probably have a way to toggle lot favorite
                        },
                        onTap: (id) {
                          context.push('/lot_details', extra: {'lot': filteredLots[i]});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(UserRoasterDto roaster) {
    if (roaster.localLogoPath != null && roaster.localLogoPath!.isNotEmpty) {
      final file = File(roaster.localLogoPath!);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
    }

    if (roaster.logoUrl != null && roaster.logoUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: roaster.logoUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.business_rounded,
          color: Color(0xFFC8A96E),
          size: 40,
        ),
      );
    }

    return const Icon(
      Icons.business_rounded,
      color: Color(0xFFC8A96E),
      size: 40,
    );
  }
}
