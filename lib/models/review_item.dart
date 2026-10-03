/// Trekker review model matching testimonials from ui.html
class ReviewItem {
  final String authorName;
  final int stars;
  final String reviewText;
  final String avatarUrl;

  const ReviewItem({
    required this.authorName,
    required this.stars,
    required this.reviewText,
    required this.avatarUrl,
  });

  static const List<ReviewItem> defaultReviews = [
    ReviewItem(
      authorName: 'Sarah Mitchell',
      stars: 5,
      reviewText:
          '"The Chitwan safari was magical. Saw rhinos up close. Celtic Trekking made it seamless."',
      avatarUrl: 'https://picsum.photos/seed/trekker1v3/80/80',
    ),
    ReviewItem(
      authorName: 'James O\'Brien',
      stars: 4,
      reviewText:
          '"EBC trek was life-changing. Our guide Pasang was incredible. Highly recommend."',
      avatarUrl: 'https://picsum.photos/seed/trekker2v3/80/80',
    ),
  ];
}
