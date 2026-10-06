import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/user_session.dart';
import '../../widgets/common/app_toast.dart';

/// Dedicated Profile Screen with user info, trek preferences, and logout
class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserSession(),
      builder: (context, _) {
        final session = UserSession();
        final email = session.email.isNotEmpty
            ? session.email
            : 'explorer@celtictrekking.com';
        final preferredDest = session.destination.isNotEmpty
            ? session.destination
            : 'Nepal, Himalayas';

        return Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            backgroundColor: AppColors.navy,
            elevation: 0,
            title: const Text(
              'My Profile',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Profile Avatar & Identity Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppStyles.softShadow,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 84,
                            height: 84,
                            decoration: BoxDecoration(
                              color: AppColors.navy,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.gold,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.navy.withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                session.avatarInitial,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'serif',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: AppColors.gold,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: AppColors.navy,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        session.userName,
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: AppColors.gold, size: 14),
                            SizedBox(width: 5),
                            Text(
                              'Verified Celtic Explorer',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Explorer Stats Overview
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppStyles.softShadow,
                  ),
                  child: Row(
                    children: [
                      _buildStatColumn('0', 'TREKS COMPLETED', Icons.hiking),
                      _buildVerticalDivider(),
                      _buildStatColumn('0m', 'MAX ALTITUDE', Icons.terrain),
                      _buildVerticalDivider(),
                      _buildStatColumn('0', 'SAVED ROUTES', Icons.bookmark_border),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Settings & Preferences Section
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppStyles.softShadow,
                  ),
                  child: Column(
                    children: [
                      _buildSettingsTile(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                        subtitle: 'Name, contact email and emergency details',
                        onTap: () => AppToast.show(
                          context,
                          'Feature coming soon: Edit profile info',
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingsTile(
                        icon: Icons.explore_outlined,
                        title: 'Preferred Destination',
                        subtitle: preferredDest,
                        onTap: () => AppToast.show(
                          context,
                          'Feature coming soon: Change preferred destination',
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingsTile(
                        icon: Icons.notifications_outlined,
                        title: 'Notification Preferences',
                        subtitle: 'Expedition alerts, guide notes & updates',
                        onTap: () => AppToast.show(
                          context,
                          'Feature coming soon: Notification settings',
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingsTile(
                        icon: Icons.support_agent_outlined,
                        title: 'Celtic Trekking Help & Support',
                        subtitle: 'Direct WhatsApp & Guide assistance',
                        onTap: () => AppToast.show(
                          context,
                          'Feature coming soon: 24/7 Guide support',
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingsTile(
                        icon: Icons.info_outline,
                        title: 'About Celtic Trekking',
                        subtitle: 'Version 1.0.0 • Kathmandu & France',
                        onTap: () => AppToast.show(
                          context,
                          'Celtic Trekking — Authentic Himalayan Expeditions',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC2626).withValues(alpha: 0.1),
                      foregroundColor: const Color(0xFFDC2626),
                      elevation: 0,
                      side: const BorderSide(
                        color: Color(0xFFDC2626),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    icon: const Icon(Icons.logout_rounded, size: 20),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.muted,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 38,
      color: AppColors.border,
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.navy.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.navy, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 11.5,
          color: AppColors.muted,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.muted,
        size: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border,
      indent: 64,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        content: const Text(
          'Are you sure you want to sign out of your Celtic Trekking explorer account?',
          style: TextStyle(color: AppColors.bodyText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              UserSession().logout();
              AppToast.show(context, 'Signed out successfully');
              onLogout();
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
