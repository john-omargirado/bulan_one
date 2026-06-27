import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/hotline.dart';
import '../../providers/hotline_provider.dart';
import '../../shared/widgets/page_hero_banner.dart';

class HotlinesScreen extends StatelessWidget {
  const HotlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const PageHeroBanner(
              title: 'Emergency Hotlines',
              subtitle: 'Tap any number to call directly.',
              imageSeed: 'bulan-hotlines-hero',
              showBackButton: true,
            ),
            Expanded(
              child: Consumer<HotlineProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.hotlines.isEmpty) {
                    return Center(
                      child: Text(
                        'No hotlines added yet.',
                        style: AppTextStyles.caption,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: provider.hotlines.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      return _HotlineTile(hotline: provider.hotlines[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HotlineTile extends StatelessWidget {
  final Hotline hotline;

  const _HotlineTile({required this.hotline});

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: hotline.number);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.tileRed,
          child: Icon(Icons.phone, color: Colors.red),
        ),
        title: Text(hotline.name, style: AppTextStyles.cardTitle),
        subtitle: Text(hotline.number, style: AppTextStyles.caption),
        trailing: const Icon(Icons.call, color: AppColors.primaryNavy),
        onTap: _call,
      ),
    );
  }
}
