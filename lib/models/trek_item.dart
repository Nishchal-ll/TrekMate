import '../constants/api_constants.dart';

/// Trek item model representing treks and circuits from Celtic Trekking API
class TrekItem {
  final int id;
  final String name;
  final String slug;
  final String location;
  final String duration;
  final String maxAltitude;
  final String difficulty;
  final String imageUrl;
  final double price;
  final int spotsAvailable;
  final String description;

  const TrekItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.location,
    required this.duration,
    required this.maxAltitude,
    required this.difficulty,
    required this.imageUrl,
    this.price = 1450.0,
    this.spotsAvailable = 8,
    this.description = '',
  });

  factory TrekItem.fromJson(Map<String, dynamic> json) {
    final destination = json['destination'] as Map<String, dynamic>?;
    final destName = destination?['name']?.toString() ?? 'Nepal, Himalayas';
    final departures = (json['departures'] as List<dynamic>?) ?? [];
    double price = 1450.0;
    int spots = 8;
    if (departures.isNotEmpty) {
      final firstDep = departures.first as Map<String, dynamic>;
      price = double.tryParse(firstDep['price']?.toString() ?? '1450') ?? 1450.0;
      spots = int.tryParse(firstDep['spots_available']?.toString() ?? '8') ?? 8;
    }

    String rawImage = json['image_url']?.toString() ??
        json['image']?.toString() ??
        '';

    // If direct image is empty, check gallery
    if (rawImage.isEmpty && json['gallery'] is List && (json['gallery'] as List).isNotEmpty) {
      rawImage = (json['gallery'] as List).first.toString();
    }
    // Or destination image
    if (rawImage.isEmpty && destination != null) {
      rawImage = destination['image_url']?.toString() ?? destination['image']?.toString() ?? '';
    }

    final normalizedImg = ApiConstants.normalizeImageUrl(rawImage);

    String trekName = json['name']?.toString() ?? 'Trek Expedition';
    String duration = json['duration']?.toString() ?? '10 Days';
    String maxAlt = json['max_altitude']?.toString() ?? '4,800m';
    String difficulty = json['difficulty']?.toString() ?? 'Moderate';

    // Tailor specific trek metadata if generic
    final slug = json['slug']?.toString().toLowerCase() ?? '';
    if (slug == 'nepal' || trekName == 'Nepal') {
      trekName = 'Langtang & Helambu Trek';
      duration = '8 Days';
      maxAlt = '5,030m';
      difficulty = 'Medium';
    } else if (slug == 'tibet' || trekName == 'Tibet') {
      trekName = 'Mount Kailash & Lhasa Circuit';
      duration = '14 Days';
      maxAlt = '5,630m';
      difficulty = 'Challenging';
    } else if (slug == 'morocco' || trekName == 'Morocco') {
      trekName = 'Mount Toubkal & High Atlas';
      duration = '7 Days';
      maxAlt = '4,167m';
      difficulty = 'Moderate';
    } else if (slug == 'romania' || trekName == 'Romania') {
      trekName = 'Wild Carpathian Mountains';
      duration = '6 Days';
      maxAlt = '2,544m';
      difficulty = 'Moderate';
    }

    return TrekItem(
      id: int.tryParse(json['id']?.toString() ?? '1') ?? 1,
      name: trekName,
      slug: slug.isNotEmpty ? slug : 'trek',
      location: destName,
      duration: duration,
      maxAltitude: maxAlt,
      difficulty: difficulty,
      imageUrl: normalizedImg.isNotEmpty
          ? normalizedImg
          : 'https://picsum.photos/seed/${slug.isEmpty ? 'trek' : slug}/800/400',
      price: price,
      spotsAvailable: spots,
      description: json['description']?.toString() ?? '',
    );
  }

  static const List<TrekItem> defaultTreks = [
    TrekItem(
      id: 1,
      name: 'Langtang & Helambu Trek',
      slug: 'langtang-helambu',
      location: 'Nepal, Himalayas',
      duration: '8 Days',
      maxAltitude: '5,030m',
      difficulty: 'Medium',
      imageUrl: 'https://picsum.photos/seed/nepaltrekv3/800/400',
      price: 1450.0,
      spotsAvailable: 8,
    ),
    TrekItem(
      id: 2,
      name: 'Mount Kailash & Lhasa Circuit',
      slug: 'tibet-kailash',
      location: 'Tibet Plateau',
      duration: '14 Days',
      maxAltitude: '5,630m',
      difficulty: 'Challenging',
      imageUrl: 'https://picsum.photos/seed/tibettrekv3/800/400',
      price: 2200.0,
      spotsAvailable: 6,
    ),
    TrekItem(
      id: 3,
      name: 'Mount Toubkal & High Atlas',
      slug: 'morocco-toubkal',
      location: 'High Atlas, Morocco',
      duration: '7 Days',
      maxAltitude: '4,167m',
      difficulty: 'Moderate',
      imageUrl: 'https://picsum.photos/seed/moroccotrekv3/800/400',
      price: 950.0,
      spotsAvailable: 10,
    ),
    TrekItem(
      id: 4,
      name: 'Wild Carpathian Mountains',
      slug: 'romania-carpathians',
      location: 'Romania',
      duration: '6 Days',
      maxAltitude: '2,544m',
      difficulty: 'Moderate',
      imageUrl: 'https://picsum.photos/seed/romaniatrekv3/800/400',
      price: 880.0,
      spotsAvailable: 8,
    ),
  ];

  static const TrekItem defaultTrek = TrekItem(
    id: 1,
    name: 'Langtang & Helambu Trek',
    slug: 'langtang-helambu',
    location: 'Nepal, Himalayas',
    duration: '8 Days',
    maxAltitude: '5,030m',
    difficulty: 'Medium',
    imageUrl: 'https://picsum.photos/seed/nepaltrekv3/800/400',
    price: 1450.0,
    spotsAvailable: 8,
  );
}
