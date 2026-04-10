import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';

class DiscoverTabItem {
  final String id;
  final String defaultLabel;
  DiscoverTabItem(this.id, this.defaultLabel);
}

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late List<DiscoverTabItem> _topPills;
  bool _showAll = true; // Toggle for "Усі" vs "Обране"

  @override
  void initState() {
    super.initState();
    _topPills = [
      DiscoverTabItem('farmers', 'Фермери'),
      DiscoverTabItem('roasters', 'Обсмажчики'),
      DiscoverTabItem('history', 'Історія Спешелті'),
    ];
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    ref.read(settingsProvider.notifier).triggerHaptic();

    setState(() {
      final item = _topPills.removeAt(oldIndex);
      _topPills.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar Area
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Відкриття',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: const Color(0xFFC8A96E),
                      ),
                    ),
                    Row(
                      children: [
                        // Connected Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.3)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent.withValues(alpha: 0.05),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.cloud_done_outlined, color: Colors.greenAccent, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Cloud Connected",
                                style: GoogleFonts.poppins(
                                  color: Colors.greenAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Avatar
                        GestureDetector(
                          onTap: () => _showProfileMenu(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/placeholder_avatar.jpg'), // fallback if missing
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Icon(Icons.person, color: Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Reorderable Capsule Tabs (Top pills)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                  ),
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    buildDefaultDragHandles: false,
                    proxyDecorator: (child, index, animation) {
                      return Material(color: Colors.transparent, child: child);
                    },
                    itemCount: _topPills.length,
                    onReorderStart: (_) => ref.read(settingsProvider.notifier).triggerVibrate(),
                    onReorder: _onReorder,
                    itemBuilder: (context, index) {
                      final pill = _topPills[index];
                      // Note: they all look dark like simple tags
                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(pill.id),
                        index: index,
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1815), // Very dark warm gray
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              pill.defaultLabel,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1815),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFFC8A96E), size: 22),
                      const SizedBox(width: 12),
                      Text(
                        'Пошук сортів та регіонів...',
                        style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // All / Favorites Toggle Switch
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: _SegmentedToggle(
                  isAllSelected: _showAll,
                  onChanged: (val) {
                    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                    setState(() => _showAll = val);
                  },
                ),
              ),
            ),

            // Filters Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _FilterButton(icon: Icons.filter_list_rounded, label: 'Фільтри'),
                        const SizedBox(width: 12),
                        _FilterButton(icon: Icons.compare_arrows_rounded, label: 'Порівняння'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1815),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.grid_view_rounded, color: Color(0xFFC8A96E), size: 18),
                    ),
                  ],
                ),
              ),
            ),

            // Coffee List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 120), // Bottom padding for nav bar
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _CoffeeCard(
                    title: 'Руанда - Washed',
                    subtitle: 'Руанда • Washed',
                    bitterness: 3,
                    acidity: 4,
                    sweetness: 3,
                  ),
                  const _CoffeeCard(
                    title: 'Руанда - Natural',
                    subtitle: 'Руанда • Natural',
                    bitterness: 3,
                    acidity: 3,
                    sweetness: 4,
                  ),
                  const _CoffeeCard(
                    title: 'Гватемала - Washed',
                    subtitle: 'Гватемала • Washed',
                    bitterness: 3,
                    acidity: 4,
                    sweetness: 3,
                  ),
                  const _CoffeeCard(
                    title: 'Ель-Сальвадор - Natural',
                    subtitle: 'Ель-Сальвадор • Natural',
                    bitterness: 4,
                    acidity: 3,
                    sweetness: 4,
                  ),
                  const _CoffeeCard(
                    title: 'Ефіопія - Washed',
                    subtitle: 'Ефіопія • Washed',
                    bitterness: 2,
                    acidity: 5,
                    sweetness: 4,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  final bool isAllSelected;
  final ValueChanged<bool> onChanged;

  const _SegmentedToggle({required this.isAllSelected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1815),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isAllSelected ? const Color(0xFFC8A96E) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Усі',
                    style: GoogleFonts.poppins(
                      color: isAllSelected ? Colors.black : Colors.white54,
                      fontWeight: isAllSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: !isAllSelected ? const Color(0xFF2C221D) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 14,
                        color: !isAllSelected ? Colors.white70 : Colors.white30,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Обране',
                        style: GoogleFonts.poppins(
                          color: !isAllSelected ? Colors.white70 : Colors.white54,
                          fontWeight: !isAllSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
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
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FilterButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1815),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CoffeeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int bitterness;
  final int acidity;
  final int sweetness;

  const _CoffeeCard({
    required this.title,
    required this.subtitle,
    required this.bitterness,
    required this.acidity,
    required this.sweetness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0A07), // Very dark card background
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Left Globe Icon inside a circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.public, color: Colors.white30, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          
          // Main Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Ratings bars Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RatingDashes('ГІРКОТА', bitterness),
                    _RatingDashes('КИСЛОТНІСТЬ', acidity),
                    _RatingDashes('СОЛОДКІСТЬ', sweetness),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
        ],
      ),
    );
  }
}

class _RatingDashes extends StatelessWidget {
  final String label;
  final int value;
  final int total = 4;

  const _RatingDashes(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white38,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(total, (index) {
            final active = index < value;
            return Container(
              margin: const EdgeInsets.only(right: 3),
              height: 2.5,
              width: 12,
              decoration: BoxDecoration(
                color: active ? const Color(0xFFC8A96E) : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }
}

void _showProfileMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1E1815), // Custom dark brown
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Avatar & Info
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/placeholder_avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white12, width: 1),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jack Sparrow',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          's.dropper.s23@gmail.com',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white12, height: 1),
              
              // Language
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language, color: Color(0xFFC8A96E)), // Gold icon
                title: Text(
                  'Мова',
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🇺🇦 UA',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFC8A96E),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.expand_more_rounded, color: Color(0xFFC8A96E), size: 20),
                  ],
                ),
                onTap: () {}, // Language toggle logic
              ),
              const Divider(color: Colors.white12, height: 1),
              
              // Edit Profile
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person_pin_rounded, color: Color(0xFFC8A96E)), // Custom user gear icon equivalent
                title: Text(
                  'РЕДАГУВАТИ ПРОФІЛЬ',
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.lerp(FontWeight.w500, FontWeight.w600, 0.5)),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
                onTap: () {},
              ),
              const Divider(color: Colors.white12, height: 1),
              
              // Log Out
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout_rounded, color: Color(0xFFE57373)), // Red icon
                title: Text(
                  'Вийти',
                  style: GoogleFonts.poppins(color: const Color(0xFFE57373), fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}
