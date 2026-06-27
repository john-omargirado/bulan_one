import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../features/home/notifications_screen.dart';
import '../../providers/notification_provider.dart';

/// Shared photo-backed header used across multiple screens (Explore,
/// Services, Report, Profile, Hotlines, My Requests), matching the
/// style of Home's hero banner. NOTE: imageUrl is a placeholder
/// (Lorem Picsum) \u2014 replace with a real photo before presenting.
class PageHeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageSeed;
  final bool showBackButton;

  const PageHeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageSeed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://picsum.photos/seed/$imageSeed/800/400';

    return SizedBox(
      width: double.infinity,
      height: 170,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryNavy.withValues(alpha: 0.9),
                    AppColors.primaryNavyDark.withValues(alpha: 0.6),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back button \u2014 only shown on screens reached via tap-through
          // (Hotlines, My Requests), not on bottom-nav tab roots.
          if (showBackButton)
            Positioned(
              top: 4,
              left: 4,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

          // SAMPLE PHOTO badge \u2014 same convention as Home's hero.
          Positioned(
            top: showBackButton ? 52 : 8,
            left: 8,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SAMPLE PHOTO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Notification bell, same pattern as Home's hero.
          Positioned(
            top: 4,
            right: 4,
            child: SafeArea(
              child: Consumer<NotificationProvider>(
                builder: (context, provider, _) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const NotificationsScreen(),
                          ),
                        ),
                      ),
                      if (provider.unreadCount > 0)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${provider.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
