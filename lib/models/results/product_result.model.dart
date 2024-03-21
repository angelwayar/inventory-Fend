class ProductResult {
  const ProductResult({
    required this.id,
    required this.code,
    required this.supplier,
    required this.description,
    required this.year,
    required this.height,
    required this.width,
    required this.depth,
    required this.retail,
    required this.images,
    required this.brand,
  });

  final String id;
  final String? code;
  final String? supplier;
  final String? description;
  final String? year;
  final double? height;
  final double? width;
  final double? depth;
  final double? retail;
  final List<String>? images;
  final String? brand;

  factory ProductResult.fromJson(Map<String, dynamic> json) => ProductResult(
        id: json["id"],
        code: json["code"] == 'None' ? null : json["code"],
        supplier: json["supplier"] == 'None' ? null : json["supplier"],
        description: json["description"] == 'None' ? null : json["description"],
        year: json["year"] == 'None' ? null : json["year"],
        height: json["height"],
        width: json["width"],
        depth: json["depth"],
        retail: json["retail"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"]?.map((x) => x)),
        brand: json["brand"] == 'None' ? null : json["brand"],
      );
}
