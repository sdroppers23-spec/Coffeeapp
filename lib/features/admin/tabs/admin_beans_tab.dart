import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../widgets/admin_edit_bean_sheet.dart';

class AdminBeansTab extends ConsumerStatefulWidget {
  const AdminBeansTab({super.key});

  @override
  ConsumerState<AdminBeansTab> createState() => _AdminBeansTabState();
}

class _AdminBeansTabState extends ConsumerState<AdminBeansTab> {
  void _openEditor({LocalizedBeanDto? bean}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AdminEditBeanSheet(existingBean: bean),
    ).then((updated) {
      if (updated == true) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalizedBeanDto>>(
      future: ref.read(databaseProvider).getAllBeans('uk'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final beans = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add New Coffee Lot'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
              ),
              onPressed: () => _openEditor(),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh, color: Colors.orange),
              label: const Text('Baseline Reset (Seed 26 Lots)'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange),
                foregroundColor: Colors.orange,
              ),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirm Reset'),
                    content: const Text(
                      'This will clear local data, seed all 26 lots, and push to cloud. Continue?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Reset & Push'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  // Show loading
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Seeding and Syncing... please wait.'),
                      duration: Duration(minutes: 1),
                    ),
                  );

                  try {
                    await ref.read(coffeeDataSeedProvider).seedAll(force: true);
                    await ref.read(syncServiceProvider).pushLocalToCloud();

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Successfully seeded 26 lots and pushed to cloud!',
                        ),
                      ),
                    );
                    setState(() {});
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            ...beans.map(
              (b) => ListTile(
                title: Text(
                  '${b.countryEmoji ?? ''} ${b.country}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(b.region),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFC8A96E)),
                  onPressed: () => _openEditor(bean: b),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
