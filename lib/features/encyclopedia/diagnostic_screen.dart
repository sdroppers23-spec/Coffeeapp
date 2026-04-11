import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/l10n/app_localizations.dart';

class EncyclopediaDiagnosticScreen extends ConsumerWidget {
  const EncyclopediaDiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Encyclopedia Diagnostic')),
      body: FutureBuilder(
        future: Future.wait([
          db.customStatement('SELECT count(*) as c FROM localized_beans'),
          db.customStatement('SELECT count(*) as c FROM localized_bean_translations'),
          db.customStatement('SELECT count(*) as c FROM localized_bean_translations WHERE language_code = ?', [lang]),
          db.watchAllEncyclopediaEntries(lang).first,
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final r1 = (snapshot.data![0] as List)[0]['c'] as int;
          final r2 = (snapshot.data![1] as List)[0]['c'] as int;
          final r3 = (snapshot.data![2] as List)[0]['c'] as int;
          final r4 = snapshot.data![3] as List;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Total Beans: $r1', style: const TextStyle(fontSize: 20)),
              Text('Total Translations: $r2', style: const TextStyle(fontSize: 20)),
              Text('Translations for "$lang": $r3', style: const TextStyle(fontSize: 20)),
              Text('Watch Result Count: ${r4.length}', style: const TextStyle(fontSize: 20)),
              const Divider(),
              ...r4.map((e) => Text('Bean ${e.id}: ${e.country} ${e.region}')),
            ],
          );
        },
      ),
    );
  }
}
