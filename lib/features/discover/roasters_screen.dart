import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/glass_swipe_wrapper.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/services/roaster_image_service.dart';
import '../../core/database/dtos.dart';
import 'lots/providers/roaster_providers.dart';
import 'user_roaster_details_screen.dart';
import '../../shared/services/toast_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import '../../shared/utils/url_helper.dart';
import '../navigation/navigation_providers.dart';
import '../../core/utils/responsive_utils.dart';

class RoastersScreen extends StatelessWidget {
  const RoastersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: RoastersBody(),
    );
  }
}

class RoastersBody extends ConsumerStatefulWidget {
  const RoastersBody({super.key});

  @override
  ConsumerState<RoastersBody> createState() => _RoastersBodyState();
}

class _RoastersBodyState extends ConsumerState<RoastersBody>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final Set<String> _selectedIds = {};
  bool get _isSelectionMode => _selectedIds.isNotEmpty;

  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // ─── Actions ───────────────────────────────────────────────────────────────

  Future<bool> _confirmDeleteDialog(String name) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, _, _) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFC8A96E),
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        ref.t('delete_roaster_title'),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ref.t('delete_roaster_confirm', args: {'name': name}),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 28),
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
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ref.t('cancel_uppercase'),
                                  style: GoogleFonts.outfit(
                                    color: Colors.white70,
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
                                  border: Border.all(
                                    color: Colors.redAccent.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ref.t('delete_uppercase'),
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
          ),
        ),
      ),
    );
    return result ?? false;
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _clearSelection() => setState(() => _selectedIds.clear());

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final roasters = ref.watch(userRoastersProvider);
    final navHeight = ref.watch(navBarHeightProvider);
    final isNavVisible = ref.watch(navBarVisibleProvider);
    final effectiveNavHeight = isNavVisible ? navHeight : 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: _isSelectionMode
            ? IconButton(
                onPressed: _clearSelection,
                icon: const Icon(Icons.close_rounded, color: Color(0xFFC8A96E)),
              )
            : null,
        title: Text(
          _isSelectionMode ? _getSelectionCountText() : ref.t('tab_roasters'),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC8A96E),
            fontSize: _isSelectionMode ? 16 : 20,
          ),
        ),
        actions: [
          if (_isSelectionMode) ...[
            // Масовий архів
            IconButton(
              onPressed: () async {
                final notifier = ref.read(userRoastersProvider.notifier);
                final isArchiving = _tabController.index != 2;

                final archivedMsg = ref.t('toast_roasters_archived');
                final restoredMsg = ref.t('toast_roasters_restored');

                for (final id in _selectedIds) {
                  await notifier.toggleArchive(id, isArchiving);
                }

                if (!context.mounted) return;

                ToastService.showSuccess(
                  context,
                  isArchiving ? archivedMsg : restoredMsg,
                );
                _clearSelection();
              },
              icon: Icon(
                _tabController.index == 2
                    ? Icons.unarchive_outlined
                    : Icons.archive_outlined,
                color: const Color(0xFFC8A96E),
              ),
            ),
            // Масове видалення
            IconButton(
              onPressed: () async {
                final confirmed = await _confirmDeleteDialog(
                  _selectedIds.length.toString(),
                );
                if (confirmed && mounted) {
                  final notifier = ref.read(userRoastersProvider.notifier);
                  for (final id in _selectedIds) {
                    await notifier.deleteRoaster(id);
                  }
                  _clearSelection();
                }
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
            ),
          ],
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Stack(
            children: [
              Column(
                children: [
                  // ── Search Bar ──────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                            top: 2,
                            bottom: 0,
                          ),
                          filled: false,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(
                              left: 12,
                              right: 8,
                              top: 9,
                            ),
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
                  // ── Sub-tabs ────────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: const Color(0xFFC8A96E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.white54,
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          Tab(text: ref.t('tab_all')),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.favorite_rounded, size: 14),
                                const SizedBox(width: 4),
                                Text(ref.t('tab_favorites')),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.archive_outlined, size: 14),
                                const SizedBox(width: 4),
                                Text(ref.t('tab_archive')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ── List ────────────────────────────────────────────────────────
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final filtered = roasters.where((b) {
                          final matchesSearch =
                              _searchQuery.isEmpty ||
                              b.name.toLowerCase().contains(
                                _searchQuery.toLowerCase(),
                              ) ||
                              (b.location?.toLowerCase().contains(
                                    _searchQuery.toLowerCase(),
                                  ) ??
                                  false);

                          if (!matchesSearch) return false;

                          if (_tabController.index == 0) return !b.isArchived;
                          if (_tabController.index == 1) {
                            return b.isFavorite && !b.isArchived;
                          }
                          if (_tabController.index == 2) return b.isArchived;
                          return !b.isArchived;
                        }).toList();

                        // IMPROVEMENT: Sort by match relevance if searching
                        if (_searchQuery.isNotEmpty) {
                          final query = _searchQuery.toLowerCase();
                          filtered.sort((a, b) {
                            final aStarts = a.name.toLowerCase().startsWith(
                              query,
                            );
                            final bStarts = b.name.toLowerCase().startsWith(
                              query,
                            );
                            if (aStarts && !bStarts) return -1;
                            if (!aStarts && bStarts) return 1;
                            // Secondary sort by name
                            return a.name.toLowerCase().compareTo(
                              b.name.toLowerCase(),
                            );
                          });
                        }

                        return Stack(
                          children: [
                            if (filtered.isEmpty)
                              _buildEmptyState()
                            else
                              ListView.builder(
                                padding: EdgeInsets.fromLTRB(
                                  16,
                                  8,
                                  16,
                                  effectiveNavHeight + 80,
                                ),
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final roaster = filtered[index];
                                  return _buildSwipeableRoasterCard(
                                    roaster,
                                    key: ValueKey(roaster.id),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),

              // ── Floating Action Bar (Selection Mode) ────────────────────────
              if (_isSelectionMode)
                Positioned(
                  bottom: effectiveNavHeight + (context.isTablet ? 12 : 8),
                  left: 16,
                  right: 16,
                  child: FadeTransition(
                    opacity: const AlwaysStoppedAnimation(1.0),
                    child: _buildSelectionActionBar(),
                  ),
                ),

              // ── Floating Add Button ─────────────────────────────────────────
              if (!_isSelectionMode && _tabController.index == 0)
                Positioned(
                  bottom: effectiveNavHeight + (context.isTablet ? 8 : 4),
                  right: 16,
                  child: FadeTransition(
                    opacity: const AlwaysStoppedAnimation(1.0),
                    child: _buildHalfWidthAddButton(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionActionBar() {
    final count = _selectedIds.length;
    const gold = Color(0xFFC8A96E);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: gold.withValues(alpha: 0.2)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _clearSelection,
            icon: const Icon(Icons.close_rounded, color: Colors.white70),
          ),
          const SizedBox(width: 8),
          Text(
            count.toString(),
            style: GoogleFonts.outfit(
              color: gold,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          // Archive
          IconButton(
            onPressed: () async {
              final notifier = ref.read(userRoastersProvider.notifier);
              final isArchiving = _tabController.index != 2;
              for (final id in _selectedIds) {
                await notifier.toggleArchive(id, isArchiving);
              }
              _clearSelection();
            },
            icon: Icon(
              _tabController.index == 2
                  ? Icons.unarchive_outlined
                  : Icons.archive_outlined,
              color: gold,
            ),
          ),
          // Delete
          IconButton(
            onPressed: () async {
              final confirmed = await _confirmDeleteDialog(count.toString());
              if (confirmed && mounted) {
                final notifier = ref.read(userRoastersProvider.notifier);
                for (final id in _selectedIds) {
                  await notifier.deleteRoaster(id);
                }
                _clearSelection();
              }
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Swipeable Card ────────────────────────────────────────────────────────

  Widget _buildSwipeableRoasterCard(UserRoasterDto roaster, {Key? key}) {
    final isArchiveTab = _tabController.index == 2;

    return Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassSwipeWrapper(
        isGripMode: false,
        isSwipeEnabled: true,
        dismissibleKey: ValueKey('roaster_swipe_${roaster.id}'),
        leftAction: GlassSwipeAction(
          icon: isArchiveTab
              ? Icons.unarchive_outlined
              : Icons.archive_outlined,
          label: isArchiveTab ? ref.t('restore') : ref.t('archive'),
          color: const Color(0xFF3A7BBF),
          onTap: () async {
            final localContext = context;
            final notifier = ref.read(userRoastersProvider.notifier);
            await notifier.toggleArchive(roaster.id, !isArchiveTab);
            if (localContext.mounted) {
              ToastService.showSuccess(
                localContext,
                isArchiveTab
                    ? ref.t('toast_roaster_restored')
                    : ref.t('toast_roaster_archived'),
              );
            }
          },
        ),
        rightAction: GlassSwipeAction(
          icon: Icons.delete_outline_rounded,
          label: ref.t('delete'),
          color: Colors.redAccent,
          onTap: () async {
            final confirmed = await _confirmDeleteDialog(roaster.name);
            if (confirmed && mounted) {
              final notifier = ref.read(userRoastersProvider.notifier);
              await notifier.deleteRoaster(roaster.id);
            }
          },
        ),
        child: GestureDetector(
          onLongPress: () => _toggleSelection(roaster.id),
          child: _PremiumRoasterCard(
            roaster: roaster,
            isSelected: _selectedIds.contains(roaster.id),
            isSelectionMode: _isSelectionMode,
            onTap: () {
              if (_isSelectionMode) {
                _toggleSelection(roaster.id);
              } else {
                ref.read(settingsProvider.notifier).triggerHaptic();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UserRoasterDetailsScreen(roaster: roaster),
                  ),
                );
              }
            },
            onFavoriteToggle: () async {
              final msg = ref.t('toast_removed_from_favorites');
              final msgAdd = ref.t('toast_added_to_favorites');
              final isFav = roaster.isFavorite;

              final notifier = ref.read(userRoastersProvider.notifier);
              await notifier.toggleFavorite(roaster.id);

              if (!mounted) return;

              ToastService.showSuccess(context, isFav ? msg : msgAdd);
            },
            onEdit: () => UserRoasterDetailsScreen.showEditRoasterDialog(
              context,
              ref,
              roaster,
            ),
            onAddLot: () => UserRoasterDetailsScreen.showLinkLotDialog(
              context,
              ref,
              roaster,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Empty State ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    final isArchiveTab = _tabController.index == 2;
    final isFavoritesTab = _tabController.index == 1;

    final String title = isArchiveTab
        ? ref.t('empty_archive_title')
        : isFavoritesTab
        ? ref.t('empty_favorites_title')
        : ref.t('empty_roasters_title');

    final String description = isArchiveTab
        ? ref.t('empty_archive_desc')
        : isFavoritesTab
        ? ref.t('empty_favorites_desc')
        : ref.t('empty_roasters_desc');

    final IconData icon = isArchiveTab
        ? Icons.archive_outlined
        : isFavoritesTab
        ? Icons.favorite_border_rounded
        : Icons.store_rounded;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 140), // Lifted from 100
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  width: 120,
                  height: 120,
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
                  child: Icon(icon, color: const Color(0xFFC8A96E), size: 54),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  color: const Color(0xFFC8A96E),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHalfWidthAddButton() {
    return PressableScale(
      onTap: () => _showAddRoasterDialog(context, ref),
      child: Container(
        height: 56,
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
            const Icon(Icons.add_rounded, color: Colors.black87, size: 20),
            const SizedBox(width: 8),
            Text(
              ref.t('add_roaster_uppercase'),
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 1.2,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Selection helpers ─────────────────────────────────────────────────────

  String _getSelectionCountText() {
    final count = _selectedIds.length;
    final String key;
    if (count % 10 == 1 && count % 100 != 11) {
      key = 'selection_roasters_1';
    } else if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      key = 'selection_roasters_2_4';
    } else {
      key = 'selection_roasters_5_plus';
    }
    return ref.t(key, args: {'count': count.toString()});
  }

  // ─── Add Dialog ───────────────────────────────────────────────────────────

  static Future<void> _showAddRoasterDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final notifier = ref.read(userRoastersProvider.notifier);
    final nameController = TextEditingController();
    final shortDescController = TextEditingController();
    final countryController = TextEditingController();
    final locationController = TextEditingController();
    final logoUrlController = TextEditingController();
    String? localPath;
    bool isFavorite = false;

    await showDialog(
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
            ref.t('add_roaster_title'),
            style: GoogleFonts.poppins(
              color: const Color(0xFFC8A96E),
              fontWeight: FontWeight.bold,
            ),
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
                _buildDialogField(
                  nameController,
                  ref.t('roaster_name_label'),
                  Icons.business_rounded,
                ),
                const SizedBox(height: 12),
                _buildDialogField(
                  locationController,
                  ref.t('city_label'), // Changed from city_country_label
                  Icons.location_on_rounded,
                ),
                const SizedBox(height: 12),
                _buildDialogField(
                  countryController,
                  ref.t('country_label'),
                  Icons.public_rounded,
                ),
                const SizedBox(height: 12),
                _buildDialogField(
                  shortDescController,
                  ref.t('short_desc_label'),
                  Icons.description_rounded,
                ),
                const SizedBox(height: 12),
                _buildDialogField(
                  logoUrlController,
                  ref.t('roaster_logo_url_label'),
                  Icons.link_rounded,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: Text(
                    ref.t('favorite_label'),
                    style: GoogleFonts.poppins(
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
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                ref.t('cancel'),
                style: GoogleFonts.poppins(color: Colors.white38),
              ),
            ),
            TextButton(
              onPressed: () async {
                final rawUrl = logoUrlController.text.trim();
                final isValid = rawUrl.isEmpty || UrlHelper.isValidUrl(rawUrl);

                if (!isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(ref.t('invalid_url_format')),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                if (nameController.text.trim().isEmpty) {
                  return;
                }
                final roaster = UserRoasterDto(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  country: countryController.text,
                  location: locationController.text,
                  description: shortDescController.text,
                  logoUrl: rawUrl.isNotEmpty ? rawUrl : null,
                  localLogoPath: localPath,
                  updatedAt: DateTime.now(),
                  isFavorite: isFavorite,
                );
                await notifier.saveRoaster(roaster);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(
                ref.t('save'),
                style: GoogleFonts.poppins(
                  color: const Color(0xFFC8A96E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDialogField(
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

// ─── Premium Card ─────────────────────────────────────────────────────────────

class _PremiumRoasterCard extends StatelessWidget {
  final UserRoasterDto roaster;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onEdit;
  final VoidCallback onAddLot;

  const _PremiumRoasterCard({
    required this.roaster,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.onEdit,
    required this.onAddLot,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 20,
        opacity: isSelected ? 0.35 : 0.15,
        blur: 30,
        color: isSelected ? const Color(0xFFC8A96E) : Colors.white,
        borderColor: isSelected
            ? const Color(0xFFC8A96E).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (isSelectionMode)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFFC8A96E)
                        : Colors.white.withValues(alpha: 0.1),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFC8A96E)
                          : Colors.white24,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.black,
                          size: 16,
                        )
                      : null,
                )
              else ...[
                const SizedBox(width: 16),
                Container(
                  width: context.isTablet ? 72 : 56,
                  height: context.isTablet ? 72 : 56,
                  margin: const EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: _buildLogo(roaster),
                  ),
                ),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roaster.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFC8A96E),
                      ),
                    ),
                    if ((roaster.location?.isNotEmpty ?? false) ||
                        (roaster.country?.isNotEmpty ?? false)) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: Colors.white38,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              [roaster.location, roaster.country]
                                  .where((s) => s != null && s.isNotEmpty)
                                  .join(', '),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white38,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (roaster.description != null &&
                        roaster.description!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        roaster.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white60,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isSelectionMode) ...[
                GestureDetector(
                  onTap: onAddLot,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Color(0xFFC8A96E),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.edit_rounded,
                      color: Colors.white30,
                      size: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      roaster.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: roaster.isFavorite
                          ? Colors.redAccent
                          : Colors.white30,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ],
          ),
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
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.business_rounded,
          color: Color(0xFFC8A96E),
          size: 28,
        ),
      );
    }

    return const Icon(
      Icons.business_rounded,
      color: Color(0xFFC8A96E),
      size: 28,
    );
  }
}

class _PremiumPulsingLoader extends StatefulWidget {
  final String message;
  const _PremiumPulsingLoader({required this.message});

  @override
  State<_PremiumPulsingLoader> createState() => _PremiumPulsingLoaderState();
}

class _PremiumPulsingLoaderState extends State<_PremiumPulsingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                    border: Border.all(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.coffee_rounded,
                    color: Color(0xFFC8A96E),
                    size: 40,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white38, Colors.white, Colors.white38],
          ).createShader(bounds),
          child: Text(
            widget.message,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
