// ignore_for_file: avoid_print
import 'dart:io';

void main() async {
  final source = Directory(
      'C:/Users/gkill/.agents/skills/supabase-postgres-best-practices');
  final dest = Directory(
      'd:/Games/Coffeeapp/.agent/skills/supabase-postgres-best-practices');

  if (!source.existsSync()) {
    print('❌ Source not found at ${source.path}');
    return;
  }

  if (!dest.existsSync()) {
    dest.createSync(recursive: true);
  }

  await copyDirectory(source, dest);
  print('✅ Skill copied to ${dest.path}');
}

Future<void> copyDirectory(Directory source, Directory destination) async {
  await for (var entity in source.list(recursive: false)) {
    if (entity is Directory) {
      final newDirectory = Directory(
          '${destination.path}/${entity.path.split(Platform.pathSeparator).last}');
      await newDirectory.create();
      await copyDirectory(entity, newDirectory);
    } else if (entity is File) {
      await entity.copy(
          '${destination.path}/${entity.path.split(Platform.pathSeparator).last}');
    }
  }
}
