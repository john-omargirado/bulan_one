import 'package:flutter/material.dart';

/// Central color palette matching the Bulan One App brand.
/// Never hardcode a hex value in a screen file — add it here first.
class AppColors {
  AppColors._();

  static const Color primaryNavy = Color(0xFF0B2C6B);
  static const Color primaryNavyDark = Color(0xFF071D47);
  static const Color accentGold = Color(0xFFF4B400);

  static const Color background = Color(0xFFF7F7F8);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);

  // Status colors for report tracking
  static const Color statusSubmitted = Color(0xFF6B6B6B);
  static const Color statusInProgress = Color(0xFFF4B400);
  static const Color statusResolved = Color(0xFF2E7D32);

  // Quick-service tile icon backgrounds (from mockup grid)
  static const Color tileBlue = Color(0xFFE6F0FB);
  static const Color tileGreen = Color(0xFFE3F3E9);
  static const Color tileAmber = Color(0xFFFCF1DC);
  static const Color tilePurple = Color(0xFFF0EAF9);
  static const Color tileRed = Color(0xFFFBE7E7);
}
