import 'package:foods_app/data/datasources/auth_datasource.dart';
import 'package:foods_app/data/datasources/food_remote_datasource.dart';
import 'package:foods_app/data/repositories/auth_repository_impl.dart';
import 'package:foods_app/data/repositories/foods_repository_impl.dart';
import 'package:foods_app/domain/repositories/auth_repository.dart';
import 'package:foods_app/domain/repositories/foods_repository.dart';
import 'package:foods_app/domain/usecases/auth_usecase.dart';

import '../../domain/usecases/food_usecase.dart';

AuthDataSource getAuthDataSource() => AuthDataSource();

AuthRepository getAuthRepository() => AuthRepositoryImpl(getAuthDataSource());

AuthUseCase getAuthUseCase() => AuthUseCase();

GetFoods getGetFoods() => GetFoods(getProductRepository());


FoodRepository getProductRepository() => FoodRepositoryImpl(getProductRepository() as FoodRemoteDataSource);



