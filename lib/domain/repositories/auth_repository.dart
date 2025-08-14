
import '../entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmail(String email, String password);
  Future<UserEntity> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> signInWithGoogle();
}