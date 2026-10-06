import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/destination_item.dart';
import '../../models/review_item.dart';
import '../../models/trek_item.dart';
import '../../models/user_session.dart';
import '../../services/api_service.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/dashboard/cta_banner.dart';
import '../../widgets/dashboard/dashboard_bottom_nav.dart';
import '../../widgets/dashboard/destination_carousel.dart';
import '../../widgets/dashboard/popular_treks_list.dart';
import '../../widgets/dashboard/quick_stats_row.dart';
import '../../widgets/dashboard/review_list.dart';
import '../profile/profile_screen.dart';
import '../reviews/reviews_screen.dart';

/// Dynamic Dashboard Screen with fixed top navigation bar
class DashboardScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const DashboardScreen({super.key, required this.onLogout});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTabIndex = 0;
  final _searchController = TextEditingController();
  final _apiService = ApiService();

  List<DestinationItem> _destinations = DestinationItem.defaultDestinations;
  List<ReviewItem> _reviews = ReviewItem.defaultReviews;
  List<TrekItem> _treks = TrekItem.defaultTreks;

  @override
  void initState() {
    super.initState();
    _fetchDynamicData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchDynamicData() async {
    try {
      final results = await Future.wait([
        _apiService.fetchDestinations(),
        _apiService.fetchReviews(perPage: 100),
        _apiService.fetchTreks(perPage: 10),
      ]);

      if (mounted) {
        setState(() {
          _destinations = results[0] as List<DestinationItem>;
          _reviews = results[1] as List<ReviewItem>;
          _treks = results[2] as List<TrekItem>;
        });
      }
    } catch (e) {
      debugPrint('Dashboard data fetch error: $e');
    }
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
          // Fixed Static Top Navigation Bar
          appBar: _selectedTabIndex == 0 ? _buildFixedTopNavBar(session) : null,
          bottomNavigationBar: DashboardBottomNav(
            selectedIndex: _selectedTabIndex,
            onTabSelected: (index) {
              if (index == 0 || index == 4) {
                setState(() {
                  _selectedTabIndex = index;
                });
              } else {
                switch (index) {
                  case 1:
                    AppToast.show(context, 'Feature coming soon: Explore destinations');
                    break;
                  case 2:
                    AppToast.show(context, 'Feature coming soon: Book an expedition');
                    break;
                  case 3:
                    AppToast.show(context, 'Feature coming soon: Saved itineraries');
                    break;
                }
              }
            },
          ),
          body: _selectedTabIndex == 4
              ? ProfileScreen(onLogout: _handleLogout)
              : RefreshIndicator(
                  color: AppColors.primaryBlue,
                  backgroundColor: AppColors.white,
                  onRefresh: _fetchDynamicData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchHeroHeader(session),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QuickStatsRow(
                                treksDone: 0,
                                maxAltitudeM: 0,
                                regionsCount: _destinations.isNotEmpty
                                    ? _destinations.length
                                    : 4,
                                onStatTap: (stat) => AppToast.show(
                                  context,
                                  'Feature coming soon: $stat tracking',
                                ),
                              ),
                              const SizedBox(height: 22),
                              _buildSectionHeader(
                                title: 'Popular Treks',
                                linkText: 'See All',
                                onTapLink: () => AppToast.show(
                                  context,
                                  'Feature coming soon: Complete treks catalog',
                                ),
                              ),
                              const SizedBox(height: 12),
                              PopularTreksList(
                                treks: _treks,
                                onSelect: (trek) => AppToast.show(
                                  context,
                                  'Feature coming soon: ${trek.name} itinerary & booking',
                                ),
                              ),
                              const SizedBox(height: 14),
                              CtaBanner(
                                onTap: () => AppToast.show(
                                  context,
                                  'Feature coming soon: Contact trek planning experts',
                                ),
                              ),
                              _buildSectionHeader(
                                title: 'Popular Destinations',
                                linkText: 'See All',
                                onTapLink: () => AppToast.show(
                                  context,
                                  'Feature coming soon: Complete destinations directory',
                                ),
                              ),
                              const SizedBox(height: 12),
                              DestinationCarousel(
                                destinations: _destinations,
                                onSelect: (dest) => AppToast.show(
                                  context,
                                  'Feature coming soon: ${dest.name} expeditions & routes',
                                ),
                              ),
                              const SizedBox(height: 22),
                              _buildSectionHeader(
                                title: 'Trekker Reviews',
                                linkText: 'All Reviews',
                                onTapLink: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ReviewsScreen(
                                        initialReviews: _reviews,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              ReviewList(reviews: _reviews.take(3).toList()),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  /// Static Fixed Top Navigation Bar (Logo on Left, White User Icon on Right)
  PreferredSizeWidget _buildFixedTopNavBar(UserSession session) {
    return AppBar(
      backgroundColor: AppColors.navy,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 72,
      titleSpacing: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Official Celtic Trekking Logo (Enlarged)
          Image.asset(
            'assets/images/logo.png',
            height: 52,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text(
              'CELTIC TREKKING',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),

          // Right: White User Icon
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedTabIndex = 4; // Switch to Profile page
              });
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.white,
                  size: 21,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Compact, slim Search Banner right beneath the fixed top bar
  Widget _buildSearchHeroHeader(UserSession session) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.navy,
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12, top: 0),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.45),
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: AppColors.white, fontSize: 12.5),
                decoration: InputDecoration(
                  hintText: 'Search treks, destinations...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 12,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty) {
                    AppToast.show(
                      context,
                      'Feature coming soon: Search for "$val"',
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
              fontSize: 12.5,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
