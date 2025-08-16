
import '../../domain/entities/user_entitiy.dart';

abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}
class SignIn extends AuthEvent {
  final String email;
  final String password;
  SignIn(this.email, this.password);
}
class SignUp extends AuthEvent {
  final String email;
  final String password;
  SignUp(this.email, this.password);
}
class SignOut extends AuthEvent {}
class SignInWithGoogle extends AuthEvent {}
class LoggedIn extends AuthEvent {
  final UserEntity user;
  LoggedIn(this.user);
}
class LoggedOut extends AuthEvent {}
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