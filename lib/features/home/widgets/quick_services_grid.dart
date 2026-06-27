import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

enum _Dest { services, transportCategory, transportMap, comingSoon }

class QuickServicesGrid extends StatelessWidget {
  const QuickServicesGrid({super.key});

  static const _items = [
    (
      Icons.description_outlined,
      'Documents',
      AppColors.tileBlue,
      AppColors.iconBlue,
      _Dest.services,
    ),
    (
      Icons.apartment,
      'LGU Services',
      AppColors.tileGreen,
      AppColors.iconGreen,
      _Dest.services,
    ),
    (
      Icons.receipt_long,
      'Pay Bills',
      AppColors.tileAmber,
      AppColors.iconAmber,
      _Dest.comingSoon,
    ),
    (
      Icons.event_available,
      'Book Appointment',
      AppColors.tilePurple,
      AppColors.iconPurple,
      _Dest.services,
    ),
    (
      Icons.directions_bus,
      'Trips & Transport',
      AppColors.tileBlue,
      AppColors.iconBlue,
      _Dest.transportCategory,
    ),
    (
      Icons.receipt,
      'Taxes',
      AppColors.tileRed,
      AppColors.iconRed,
      _Dest.comingSoon,
    ),
    (
      Icons.local_hospital_outlined,
      'Health Services',
      AppColors.tileGreen,
      AppColors.iconGreen,
      _Dest.comingSoon,
    ),
    (
      Icons.school_outlined,
      'Scholarship',
      AppColors.tileAmber,
      AppColors.iconAmber,
      _Dest.comingSoon,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final (icon, label, bgColor, iconColor, dest) = _items[index];
        return GestureDetector(
          onTap: () {
            switch (dest) {
              case _Dest.services:
                context.go('/services');
              case _Dest.transportCategory:
                context.push('/services/transport');
              case _Dest.transportMap:
                context.push('/services/transport');
              case _Dest.comingSoon:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$label is coming soon')),
                );
            }
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: bgColor,
                child: Icon(icon, color: iconColor),
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
