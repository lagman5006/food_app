import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<LoadMapEvent>((event, emit) {
      emit(MapLoaded(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    });
  }
}
