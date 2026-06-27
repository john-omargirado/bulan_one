import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/page_hero_banner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeroBanner(
                title: 'Profile',
                subtitle: 'No account needed \u2014 quick access and app info.',
                imageSeed: 'bulan-profile-hero',
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quick Access', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: AppSpacing.sm),

                    _ProfileTile(
                      icon: Icons.call_outlined,
                      iconColor: Colors.red.shade700,
                      iconBg: AppColors.tileRed,
                      title: 'Emergency Hotlines',
                      subtitle: 'Tap to call our 24/7 hotlines',
                      onTap: () => context.push('/hotlines'),
                    ),
                    _ProfileTile(
                      icon: Icons.campaign_outlined,
                      iconColor: AppColors.primaryNavy,
                      iconBg: AppColors.tileBlue,
                      title: 'My Reports',
                      subtitle: 'Track issues you\u2019ve submitted',
                      onTap: () => context.go('/report'),
                    ),
                    _ProfileTile(
                      icon: Icons.assignment_outlined,
                      iconColor: AppColors.iconGreen,
                      iconBg: AppColors.tileGreen,
                      title: 'My Requests',
                      subtitle: 'Track service requests you\u2019ve submitted',
                      onTap: () => context.push('/services/my-requests'),
                    ),

                    const SizedBox(height: AppSpacing.xl),
                    Text('About', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: AppSpacing.sm),

                    _ProfileTile(
                      icon: Icons.info_outline,
                      iconColor: AppColors.iconAmber,
                      iconBg: AppColors.tileAmber,
                      title: 'About Bulan One App',
                      subtitle: 'No sign-up required to use this app',
                      onTap: () => _showAboutSheet(context),
                    ),
                    _ProfileTile(
                      icon: Icons.feedback_outlined,
                      iconColor: AppColors.iconPurple,
                      iconBg: AppColors.tilePurple,
                      title: 'Send Feedback',
                      subtitle: 'Help us improve this app',
                      onTap: () => _sendFeedbackEmail(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bulan One App', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'An all-in-one civic app for Bulan, Sorsogon. Report issues, '
              'request services, browse local destinations, and stay updated '
              'on municipal announcements \u2014 no sign-up required.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Version 0.1.0', style: AppTextStyles.tiny),
          ],
        ),
      ),
    );
  }

  Future<void> _sendFeedbackEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'feedback@example.com', // PLACEHOLDER - replace with a real address
      query: 'subject=Bulan One App Feedback',
    );
    await launchUrl(uri);
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor),
          ),
          title: Text(title, style: AppTextStyles.cardTitle),
          subtitle: Text(subtitle, style: AppTextStyles.caption),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
