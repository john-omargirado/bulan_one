import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class EmergencyHotlineCard extends StatelessWidget {
  final VoidCallback onTap;

  const EmergencyHotlineCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.call, color: Colors.white, size: 22),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Hotline',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tap to call our 24/7 hotlines',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.red.shade700),
            ],
          ),
        ),
      ),
    );
  }
}
