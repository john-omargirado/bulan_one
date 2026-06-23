import 'package:flutter/material.dart';
import '../models/destination.dart';

class DishCard extends StatelessWidget {
  final LocalDish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://picsum.photos/seed/${dish.imageSeed}/200/150';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: 130,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          dish.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        Text(
          dish.description,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
