import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String name;
  final String image;
  final String location;
  final String category;

  const Food({
    required this.name,
    required this.image,
    required this.location,
    required this.category,
  });

  @override
  List<Object?> get props => [name, image, location, category];
}
