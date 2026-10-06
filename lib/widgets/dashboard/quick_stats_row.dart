import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

/// 3-stat card summary row matching Celtic Trekking dashboard
class QuickStatsRow extends StatelessWidget {
  final int treksDone;
  final int maxAltitudeM;
  final int regionsCount;
  final ValueChanged<String>? onStatTap;

  const QuickStatsRow({
    super.key,
    this.treksDone = 0,
    this.maxAltitudeM = 0,
    this.regionsCount = 4,
    this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          icon: Icons.hiking,
          iconBg: AppColors.navy.withValues(alpha: 0.08),
          iconColor: AppColors.navy,
          value: '$treksDone',
          label: 'TREKS DONE',
          onTap: () => onStatTap?.call('Trek History'),
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          icon: Icons.terrain,
          iconBg: AppColors.gold.withValues(alpha: 0.12),
          iconColor: AppColors.gold,
          value: maxAltitudeM > 0 ? '$maxAltitudeM' : '0',
          label: 'MAX ALT (M)',
          onTap: () => onStatTap?.call('Altitude Records'),
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          icon: Icons.public,
          iconBg: AppColors.primaryBlue.withValues(alpha: 0.08),
          iconColor: AppColors.primaryBlue,
          value: '$regionsCount',
          label: 'REGIONS',
          onTap: () => onStatTap?.call('Trek Regions'),
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
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
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
        ),
      ),
    );
  }
}
