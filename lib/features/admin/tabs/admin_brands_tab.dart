import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../widgets/admin_edit_brand_sheet.dart';

class AdminBrandsTab extends ConsumerStatefulWidget {
  const AdminBrandsTab({super.key});

  @override
  ConsumerState<AdminBrandsTab> createState() => _AdminBrandsTabState();
}

class _AdminBrandsTabState extends ConsumerState<AdminBrandsTab> {
  void _openEditor({LocalizedBrandDto? brand}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AdminEditBrandSheet(existingBrand: brand),
    ).then((updated) {
      if (updated == true) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalizedBrandDto>>(
      future: ref.read(databaseProvider).getAllBrands('uk'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final brands = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add New Brand'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
              ),
              onPressed: () => _openEditor(),
            ),
            const SizedBox(height: 16),
            ...brands.map(
              (b) => ListTile(
                title: Text(
                  b.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  b.shortDesc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFC8A96E)),
                  onPressed: () => _openEditor(brand: b),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
