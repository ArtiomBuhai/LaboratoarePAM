import '../Entities/product.dart';

abstract class ProductDetailsRepository {
  /// Loads product details from local or remote source
  Future<Map<String, dynamic>> loadProductDetails();

  /// Get the main product details
  Map<String, dynamic>? getProductDetails();

  /// Get related products
  List<Product> getRelatedProducts();

  /// Get currently selected color
  String? getSelectedColor();

  /// Set the selected color
  void setSelectedColor(String colorName);

  /// Select product by ID
  Product? selectProductById(String id);
}
