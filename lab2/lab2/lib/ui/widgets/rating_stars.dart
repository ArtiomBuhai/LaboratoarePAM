import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;
  final int max;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 14,
    this.color,
    this.max = 5,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.amber;
    final full = rating.floor();
    final half = (rating - full) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        IconData icon;
        if (i < full) {
          icon = Icons.star;
        } else if (i == full && half) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, size: size, color: effectiveColor);
      }),
    );
  }
}
