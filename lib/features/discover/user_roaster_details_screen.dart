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
import '../../core/providers/preferences_provider.dart';
import '../../shared/services/roaster_image_service.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../navigation/navigation_providers.dart';


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

  static Future<void> showEditRoasterDialog(
    BuildContext context,
    WidgetRef ref,
    UserRoasterDto roaster,
  ) async {
    final notifier = ref.read(userRoastersProvider.notifier);
    final nameController = TextEditingController(text: roaster.name);
    final shortDescController = TextEditingController(
      text: roaster.description,
    );
    final countryController = TextEditingController(text: roaster.country);
    final locationController = TextEditingController(text: roaster.location);
    final logoUrlController = TextEditingController(text: roaster.logoUrl);
    String? localPath = roaster.localLogoPath;
    String? urlError;

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF151515),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          title: Text(
            context.t('edit_roaster_title'),
            style: GoogleFonts.poppins(
              color: const Color(0xFFC8A96E),
              fontWeight: FontWeight.bold,
            ),
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
                          ? DecorationImage(
                              image: FileImage(File(localPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: localPath == null
                        ? const Icon(
                            Icons.add_a_photo_rounded,
                            color: Color(0xFFC8A96E),
                            size: 30,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                buildDialogField(
                  context,
                  nameController,
                  context.t('roaster_name_label'),
                  Icons.business_rounded,
                ),
                const SizedBox(height: 12),
                buildDialogField(
                  context,
                  locationController,
                  context.t('city_label'),
                  Icons.location_on_rounded,
                ),
                const SizedBox(height: 12),
                buildDialogField(
                  context,
                  countryController,
                  context.t('country_label'),
                  Icons.public_rounded,
                ),
                const SizedBox(height: 12),
                buildDialogField(
                  context,
                  logoUrlController,
                  context.t('roaster_logo_url_label'),
                  Icons.link_rounded,
                  errorText: urlError,
                ),
                const SizedBox(height: 12),
                buildDialogField(
                  context,
                  shortDescController,
                  context.t('short_desc_label'),
                  Icons.description_rounded,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) return;

                    String url = logoUrlController.text.trim();
                    if (url.isNotEmpty) {
                      // Basic URL validation & auto-prefix
                      if (!url.startsWith('http://') &&
                          !url.startsWith('https://')) {
                        url = 'https://$url';
                      }

                      final urlRegExp = RegExp(
                        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
                      );

                      if (!urlRegExp.hasMatch(url)) {
                        setDialogState(() {
                          urlError = context.t('invalid_url_format');
                        });
                        return;
                      }
                    }

                    final updated = roaster.copyWith(
                      name: nameController.text,
                      country: countryController.text,
                      location: locationController.text,
                      description: shortDescController.text,
                      logoUrl: url,
                      localLogoPath: localPath,
                      updatedAt: DateTime.now(),
                    );
                    await notifier.saveRoaster(updated);
                    if (context.mounted) Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8A96E),
                    foregroundColor: Colors.black,
                    minimumSize: const Offset(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                  ),
                  child: Text(
                    context.t('save'),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    minimumSize: const Offset(double.infinity, 44),
                  ),
                  child: Text(
                    context.t('cancel'),
                    style: GoogleFonts.outfit(
                      color: Colors.white38,
                      fontWeight: FontWeight.w600,
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

  static Future<void> showLinkLotDialog(
    BuildContext context,
    WidgetRef ref,
    UserRoasterDto roaster,
  ) async {
    final allLotsAsync = ref.read(userLotsStreamProvider);
    final allLots = allLotsAsync.value ?? [];

    // Filter lots that are not already linked to this roaster
    final availableLots = allLots
        .where((l) => l.userRoasterId != roaster.id)
        .toList();

    if (availableLots.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF151515),
            content: Text(
              context.t('no_lots_available_to_link'),
              style: const TextStyle(color: Color(0xFFC8A96E)),
            ),
          ),
        );
      }
      return;
    }

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(
          context.t('link_lot_title'),
          style: GoogleFonts.poppins(
            color: const Color(0xFFC8A96E),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableLots.length,
              itemBuilder: (context, index) {
                final lot = availableLots[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: Colors.white.withValues(alpha: 0.03),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.coffee_rounded,
                        color: Color(0xFFC8A96E),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      lot.coffeeName ?? context.t('unknown_lot'),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      lot.originCountry ?? '',
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.link_rounded,
                      color: Color(0xFFC8A96E),
                    ),
                    onTap: () async {
                      await ref
                          .read(databaseProvider)
                          .linkLotToRoaster(lot.id, roaster.id);
                      ref.invalidate(userRoasterLotsProvider(roaster.id));
                      if (context.mounted) Navigator.pop(ctx);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              context.t('cancel'),
              style: GoogleFonts.outfit(color: Colors.white38),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> confirmDeleteDialog(
    BuildContext context,
    String name,
  ) async {
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
                child: Text(
                  context.t('cancel'),
                  style: const TextStyle(color: Colors.white38),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  context.t('delete'),
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<bool> confirmUnlinkDialog(
    BuildContext context,
    String lotName,
  ) async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: true,
          barrierLabel: '',
          barrierColor: Colors.black87,
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (ctx, anim1, anim2) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.link_off_rounded,
                      color: Colors.redAccent,
                      size: 48,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      context.t('unlink_lot_confirm_title'),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.t('unlink_lot_confirm_desc_template', args: {'name': lotName}),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white60,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(ctx, false),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white.withValues(alpha: 0.05),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                context.t('cancel').toUpperCase(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(ctx, true),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.redAccent,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                context.t('unlink_uppercase'),
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  static Widget buildDialogField(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
        errorText: errorText,
        errorStyle: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 11),
        prefixIcon: Icon(icon, color: const Color(0xFFC8A96E), size: 18),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.03),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC8A96E), width: 1),
        ),
      ),
    );
  }

  @override
  ConsumerState<UserRoasterDetailsScreen> createState() =>
      _UserRoasterDetailsScreenState();
}

class _UserRoasterDetailsScreenState
    extends ConsumerState<UserRoasterDetailsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
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

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) return;
        ref.read(navBarVisibleProvider.notifier).show();
      },
      child: Scaffold(
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
            icon: const Icon(Icons.add_link_rounded, color: Color(0xFFC8A96E)),
            tooltip: context.t('link_lot_title'),
            onPressed: () => UserRoasterDetailsScreen.showLinkLotDialog(
              context,
              ref,
              currentRoaster,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: Colors.white70),
            onPressed: () => UserRoasterDetailsScreen.showEditRoasterDialog(
              context,
              ref,
              currentRoaster,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
            onPressed: () async {
              final confirmed =
                  await UserRoasterDetailsScreen.confirmDeleteDialog(
                    context,
                    currentRoaster.name,
                  );
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
              color: currentRoaster.isFavorite
                  ? Colors.redAccent
                  : Colors.white,
            ),
            onPressed: () {
              ref
                  .read(userRoastersProvider.notifier)
                  .toggleFavorite(currentRoaster.id);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 80), // Increased from 40 to fix "накладка"
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
                if ((currentRoaster.location?.isNotEmpty ?? false) ||
                    (currentRoaster.country?.isNotEmpty ?? false))
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
                          [currentRoaster.location, currentRoaster.country]
                              .where((s) => s != null && s.isNotEmpty)
                              .join(', '),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
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
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: context.t('search_lots'),
                        hintStyle: GoogleFonts.outfit(
                          color: Colors.white24,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                          bottom: 0,
                        ),
                        filled: false,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 12, right: 8, top: 9),
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
                        context.t('lots_by_roaster_title'),
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
                            color: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.1),
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
              ],
            ),
          ),
          lotsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
              ),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(child: Text(error.toString())),
            ),
            data: (lots) {
              final filteredLots = lots.where((l) {
                final query = _searchQuery.toLowerCase();
                if (query.isEmpty) return true;
                return (l.coffeeName?.toLowerCase().contains(query) ?? false) ||
                    (l.originCountry?.toLowerCase().contains(query) ?? false) ||
                    (l.region?.toLowerCase().contains(query) ?? false);
              }).toList();

              if (filteredLots.isEmpty) {
                return SliverToBoxAdapter(
                  child: _buildEmptyState(isSearch: _searchQuery.isNotEmpty),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MyLotListCard(
                        forcedSwipeMode: LotSwipeMode.swipe,
                        lot: filteredLots[i],
                        isSelected: false,
                        isSelectionMode: false,
                        onLongPress: (_) {},
                        onFavoriteToggle: (lot) {
                          ref
                              .read(databaseProvider)
                              .toggleLotFavorite(lot.id, !lot.isFavorite);
                          ref.invalidate(
                            userRoasterLotsProvider(currentRoaster.id),
                          );
                        },
                        onTap: (id) {
                          context.push(
                            '/lot_details',
                            extra: {'lot': filteredLots[i]},
                          );
                        },
                        onEditSwipe: (lot) {
                          context.push('/edit_lot', extra: lot);
                        },
                        onDeleteSwipe: (lot) async {
                          final confirmed =
                              await UserRoasterDetailsScreen.confirmUnlinkDialog(
                                context,
                                lot.coffeeName ?? '',
                              );
                          if (confirmed) {
                            await ref
                                .read(databaseProvider)
                                .linkLotToRoaster(lot.id, null);
                            ref.invalidate(
                              userRoasterLotsProvider(currentRoaster.id),
                            );
                            return true;
                          }
                          return false;
                        },
                      ),
                    ),
                    childCount: filteredLots.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

  Widget _buildEmptyState({bool isSearch = false}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24), // Reduced from 48
          // Decorative Icon with Glow (matching RoastersScreen style)
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
              border: Border.all(
                color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC8A96E).withValues(alpha: 0.05),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              isSearch ? Icons.search_off_rounded : Icons.coffee_rounded,
              color: const Color(0xFFC8A96E),
              size: 48,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            isSearch
                ? context.t('empty_search_title')
                : context.t('no_lots_linked'),
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              color: const Color(0xFFC8A96E),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          if (!isSearch) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                context.t('no_lots_linked_desc'),
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white38,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            PressableScale(
              onTap: () => UserRoasterDetailsScreen.showLinkLotDialog(
                context,
                ref,
                widget.roaster,
              ),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFC8A96E),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_link_rounded,
                      color: Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.t('link_lot_title').toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 120), // Added bottom space to lift everything up
        ],
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
