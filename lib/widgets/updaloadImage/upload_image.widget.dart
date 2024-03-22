import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/convert_base64_to_XFile.util.dart';
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
