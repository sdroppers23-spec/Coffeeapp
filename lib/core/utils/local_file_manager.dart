import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class LocalFileManager {
  static const String coffeeImagesDir = 'coffee_images';

  /// Saves image bytes to the application's documents directory.
  /// Returns the absolute file path of the saved image.
  static Future<String> saveImageLocal(
    Uint8List bytes, {
    String extension = '.jpg',
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesPath = Directory(p.join(directory.path, coffeeImagesDir));

      if (!await imagesPath.exists()) {
        await imagesPath.create(recursive: true);
      }

      final fileName = '${const Uuid().v4()}$extension';
      final filePath = p.join(imagesPath.path, fileName);

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      return filePath;
    } catch (e) {
      // Silent fail for image saving telemetry
      rethrow;
    }
  }

  /// Deletes a local image by its absolute path.
  static Future<void> deleteImage(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Ignore cleanup errors in production
    }
  }

  /// Checks if a string is a potential local file path.
  static bool isLocalPath(String path) {
    return !path.startsWith('http') && !path.startsWith('assets/');
  }
}
