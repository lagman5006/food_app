import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFoods extends FoodEvent {
  @override
  List<Object?> get props => [];
}

class FetchFoods extends FoodEvent {
  @override
  List<Object?> get props => [];
}