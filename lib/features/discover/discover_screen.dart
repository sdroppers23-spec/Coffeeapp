import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/pressable_scale.dart';

class DiscoverTabItem {
  final String id;
  final String label;
  DiscoverTabItem(this.id, this.label);
}

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late List<DiscoverTabItem> _tabs;
  String _selectedTabId = 'roasters';
  final ScrollController _reorderController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabs = [
      DiscoverTabItem('farmers', 'Фермери'),
      DiscoverTabItem('roasters', 'Мої обсмажчики'),
      DiscoverTabItem('history', 'Історія Спешелті'),
    ];
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    ref.read(settingsProvider.notifier).triggerHaptic();

    setState(() {
      final item = _tabs.removeAt(oldIndex);
      _tabs.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure black background
      body: SafeArea(
        child: Column(
          children: [
            // Header: Title, Badge, Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered Title and Badge
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
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.greenAccent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2D322F), // Dark grey-green
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
                  // Avatar on the Far Right
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _showProfileMenu(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 1.5),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/placeholder_avatar.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                  itemCount: _tabs.length,
                  onReorderStart: (_) =>
                      ref.read(settingsProvider.notifier).triggerVibrate(),
                  onReorder: _onReorder,
                  itemBuilder: (context, index) {
                    final tab = _tabs[index];
                    final isSelected = _selectedTabId == tab.id;

                    return ReorderableDelayedDragStartListener(
                      key: ValueKey(tab.id),
                      index: index,
                      child: _CapsuleTab(
                        label: tab.label,
                        isSelected: isSelected,
                        onTap: () {
                          ref.read(settingsProvider.notifier).triggerHaptic();
                          setState(() {
                            _selectedTabId = tab.id;
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
                  )
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
                    size: 120
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
                            size: 32
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
                    const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38),
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
                        const Icon(Icons.location_on_rounded, color: Colors.white24, size: 16),
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

void _showProfileMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return GlassContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(20),
        blur: 30,
        opacity: 0.15,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/placeholder_avatar.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jack Sparrow',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        's.dropper.s23@gmail.com',
                        style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildMenuItem(Icons.language, 'Мова', trailing: '🇺🇦 UA'),
              _buildMenuItem(Icons.person_outline, 'Редагувати профіль'),
              _buildMenuItem(Icons.logout, 'Вийти', color: Colors.redAccent),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildMenuItem(IconData icon, String title, {String? trailing, Color? color}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: color ?? const Color(0xFFC8A96E)),
    title: Text(
      title,
      style: GoogleFonts.poppins(color: color ?? Colors.white70, fontSize: 14),
    ),
    trailing: trailing != null
        ? Text(
            trailing,
            style: GoogleFonts.poppins(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold),
          )
        : const Icon(Icons.chevron_right, color: Colors.white10),
    onTap: () {},
  );
}
