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
import 'lots/lots_providers.dart';
import 'package:go_router/go_router.dart';
import '../../shared/services/roaster_image_service.dart';


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
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
            onPressed: () async {
              final confirmed = await _confirmDeleteDialog(currentRoaster.name);
              if (confirmed && mounted) {
                await ref
                    .read(userRoastersProvider.notifier)
                    .deleteRoaster(currentRoaster.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
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
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onSubmitted: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: context.t('search_lots'),
                    hintStyle:
                        GoogleFonts.outfit(color: Colors.white24, fontSize: 14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
                    filled: false,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      child: Icon(
                        Icons.search_rounded,
                        color: Color(0xFFC8A96E),
                        size: 20,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
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
                    l10n.translate('lots_by_roaster_title'),
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
                           (l.originCountry?.toLowerCase().contains(query) ?? false) ||
                           (l.region?.toLowerCase().contains(query) ?? false);
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
                          ref.read(userLotsProvider.notifier).toggleFavorite(lot.id);
                          ref.invalidate(userRoasterLotsProvider(currentRoaster.id));
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

  Future<bool> _confirmDeleteDialog(String name) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF151515),
            title: Text(
              context.t('delete_roaster_confirm_title'),
              style: const TextStyle(color: Color(0xFFC8A96E)),
            ),
            content: Text(
              context.t('delete_roaster_confirm_msg', args: {'name': name}),
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(context.t('cancel'), style: const TextStyle(color: Colors.white38)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(context.t('delete'), style: const TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<void> _showEditRoasterDialog(
    BuildContext context,
    WidgetRef ref,
    UserRoasterDto roaster,
  ) async {
    final notifier = ref.read(userRoastersProvider.notifier);
    final nameController = TextEditingController(text: roaster.name);
    final shortDescController = TextEditingController(text: roaster.description);
    final locationController = TextEditingController(text: roaster.location);
    final logoUrlController = TextEditingController(text: roaster.logoUrl);
    String? localPath = roaster.localLogoPath;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF151515),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            context.t('edit_roaster_title'),
            style: GoogleFonts.poppins(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final path = await RoasterImageService.pickAndSaveImage();
                    if (path != null) {
                      setDialogState(() => localPath = path);
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                      image: localPath != null
                          ? DecorationImage(image: FileImage(File(localPath!)), fit: BoxFit.cover)
                          : null,
                    ),
                    child: localPath == null
                        ? const Icon(Icons.add_a_photo_rounded, color: Color(0xFFC8A96E), size: 30)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _buildDialogField(context, nameController, context.t('name_label'), Icons.business_rounded),
                const SizedBox(height: 12),
                _buildDialogField(context, locationController, context.t('location_label'), Icons.location_on_rounded),
                const SizedBox(height: 12),
                _buildDialogField(context, logoUrlController, 'Logo URL (optional)', Icons.link_rounded),
                const SizedBox(height: 12),
                _buildDialogField(context, shortDescController, context.t('description_label'), Icons.description_rounded, maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.t('cancel'), style: GoogleFonts.outfit(color: Colors.white38)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty) return;
                final updated = roaster.copyWith(
                  name: nameController.text,
                  location: locationController.text,
                  description: shortDescController.text,
                  logoUrl: logoUrlController.text,
                  localLogoPath: localPath,
                  updatedAt: DateTime.now(),
                );
                await notifier.saveRoaster(updated);
                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(context.t('save'), style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDialogField(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
        prefixIcon: Icon(icon, color: const Color(0xFFC8A96E), size: 18),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.03),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC8A96E), width: 1)),
      ),
    );
  }
}
