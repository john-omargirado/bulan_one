import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class QuickServicesGrid extends StatelessWidget {
  const QuickServicesGrid({super.key});

  static const _items = [
    (Icons.description_outlined, 'Documents', AppColors.tileBlue, true),
    (Icons.apartment, 'LGU Services', AppColors.tileGreen, true),
    (Icons.receipt_long, 'Pay Bills', AppColors.tileAmber, false),
    (Icons.event_available, 'Book Appointment', AppColors.tilePurple, true),
    (Icons.directions_bus, 'Trips & Transport', AppColors.tileBlue, false),
    (Icons.receipt, 'Taxes', AppColors.tileRed, false),
    (
      Icons.local_hospital_outlined,
      'Health Services',
      AppColors.tileGreen,
      false,
    ),
    (Icons.school_outlined, 'Scholarship', AppColors.tileAmber, false),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final (icon, label, color, isReady) = _items[index];
        return GestureDetector(
          onTap: () {
            if (isReady) {
              context.go('/services');
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$label is coming soon')));
            }
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color,
                child: Icon(icon, color: AppColors.primaryNavy),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
