import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

enum SocialType { google, facebook }

/// Social authentication button with authentic Google and Facebook branding
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

    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: AppColors.inputBg,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGoogle ? _buildGoogleIcon() : _buildFacebookIcon(),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 18,
      height: 18,
      child: CustomPaint(
        painter: _GoogleIconPainter(),
      ),
    );
  }

  Widget _buildFacebookIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'sans-serif',
          ),
        ),
      ),
    );
  }
}

/// Draws the official Google 4-color "G" logo
class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    // Red arc (top)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2.4,
      1.6,
      true,
      redPaint,
    );

    // Yellow arc (left)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -4.0,
      1.6,
      true,
      yellowPaint,
    );

    // Green arc (bottom)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.8,
      1.6,
      true,
      greenPaint,
    );

    // Blue arc & horizontal bar (right & crossbar)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.8,
      1.6,
      true,
      bluePaint,
    );

    // Inner cutout
    final innerPaint = Paint()
      ..color = AppColors.inputBg
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.55, innerPaint);

    // Blue horizontal bar
    final barRect = Rect.fromLTRB(
      center.dx,
      center.dy - radius * 0.22,
      w,
      center.dy + radius * 0.22,
    );
    canvas.drawRect(barRect, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
