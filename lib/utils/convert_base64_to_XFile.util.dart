import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<XFile?> base64ToXFile(String base64Image) async {
  try {
    List<int> bytes = base64.decode(base64Image);
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    String tempFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String tempFilePath = '$tempPath/$tempFileName.png';

    await File(tempFilePath).writeAsBytes(bytes);

    XFile xFile = XFile(tempFilePath);

    return xFile;
  } catch (e) {
    return null;
  }
}
