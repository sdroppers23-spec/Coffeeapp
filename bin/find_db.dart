import 'dart:io';
import 'package:path/path.dart' as p;

void main() async {
  // On Windows, Drift uses the local directory or documents depending on how it's initialized.
  // The app code says: final dbFolder = await getApplicationDocumentsDirectory();
  // Since I can't run Flutter code easily in shell without full environment,
  // I will check common locations.

  final userProfile = Platform.environment['USERPROFILE'] ?? 'C:\\Users\\gkill';
  final docs = p.join(userProfile, 'Documents');
  final appData =
      p.join(userProfile, 'AppData', 'Roaming', 'specialty_tracker');

  final candidates = [
    p.join(docs, 'speciality_coffee_v17.sqlite'),
    p.join(appData, 'speciality_coffee_v17.sqlite'),
    p.join(Directory.current.path, 'speciality_coffee_v17.sqlite'),
  ];

  for (final c in candidates) {
    if (File(c).existsSync()) {
      // ignore: avoid_print
      print('FOUND: $c');
    }
  }
}
