import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

/// 3-stat card summary row matching ui.html
class QuickStatsRow extends StatelessWidget {
  final VoidCallback? onStatTap;

  const QuickStatsRow({super.key, this.onStatTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          icon: Icons.hiking,
          iconBg: AppColors.navy.withValues(alpha: 0.08),
          iconColor: AppColors.navy,
          value: '12',
          label: 'TREKS DONE',
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          icon: Icons.terrain,
          iconBg: AppColors.gold.withValues(alpha: 0.12),
          iconColor: AppColors.goldDark,
          value: '4,820',
          label: 'MAX ALT (M)',
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          icon: Icons.public,
          iconBg: AppColors.navyAccent.withValues(alpha: 0.08),
          iconColor: AppColors.navyAccent,
          value: '3',
          label: 'COUNTRIES',
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppStyles.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
