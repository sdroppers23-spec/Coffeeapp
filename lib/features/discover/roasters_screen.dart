import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/database/database_provider.dart';
import '../../shared/widgets/premium_background.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/supabase/supabase_provider.dart';
import 'brand_details_screen.dart';
import '../../core/database/dtos.dart';
import 'discovery_providers.dart';

class RoastersScreen extends StatelessWidget {
  const RoastersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RoastersBody(),
      ),
    );
  }
}

class RoastersBody extends ConsumerStatefulWidget {
  const RoastersBody({super.key});

  @override
  ConsumerState<RoastersBody> createState() => _RoastersBodyState();
}

class _RoastersBodyState extends ConsumerState<RoastersBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<int> _selectedIds = {};
  final Set<int> _pendingDeleteIds = {};
  bool get _isSelectionMode => _selectedIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                        child: const Icon(Icons.warning_amber_rounded,
                            color: Color(0xFFC8A96E), size: 32),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Видалити обсмажчика?',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Видалити "$name" з вашого списку?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                            color: Colors.white70, fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 28),
                      Row(children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(ctx, false),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white.withValues(alpha: 0.05),
                                border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1)),
                              ),
                              alignment: Alignment.center,
                              child: Text('СКАСУВАТИ',
                                  style: GoogleFonts.outfit(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.2)),
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
                                    color:
                                        Colors.redAccent.withValues(alpha: 0.5)),
                              ),
                              alignment: Alignment.center,
                              child: Text('ВИДАЛИТИ',
                                  style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.2)),
                            ),
                          ),
                        ),
                      ]),
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

  void _toggleSelection(int id) {
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
  Widget build(BuildContext context) {
    final brandsAsync = ref.watch(brandsProvider);

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
                icon: const Icon(Icons.close_rounded,
                    color: Color(0xFFC8A96E)),
              )
            : null,
        title: Text(
          _isSelectionMode
              ? _selectionCountText
              : 'Мої обсмажчики',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC8A96E),
            fontSize: _isSelectionMode ? 16 : 20,
          ),
        ),
        actions: [
          if (_isSelectionMode) ...[
            // Масовий архів
            brandsAsync.whenData((brands) {
              final activeTab = _tabController.index;
              return IconButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final db = ref.read(databaseProvider);
                  final isArchiving = activeTab != 2;
                  for (final id in _selectedIds) {
                    await db.toggleBrandArchive(id, isArchiving);
                  }
                  _clearSelection();
                  ref.invalidate(brandsProvider);
                  if (mounted) {
                    messenger.showSnackBar(SnackBar(
                      content: Text(isArchiving
                          ? 'Обсмажчики архівовані'
                          : 'Обсмажчики відновлені'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xFF2A2A2A),
                    ));
                  }
                },
                icon: Icon(
                  _tabController.index == 2
                      ? Icons.unarchive_outlined
                      : Icons.archive_outlined,
                  color: Colors.white70,
                ),
              );
            }).value ?? const SizedBox(),
            // Масове видалення
            IconButton(
              onPressed: () async {
                final confirm =
                    await _confirmDeleteDialog('${_selectedIds.length} обсмажчиків');
                if (confirm) {
                  final db = ref.read(databaseProvider);
                  for (final id in _selectedIds) {
                    await db.deleteBrand(id);
                  }
                  _clearSelection();
                  ref.invalidate(brandsProvider);
                }
              },
              icon: const Icon(Icons.delete_outline_rounded,
                  color: Colors.orangeAccent),
            ),
          ] else ...[
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
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.3)),
                  ),
                  child: const Icon(Icons.add,
                      size: 20, color: Color(0xFFC8A96E)),
                ),
              ),
            ),
          ],
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
          // ── Sub-tabs ────────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05)),
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
                    fontSize: 13, fontWeight: FontWeight.bold),
                tabs: [
                  const Tab(text: 'Усі'),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite_rounded, size: 14),
                        SizedBox(width: 4),
                        Text('Улюблені'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.archive_outlined, size: 14),
                        SizedBox(width: 4),
                        Text('Архів'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── List ────────────────────────────────────────────────────────
    return brandsAsync.when(
      loading: () => const Center(
        child: _PremiumPulsingLoader(
          message: 'Завантаження обсмажчиків...',
        ),
      ),
      error: (e, _) => Center(
          child: Text('Помилка: $e',
              style: const TextStyle(color: Colors.red))),
      data: (brands) {
        final filtered = brands.where((b) {
          if (_pendingDeleteIds.contains(b.id)) return false;
          if (_tabController.index == 0) return !b.isArchived;
          if (_tabController.index == 1) {
            return b.isFavorite && !b.isArchived;
          }
          if (_tabController.index == 2) return b.isArchived;
          return !b.isArchived;
        }).toList();

        return Stack(
          children: [
            if (filtered.isEmpty)
              _buildEmptyState()
            else
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final brand = filtered[index];
                  return _buildSwipeableBrandCard(brand);
                },
              ),
            // FAB добавити обсмажчика
            if (!_isSelectionMode)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: GestureDetector(
                    onTap: () => _showAddRoasterDialog(context, ref),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8955A),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC8A96E)
                                .withValues(alpha: 0.35),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_rounded,
                              color: Colors.black87, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'ДОДАТИ ОБСМАЖЧИКА',
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
                ),
              ),
          ],
        );
      },
    );
  }

  // ─── Swipeable Card ────────────────────────────────────────────────────────

  Widget _buildSwipeableBrandCard(LocalizedBrandDto brand) {
    final isArchiveTab = _tabController.index == 2;

    return Dismissible(
      key: ValueKey(brand.id),
      background: _buildSwipeBackground(
        icon: isArchiveTab
            ? Icons.unarchive_outlined
            : Icons.archive_outlined,
        color: const Color(0xFF3A7BBF),
        label: isArchiveTab ? 'Відновити' : 'Архів',
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: _buildSwipeBackground(
        icon: Icons.delete_outline_rounded,
        color: Colors.redAccent,
        label: 'Видалити',
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Архів / відновлення
          final db = ref.read(databaseProvider);
          await db.toggleBrandArchive(brand.id, !isArchiveTab);
          ref.invalidate(brandsProvider);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isArchiveTab
                  ? '${brand.name} відновлено'
                  : '${brand.name} архівовано'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF2A2A2A),
            ));
          }
          return false; // не видаляємо з UI одразу — провайдер оновиться
        } else {
          // Видалення
          return _confirmDeleteDialog(brand.name);
        }
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final db = ref.read(databaseProvider);
          await db.deleteBrand(brand.id);
          ref.invalidate(brandsProvider);
        }
      },
      child: GestureDetector(
        onLongPress: () => _toggleSelection(brand.id),
        child: _PremiumRoasterCard(
          brand: brand,
          isSelected: _selectedIds.contains(brand.id),
          isSelectionMode: _isSelectionMode,
          onTap: () {
            if (_isSelectionMode) {
              _toggleSelection(brand.id);
            } else {
              ref.read(settingsProvider.notifier).triggerHaptic();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => BrandDetailsScreen(brand: brand)),
              );
            }
          },
          onFavoriteToggle: () async {
            final db = ref.read(databaseProvider);
            await db.toggleBrandFavorite(brand.id, !brand.isFavorite);
            ref.invalidate(brandsProvider);
          },
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({
    required IconData icon,
    required Color color,
    required String label,
    required AlignmentGeometry alignment,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(label,
              style: GoogleFonts.outfit(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ─── Empty State ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    final isArchiveTab = _tabController.index == 2;
    final isFavoritesTab = _tabController.index == 1;

    final String title = isArchiveTab
        ? 'Архів порожній'
        : isFavoritesTab
            ? 'Жодного улюбленого'
            : 'Немає обсмажчиків';

    final String description = isArchiveTab
        ? 'Заархівовані обсмажчики з\'являться тут'
        : isFavoritesTab
            ? 'Натисніть ❤️ на картці, щоб додати до улюблених'
            : 'Додайте своїх улюблених обсмажчиків';

    final IconData icon = isArchiveTab
        ? Icons.archive_outlined
        : isFavoritesTab
            ? Icons.favorite_border_rounded
            : Icons.store_rounded;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Decorative Icon with Glow
            Container(
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
    );
  }

  // ─── Selection helpers ─────────────────────────────────────────────────────

  String get _selectionCountText {
    final count = _selectedIds.length;
    if (count % 10 == 1 && count % 100 != 11) return 'Обрано $count обсмажчика';
    if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return 'Обрано $count обсмажчики';
    }
    return 'Обрано $count обсмажчиків';
  }

  // ─── Add Dialog ───────────────────────────────────────────────────────────

  static Future<void> _showAddRoasterDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final db = ref.read(databaseProvider);
    final nameController = TextEditingController();
    final shortDescController = TextEditingController();
    final locationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Додати обсмажчика',
          style: GoogleFonts.poppins(
              color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogField(
                nameController, 'Назва обсмажчика', Icons.business_rounded),
            const SizedBox(height: 12),
            _buildDialogField(
                locationController, 'Місто / країна', Icons.location_on_rounded),
            const SizedBox(height: 12),
            _buildDialogField(shortDescController, 'Короткий опис',
                Icons.description_rounded),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Скасувати',
                style: GoogleFonts.poppins(color: Colors.white38)),
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
              'Зберегти',
              style: GoogleFonts.poppins(
                  color: const Color(0xFFC8A96E),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
  final LocalizedBrandDto brand;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const _PremiumRoasterCard({
    required this.brand,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PressableScale(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected
                ? const Color(0xFFC8A96E).withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFC8A96E).withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.06),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Checkbox або Лого
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
                            ? const Icon(Icons.check_rounded,
                                color: Colors.black, size: 16)
                            : null,
                      )
                    else
                      Container(
                        width: 56,
                        height: 56,
                        margin: const EdgeInsets.only(right: 14),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: _BrandLogo(url: brand.logoUrl),
                      ),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brand.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC8A96E),
                            ),
                          ),
                          if (brand.location.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Row(children: [
                              const Icon(Icons.location_on_rounded,
                                  size: 12, color: Colors.white38),
                              const SizedBox(width: 4),
                              Text(brand.location,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.white38)),
                            ]),
                          ],
                          if (brand.shortDesc.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              brand.shortDesc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white60,
                                  height: 1.4),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Кнопка улюблене
                    if (!isSelectionMode)
                      GestureDetector(
                        onTap: onFavoriteToggle,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            brand.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: brand.isFavorite
                                ? Colors.redAccent
                                : Colors.white30,
                            size: 22,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Brand Logo ───────────────────────────────────────────────────────────────

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

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
