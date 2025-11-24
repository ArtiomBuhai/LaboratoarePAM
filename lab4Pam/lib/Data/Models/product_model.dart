import '../../Domain/Entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String brand,
    required double price,
    double? oldPrice,
    required String imageUrl,
    bool isNew = false,
    double? discount,
    int? rating,
  }) : super(
    id: id,
    name: name,
    brand: brand,
    price: price,
    oldPrice: oldPrice,
    imageUrl: imageUrl,
    isNew: isNew,
    discount: discount,
    rating: rating,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int? parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString());
    }

    final image = json['image'] ?? json['imageUrl'] ?? json['image_url'] ?? '';
    final priceVal = json.containsKey('newPrice') ? json['newPrice'] : json['price'];
    final oldPriceVal = json.containsKey('oldPrice') ? json['oldPrice'] : null;

    return ProductModel(
      id: (json['id'] ?? json['ID'] ?? '').toString(),
      name: json['name'] ?? json['title'] ?? '',
      brand: json['brand'] ?? '',
      price: parseDouble(priceVal),
      oldPrice: oldPriceVal != null ? parseDouble(oldPriceVal) : null,
      imageUrl: image.toString(),
      isNew: json['isNew'] == true,
      discount: json['discount'] != null ? parseDouble(json['discount']) : null,
      rating: parseInt(json['rating']),
    );
  }
}
