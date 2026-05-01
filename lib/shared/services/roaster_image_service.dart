import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class RoasterImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickAndSaveImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image == null) return null;

      final appDir = await getApplicationDocumentsDirectory();
      final roastersDir = Directory(p.join(appDir.path, 'roasters'));

      if (!await roastersDir.exists()) {
        await roastersDir.create(recursive: true);
      }

      final fileName =
          'roaster_${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
      final savedFile = await File(
        image.path,
      ).copy(p.join(roastersDir.path, fileName));

      return savedFile.path;
    } catch (e) {
      return null;
    }
  }
}
