import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesWidget extends StatefulWidget {
  final ValueChanged<List<XFile>> imagesSeleted;

  const UploadImagesWidget({super.key, required this.imagesSeleted});

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  final imageList = <XFile>[];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (imageList.isNotEmpty) {
      return _GridViewImageWidget(
        images: imageList,
        isEmptyGridViewImageWidget: (value) {
          if (value.isEmpty) {
            widget.imagesSeleted(value);
            setState(() {});
          }
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

  Future<void> imageSelect() async {
    final List<XFile> selectedImage = await picker.pickMultiImage();
    setState(() {
      imageList.addAll(selectedImage);
      widget.imagesSeleted(imageList);
    });
  }
}

class _GridViewImageWidget extends StatefulWidget {
  final List<XFile> images;
  final ValueChanged<List<XFile>> isEmptyGridViewImageWidget;

  const _GridViewImageWidget({
    required this.images,
    required this.isEmptyGridViewImageWidget,
  });

  @override
  State<_GridViewImageWidget> createState() => _GridViewImageWidgetState();
}

class _GridViewImageWidgetState extends State<_GridViewImageWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: widget.images.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _AddImagesButtonWidget(
            imagesSeleted: (value) {
              setState(() {
                widget.images.addAll(value);
                widget.isEmptyGridViewImageWidget(value);
              });
            },
          );
        } else {
          final image = widget.images[index - 1].path;
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Image.file(
                      File(image),
                      fit: BoxFit.contain,
                    );
                  });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  height: 130.0,
                  width: 130.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.file(
                      File(image),
                      height: 150.0,
                      width: 150.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Positioned(
                  left: -2.0,
                  top: -4.0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.images.removeAt(index - 1);
                        if (widget.images.isEmpty) {
                          widget.isEmptyGridViewImageWidget(widget.images);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_outlined,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class _AddImagesButtonWidget extends StatelessWidget {
  final ValueChanged<List<XFile>> imagesSeleted;
  final _images = <XFile>[];
  final _picker = ImagePicker();

  _AddImagesButtonWidget({required this.imagesSeleted});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imageSelect,
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        height: 150.0,
        width: 150.0,
        decoration: BoxDecoration(
          // color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }

  Future<void> imageSelect() async {
    final List<XFile> selectedImage = await _picker.pickMultiImage();

    _images.addAll(selectedImage);
    imagesSeleted(selectedImage);
  }
}
