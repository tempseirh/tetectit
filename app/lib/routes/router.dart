import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/pages/views/profile.dart';

final router = [
  GetPage(
    name: RouteNames.splashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: RouteNames.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: RouteNames.welcomeScreen,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
    name: RouteNames.loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: RouteNames.signupScreen,
    page: () => const SignupScreen(),
  ),
  GetPage(
    name: RouteNames.profileScreen,
    page: () => const ProfileScreen(),
  )
];
