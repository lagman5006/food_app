import 'package:foods_app/data/datasources/auth_datasource.dart';
import 'package:foods_app/data/repositories/auth_repository_impl.dart';
import 'package:foods_app/domain/repositories/auth_repository.dart';
import 'package:foods_app/domain/usecases/auth_usecase.dart';

AuthDataSource getAuthDataSource() => AuthDataSource();

AuthRepository getAuthRepository() => AuthRepositoryImpl(getAuthDataSource());

AuthUseCase getAuthUseCase() => AuthUseCase();


