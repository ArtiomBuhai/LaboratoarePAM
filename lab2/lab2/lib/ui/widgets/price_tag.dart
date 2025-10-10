import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double? oldPrice;

  const PriceTag({super.key, required this.price, this.oldPrice});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Row(
      children: [
        Text('\$${price.toStringAsFixed(2)}',
            style: style.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        if (oldPrice != null) ...[
          const SizedBox(width: 8),
          Text('\$${oldPrice!.toStringAsFixed(0)}',
              style: style.bodyMedium?.copyWith(
                color: Colors.black45,
                decoration: TextDecoration.lineThrough,
              )),
        ],
      ],
    );
  }
}
