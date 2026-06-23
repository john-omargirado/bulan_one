import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/announcement_provider.dart';
import 'widgets/hero_banner.dart';
import 'widgets/emergency_hotline_card.dart';
import 'widgets/quick_services_grid.dart';
import 'widgets/announcement_card.dart';
import 'widgets/featured_banner_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroBanner(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmergencyHotlineCard(
                      onTap: () => context.push('/hotlines'),
                    ),
                    const SizedBox(height: 24),
                    const QuickServicesGrid(),
                    const SizedBox(height: 24),
                    const FeaturedBannerCard(),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      title: 'Latest Announcements',
                      onViewAll: () =>
                          context.go('/home'), // placeholder target
                    ),
                    const SizedBox(height: 12),
                    const _AnnouncementsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        GestureDetector(
          onTap: onViewAll,
          child: const Row(
            children: [
              Text('View All', style: TextStyle(color: AppColors.primaryNavy)),
              Icon(Icons.chevron_right, size: 18, color: AppColors.primaryNavy),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnnouncementsList extends StatelessWidget {
  const _AnnouncementsList();

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnouncementProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.announcements.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No announcements yet.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        // Show at most 2 on Home — matches mockup density.
        final items = provider.announcements.take(2).toList();

        return Column(
          children: items
              .map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnnouncementCard(announcement: a),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
