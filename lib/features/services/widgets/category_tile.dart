import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/service_item.dart';
import 'service_icon.dart';

class CategoryTile extends StatelessWidget {
  final ServiceCategory category;
  final VoidCallback onTap;

  const CategoryTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.tileBlue,
          child: Icon(
            serviceIconFor(category.icon),
            color: AppColors.primaryNavy,
          ),
        ),
        title: Text(category.name, style: AppTextStyles.cardTitle),
        subtitle: Text(category.description, style: AppTextStyles.caption),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.tileBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${category.serviceCount} Services',
            style: AppTextStyles.tinyBold.copyWith(
              color: AppColors.primaryNavy,
            ),
          ),
        ),
      ),
    );
  }
}
