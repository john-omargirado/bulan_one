import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            const Icon(
              Icons.person_outline,
              size: 56,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('No account needed', style: AppTextStyles.cardTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This app works without sign-up. Account features may be added later.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.call_outlined,
                  color: AppColors.primaryNavy,
                ),
                title: Text(
                  'Emergency Hotlines',
                  style: AppTextStyles.cardTitle,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/hotlines'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
