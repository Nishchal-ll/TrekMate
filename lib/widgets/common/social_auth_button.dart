import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

enum SocialType { google, facebook }

/// Social authentication button (Google / Facebook) matching ui.html
class SocialAuthButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback onTap;

  const SocialAuthButton({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isGoogle = type == SocialType.google;
    final label = isGoogle ? 'Google' : 'Facebook';
    final iconColor = isGoogle ? const Color(0xFFEA4335) : const Color(0xFF1877F2);
    final iconData = isGoogle ? Icons.g_mobiledata : Icons.facebook;

    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          backgroundColor: AppColors.inputBg,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: iconColor, size: isGoogle ? 24 : 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
