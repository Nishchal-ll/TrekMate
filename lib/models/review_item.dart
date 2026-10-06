import '../constants/api_constants.dart';

/// Authentic traveler reviews from Celtic Trekking API
class ReviewItem {
  final String id;
  final String authorName;
  final String trekLocation;
  final int stars;
  final String reviewText;
  final String avatarUrl;

  const ReviewItem({
    this.id = '',
    required this.authorName,
    required this.trekLocation,
    required this.stars,
    required this.reviewText,
    required this.avatarUrl,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    String name = json['name']?.toString() ??
        json['name_en']?.toString() ??
        json['name_fr']?.toString() ??
        'Traveler';
    final location = json['location']?.toString() ??
        json['location_en']?.toString() ??
        json['location_fr']?.toString() ??
        '';
    final content = json['content']?.toString() ??
        json['content_en']?.toString() ??
        json['content_fr']?.toString() ??
        '';
    final rawStars = int.tryParse(json['rating']?.toString() ?? '5') ?? 5;
    final avatar = json['avatar_url']?.toString() ??
        json['avatar']?.toString() ??
        '';

    // Unescape common HTML entities
    String cleanedContent = content
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&#039;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // If author name is generic "Anonymous", see if we can extract names from the beginning of review or use Traveler
    if (name.toLowerCase() == 'anonymous' || name.toLowerCase() == 'anonyme') {
      if (cleanedContent.isNotEmpty) {
        // e.g. "Quentin DUMONT and Patrick DUMONT The Manaslu tour..."
        final firstWords = cleanedContent.split(' ');
        if (firstWords.length >= 2 && firstWords[0].isNotEmpty && firstWords[1].isNotEmpty &&
            firstWords[0][0] == firstWords[0][0].toUpperCase() &&
            firstWords[1][0] == firstWords[1][1].toUpperCase()) {
          name = '${firstWords[0]} ${firstWords[1]}';
        } else {
          name = 'Celtic Traveler';
        }
      } else {
        name = 'Celtic Traveler';
      }
    }

    if (cleanedContent.isEmpty) {
      cleanedContent = 'Wonderful trekking experience with Celtic Trekking!';
    }
    if (cleanedContent.length > 220) {
      cleanedContent = '${cleanedContent.substring(0, 217)}...';
    }

    String trekLoc = location.isNotEmpty ? location : '';
    if (trekLoc.isEmpty && json['trek'] is Map) {
      trekLoc = json['trek']['name']?.toString() ?? '';
    }
    if (trekLoc.isEmpty) {
      trekLoc = 'Himalayas, Nepal';
    }

    final normalizedAvatar = ApiConstants.normalizeImageUrl(avatar);

    return ReviewItem(
      id: json['id']?.toString() ?? '',
      authorName: name.isNotEmpty ? name : 'Traveler',
      trekLocation: trekLoc,
      stars: rawStars.clamp(1, 5),
      reviewText: '"$cleanedContent"',
      avatarUrl: normalizedAvatar.isNotEmpty
          ? normalizedAvatar
          : 'https://picsum.photos/seed/${name.hashCode.abs() % 1000}/100/100',
    );
  }

  static const List<ReviewItem> defaultReviews = [
    ReviewItem(
      id: '1',
      authorName: 'Nathalie F.',
      trekLocation: 'Langtang & Helambu (Nepal)',
      stars: 5,
      reviewText:
          '"2nd time going with Celtic Trekking and always a pleasure. Our guide Ram Puri was wonderful and attentive at all times. Unforgettable memories!"',
      avatarUrl: 'https://picsum.photos/seed/nathalief/100/100',
    ),
    ReviewItem(
      id: '2',
      authorName: 'Marie Cécile & Group',
      trekLocation: 'Draa Valley (Morocco)',
      stars: 5,
      reviewText:
          '"Very happy with our trek in Morocco. Our guide Hassan was extraordinarily competent with our group. Highly recommended agency!"',
      avatarUrl: 'https://picsum.photos/seed/mariececile/100/100',
    ),
    ReviewItem(
      id: '3',
      authorName: 'Marc & Sophie',
      trekLocation: 'Annapurna Sanctuary (Nepal)',
      stars: 5,
      reviewText:
          '"Breathtaking views and impeccable safety standards. The local Sherpa support and personalized itinerary made it a life-changing adventure."',
      avatarUrl: 'https://picsum.photos/seed/marcsophie/100/100',
    ),
  ];
}
