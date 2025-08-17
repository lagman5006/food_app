class MapEntity {
  final String name;
  final String image;
  final String category;
  final String location;
  final double? latitude;
  final double? longitude;

  const MapEntity({
    required this.name,
    required this.image,
    required this.category,
    required this.location,
    this.latitude,
    this.longitude,
  });
}
