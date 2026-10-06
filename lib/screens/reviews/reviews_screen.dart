import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/review_item.dart';
import '../../services/api_service.dart';
import '../../widgets/common/app_toast.dart';

/// Dedicated Screen displaying all authentic traveler reviews
class ReviewsScreen extends StatefulWidget {
  final List<ReviewItem> initialReviews;

  const ReviewsScreen({super.key, required this.initialReviews});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late List<ReviewItem> _reviews;
  final _apiService = ApiService();
  bool _isLoading = false;
  int _selectedFilter = 0; // 0 = All, 5 = 5 stars, 4 = 4 stars

  @override
  void initState() {
    super.initState();
    _reviews = widget.initialReviews;
    if (_reviews.length <= 3) {
      _loadReviews();
    }
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    try {
      final reviews = await _apiService.fetchReviews(perPage: 100);
      if (mounted) {
        setState(() {
          _reviews = reviews;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<ReviewItem> get _filteredReviews {
    if (_selectedFilter == 0) return _reviews;
    return _reviews.where((r) => r.stars == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredReviews;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Traveler Reviews',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.rate_review_outlined, color: AppColors.goldLight),
            onPressed: () => AppToast.show(
              context,
              'Feature coming soon: Submit a traveler review',
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primaryBlue,
        backgroundColor: AppColors.white,
        onRefresh: _loadReviews,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingSummaryCard(),
              const SizedBox(height: 18),
              _buildFilterChips(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Showing ${filtered.length} Reviews',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText,
                    ),
                  ),
                  InkWell(
                    onTap: () => AppToast.show(context, 'Feature coming soon: Sort reviews'),
                    child: const Row(
                      children: [
                        Icon(Icons.sort_rounded, size: 16, color: AppColors.primaryBlue),
                        SizedBox(width: 4),
                        Text(
                          'Most Recent',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(color: AppColors.primaryBlue),
                  ),
                )
              else if (filtered.isEmpty)
                _buildEmptyState()
              else
                ...filtered.map((r) => _buildReviewCard(r)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: AppStyles.softShadow,
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () => AppToast.show(
                context,
                'Feature coming soon: Submit a traveler review',
              ),
              icon: const Icon(Icons.edit_note_rounded, color: AppColors.goldLight),
              label: const Text(
                'Write a Review',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: AppStyles.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '4.9',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: AppColors.goldLight, size: 14),
                    Icon(Icons.star_rounded, color: AppColors.goldLight, size: 14),
                    Icon(Icons.star_rounded, color: AppColors.goldLight, size: 14),
                    Icon(Icons.star_rounded, color: AppColors.goldLight, size: 14),
                    Icon(Icons.star_rounded, color: AppColors.goldLight, size: 14),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verified Himalayan Adventures',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Over 60+ travelers shared their authentic expeditions with Celtic Trekking across Nepal, Tibet, and Morocco.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.bodyText.withValues(alpha: 0.8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'label': 'All (${_reviews.length})', 'value': 0},
      {'label': '5 Stars ★', 'value': 5},
      {'label': '4 Stars ★', 'value': 4},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter == f['value'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                f['label'] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.white : AppColors.darkText,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryBlue,
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? AppColors.primaryBlue : AppColors.border,
                ),
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = (f['value'] as int);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReviewCard(ReviewItem review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppStyles.softShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              review.avatarUrl,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    review.authorName.isNotEmpty ? review.authorName[0] : 'T',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        review.authorName,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (starIdx) {
                        return Icon(
                          starIdx < review.stars
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 15,
                          color: AppColors.gold,
                        );
                      }),
                    ),
                  ],
                ),
                if (review.trekLocation.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 12.5,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          review.trekLocation,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  review.reviewText,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.bodyText,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.rate_review_outlined, size: 48, color: AppColors.muted.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            const Text(
              'No reviews match this rating filter',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
