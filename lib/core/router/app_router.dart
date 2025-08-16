import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:foods_app/presentation/pages/auth_page.dart';
import 'package:foods_app/presentation/pages/home_page.dart';
import 'package:foods_app/presentation/pages/onboarding_page.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blocs/auth_bloc/auth_state.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: "/onboarding",
    routes: [
      GoRoute(path: "/onboarding", builder: (context, state) =>  OnboardingPage()),
      GoRoute(
        path: "/auth",
        builder: (context, state) => BlocProvider.value(
          value: authBloc,
          child: const AuthPage(),
        ),
      ),
      GoRoute(path: "/home", builder: (context, state) => const HomePage()),
    ],
    redirect: (context, state) {
      // if (!hasSeenOnboarding){
      //   return '/onboarding';
      // }
      final authState = authBloc.state;
      final isAuthPage = state.matchedLocation == "/auth";
      final isOnboardingPage = state.matchedLocation == "/onboarding";

      if (authState is Unauthenticated && !isAuthPage && !isOnboardingPage) {
        return '/auth';
      } else if (authState is Authenticated || authState is AuthSuccess) {
        return '/home';
      }
      return null;
    },
  );
}