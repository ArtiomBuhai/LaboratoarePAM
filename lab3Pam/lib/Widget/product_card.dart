import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../pages/Produc_Card/product_page.dart';
import '../pages/Produc_Card/Controller/Product_Cart_Controller.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return GestureDetector(
      onTap: () {
        // Request the controller to select the product by id so the details page shows `details.product` when available
        try {
          final cartCtrl = Get.put(ProductCartController());
          cartCtrl.selectProductById(widget.product.id);
        } catch (_) {}

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.product),
          ),
        );
      },

      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagine + badge-uri
                SizedBox(
                  height: 180,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: product.imageUrl.startsWith('http')
                            ? Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : (product.imageUrl.isNotEmpty
                                ? Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    width: double.infinity,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                  )),
                      ),

                      // 🔹 Badge discount + NEW
                      if (product.discount != null || product.isNew)
                        Positioned(
                          left: 8,
                          top: 8,
                          child: Row(
                            children: [
                              if (product.discount != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-${product.discount!.toInt()}%",
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),

                              if (product.discount != null && product.isNew)
                                const SizedBox(width: 4), // 🔸 mic spațiu între ele

                              if (product.isNew)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),




                      // Inimioara (Favorite) - floating colț jos-dreapta
                      Positioned(
                        bottom: -16, // jumătate din înălțimea cercului
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Material(
                            elevation: 4,
                            shape: const CircleBorder(),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ⭐️ RATING STARS
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (product.rating?.round() ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    );
                  }),
                ),

                const SizedBox(height: 6),

                // Text și prețuri într-un Flexible pentru a evita overflow
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nume produs
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Brand
                      Text(
                        product.brand,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Preturi
                      Row(
                        children: [
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (product.oldPrice != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              "\$${product.oldPrice}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
