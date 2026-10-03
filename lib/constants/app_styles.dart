import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography and text styles for Celtic Trekking
class AppStyles {
  // Serif Headings (Playfair Display style)
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'serif',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    letterSpacing: 0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'serif',
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'serif',
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
  );

  static const TextStyle brandLogo = TextStyle(
    fontFamily: 'serif',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 1.5,
  );

  // Body & Subtitle styles
  static const TextStyle subtitle = TextStyle(
    fontSize: 13,
    color: AppColors.muted,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.bodyText,
    letterSpacing: 1.0,
  );

  static const TextStyle input = TextStyle(
    fontSize: 14,
    color: AppColors.darkText,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  // Box shadows
  static List<BoxShadow> softShadow = [
    const BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> floatingShadow = [
    BoxShadow(
      color: AppColors.navy.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];
}
