import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';



class ProductCartController extends GetxController {
  var saleProducts = <Product>[].obs;
  var newProducts = <Product>[].obs;
  var isLoading = false.obs;
  var saleLoading = false.obs;
  var newLoading = false.obs;
  var bannerUrl = ''.obs;
  // Selected product for details page
  final selectedProduct = Rxn<Product>();
  // Full details map parsed from JSON (details.product)
  final productDetails = Rxn<Map<String, dynamic>>();
  // Currently selected color name for the details page (e.g. 'Black')
  final selectedColor = Rxn<String>();
  // Related products for the details page
  var relatedProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      // 1️⃣ Read JSON from assets
      final String jsonString = await rootBundle.loadString('assets/json_files/use.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      // details holds the product detail and relatedProducts
      final Map<String, dynamic>? details = (data['details'] as Map<String, dynamic>?);

      // parse product details from `details` (this file uses `details.product`)
      if (details != null) {
        try {
          final prod = details['product'] as Map<String, dynamic>?;
          if (prod != null) {
            productDetails.value = Map<String, dynamic>.from(prod);

            // build selectedProduct from details.product
            String mainImage = '';
            try {
              final colors = prod['colors'] as List?;
              if (colors != null && colors.isNotEmpty) {
                final images = colors[0]['images'] as List?;
                if (images != null && images.isNotEmpty) mainImage = images[0] as String;
              }
            } catch (_) {}

            selectedProduct.value = Product(
              id: prod['id']?.toString() ?? prod['sku']?.toString() ?? '',
              name: prod['title'] ?? prod['name'] ?? '',
              brand: prod['brand'] ?? '',
              price: (prod['price'] is num) ? (prod['price'] as num).toDouble() : double.tryParse(prod['price']?.toString() ?? '') ?? 0.0,
              oldPrice: null,
              imageUrl: mainImage,
              isNew: prod['isNew'] == true,
              discount: null,
              rating: prod['rating'] != null ? (prod['rating'] as num).toInt() : null,
            );
            // set default selected color: prefer 'Black' if present, otherwise first color
            try {
              final colors = prod['colors'] as List?;
              if (colors != null && colors.isNotEmpty) {
                String? chosen;
                try {
                  // look for a color named 'Black' (case-insensitive)
                  for (final c in colors) {
                    final name = c['name']?.toString();
                    if (name != null && name.toLowerCase() == 'black') {
                      chosen = name;
                      break;
                    }
                  }
                } catch (_) {}
                // fallback to first color name
                chosen ??= colors[0]['name']?.toString();
                if (chosen != null && chosen.isNotEmpty) selectedColor.value = chosen;
              }
            } catch (_) {}
            print('ProductCartController: selectedProduct set from details (id=${selectedProduct.value?.id}, name=${selectedProduct.value?.name})');
          }
        } catch (e) {
          print('Eroare la parsarea detaliilor produsului: $e');
        }

        // related products
        try {
          final rel = details['relatedProducts'] as List?;
          if (rel != null) {
            final parsed = rel.map((e) => Product.fromJson(e)).toList();
            relatedProducts.assignAll(parsed);
            print('ProductCartController: parsed ${parsed.length} relatedProducts');
          }
        } catch (e) {
          print('Eroare la parsarea produselor corelate: $e');
        }
      }
    } catch (e) {
      print("Eroare la citirea fișierului JSON: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Selects a product to display in the details page by id.
  /// Prefers the detailed product from `productDetails` when the id matches.
  void selectProductById(String id) {
    if (productDetails.value != null) {
      final pd = productDetails.value!;
      final pdId = (pd['id'] ?? pd['sku'])?.toString() ?? '';
      if (pdId.isNotEmpty && pdId == id) {
        // build Product from productDetails
        try {
          final mainImage = () {
            try {
              final colors = pd['colors'] as List?;
              if (colors != null && colors.isNotEmpty) {
                final imgs = colors[0]['images'] as List?;
                if (imgs != null && imgs.isNotEmpty) return imgs[0] as String;
              }
            } catch (_) {}
            return '';
          }();

          selectedProduct.value = Product(
            id: pdId,
            name: pd['title'] ?? pd['name'] ?? '',
            brand: pd['brand'] ?? '',
            price: (pd['price'] is num) ? (pd['price'] as num).toDouble() : double.tryParse(pd['price']?.toString() ?? '') ?? 0.0,
            oldPrice: null,
            imageUrl: mainImage,
            isNew: pd['isNew'] == true,
            discount: null,
            rating: pd['rating'] != null ? (pd['rating'] as num).toInt() : null,
          );
          return;
        } catch (_) {}
      }
    }

    // fallback: try to find in lists
    final all = [...saleProducts, ...newProducts, ...relatedProducts];
    Product? found;
    try {
      found = all.firstWhere((p) => p.id == id || p.id == id.toString());
    } catch (_) {
      found = null;
    }
    if (found != null) {
      selectedProduct.value = found;
    }
  }

  /// Change the currently selected color (used by ProductOptions + carousel)
  void setSelectedColor(String? colorName) {
    if (colorName == null) return;
    selectedColor.value = colorName;
    print('ProductCartController: selectedColor set to $colorName');
  }
}
