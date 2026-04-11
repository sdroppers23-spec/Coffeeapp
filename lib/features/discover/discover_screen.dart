import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/user_profile_avatar.dart';
import '../../core/providers/settings_provider.dart';
import 'lots/widgets/my_lots_content.dart';
import './discovery_tab_order.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  String _selectedTabId = 'myLots'; // Default to My Lots
  final ScrollController _reorderController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Tabs are built from discoveryTabOrderProvider
  }

  String _getTabLabel(DiscoverTabType type) {
    switch (type) {
      case DiscoverTabType.myLots:
        return 'Мої лоти';
      case DiscoverTabType.history:
        return 'Історія Спешелті';
      case DiscoverTabType.farmers:
        return 'Фермери';
      case DiscoverTabType.roasters:
        return 'Мої обсмажчики';
      case DiscoverTabType.encyclopedia:
        return 'Енциклопедія';
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    ref.read(discoveryTabOrderProvider.notifier).reorder(oldIndex, newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final tabOrder = ref.watch(discoveryTabOrderProvider);
    
    // Ensure we have a valid selection
    if (!tabOrder.any((t) => t.name == _selectedTabId) && tabOrder.isNotEmpty) {
      _selectedTabId = tabOrder.first.name;
    }

    return Scaffold(
      backgroundColor: Colors.black, // Pure black background
      floatingActionButton: null,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Title, Badge, Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Відкриття',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: const Color(0xFFC8A96E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.greenAccent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2D322F),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cloud_done_outlined, color: Colors.greenAccent, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              "Cloud Connected",
                              style: GoogleFonts.poppins(
                                color: Colors.greenAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: UserProfileAvatar(radius: 17),
                  ),
                ],
              ),
            ),

            // Reorderable Capsule Tabs
            SizedBox(
              height: 54,
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: ReorderableListView.builder(
                  scrollController: _reorderController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) {
                    return Material(color: Colors.transparent, child: child);
                  },
                  itemCount: tabOrder.length,
                  onReorderStart: (_) => ref.read(settingsProvider.notifier).triggerVibrate(),
                  onReorder: _onReorder,
                  itemBuilder: (context, index) {
                    final type = tabOrder[index];
                    final tabId = type.name;
                    final isSelected = _selectedTabId == tabId;

                    return ReorderableDelayedDragStartListener(
                      key: ValueKey(tabId),
                      index: index,
                      child: _CapsuleTab(
                        label: _getTabLabel(type),
                        isSelected: isSelected,
                        onTap: () {
                          ref.read(settingsProvider.notifier).triggerHaptic();
                          setState(() {
                            _selectedTabId = tabId;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Content Area
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildTabContent(_selectedTabId),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTabContent(String tabId) {
    switch (tabId) {
      case 'myLots':
        return const MyLotsContent();
      case 'roasters':
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: const [
            _RoasteryCard(
              title: '3 Champs Roastery',
              description: 'Українське обсмажування кави',
              location: 'Київ, Україна',
            ),
          ],
        );
      default:
        return Center(
          child: Text(
            'Контент розділу $tabId',
            style: GoogleFonts.poppins(color: Colors.white24),
          ),
        );
    }
  }
}

class _CapsuleTab extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CapsuleTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CapsuleTab> createState() => _CapsuleTabState();
}

class _CapsuleTabState extends State<_CapsuleTab> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? const Color(0xFFC8A96E)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _isPressed
                ? Colors.white.withValues(alpha: 0.8) // Yellowish-white flash
                : (widget.isSelected ? Colors.transparent : Colors.white10),
            width: 1.5,
          ),
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.poppins(
            color: widget.isSelected ? Colors.black : Colors.white70,
            fontSize: 14,
            fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _RoasteryCard extends StatelessWidget {
  final String title;
  final String description;
  final String location;

  const _RoasteryCard({
    required this.title,
    required this.description,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0A07),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Area
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Color(0xFF141414), // Almost black
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Large background ghost icon
                  Icon(
                    Icons.coffee_maker_rounded,
                    color: Colors.white.withValues(alpha: 0.03),
                    size: 120,
                  ),
                  // Centered Blue Icon Island
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C3E50), // Steel blue
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.coffee_maker_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Info Area
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFC8A96E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white38,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white24,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: GoogleFonts.poppins(
                            color: Colors.white24,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Дивіться лоти >',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFC8A96E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Profile menu is handled by UserProfileAvatar


// _UserAvatar removal
