import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/domain/usecases/food_usecase.dart';
import 'package:foods_app/presentation/blocs/food_bloc/food_state.dart';

import 'food_event.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoods getFoods;

  FoodBloc(this.getFoods,) : super(FoodInitial()) {
    on<LoadFoods>((event, emit) async {
      emit(FoodLoading());
      try {
        final foods = await getFoods();
        emit(FoodLoaded(foods));
      } catch (e) {
        emit(FoodError("Failed to load foods $e"));
      }
    });
  }
}
