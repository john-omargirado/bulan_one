import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
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
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          category.description,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.tileBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${category.serviceCount} Services',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
