import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text style scale. Every Text widget in the app should
/// reference one of these rather than constructing a raw TextStyle —
/// keeps font sizes/weights consistent across every screen.
class AppTextStyles {
  AppTextStyles._();

  // Page-level headers, e.g. "Explore Bulan", "Mabuhay!"
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Section headers, e.g. "Featured Destinations", "Popular Services"
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Card titles, list item titles
  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Standard body copy
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // Secondary/supporting text, descriptions
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  // Smallest text — badges, timestamps, fine print
  static const TextStyle tiny = TextStyle(
    fontSize: 10,
    color: AppColors.textSecondary,
  );

  // Emphasized small text, e.g. status badges
  static const TextStyle tinyBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}
