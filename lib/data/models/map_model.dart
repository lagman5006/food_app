import '../../domain/entities/map_entity.dart';

class MapModel extends MapEntity {
  const MapModel({
    required super.name,
    required super.image,
    required super.category,
    required super.location,
    super.latitude,
    super.longitude,
  });

  factory MapModel.fromMap(Map<String, dynamic> map) {
    return MapModel(
      name: map["name"] as String,
      image: map["image"] as String,
      category: map["category"] as String,
      location: map["location"] as String,
      latitude: (map["latitude"] as num?)?.toDouble(),
      longitude: (map["longitude"] as num?)?.toDouble(),
    );
  }
}
