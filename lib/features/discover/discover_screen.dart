import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../specialty/specialty_screen.dart';
import 'farmers_screen.dart';
import 'roasters_screen.dart';
import '../encyclopedia/add_custom_lot_screen.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/settings_provider.dart';

class DiscoverTab {
  final String id;
  final Widget content;

  DiscoverTab({required this.id, required this.content});
}

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late List<DiscoverTab> _tabs;
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _tabs = [
      DiscoverTab(id: 'farmers', content: const FarmersScreen()),
      DiscoverTab(id: 'roasters', content: const RoastersScreen()),
      DiscoverTab(
        id: 'encyclopedia',
        content: const SpecialtyEducationScreen(),
      ),
      DiscoverTab(
        id: 'my_lots',
        content: const AddCustomLotScreen(openAsAdd: false),
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    ref.read(settingsProvider.notifier).triggerHaptic();

    setState(() {
      final tab = _tabs.removeAt(oldIndex);
      _tabs.insert(newIndex, tab);

      if (_currentIndex == oldIndex) {
        _currentIndex = newIndex;
      } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
        _currentIndex--;
      } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
        _currentIndex++;
      }
    });

    _pageController.jumpToPage(_currentIndex);
  }

  String _getTabLabel(String id) {
    return ref.t(id);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          padding: const EdgeInsets.only(top: 48, bottom: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      ref.t('discover'),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 28,
                        color: const Color(0xFFC8A96E),
                        shadows: [
                          Shadow(
                            color: const Color(
                              0xFFC8A96E,
                            ).withValues(alpha: 0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),

                    // Right actions: Cloud Badge & Avatar
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Cloud badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.greenAccent.withValues(alpha: 0.5),
                            ),
                            color: Colors.greenAccent.withValues(alpha: 0.1),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.cloud_done_outlined,
                                color: Colors.greenAccent,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Cloud Connected",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Profile Avatar
                        GestureDetector(
                          onTap: () => _showProfileMenu(context, ref),
                          child: Hero(
                            tag: 'profile_avatar',
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/placeholder_avatar.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white30,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Custom Telegram-style capsule tabs
              SizedBox(
                height: 40,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor:
                        Colors.transparent, // Fixes drag shadow background
                  ),
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    buildDefaultDragHandles: false,
                    proxyDecorator: (child, index, animation) {
                      return Material(color: Colors.transparent, child: child);
                    },
                    itemCount: _tabs.length,
                    onReorderStart: (_) {
                      ref.read(settingsProvider.notifier).triggerVibrate();
                    },
                    onReorder: _onReorder,
                    itemBuilder: (context, index) {
                      final tab = _tabs[index];
                      final isSelected = index == _currentIndex;

                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(tab.id),
                        index: index,
                        child: GestureDetector(
                          onTap: () {
                            ref
                                .read(settingsProvider.notifier)
                                .triggerSelectionVibrate();
                            setState(() => _currentIndex = index);
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFC8A96E)
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _getTabLabel(tab.id),
                                style: GoogleFonts.poppins(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: 13,
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(settingsProvider.notifier).triggerSelectionVibrate();
          setState(() => _currentIndex = index);
        },
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          return _tabs[index].content;
        },
      ),
    );
  }
}

void _showProfileMenu(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1E293B), // Dark slate
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/placeholder_avatar.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: const Color(0xFFC8A96E),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white30,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coffee Lover',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Pro Member',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Dummy options for profile
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white30,
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Saved Lots',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white30,
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}
