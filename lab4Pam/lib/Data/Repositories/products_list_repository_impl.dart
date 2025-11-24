import 'package:flutter/foundation.dart';
import '../../Domain/Entities/product.dart';
import '../../Domain/Repositories/products_list_repository.dart';
import '../DataSources/products_list_data_source.dart';
import '../Models/product_model.dart';

class ProductsListRepositoryImpl implements ProductsListRepository {
  final ProductsListLocalDataSource localDataSource;
  final ProductsListInternetDataSource? internetDataSource;

  List<Product> _saleProducts = [];
  List<Product> _newProducts = [];
  String? _bannerUrl;

  ProductsListRepositoryImpl({required this.localDataSource, this.internetDataSource});

  @override
  Future<Map<String, dynamic>> loadProductsList() async {
    try {
      Map<String, dynamic>? data;

      // Try internet data source first if available. Skip on Web (CORS issues).
      if (internetDataSource != null && !kIsWeb) {
        try {
          data = await internetDataSource!.fetchProductsList();
        } catch (e) {
          print('ProductsListRepositoryImpl: internet datasource failed: $e');
          data = null;
        }
      } else if (kIsWeb) {
        print('ProductsListRepositoryImpl: running on web — skipping remote API. Using local asset.');
      }

      // Fallback to local asset
      data ??= await localDataSource.getProductsListFromAssets();

      // Parse ecommerce sections (Sale & New)

        _bannerUrl = data['header']?['bannerImage']?.toString();

        final sections = data['sections'] as List?;
        if (sections != null) {
          for (final section in sections) {
            final title = section['title']?.toString() ?? '';
            final items = section['items'] as List?;
            if (items != null) {
              final parsed = items.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
              if (title.toLowerCase() == 'sale') {
                _saleProducts = parsed;
              } else if (title.toLowerCase() == 'new') {
                _newProducts = parsed;
              }
            }
          }
        }


      return data;
    } catch (e) {
      print('ProductsListRepositoryImpl.loadProductsList error: $e');
      rethrow;
    }
  }

  @override
  List<Product> getSaleProducts() => _saleProducts;

  @override
  List<Product> getNewProducts() => _newProducts;

  @override
  String? getBannerUrl() => _bannerUrl;
}
