import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class QuickServicesGrid extends StatelessWidget {
  const QuickServicesGrid({super.key});

  static const _items = [
    (Icons.description_outlined, 'Documents', AppColors.tileBlue),
    (Icons.apartment, 'LGU Services', AppColors.tileGreen),
    (Icons.receipt_long, 'Pay Bills', AppColors.tileAmber),
    (Icons.event_available, 'Book Appointment', AppColors.tilePurple),
    (Icons.directions_bus, 'Trips & Transport', AppColors.tileBlue),
    (Icons.receipt, 'Taxes', AppColors.tileRed),
    (Icons.local_hospital_outlined, 'Health Services', AppColors.tileGreen),
    (Icons.school_outlined, 'Scholarship', AppColors.tileAmber),
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
        final (icon, label, color) = _items[index];
        return GestureDetector(
          onTap: () => context.go('/services'),
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
