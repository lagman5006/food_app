import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUp extends AuthEvent {
  final String email;
  final String password;

  SignUp(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignInWithGoogle extends AuthEvent {
  @override
  List<Object> get props => [];
}
