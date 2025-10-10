class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? oldPrice;
  final int discountPercent;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final List<String> colors;
  final List<String> sizes;
  final String description;
  final bool isNew;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.oldPrice,
    this.discountPercent = 0,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.description,
    this.isNew = false,
  });
}
