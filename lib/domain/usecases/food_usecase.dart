import 'package:foods_app/data/datasources/food_remote_datasource.dart';
import 'package:foods_app/data/models/product_model.dart';
import 'package:foods_app/domain/repositories/foods_repository.dart';

import '../entities/product_entity.dart';

class GetFoods {
  final FoodRepository repository;

  GetFoods(this.repository);

  Future<List<Food>> call() async {
    return await repository.getFoods();
  }
}
