import 'package:foods_app/data/models/product_model.dart';

abstract class FoodRemoteDataSource {
  Future<List<FoodModel>> getFoods();
}
