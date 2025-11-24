import 'package:flutter/foundation.dart';
import '../../Domain/Entities/product.dart';
import '../../Domain/Repositories/product_details_repository.dart';
import '../DataSources/product_details_data_source.dart';
import '../Models/product_model.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsLocalDataSource localDataSource;
  final ProductDetailsInternetDataSource? internetDataSource;

  Map<String, dynamic>? _productDetails;
  List<Product> _relatedProducts = [];
  String? _selectedColor;

  ProductDetailsRepositoryImpl({required this.localDataSource, this.internetDataSource});

  @override
  Future<Map<String, dynamic>> loadProductDetails() async {
    try {
      Map<String, dynamic>? data;

      // Try internet data source first if available. Skip on Web (CORS issues).
      if (internetDataSource != null && !kIsWeb) {
        try {
          data = await internetDataSource!.fetchProductDetails();
        } catch (e) {
          print('ProductDetailsRepositoryImpl: internet datasource failed: $e');
          data = null;
        }
      } else if (kIsWeb) {
        print('ProductDetailsRepositoryImpl: running on web — skipping remote API. Using local asset.');
      }

      // Fallback to local asset
      data ??= await localDataSource.getProductDetailsFromAssets();

      // Parse product details
        _productDetails = Map<String, dynamic>.from(data['product'] ?? {});

        // Extract main image from first color
        if (_productDetails != null) {
          try {
            final colors = _productDetails!['colors'] as List?;
            if (colors != null && colors.isNotEmpty) {
              final images = colors[0]['images'] as List?;
              if (images != null && images.isNotEmpty) {
                _productDetails!['mainImage'] = images[0];
              }

              // Set default color to Black or first color
              String? chosen;
              for (final c in colors) {
                final name = c['name']?.toString();
                if (name != null && name.toLowerCase() == 'black') {
                  chosen = name;
                  break;
                }
              }
              _selectedColor = chosen ?? colors[0]['name']?.toString();
              // Store selected color in details map
              _productDetails!['selectedColor'] = _selectedColor;
            }
          } catch (_) {}
        }

        // Parse related products
        final rel = data['relatedProducts'] as List?;
        if (rel != null) {
          _relatedProducts = rel.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
        }


      return data;
    } catch (e) {
      print('ProductDetailsRepositoryImpl.loadProductDetails error: $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic>? getProductDetails() => _productDetails;

  @override
  List<Product> getRelatedProducts() => _relatedProducts;

  @override
  String? getSelectedColor() => _selectedColor;

  @override
  void setSelectedColor(String colorName) {
    _selectedColor = colorName;
    if (_productDetails != null) {
      _productDetails!['selectedColor'] = colorName;
    }
  }

  @override
  Product? selectProductById(String id) {
    if (_productDetails != null) {
      final pdId = (_productDetails!['id'] ?? _productDetails!['sku'])?.toString() ?? '';
      if (pdId.isNotEmpty && pdId == id) {
        return _buildProductFromDetails();
      }
    }

    // Fallback: search in related products
    try {
      return _relatedProducts.firstWhere((p) => p.id == id || p.id == id.toString());
    } catch (_) {
      return null;
    }
  }

  Product? _buildProductFromDetails() {
    if (_productDetails == null) return null;
    try {
      final pd = _productDetails!;
      final mainImage = pd['mainImage']?.toString() ?? '';
      return ProductModel(
        id: (pd['id'] ?? pd['sku'])?.toString() ?? '',
        name: pd['title'] ?? pd['name'] ?? '',
        brand: pd['brand'] ?? '',
        price: (pd['price'] is num) ? (pd['price'] as num).toDouble() : 0.0,
        imageUrl: mainImage,
        isNew: pd['isNew'] == true,
        rating: pd['rating'] != null ? (pd['rating'] as num).toInt() : null,
      );
    } catch (_) {
      return null;
    }
  }
}
