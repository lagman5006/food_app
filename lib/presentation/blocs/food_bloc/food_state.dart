import '../../../domain/entities/product_entity.dart';

abstract class FoodState {}

class FoodInitial extends FoodState{}
class FoodLoading extends FoodState{}
class FoodLoaded extends FoodState{
  final List<Food> foods;

  FoodLoaded(this.foods);

}
class FoodError extends FoodState {
  final String message;

  FoodError(this.message);

}