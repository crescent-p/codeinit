import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc'],
  );
  if (result != null) {
    PlatformFile file = result.files.first;
    return file;
  } else {
    return null;
  }
}
