// utils/file_picker_helper.dart
import 'package:file_picker/file_picker.dart';


class FilePickerHelper {
  // Pick an image file
  static Future<PlatformFile?> pickImage() async {
    // Prompt the user to pick an image file
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      // Access the first file (single file selection)
      PlatformFile file = result.files.single;

      // Return the file
      return file;
    } else {
      return null;
    }
  }

  // Pick a video file
  static Future<PlatformFile?> pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    return result?.files.single;
  }

  // Pick a document file (PDF, DOC, DOCX)
  static Future<PlatformFile?> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    return result?.files.single;
  }
}
