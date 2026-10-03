import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Dark upcoming trek card matching ui.html
class UpcomingTrekCard extends StatelessWidget {
  final VoidCallback onTap;

  const UpcomingTrekCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(18),
          image: const DecorationImage(
            image: NetworkImage('https://picsum.photos/seed/annapurnav3/800/400'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, color: AppColors.goldLight, size: 12),
                  SizedBox(width: 6),
                  Text(
                    'IN 14 DAYS',
                    style: TextStyle(
                      color: AppColors.goldLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Annapurna Circuit',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.white.withValues(alpha: 0.45),
                  size: 13,
                ),
                const SizedBox(width: 5),
                Text(
                  'Nepal, Himalayas',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _buildMetaItem(Icons.calendar_today, '18 Days'),
                const SizedBox(width: 18),
                _buildMetaItem(Icons.terrain, '5,416m'),
                const SizedBox(width: 18),
                _buildMetaItem(Icons.group, '8 Trekkers'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gold, size: 13),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
