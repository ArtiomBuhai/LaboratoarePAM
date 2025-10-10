import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'price_tag.dart';
import 'rating_stars.dart';

class ProductCardSmall extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCardSmall({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            RatingStars(rating: product.rating, size: 12),
            const SizedBox(height: 2),
            PriceTag(price: product.price, oldPrice: product.oldPrice),
          ],
        ),
      ),
    );
  }
}
