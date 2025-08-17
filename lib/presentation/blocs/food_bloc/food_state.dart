import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class FoodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodLoading extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodLoaded extends FoodState {
  final List<Food> foods;

  FoodLoaded(this.foods);

  @override
  List<Object?> get props => [foods];
}

class FoodError extends FoodState {
  final String message;

  FoodError(this.message);

  @override
  List<Object?> get props => [message];
}