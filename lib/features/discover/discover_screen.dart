import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/user_profile_avatar.dart';
import '../../core/providers/settings_provider.dart';
import 'lots/widgets/my_lots_content.dart';
import './discovery_tab_order.dart';
import '../encyclopedia/encyclopedia_screen.dart';
import './farmers_screen.dart';
import './roasters_screen.dart';
import '../specialty/specialty_screen.dart';

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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
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
                            const Icon(
                              Icons.cloud_done_outlined,
                              color: Colors.greenAccent,
                              size: 14,
                            ),
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
                data: Theme.of(
                  context,
                ).copyWith(canvasColor: Colors.transparent),
                child: ReorderableListView.builder(
                  scrollController: _reorderController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) {
                    return Material(color: Colors.transparent, child: child);
                  },
                  itemCount: tabOrder.length,
                  onReorderStart: (_) =>
                      ref.read(settingsProvider.notifier).triggerVibrate(),
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
      case 'encyclopedia':
        return const EncyclopediaBody();
      case 'farmers':
        return const FarmersBody();
      case 'roasters':
        return const RoastersBody();
      case 'history':
        return const SpecialtyEducationScreen();
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

// Profile menu is handled by UserProfileAvatar
