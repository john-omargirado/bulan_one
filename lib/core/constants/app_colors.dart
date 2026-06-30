import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand blue (updated). Name kept as `primaryNavy` to avoid
  // a project-wide rename of every AppColors.primaryNavy reference \u2014
  // the identifier stays, the actual color value is the new brand blue.
  static const Color primaryNavy = Color(0xFF0318DC);
  static const Color primaryNavyDark = Color(0xFF021090);
  static const Color accentGold = Color(0xFFFCB20F);

  // New secondary accent blue. Lighter than primary \u2014 use for icon
  // tints, borders, or backgrounds with dark text. Avoid white text
  // directly on a solid secondaryBlue fill; contrast is borderline.
  static const Color secondaryBlue = Color(0xFF0081EF);

  static const Color background = Color(0xFFF1F2F4);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);

  static const Color statusSubmitted = Color(0xFF6B6B6B);
  static const Color statusInProgress = Color(0xFFFCB20F);
  static const Color statusResolved = Color(0xFF2E7D32);

  static const Color tileBlue = Color(0xFFCFE3FA);
  static const Color tileGreen = Color(0xFFC8EBDA);
  static const Color tileAmber = Color(0xFFFAE4B8);
  static const Color tilePurple = Color(0xFFDED0F0);
  static const Color tileRed = Color(0xFFF8CACA);

  static const Color iconBlue = Color(0xFF1E88E5);
  static const Color iconGreen = Color(0xFF00897B);
  static const Color iconAmber = Color(0xFFF9A825);
  static const Color iconPurple = Color(0xFF7E57C2);
  static const Color iconRed = Color(0xFFE53935);

  /// Semantic category colors — one consistent mapping used everywhere
  /// a category appears (Services, Reports, Explore), so the same
  /// category always reads the same color across the whole app.
  static Color categoryColor(String category) {
    switch (category) {
      case 'Government Services':
      case 'flooding':
      case 'road':
        return primaryNavy;
      case 'Health Services':
      case 'medical':
        return const Color(
          0xFFD32F2F,
        ); // health = red, distinct from emergency-red usage above by context
      case 'Education Services':
        return const Color(0xFF7B1FA2); // purple
      case 'Transport & Travel':
        return const Color(0xFF1565C0); // blue
      case 'Disaster & Safety':
      case 'emergency':
        return const Color(
          0xFFE65100,
        ); // orange — urgency without being literal red
      default:
        return primaryNavy;
    }
  }

  static Color categoryTileColor(String category) {
    return categoryColor(category).withValues(alpha: 0.12);
  }
}
