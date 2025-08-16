

import '../domain/entities/user_entitiy.dart';
import 'blocs/auth_bloc/auth_event.dart';

class AddUser extends AuthEvent {
  final UserEntity user;

   AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUser extends AuthEvent {
  final UserEntity user;

   UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends AuthEvent {
  final String uid;

   DeleteUser(this.uid);

  @override
  List<Object> get props => [uid];
}