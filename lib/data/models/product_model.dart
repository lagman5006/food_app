
import '../../domain/entities/product_entity.dart';

class FoodModel extends Food {
  const FoodModel({
    required super.name,
    required super.image,
    required super.location,
    required super.category,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'],
      image: json['image'],
      location: json['location'],
      category: json['category'],
    );
  }
}
