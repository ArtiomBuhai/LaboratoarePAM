import '../Entities/product.dart';

abstract class ProductsListRepository {
  /// Loads product list from local or remote source
  Future<Map<String, dynamic>> loadProductsList();

  /// Getter for sale products
  List<Product> getSaleProducts();

  /// Getter for new products
  List<Product> getNewProducts();

  /// Getter for banner URL
  String? getBannerUrl();
}
