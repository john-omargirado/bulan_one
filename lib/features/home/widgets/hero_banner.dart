import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Top hero banner with background image + gradient overlay.
///
/// NOTE: heroImageUrl below is a placeholder (Lorem Picsum).
/// Replace with a real, rights-cleared photo of Bulan before
/// presenting to the LGU — e.g. host it in Firebase Storage and
/// swap this URL for that download link.
class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  static const String heroImageUrl =
      'https://picsum.photos/seed/bulan-coast/800/500';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(heroImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // Gradient overlay so white text stays legible over any photo.
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
                    Icon(Icons.location_on, color: Colors.white70, size: 16),
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
    );
  }
}
