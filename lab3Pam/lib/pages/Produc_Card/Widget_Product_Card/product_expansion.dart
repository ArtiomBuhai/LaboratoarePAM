import 'package:flutter/material.dart';

class ProductExpansion extends StatelessWidget {
  final String? deliveryInfo;
  final String? returnsInfo;
  final String? supportContact;

  const ProductExpansion({super.key, this.deliveryInfo, this.returnsInfo, this.supportContact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ExpansionTile(
          title: const Text("Shipping info"),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(deliveryInfo ?? returnsInfo ?? "Free shipping for orders over \$50"),
            )
          ],
        ),
        ExpansionTile(
          title: const Text("Support"),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(supportContact ?? "Contact us at support@example.com"),
            )
          ],
        ),
      ],
    );
  }
}
