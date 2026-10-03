/// Destination item model matching popular destinations from ui.html
class DestinationItem {
  final String id;
  final String name;
  final double rating;
  final int trekCount;
  final String imageUrl;

  const DestinationItem({
    required this.id,
    required this.name,
    required this.rating,
    required this.trekCount,
    required this.imageUrl,
  });

  static const List<DestinationItem> defaultDestinations = [
    DestinationItem(
      id: 'nepal',
      name: 'Nepal',
      rating: 4.9,
      trekCount: 24,
      imageUrl: 'https://picsum.photos/seed/nepalpeakv3/300/200',
    ),
    DestinationItem(
      id: 'tibet',
      name: 'Tibet',
      rating: 4.8,
      trekCount: 12,
      imageUrl: 'https://picsum.photos/seed/tibetplatv3/300/200',
    ),
    DestinationItem(
      id: 'morocco',
      name: 'Morocco',
      rating: 4.7,
      trekCount: 9,
      imageUrl: 'https://picsum.photos/seed/moroccoatv3/300/200',
    ),
    DestinationItem(
      id: 'romania',
      name: 'Romania',
      rating: 4.6,
      trekCount: 7,
      imageUrl: 'https://picsum.photos/seed/romaniacv3/300/200',
    ),
  ];
}
