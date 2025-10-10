import 'package:flutter/material.dart';
import '../../data/mock_products.dart';
import '../../models/product.dart';
import '../widgets/chips.dart';
import '../widgets/price_tag.dart';
import '../widgets/rating_stars.dart';
import '../widgets/product_card_small.dart';
import '../../routes/app_router.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final Product product;
  int imageIndex = 0;
  String? selectedColor;
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    product = byId(widget.productId);
    selectedColor = product.colors.isNotEmpty ? product.colors.first : null;
    selectedSize = product.sizes.isNotEmpty ? product.sizes.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final also = allProducts.where((p) => p.id != product.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 420,
            child: PageView.builder(
              itemCount: product.images.length,
              onPageChanged: (i) => setState(() => imageIndex = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(product.images[i], fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              product.images.length,
              (i) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == imageIndex ? Colors.black87 : Colors.black26,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingStars(rating: product.rating, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '(${product.reviewsCount})',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PriceTag(price: product.price, oldPrice: product.oldPrice),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (product.sizes.isNotEmpty) ...[
                  const Text(
                    'Size:',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  ...product.sizes.map(
                    (s) => SizeChip(
                      label: s,
                      selected: s == selectedSize,
                      onTap: () => setState(() => selectedSize = s),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (product.colors.isNotEmpty) ...[
                  const Text(
                    'Color:',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  ...product.colors.map(
                    (c) => ColorChipDot(
                      name: c,
                      selected: c == selectedColor,
                      onTap: () => setState(() => selectedColor = c),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(product.description),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // change button color to red
                foregroundColor: Colors.white, // text color
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added to cart: ${product.title} — $selectedSize, $selectedColor',
                    ),
                  ),
                );
              },
              child: const Text('ADD TO CART'),
            ),
          ),
 
          const SizedBox(height: 8),
          const Divider(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpansionTile(
              title: const Text('Shipping info'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Standard delivery 3–5 days. Free over \$50.'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpansionTile(
              title: const Text('Support'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('30-day returns. Contact support@example.com'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'You can also like this',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: also.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => ProductCardSmall(
                product: also[i],
                onTap: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.product,
                  arguments: also[i].id,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
