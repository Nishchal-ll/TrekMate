import 'package:flutter/material.dart';

/// Design tokens and colors for Celtic Trekking
/// Matched precisely with Celtic-Trekking web codebase (css/layout.css & home.css)
class AppColors {
  // Signature Celtic Midnight Navy & Blues
  static const Color navy = Color(0xFF011231);         // Midnight Navy (Header & Brand)
  static const Color navyMid = Color(0xFF071C45);      // Mid Navy
  static const Color navyLight = Color(0xFF0F3272);    // Navy Accent
  static const Color navySoft = Color(0xFF1E50BC);     // Soft Royal

  // Primary Action & Button Blues
  static const Color primaryBlue = Color(0xFF1E70BF);   // Celtic Trekking Primary Blue
  static const Color buttonBlue = Color(0xFF3B82F6);    // Interactive Button Blue
  static const Color buttonBlueDark = Color(0xFF1E70BF);// Button gradient end
  static const Color buttonBlueLight = Color(0xFF60A5FA);// Light blue highlight

  // Gold & Amber Accents (Ratings, badges, highlights)
  static const Color gold = Color(0xFFD97706);          // Warm Amber Gold
  static const Color goldLight = Color(0xFFFBBF24);     // Light Gold
  static const Color goldDark = Color(0xFFB45309);      // Deep Amber

  // Neutrals & Backgrounds (Slate palette)
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8FAFC);      // Slate 50 background
  static const Color blueGray = Color(0xFFE2E8F0);      // Slate 200
  static const Color inputBg = Color(0xFFF1F5F9);       // Slate 100
  static const Color border = Color(0xFFE2E8F0);        // Card & input border

  // Typography Colors
  static const Color darkText = Color(0xFF0F172A);      // Slate 900 (Main Headings)
  static const Color bodyText = Color(0xFF334155);      // Slate 700 (Body text)
  static const Color muted = Color(0xFF64748B);         // Slate 500 (Subtitles & icons)
  static const Color subtle = Color(0xFF94A3B8);        // Slate 400

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Shadows
  static const Color cardShadow = Color(0x0D011231);
}
