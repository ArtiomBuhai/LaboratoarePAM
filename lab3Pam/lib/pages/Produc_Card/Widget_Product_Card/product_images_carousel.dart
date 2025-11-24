import 'package:flutter/material.dart';

class ProductImagesCarousel extends StatelessWidget {
  final List<String> images;

  const ProductImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // înălțime fixă
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: images.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.white,
                  width: 250, // lățimea imaginii
                  child: images[index].toString().startsWith('http')
                      ? Image.network(
                          images[index],
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )
                      : Image.asset(
                          images[index],
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                ),
              );
        },
      ),
    );
  }
}
