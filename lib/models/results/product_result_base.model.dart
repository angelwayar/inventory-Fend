import 'package:inventory_fend/models/models.dart';

class ProductResultBase {
  const ProductResultBase({
    required this.totalItems,
    required this.totalPages,
    required this.products,
  });

  final int totalItems;
  final int totalPages;
  final List<ProductResult> products;

  ProductResultBase copyWith({
    int? totalItems,
    int? totalPages,
    List<ProductResult>? products,
  }) {
    return ProductResultBase(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      products: products ?? this.products,
    );
  }

  factory ProductResultBase.fromJson(Map<String, dynamic> json) =>
      ProductResultBase(
        totalItems: json['total_items'],
        totalPages: json['total_pages'],
        products: List<ProductResult>.from(
          json['products']?.map((x) => ProductResult.fromJson(x)),
        ),
      );
}
