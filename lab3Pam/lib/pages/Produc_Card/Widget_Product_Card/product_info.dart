import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String brand;
  final String price;

  const ProductInfo({super.key, required this.brand, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(brand, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 18),
              Icon(Icons.star, color: Colors.amber, size: 18),
              Icon(Icons.star, color: Colors.amber, size: 18),
              Icon(Icons.star, color: Colors.amber, size: 18),
              Icon(Icons.star_half, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Text("(10)", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
