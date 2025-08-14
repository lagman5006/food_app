import 'package:foods_app/presentation/pages/auth_page.dart';
import 'package:foods_app/presentation/pages/home_page.dart';
import 'package:foods_app/presentation/pages/onboarding_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/Onboarding",
  routes: [
    GoRoute(path: "/Onboarding", builder: (_, __) => OnboardingPage()),
    GoRoute(path: "/auth", builder: (_, __) => AuthPage()),
    GoRoute(path: "/home", builder: (_, __) => HomePage()),
  ],
);
