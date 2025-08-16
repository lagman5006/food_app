import 'package:foods_app/data/datasources/food_remote_datasource.dart';
import 'package:foods_app/domain/entities/product_entity.dart';
import 'package:foods_app/domain/repositories/foods_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource remoteDataSource;

  FoodRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Food>> getFoods() async {
    return await remoteDataSource.getFoods();
  }
}
