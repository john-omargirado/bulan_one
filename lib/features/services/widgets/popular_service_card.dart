import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/service_item.dart';
import 'service_icon.dart';

class PopularServiceCard extends StatelessWidget {
  final ServiceItem service;
  final VoidCallback onTap;

  const PopularServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.tileBlue,
              child: Icon(
                serviceIconFor(service.icon),
                color: AppColors.primaryNavy,
                size: 20,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              service.name,
              style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              service.description,
              style: AppTextStyles.tiny,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
