import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/navigation/navi_item.dart';
import 'package:foods_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:foods_app/presentation/pages/auth_page.dart';
import 'package:foods_app/presentation/pages/home_page.dart';
import 'package:foods_app/presentation/pages/main_page.dart';
import 'package:foods_app/presentation/pages/onboarding_page.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blocs/auth_bloc/auth_state.dart';
import '../../presentation/pages/book_page.dart';
import '../../presentation/pages/profile_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthBloc authBloc, NavigationCubit navigationCubit) {
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
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider.value(
            value: navigationCubit,
            child: MainPage(child: child),
          );
        },
        routes: [
          GoRoute(path: "/home", builder: (context, state) => const HomePage()),
          GoRoute(path: "/book", builder: (context, state) => const BookPage()),
          GoRoute(path: "/profile", builder: (context, state) => const ProfilePage()),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthPage = state.matchedLocation == "/auth";
      final isOnboardingPage = state.matchedLocation == "/onboarding";

      if (authState is Unauthenticated && !isAuthPage && !isOnboardingPage) {
        return '/auth';
      } else if ((authState is Authenticated || authState is AuthSuccess) && !state.matchedLocation.startsWith('/home') && !state.matchedLocation.startsWith('/book') && !state.matchedLocation.startsWith('/profile')) {
        return '/home';
      }
      return null;
    },
  );
}