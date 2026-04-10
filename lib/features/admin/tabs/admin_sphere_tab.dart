import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../widgets/admin_edit_sphere_sheet.dart';

class AdminSphereTab extends ConsumerStatefulWidget {
  const AdminSphereTab({super.key});

  @override
  ConsumerState<AdminSphereTab> createState() => _AdminSphereTabState();
}

class _AdminSphereTabState extends ConsumerState<AdminSphereTab> {
  void _openEditor({SphereRegionDto? region}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AdminEditSphereSheet(existingRegion: region),
    ).then((updated) {
      if (updated == true) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SphereRegionDto>>(
      future: ref.read(databaseProvider).getAllSphereRegions('uk'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final regions = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Sphere Region'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
              ),
              onPressed: () => _openEditor(),
            ),
            const SizedBox(height: 16),
            ...regions.map(
              (r) => ListTile(
                title: Text(
                  r.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Lat: ${r.latitude}, Lng: ${r.longitude}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFC8A96E)),
                  onPressed: () => _openEditor(region: r),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
