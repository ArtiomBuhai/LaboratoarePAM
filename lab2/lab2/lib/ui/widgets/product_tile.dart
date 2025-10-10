import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'price_tag.dart';
import 'rating_stars.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final badge = product.discountPercent > 0
        ? '-${product.discountPercent}%'
        : (product.isNew ? 'NEW' : null);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      product.images.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: product.discountPercent > 0
                            ? const Color(0xFFE53935)
                            : Colors.black87,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            RatingStars(rating: product.rating, size: 14),
            const SizedBox(height: 4),
            PriceTag(price: product.price, oldPrice: product.oldPrice),
          ],
        ),
      ),
    );
  }
}
