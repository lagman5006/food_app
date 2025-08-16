import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entitiy.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}
class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
class Unauthenticated extends AuthState {}
class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}
class UserLoaded extends AuthState {
  final List<UserEntity> users;
  const UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}