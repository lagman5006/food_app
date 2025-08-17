import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/map_bloc/map_bloc.dart';
import '../blocs/map_bloc/map_state.dart';

class MapPage extends StatelessWidget {
  final String title;
  const MapPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapInitial) {
            return const Center(child: Text('Initializing map...'));
          } else if (state is MapLoaded) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(state.latitude, state.longitude),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('location'),
                  position: LatLng(state.latitude, state.longitude),
                  infoWindow: InfoWindow(title: title),
                ),
              },
            );
          } else {
            return const Center(child: Text('Failed to load map'));
          }
        },
      ),
    );
  }
}