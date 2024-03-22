import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProductCommand {
  final String? code;
  final String? supplier;
  final String? description;
  final String? year;
  final double? height;
  final double? width;
  final double? depth;
  final double? retail;
  final double? wholesaleRetail;
  final double? wholesaleMajor;
  final List<XFile>? images;
  final String? brand;

  const ProductCommand({
    required this.code,
    required this.supplier,
    required this.description,
    required this.year,
    required this.height,
    required this.width,
    required this.depth,
    required this.retail,
    required this.wholesaleRetail,
    required this.wholesaleMajor,
    required this.images,
    required this.brand,
  });

  Future<Map<String, dynamic>> toJson() async {
    final imageFile = [];
    if (images != null && images!.isNotEmpty) {
      for (var img in images!) {
        if (img.path.isNotEmpty) {
          final formData = await MultipartFile.fromFile(img.path);
          imageFile.add(formData);
        }
      }
    }

    return {
      "code": code,
      "supplier": supplier,
      "description": description,
      "year": year,
      "height": height,
      "width": width,
      "depth": depth,
      "retail": retail,
      "min": wholesaleRetail,
      "max": wholesaleMajor,
      "images": imageFile.isEmpty ? null : imageFile,
      "brand": brand,
    };
  }

  ProductCommand copyWith({
    String? code,
    String? supplier,
    String? description,
    String? year,
    double? height,
    double? width,
    double? depth,
    double? retail,
    double? wholesaleRetail,
    double? wholesaleMajor,
    List<XFile>? images,
    String? brand,
  }) {
    return ProductCommand(
      code: code ?? this.code,
      supplier: supplier ?? this.supplier,
      description: description ?? this.description,
      year: year ?? this.year,
      height: height ?? this.height,
      width: width ?? this.width,
      depth: depth ?? this.depth,
      retail: retail ?? this.retail,
      wholesaleRetail: wholesaleRetail ?? this.wholesaleRetail,
      wholesaleMajor: wholesaleMajor ?? this.wholesaleMajor,
      images: images ?? this.images,
      brand: brand ?? this.brand,
    );
  }
}
