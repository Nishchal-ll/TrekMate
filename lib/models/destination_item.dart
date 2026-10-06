import '../constants/api_constants.dart';

/// Destination item model matching authentic destinations from Celtic Trekking
class DestinationItem {
  final String id;
  final String name;
  final String slug;
  final String tag;
  final double rating;
  final int trekCount;
  final int circuitsCount;
  final String imageUrl;

  const DestinationItem({
    required this.id,
    required this.name,
    this.slug = '',
    required this.tag,
    required this.rating,
    required this.trekCount,
    this.circuitsCount = 0,
    required this.imageUrl,
  });

  factory DestinationItem.fromJson(Map<String, dynamic> json) {
    final name = json['name']?.toString() ??
        json['name_en']?.toString() ??
        'Destination';
    final slug = json['slug']?.toString() ?? '';
    final rawImage = json['image_url']?.toString() ??
        json['image']?.toString() ??
        '';
    final treksCount = int.tryParse(json['treks_count']?.toString() ?? '0') ?? 0;
    final circuitsCount =
        int.tryParse(json['circuits_count']?.toString() ?? '0') ?? 0;

    // Provide helpful tag
    String tag = '$treksCount Circuits';
    if (slug == 'nepal') tag = 'Himalayas & Everest';
    if (slug == 'tibet') tag = 'Roof of the World';
    if (slug == 'morocco' || slug == 'maroc') tag = 'Atlas & Sahara Desert';
    if (slug == 'romania' || slug == 'roumanie') tag = 'Wild Carpathians';
    if (slug == 'ladakh') tag = 'Little Tibet & Zanskar';

    final normalizedImg = ApiConstants.normalizeImageUrl(rawImage);

    return DestinationItem(
      id: json['id']?.toString() ?? slug,
      name: name,
      slug: slug,
      tag: tag,
      rating: 4.8,
      trekCount: treksCount > 0 ? treksCount : 5,
      circuitsCount: circuitsCount,
      imageUrl: normalizedImg.isNotEmpty
          ? normalizedImg
          : 'https://picsum.photos/seed/${slug.isEmpty ? 'dest' : slug}/400/260',
    );
  }

  static const List<DestinationItem> defaultDestinations = [
    DestinationItem(
      id: 'nepal',
      name: 'Nepal',
      slug: 'nepal',
      tag: 'Himalayas & Everest',
      rating: 4.9,
      trekCount: 16,
      circuitsCount: 4,
      imageUrl: 'https://picsum.photos/seed/nepalpeakv3/400/260',
    ),
    DestinationItem(
      id: 'tibet',
      name: 'Tibet',
      slug: 'tibet',
      tag: 'Roof of the World',
      rating: 4.8,
      trekCount: 8,
      circuitsCount: 2,
      imageUrl: 'https://picsum.photos/seed/tibetplatv3/400/260',
    ),
    DestinationItem(
      id: 'maroc',
      name: 'Morocco',
      slug: 'morocco',
      tag: 'Atlas & Sahara Desert',
      rating: 4.9,
      trekCount: 11,
      circuitsCount: 3,
      imageUrl: 'https://picsum.photos/seed/moroccoatv3/400/260',
    ),
    DestinationItem(
      id: 'ladakh',
      name: 'Ladakh (Inde)',
      slug: 'ladakh',
      tag: 'Little Tibet & Zanskar',
      rating: 4.8,
      trekCount: 7,
      circuitsCount: 2,
      imageUrl: 'https://picsum.photos/seed/ladakhvalley/400/260',
    ),
    DestinationItem(
      id: 'roumanie',
      name: 'Romania',
      slug: 'romania',
      tag: 'Wild Carpathians',
      rating: 4.7,
      trekCount: 5,
      circuitsCount: 1,
      imageUrl: 'https://picsum.photos/seed/romaniacv3/400/260',
    ),
  ];
}
