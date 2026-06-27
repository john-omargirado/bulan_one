import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryNavy = Color(0xFF0B2C6B);
  static const Color primaryNavyDark = Color(0xFF071D47);
  static const Color accentGold = Color(0xFFF4B400);

  static const Color background = Color(0xFFF7F7F8);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);

  static const Color statusSubmitted = Color(0xFF6B6B6B);
  static const Color statusInProgress = Color(0xFFF4B400);
  static const Color statusResolved = Color(0xFF2E7D32);

  static const Color tileBlue = Color(0xFFE6F0FB);
  static const Color tileGreen = Color(0xFFE3F3E9);
  static const Color tileAmber = Color(0xFFFCF1DC);
  static const Color tilePurple = Color(0xFFF0EAF9);
  static const Color tileRed = Color(0xFFFBE7E7);

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
