import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/product_images_carousel.dart';
import '../Widgets/product_options.dart';
import '../Widgets/product_info.dart';
import '../Widgets/product_description.dart';
import '../Widgets/add_to_cart_section.dart';
import '../Widgets/product_expansion.dart';
import '../Widgets/product_recommendations.dart';
import '../../Domain/Entities/product.dart';
import '../Controllers/product_cart_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductCartController());
    return Obx(() {
      final displayProduct = controller.selectedProduct.value ?? product;

      // Compose images list from product details (only images for the selected color)
      final images = <String>[];
      final details = controller.productDetails.value;
      final selectedColorName = controller.selectedColor.value;

      if (details != null) {
        try {
          final colors = details['colors'] as List?;
          if (colors != null && colors.isNotEmpty) {
            Map<String, dynamic>? matched;
            if (selectedColorName != null && selectedColorName.isNotEmpty) {
              for (final c in colors) {
                final name = c['name']?.toString();
                if (name != null && name.toLowerCase() == selectedColorName.toLowerCase()) {
                  matched = Map<String, dynamic>.from(c as Map);
                  break;
                }
              }
            }
            matched ??= Map<String, dynamic>.from(colors[0] as Map);

            final imgs = (matched['images'] as List?) ?? [];
            for (final im in imgs) {
              if (im != null && im.toString().isNotEmpty) images.add(im.toString());
            }
          }
        } catch (_) {}
      }

      if (images.isEmpty && displayProduct.imageUrl.isNotEmpty) images.add(displayProduct.imageUrl);

      // Extract sizes, colors, description, shipping info
      List<String>? sizes;
      List<String>? colorNames;
      String? description;
      String? deliveryInfo;
      String? returnsInfo;
      String? supportContact;

      if (details != null) {
        try {
          final s = details['sizes'] as List?;
          if (s != null) sizes = s.map((e) => e.toString()).toList();

          final colors = details['colors'] as List?;
          if (colors != null) colorNames = colors.map((c) => c['name']?.toString() ?? '').where((n) => n.isNotEmpty).toList();

          description = details['description']?.toString() ?? details['title']?.toString();

          final shipping = details['shippingInfo'] as Map<String, dynamic>?;
          if (shipping != null) {
            deliveryInfo = shipping['delivery']?.toString();
            returnsInfo = shipping['returns']?.toString();
          }

          final support = details['support'] as Map<String, dynamic>?;
          if (support != null) supportContact = support['contactEmail']?.toString();
        } catch (_) {}
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(displayProduct.name, style: const TextStyle(color: Colors.black)),
          actions: [
            IconButton(icon: const Icon(Icons.share, color: Colors.black), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.black), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImagesCarousel(images: images.isNotEmpty ? images : ['assets/1.png']),
              const SizedBox(height: 16),
              ProductOptions(sizes: sizes, colors: colorNames),
              const SizedBox(height: 16),
              ProductInfo(brand: displayProduct.brand, price: "\$${displayProduct.price}"),
              ProductDescription(
                description: description ?? displayProduct.name,
              ),
              AddToCartSection(onAddToCart: () {}),
              const SizedBox(height: 8),
              ProductExpansion(
                deliveryInfo: deliveryInfo,
                returnsInfo: returnsInfo,
                supportContact: supportContact,
              ),
              const SizedBox(height: 8),
              Obx(() => ProductRecommendations(products: controller.relatedProducts.toList())),
            ],
          ),
        ),
      );
    });
  }
}
