import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets.dart';

part 'gridview_image.dart';

class UploadImagesWidget extends StatefulWidget {
  final List<String>? initialImages;
  final ValueChanged<List<XFile>> imagesSeleted;

  const UploadImagesWidget({
    super.key,
    this.initialImages,
    required this.imagesSeleted,
  });

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  late final List<XFile> imageList;
  late final ImagePicker picker;

  @override
  void initState() {
    imageList = [];
    picker = ImagePicker();

    loadImages();
    super.initState();
  }

  void loadImages() async {
    for (var element in widget.initialImages ?? []) {
      final img = await base64ToXFile(element);
      if (img != null) {
        setState(() {
          imageList.add(img);
        });
      }
    }
  }

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

  Future<void> imageSelect() async {
    final List<XFile> selectedImage = await picker.pickMultiImage();
    setState(() {
      imageList.addAll(selectedImage);
      widget.imagesSeleted(imageList);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageList.isNotEmpty) {
      return GridViewImageWidget(
        images: imageList,
        isEmptyGridViewImageWidget: (value) {
          widget.imagesSeleted(value);
        },
      );
    }
    return InkWell(
      onTap: imageSelect,
      borderRadius: BorderRadius.circular(24.0),
      child: const SizedBox(
        height: 300.0,
        child: Center(
          child: Text('Agregar images'),
        ),
      ),
    );
  }
}
