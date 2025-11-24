class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final bool isNew;
  final double? discount;
  final int? rating;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    this.isNew = false,
    this.discount,
    this.rating,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    // Accept different key names used in various mock/json sources.
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
    // price can be under 'price' or 'newPrice'
    final priceVal = json.containsKey('newPrice') ? json['newPrice'] : json['price'];
    final oldPriceVal = json.containsKey('oldPrice') ? json['oldPrice'] : null;

    return Product(
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
