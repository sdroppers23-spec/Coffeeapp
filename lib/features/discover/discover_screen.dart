import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


import '../specialty/specialty_screen.dart';
import 'farmers_screen.dart';
import 'roasters_screen.dart';
import '../flavor_map/terroir_globe.dart';
import '../encyclopedia/add_custom_lot_screen.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Container(
            padding: const EdgeInsets.only(top: 48, bottom: 8), // Status bar padding
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
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
                              color: const Color(0xFFC8A96E).withValues(alpha: 0.3),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
                              color: Colors.greenAccent.withValues(alpha: 0.1),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.cloud_done_outlined, color: Colors.greenAccent, size: 14),
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
                                    image: AssetImage('assets/images/placeholder_avatar.jpg'), // Ensure an asset or network image is supplied, fallback to icon if needed
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.white24, width: 1.5),
                                ),
                                child: const Icon(Icons.person, color: Colors.white30, size: 20), // Placeholder child incase image fails or is missing initially
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tabs
                SizedBox(
                  height: 36,
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xFFC8A96E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white60,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                    unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
                    tabs: [
                      Tab(child: Text(ref.t('farmers'))),
                      Tab(child: Text(ref.t('roasters'))),
                      Tab(child: Text(ref.t('history'))),
                      Tab(child: Text(ref.t('encyclopedia'))),
                      Tab(child: Text(ref.t('my_lots'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FarmersScreen(),
            RoastersScreen(),
            TerroirGlobe(),
            SpecialtyEducationScreen(),
            AddCustomLotScreen(openAsAdd: false),
          ],
        ),
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
                        image: AssetImage('assets/images/placeholder_avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: const Color(0xFFC8A96E), width: 2),
                    ),
                    child: const Icon(Icons.person, color: Colors.white30, size: 30),
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
                leading: const Icon(Icons.person_outline, color: Colors.white70),
                title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white30),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border, color: Colors.white70),
                title: const Text('Saved Lots', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white30),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log Out', style: TextStyle(color: Colors.redAccent)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}
