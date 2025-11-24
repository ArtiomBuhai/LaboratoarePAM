import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Product_Cart_Controller.dart';

class ProductOptions extends StatefulWidget {
  final List<String>? sizes;
  final List<String>? colors;

  const ProductOptions({super.key, this.sizes, this.colors});

  @override
  State<ProductOptions> createState() => _ProductOptionsState();
}

class _ProductOptionsState extends State<ProductOptions> {
  String? selectedSize;
  // keep favorite locally
  bool isFavorite = false; // 🔴 starea pentru inimioară

  @override
  Widget build(BuildContext context) {
  final cartCtrl = Get.put(ProductCartController());
  final availableSizes = widget.sizes ?? ["S", "M", "L"];
  final availableColors = widget.colors ?? ["Black", "Red", "Blue"];
  final selectedColor = cartCtrl.selectedColor.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Dropdown pentru Size
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Size"),
                  value: selectedSize,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: availableSizes.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Center(
                        child: Text(e, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => selectedSize = val);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 🔹 Dropdown pentru Color
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
                child: DropdownButtonHideUnderline(
                child: Obx(() {
                  final current = cartCtrl.selectedColor.value ?? (availableColors.isNotEmpty ? availableColors[0] : null);
                  return DropdownButton<String>(
                    hint: const Text("Color"),
                    value: current,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: availableColors.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Center(
                          child: Text(e, style: const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      // update the controller selected color
                      setState(() {
                        cartCtrl.setSelectedColor(val);
                      });
                    },
                  );
                })),
            ),
          ),

          const SizedBox(width: 12),

          // ❤️ Inimioara
          Material(
            color: Colors.white,
            elevation: 3,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
