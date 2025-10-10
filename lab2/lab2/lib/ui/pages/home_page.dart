import 'package:flutter/material.dart';
import '../../data/mock_products.dart';
import '../../routes/app_router.dart';
import '../widgets/section_header.dart';
import '../widgets/product_tile.dart';
import '../widgets/product_card_small.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sale = saleProducts();
    final fresh = newProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Street clothes'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // Banner
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 7,
                  child: Image.asset(
                    'assets/images/1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    'Sale',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader(title: 'Street Clothes', onSeeAll: () {}),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sale.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => ProductTile(
                product: sale[i],
                onTap: () => Navigator.pushNamed(context, AppRoutes.product, arguments: sale[i].id),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SectionHeader(title: 'New', onSeeAll: () {}),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: fresh.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => ProductCardSmall(
                product: fresh[i],
                onTap: () => Navigator.pushNamed(context, AppRoutes.product, arguments: fresh[i].id),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Likes'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
