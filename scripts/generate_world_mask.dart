// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:convert';

void main() async {
  final jsonFile =
      File('D:/Games/Coffeeapp/build/app/outputs/flutter-apk/world_map.json');
  if (!jsonFile.existsSync()) {
    print('Error: world_map.json not found');
    return;
  }

  final data = json.decode(await jsonFile.readAsString());
  final List<dynamic> mapData = data['map'];

  final buffer = StringBuffer();
  buffer.writeln('class WorldMaskData {');
  buffer.writeln('  // High-precision 240x120 map mask');
  buffer.writeln('  static const List<String> maskRows = [');
  for (var row in mapData) {
    buffer.writeln('    "$row",');
  }
  buffer.writeln('  ];');
  buffer.writeln('');
  buffer.writeln('  static bool isLand(double lat, double lon) {');
  buffer.writeln('    // Map latitude (-90 to 90) to row (0 to 119)');
  buffer.writeln('    // Map longitude (-180 to 180) to col (0 to 239)');
  buffer
      .writeln('    int row = ((90 - lat) / 180 * 119).round().clamp(0, 119);');
  buffer.writeln(
      '    int col = ((lon + 180) / 360 * 239).round().clamp(0, 239);');
  buffer.writeln('    ');
  buffer.writeln('    return maskRows[row][col] == "1";');
  buffer.writeln('  }');
  buffer.writeln('}');

  final outFile =
      File('D:/Games/Coffeeapp/lib/features/flavor_map/world_mask_data.dart');
  await outFile.writeAsString(buffer.toString());
  print(
      'Successfully generated world_mask_data.dart with ${mapData.length} rows.');
}
