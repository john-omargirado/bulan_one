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
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.tileBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  serviceIconFor(service.icon),
                  color: AppColors.primaryNavy,
                  size: 18,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                service.name,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                service.description,
                style: AppTextStyles.tiny,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (service.isInfoOnly) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 10,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Info only',
                      style: AppTextStyles.tiny.copyWith(fontSize: 9),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
