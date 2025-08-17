abstract class MapEvent {}

class LoadMapEvent extends MapEvent {
  final double latitude;
  final double longitude;

  LoadMapEvent(this.latitude, this.longitude);
}
