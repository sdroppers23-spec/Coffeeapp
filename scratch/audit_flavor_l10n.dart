import 'package:specialty_tracker/features/flavor_map/sca_flavor_wheel_data.dart';

void main() {
  final keys = <String>{};
  for (var cat in ScaFlavorData.localizedData) {
    keys.add(cat.key);
    for (var sub in cat.sub) {
      keys.add(sub.key);
      for (var note in sub.noteKeys) {
        keys.add(note);
      }
    }
  }

  // ignore: avoid_print
  print('Total keys used in data: ${keys.length}');
}
