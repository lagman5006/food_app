abstract class MapState {}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final double latitude;
  final double longitude;

  MapLoaded({required this.latitude, required this.longitude});
}
