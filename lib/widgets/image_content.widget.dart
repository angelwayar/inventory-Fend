import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/image.util.dart';
import 'widgets.dart';

class ImageContentWidget extends StatelessWidget {
  const ImageContentWidget({super.key, required this.productResult});

  final ProductResult productResult;

  @override
  Widget build(BuildContext context) {
    if ((productResult.images != null) &&
        (productResult.images!.isNotEmpty) &&
        (productResult.images![0].isNotEmpty)) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
        child: Image.memory(
          imageFile(
            base64Image: productResult.images![0],
          ),
          height: 280.0,
          width: 400.0,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return const ErrorImage();
          },
        ),
      );
    } else {
      return const ErrorImage();
    }
  }
}
