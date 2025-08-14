import 'package:foods_app/data/datasources/auth_datasource.dart';
import 'package:foods_app/domain/entities/user_entitiy.dart';
import 'package:foods_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);


  @override
  Future<UserEntity> signInWithEmail(String email, String password) => dataSource.signInWithEmail(email, password);

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Future<UserEntity> signUpWithEmail(String email, String password) => dataSource.signUpWithEmail(email, password);

  @override
  Future<UserEntity?> signInWithGoogle() => dataSource.signInWithGoogle();

}