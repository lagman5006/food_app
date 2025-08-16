import 'package:foods_app/data/datasources/auth_datasource.dart';
import 'package:foods_app/data/models/product_model.dart';
import 'package:foods_app/domain/entities/user_entitiy.dart';
import 'package:foods_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> signInWithEmail(String email, String password) =>
      dataSource.signInWithEmail(email, password);

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Future<UserEntity> signUpWithEmail(String email, String password) =>
      dataSource.signUpWithEmail(email, password);

  @override
  Future<UserEntity?> signInWithGoogle() => dataSource.signInWithGoogle();

  @override
  Future<List<UserEntity?>> getAllUser() => dataSource.getAllUsers();

  @override
  Future<void> addUser(UserEntity user) => dataSource.addUser(user);

  @override
  Future<void> deleteUser(String uid) => dataSource.deleteUser(uid);

  @override
  Future<void> updateUser(UserEntity user) => dataSource.updateUser(user);







}
