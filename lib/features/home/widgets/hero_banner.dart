import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/notification_provider.dart';
import '../notifications_screen.dart';

/// Top hero banner with background image + gradient overlay.
///
/// NOTE: heroImageUrl below is a placeholder (Lorem Picsum).
/// Replace with a real, rights-cleared photo of Bulan before
/// presenting to the LGU — e.g. host it in Firebase Storage and
/// swap this URL for that download link. The "SAMPLE PHOTO" badge
/// signals this is not yet a real photo; remove it once replaced.
class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  static const String heroImageUrl =
      'https://picsum.photos/seed/bulan-coast/800/500';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(
        children: [
          // Background image + gradient overlay (the original Container)
          Container(
            width: double.infinity,
            height: 220,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(heroImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryNavy.withValues(alpha: 0.85),
                    AppColors.primaryNavyDark.withValues(alpha: 0.55),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.nightlight_round,
                            color: AppColors.accentGold,
                            size: 22,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'BULAN ONE APP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Mabuhay!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Bulan, Sorsogon',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // SAMPLE PHOTO badge — sibling of the background Container above,
          // not nested inside it, so it sits on top regardless of the
          // gradient/content layers underneath.
          Positioned(
            top: 12,
            right: 12,
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
                          top: 6,
                          right: 6,
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
