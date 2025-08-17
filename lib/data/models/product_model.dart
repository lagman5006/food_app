
import '../../domain/entities/product_entity.dart';

class FoodModel extends Food {
  const FoodModel({
    required String name,
    required String image,
    required String location,
    required String category,
    double? latitude,
    double? longitude,
  }) : super(
    name: name,
    image: image,
    location: location,
    category: category,
    latitude: latitude,
    longitude: longitude,
  );

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'],
      image: json['image'],
      location: json['location'],
      category: json['category'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'location': location,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
