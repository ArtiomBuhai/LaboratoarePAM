import 'package:flutter/material.dart';

class AddToCartSection extends StatelessWidget {
  final VoidCallback onAddToCart;

  const AddToCartSection({
    super.key,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // fundal alb
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // buton roșu
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onAddToCart,
          child: const Text(
            "ADD TO CART",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
