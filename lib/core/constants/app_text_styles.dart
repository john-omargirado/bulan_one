import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headline => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardTitle => GoogleFonts.publicSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get body =>
      GoogleFonts.publicSans(fontSize: 14, color: AppColors.textPrimary);

  static TextStyle get caption =>
      GoogleFonts.publicSans(fontSize: 12, color: AppColors.textSecondary);

  static TextStyle get tiny =>
      GoogleFonts.publicSans(fontSize: 10, color: AppColors.textSecondary);

  static TextStyle get tinyBold =>
      GoogleFonts.publicSans(fontSize: 10, fontWeight: FontWeight.w600);
}
