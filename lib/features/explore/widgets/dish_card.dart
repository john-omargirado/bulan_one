import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/placeholder_image.dart';
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
        PlaceholderImage(
          imageUrl: imageUrl,
          width: 130,
          height: 90,
          borderRadius: BorderRadius.circular(12),
        ),
        const SizedBox(height: 6),
        Text(dish.name, style: AppTextStyles.cardTitle.copyWith(fontSize: 12)),
        Text(dish.description, style: AppTextStyles.tiny),
      ],
    );
  }
}
