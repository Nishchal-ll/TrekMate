import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/review_item.dart';

/// Testimonial review cards matching Celtic Trekking web testimonials
class ReviewList extends StatelessWidget {
  final List<ReviewItem> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reviews.map((review) {
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
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 42,
                    height: 42,
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
                              fontSize: 14,
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
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              review.trekLocation,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      review.reviewText,
                      style: const TextStyle(
                        fontSize: 12.5,
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
      }).toList(),
    );
  }
}
