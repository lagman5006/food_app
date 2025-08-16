import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/router/app_router.dart';
import 'package:foods_app/data/repositories/food_remote_data_source_impl.dart';
import 'package:foods_app/data/repositories/foods_repository_impl.dart';
import 'package:foods_app/domain/usecases/food_usecase.dart';
import 'package:foods_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:foods_app/presentation/blocs/food_bloc/foodBloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authBloc = AuthBloc();
  final foodRepository = FoodRepositoryImpl(
    FoodREmoteDatasourceImpl(firestore: FirebaseFirestore.instance),
  );
  final getFoods = GetFoods(foodRepository);
  final foodBloc = FoodBloc(getFoods);
  runApp(MyApp(authBloc: authBloc, foodBloc: foodBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final FoodBloc foodBloc;
  const MyApp({super.key, required this.authBloc, required this.foodBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: foodBloc),
      ],
      child: MaterialApp.router(
        routerConfig: createRouter(authBloc),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
