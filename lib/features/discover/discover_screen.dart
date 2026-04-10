import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../encyclopedia/encyclopedia_screen.dart';
import '../specialty/specialty_screen.dart';
import 'farmers_screen.dart';
import 'roasters_screen.dart';
import '../flavor_map/terroir_globe.dart';
import '../encyclopedia/add_custom_lot_screen.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/glass_container.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: GlassContainer(
            borderRadius: 0,
            padding: EdgeInsets.zero,
            opacity: 0.1,
            blur: 20,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(ref.t('discover'), 
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, 
                  letterSpacing: 0.5,
                  fontSize: 22
                )),
              actions: const [],
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorWeight: 3,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: [
                  Tab(text: ref.t('farmers')),
                  Tab(text: ref.t('roasters')),
                  Tab(text: ref.t('history')),
                  Tab(text: ref.t('encyclopedia')),
                  Tab(text: ref.t('my_lots')),
                ],
              ),
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
