import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tabs/admin_brands_tab.dart';
import 'tabs/admin_beans_tab.dart';
import 'tabs/admin_sphere_tab.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Admin Console',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicatorColor: Color(0xFFC8A96E),
            labelColor: Color(0xFFC8A96E),
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: 'Brands', icon: Icon(Icons.storefront_outlined)),
              Tab(text: 'Beans', icon: Icon(Icons.coffee_outlined)),
              Tab(text: 'Sphere', icon: Icon(Icons.language_outlined)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AdminBrandsTab(),
            AdminBeansTab(),
            AdminSphereTab(),
          ],
        ),
      ),
    );
  }
}
