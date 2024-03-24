import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/image.util.dart';
import 'widgets.dart';

class ImageContentWidget extends StatelessWidget {
  const ImageContentWidget({
    super.key,
    required this.productResult,
    this.width,
    this.fit = BoxFit.fill,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
    ),
  });

  final BoxFit? fit;
  final double? width;
  final ProductResult productResult;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    if ((productResult.images != null) &&
        (productResult.images!.isNotEmpty) &&
        (productResult.images![0].isNotEmpty)) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.memory(
          imageFile(
            base64Image: productResult.images![0],
          ),
          height: 280.0,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return ErrorImage(borderRadius: borderRadius, width: width);
          },
        ),
      );
    } else {
      return ErrorImage(borderRadius: borderRadius, width: width);
    }
  }
}
