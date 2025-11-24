import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controllers/product_controller.dart';
import '../../Widget/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildSection(String title, List products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text("View all", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner - show local placeholder first, then switch to network when available
              Obx(() {
                final banner = controller.bannerUrl.value;
                return Container(
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: banner.isNotEmpty
                          ? NetworkImage(banner)
                          : const AssetImage("assets/banner.png") as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Street clothes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Sale Section with its own loader
              Obx(() {
                if (controller.saleLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 280,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                return buildSection("Sale", controller.saleProducts);
              }),

              // New Section with its own loader
              Obx(() {
                if (controller.newLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 280,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
                return buildSection("New", controller.newProducts);
              }),
            ],
          ),
        ),
      ),
    );
  }
}