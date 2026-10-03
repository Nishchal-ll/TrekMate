import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/destination_item.dart';
import '../../models/review_item.dart';
import '../../models/user_session.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/dashboard/cta_banner.dart';
import '../../widgets/dashboard/dashboard_bottom_nav.dart';
import '../../widgets/dashboard/destination_carousel.dart';
import '../../widgets/dashboard/quick_stats_row.dart';
import '../../widgets/dashboard/review_list.dart';
import '../../widgets/dashboard/upcoming_trek_card.dart';

/// Dashboard Screen matching Celtic Trekking design in ui.html
class DashboardScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const DashboardScreen({super.key, required this.onLogout});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTabIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleLogout() {
    UserSession().logout();
    AppToast.show(context, 'Signed out successfully');
    widget.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserSession(),
      builder: (context, _) {
        final session = UserSession();
        return Scaffold(
          backgroundColor: AppColors.offWhite,
          bottomNavigationBar: DashboardBottomNav(
            selectedIndex: _selectedTabIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
              switch (index) {
                case 1:
                  AppToast.show(context, 'Explore section');
                  break;
                case 2:
                  AppToast.show(context, 'Book a new trek');
                  break;
                case 3:
                  AppToast.show(context, 'Saved treks: 5');
                  break;
                case 4:
                  AppToast.show(context, 'Profile settings');
                  break;
              }
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDashHeader(session),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const QuickStatsRow(),
                      const SizedBox(height: 22),
                      _buildSectionHeader(
                        title: 'Upcoming Trek',
                        linkText: 'View Details',
                        onTapLink: () => AppToast.show(
                          context,
                          'Opening Annapurna Circuit details',
                        ),
                      ),
                      const SizedBox(height: 12),
                      UpcomingTrekCard(
                        onTap: () => AppToast.show(
                          context,
                          'Annapurna Circuit details',
                        ),
                      ),
                      CtaBanner(
                        onTap: () => AppToast.show(
                          context,
                          'Opening trek planning contact form',
                        ),
                      ),
                      _buildSectionHeader(
                        title: 'Popular Destinations',
                        linkText: 'See All',
                        onTapLink: () => AppToast.show(
                          context,
                          'Showing all destinations',
                        ),
                      ),
                      const SizedBox(height: 12),
                      DestinationCarousel(
                        destinations: DestinationItem.defaultDestinations,
                        onSelect: (dest) => AppToast.show(
                          context,
                          'Exploring ${dest.name} treks',
                        ),
                      ),
                      const SizedBox(height: 22),
                      _buildSectionHeader(
                        title: 'Trekker Reviews',
                        linkText: 'All Reviews',
                        onTapLink: () => AppToast.show(
                          context,
                          'Showing all trekker reviews',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const ReviewList(reviews: ReviewItem.defaultReviews),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashHeader(UserSession session) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.navy,
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/seed/himalayaskyv3/800/400'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      padding: const EdgeInsets.only(top: 56, left: 24, right: 24, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.navyAccent, AppColors.gold],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    session.avatarInitial,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.white,
                            size: 20,
                          ),
                          onPressed: () => AppToast.show(
                            context,
                            '3 new expedition notifications',
                          ),
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.navy, width: 2),
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.logout,
                        color: AppColors.white,
                        size: 18,
                      ),
                      onPressed: _handleLogout,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Hey, ${session.userName}',
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Ready for your next adventure?',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.white.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white.withValues(alpha: 0.4),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: AppColors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Search treks, destinations...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onSubmitted: (val) {
                      if (val.trim().isNotEmpty) {
                        AppToast.show(context, 'Searching for "$val"...');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String linkText,
    required VoidCallback onTapLink,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.sectionTitle),
        GestureDetector(
          onTap: onTapLink,
          child: Text(
            linkText,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
