import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widgets/user_profile_avatar.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/l10n/app_localizations.dart';
import 'lots/widgets/my_lots_content.dart';
import './discovery_tab_order.dart';
import '../encyclopedia/encyclopedia_screen.dart';
import './farmers_screen.dart';
import './roasters_screen.dart';
import '../navigation/navigation_providers.dart';
import '../specialty/specialty_screen.dart';
import '../../shared/widgets/sync_indicator.dart';
import 'package:go_router/go_router.dart';


class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  String _selectedTabId = '';
  final ScrollController _reorderController = ScrollController();
  late PageController _pageController;
  final Map<String, GlobalKey> _tabKeys = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Ensure navigation bar is visible when entering Discover
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(navBarVisibleProvider.notifier).show();
        _snapToInitialTab();
      }
    });
  }

  void _snapToInitialTab() {
    final tabOrder = ref.read(discoveryTabOrderProvider);
    final index = tabOrder.indexWhere((t) => t.name == _selectedTabId);
    if (index >= 0 && index < tabOrder.length && _pageController.hasClients) {
      _pageController.jumpToPage(index);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _reorderController.dispose();
    super.dispose();
  }

  void _scrollToActiveTab(String tabId) {
    final key = _tabKeys[tabId];
    if (key == null || key.currentContext == null) return;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      alignment: 0.5, // Center the tab
    );
  }

  String _getTabLabel(DiscoverTabType type) {
    switch (type) {
      case DiscoverTabType.myLots:
        return ref.t('tab_my_lots');
      case DiscoverTabType.history:
        return ref.t('tab_history');
      case DiscoverTabType.farmers:
        return ref.t('tab_farmers');
      case DiscoverTabType.roasters:
        return ref.t('tab_roasters');
      case DiscoverTabType.encyclopedia:
        return ref.t('tab_encyclopedia');
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    ref.read(discoveryTabOrderProvider.notifier).reorder(oldIndex, newIndex);
    // After reorder, try to keep the selected tab in view
    Future.microtask(() {
      final tabOrder = ref.read(discoveryTabOrderProvider);
      final index = tabOrder.indexWhere((t) => t.name == _selectedTabId);
      if (index >= 0 && _pageController.hasClients) {
        _pageController.jumpToPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabOrder = ref.watch(discoveryTabOrderProvider);

    // Ensure we have a valid selection
    if (!tabOrder.any((t) => t.name == _selectedTabId) && tabOrder.isNotEmpty) {
      _selectedTabId = tabOrder.first.name;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final order = ref.read(discoveryTabOrderProvider);
        final currentIndex = order.indexWhere((t) => t.name == _selectedTabId);
        
        if (currentIndex > 0) {
          final prevTabId = order[currentIndex - 1].name;
          ref.read(navBarVisibleProvider.notifier).show();
          setState(() {
            _selectedTabId = prevTabId;
          });
          _scrollToActiveTab(prevTabId);
        } else {
          StatefulNavigationShell.of(context).goBranch(0);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // Sync with global background
        extendBody: true,
      floatingActionButton: null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header: Title, Badge, Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            ref.t('discover'),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: const Color(0xFFC8A96E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Flexible(child: SyncIndicator()),
                      ],
                    ),
                  ),
                  const UserProfileAvatar(radius: 17),
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
                  physics: const BouncingScrollPhysics(),
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

                    // Assign or reuse key
                    final tabKey = _tabKeys.putIfAbsent(
                      tabId,
                      () => GlobalKey(),
                    );

                    return ReorderableDelayedDragStartListener(
                      key: ValueKey(tabId),
                      index: index,
                      child: Container(
                        key: tabKey,
                        child: _CapsuleTab(
                          label: _getTabLabel(type),
                          isSelected: isSelected,
                          onTap: () {
                            ref.read(settingsProvider.notifier).triggerHaptic();
                            ref
                                .read(navBarVisibleProvider.notifier)
                                .show(); // FORCE SHOW NAVBAR
                            setState(() {
                              _selectedTabId = tabId;
                            });
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Content Area
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index >= 0 && index < tabOrder.length) {
                    final newTabId = tabOrder[index].name;
                    if (_selectedTabId != newTabId) {
                      ref
                          .read(navBarVisibleProvider.notifier)
                          .show(); // FORCE SHOW NAVBAR
                      setState(() {
                        _selectedTabId = newTabId;
                      });
                      _scrollToActiveTab(newTabId);
                    }
                  }
                },
                itemCount: tabOrder.length,
                itemBuilder: (context, index) {
                  return _buildTabContent(tabOrder[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  Widget _buildTabContent(String tabId) {
    Widget child;
    switch (tabId) {
      case 'myLots':
        child = const MyLotsContent();
        break;
      case 'encyclopedia':
        child = const EncyclopediaBody();
        break;
      case 'farmers':
        child = const FarmersBody();
        break;
      case 'roasters':
        child = const RoastersBody();
        break;
      case 'history':
        child = const SpecialtyEducationScreen();
        break;
      default:
        child = Center(
          child: Text(
            ref.t('section_content_placeholder', args: {'tabId': tabId}),
            style: GoogleFonts.poppins(color: Colors.white24),
          ),
        );
    }
    return RepaintBoundary(child: child);
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
