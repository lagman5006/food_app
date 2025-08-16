import '../entities/product_entity.dart';

abstract class FoodRepository {
  Future<List<Food>> getFoods();
}