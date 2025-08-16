import 'package:foods_app/data/datasources/auth_datasource.dart';

import '../entities/user_entitiy.dart';

class AuthUseCase {
  final AuthDataSource _authDataSource = AuthDataSource();

  Future<UserEntity> signIn(String email, String password) =>
      _authDataSource.signInWithEmail(email, password);

  Future<UserEntity> signUp(String email, String password) =>
      _authDataSource.signUpWithEmail(email, password);

  Future<void> signOut() => _authDataSource.signOut();

  Future<UserEntity?> signInWithGoogle() =>
      _authDataSource.signInWithGoogle();

  Future<void> addUser(UserEntity user) => _authDataSource.addUser(user);
  Future<void> updateUser(UserEntity user) => _authDataSource.updateUser(user);
  Future<void> deleteUser(String uid) => _authDataSource.deleteUser(uid);

  Future<List<UserEntity>> getAllUser() => _authDataSource.getAllUsers();

}