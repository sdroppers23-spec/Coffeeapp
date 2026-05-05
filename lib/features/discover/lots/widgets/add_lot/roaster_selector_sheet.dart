import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/database/dtos.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../shared/widgets/pressable_scale.dart';
import '../../providers/roaster_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../shared/services/roaster_image_service.dart';
import '../../../../../shared/services/toast_service.dart';
import 'dart:io';

class RoasterSelectorSheet extends ConsumerStatefulWidget {
  final void Function(UserRoasterDto?) onSelected;

  const RoasterSelectorSheet({super.key, required this.onSelected});

  @override
  ConsumerState<RoasterSelectorSheet> createState() =>
      _RoasterSelectorSheetState();
}

class _RoasterSelectorSheetState extends ConsumerState<RoasterSelectorSheet> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roasters = ref.watch(userRoastersProvider);
    final filteredRoasters = roasters
        .where(
          (r) =>
              r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (r.country?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
                  false),
        )
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ref.t('roasters'),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC8A96E),
                    letterSpacing: 1.5,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white54),
                ),
              ],
            ),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                  hintText: ref.t('search_roasters'),
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
                    bottom: 2,
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

          // Add New Button (Raised and Half-Width)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: PressableScale(
                    onTap: () => _showAddEditRoasterDialog(),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFC8A96E),
                            const Color(0xFFC8A96E).withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              ref.t('add_roaster_uppercase'),
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: filteredRoasters.isEmpty && _searchQuery.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: filteredRoasters.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return _buildClearItem();
                      final roaster = filteredRoasters[index - 1];
                      return _buildRoasterItem(roaster);
                    },
                  ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRoasterItem(UserRoasterDto roaster) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        onTap: () => widget.onSelected(roaster),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: _buildLogo(roaster),
          ),
        ),
        title: Text(
          roaster.name,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          roaster.country ?? '',
          style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                size: 20,
                color: Colors.white24,
              ),
              onPressed: () => _showAddEditRoasterDialog(roaster),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 20,
                color: Colors.redAccent,
              ),
              onPressed: () => _confirmDelete(roaster),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        onTap: () => widget.onSelected(null),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
          ),
          child: const Icon(
            Icons.close_rounded,
            color: Colors.redAccent,
            size: 20,
          ),
        ),
        title: Text(
          ref.t('none_clear_selection'),
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.coffee_maker_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 16),
          Text(
            ref.t('empty_roasters_title'),
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            ref.t('empty_roasters_desc'),
            style: GoogleFonts.outfit(color: Colors.white12, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showAddEditRoasterDialog([UserRoasterDto? existing]) {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final locationController = TextEditingController(
      text: existing?.location ?? '',
    );
    final countryController = TextEditingController(
      text: existing?.country ?? '',
    );
    final logoUrlController = TextEditingController(
      text: existing?.logoUrl ?? '',
    );
    String? localPath = existing?.localLogoPath;
    bool isFavorite = existing?.isFavorite ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF121212),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            existing == null
                ? ref.t('add_roaster_title')
                : ref.t('edit_profile_dialog_title'),
            style: GoogleFonts.outfit(color: const Color(0xFFC8A96E)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Picker
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
                TextField(
                  controller: nameController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: ref.t('roaster_name_label'),
                    labelStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: locationController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: ref.t('location_label'),
                    labelStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: countryController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: ref.t('country_field'),
                    labelStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: logoUrlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: ref.t('roaster_logo_url_label'),
                    labelStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: Text(
                    ref.t('favorite_label'),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  value: isFavorite,
                  activeThumbColor: const Color(0xFFC8A96E),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setDialogState(() => isFavorite = val),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                ref.t('cancel'),
                style: const TextStyle(color: Colors.white38),
              ),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final location = locationController.text.trim();

                if (name.isEmpty) return;

                // Duplicate check
                if (existing == null) {
                  final allRoasters = ref.read(userRoastersProvider);
                  final duplicate = allRoasters
                      .cast<UserRoasterDto?>()
                      .firstWhere(
                        (r) =>
                            r!.name.toLowerCase() == name.toLowerCase() &&
                            (r.location?.toLowerCase() ?? '') ==
                                location.toLowerCase() &&
                            (r.country?.toLowerCase() ?? '') ==
                                countryController.text.trim().toLowerCase(),
                        orElse: () => null,
                      );

                  if (duplicate != null) {
                    ToastService.showError(
                      context,
                      ref.t('error_roaster_exists'),
                    );
                    widget.onSelected(duplicate);
                    Navigator.pop(context); // Close dialog
                    return;
                  }
                }

                final roaster = UserRoasterDto(
                  id: existing?.id ?? const Uuid().v4(),
                  name: name,
                  location: location,
                  country: countryController.text.trim(),
                  logoUrl: logoUrlController.text.trim().isNotEmpty
                      ? logoUrlController.text.trim()
                      : null,
                  localLogoPath: localPath,
                  updatedAt: DateTime.now(),
                  isFavorite: isFavorite,
                  isArchived: existing?.isArchived ?? false,
                );

                ref.read(userRoastersProvider.notifier).saveRoaster(roaster);
                if (existing == null) {
                  widget.onSelected(roaster);
                }
                Navigator.pop(context);
              },
              child: Text(
                ref.t('save'),
                style: const TextStyle(color: Color(0xFFC8A96E)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(UserRoasterDto roaster) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        title: Text(
          ref.t('delete_roaster_title'),
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          ref.t('delete_roaster_confirm', args: {'name': roaster.name}),
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              ref.t('cancel'),
              style: const TextStyle(color: Colors.white38),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(userRoastersProvider.notifier).deleteRoaster(roaster.id);
              Navigator.pop(context);
            },
            child: Text(
              ref.t('delete_uppercase'),
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
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
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.business_rounded,
          color: Color(0xFFC8A96E),
          size: 20,
        ),
      );
    }

    return const Icon(
      Icons.business_rounded,
      color: Color(0xFFC8A96E),
      size: 20,
    );
  }
}
