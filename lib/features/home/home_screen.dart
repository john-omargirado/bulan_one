import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/announcement_provider.dart';
import 'widgets/hero_banner.dart';
import 'widgets/emergency_hotline_card.dart';
import 'widgets/quick_services_grid.dart';
import 'widgets/featured_banner_card.dart';
import 'widgets/announcement_card.dart';
import '../explore/models/destination.dart';
import '../explore/widgets/destination_card.dart';

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
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmergencyHotlineCard(
                      onTap: () => context.push('/hotlines'),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const QuickServicesGrid(),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionHeader(
                      title: 'Explore Bulan',
                      onViewAll: () => context.go('/explore'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: bulanDestinations.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.md),
                        itemBuilder: (context, i) =>
                            DestinationCard(destination: bulanDestinations[i]),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    const FeaturedBannerCard(),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionHeader(
                      title: 'Latest Announcements',
                      onViewAll: () => context.go('/home'),
                    ),
                    const SizedBox(height: AppSpacing.md),
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
        Text(title, style: AppTextStyles.sectionTitle),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                'View All',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.primaryNavy,
              ),
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
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.announcements.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Text('No announcements yet.', style: AppTextStyles.caption),
          );
        }

        final items = provider.announcements.take(2).toList();

        return Column(
          children: items
              .map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: AnnouncementCard(announcement: a),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
