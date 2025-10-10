import 'package:flutter/material.dart';

class SizeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const SizeChip({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class ColorChipDot extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const ColorChipDot({super.key, required this.name, required this.selected, required this.onTap});

  Color _map(String name) {
    switch (name.toLowerCase()) {
      case 'black':
        return const Color(0xFF111111);
      case 'white':
        return const Color(0xFFEDEDED);
      case 'red':
        return const Color(0xFFE53935);
      case 'grey':
        return const Color(0xFF9E9E9E);
      case 'pink':
        return const Color(0xFFF48FB1);
      default:
        return const Color(0xFFBDBDBD);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _map(name);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : Colors.black12,
            width: selected ? 2 : 1,
          ),
        ),
      ),
    );
  }
}
