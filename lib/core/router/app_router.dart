import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:nfcreadertools/features/auth/presentation/screens/auth_sign_up_screen.dart';
import 'package:nfcreadertools/features/bottom_nav/presentation/screens/bottom_nav.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_first_screen.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_second_screen.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_third_screen.dart';
import 'package:nfcreadertools/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      /// Splash Screen
      GoRoute(
        path: "/",
        name: "splashScreen",
        builder: (context, state) {
          return SplashScreen();
        },
      ),

      /// Get Started First Screen
      GoRoute(
        path: "/getStartedFirstScreen",
        name: "getStartedFirstScreen",
        builder: (context, state) {
          return GetStartedScreenFirstScreen();
        },
      ),

      /// Get Started Second Screen
      GoRoute(
        path: "/getStartedSecondScreen",
        name: "getStartedSecondScreen",
        builder: (context, state) {
          return GetStartedSecondScreen();
        },
      ),

      /// Get Started Third Screen
      GoRoute(
        path: "/getStartedThirdScreen",
        name: "getStartedThirdScreen",
        builder: (context, state) {
          return GetStartedThirdScreen();
        },
      ),

      /// auth login screen
      GoRoute(
        path: "/authLoginScreen",
        name: "authLoginScreen",
        builder: (context, state) {
          return AuthLoginScreen();
        },
      ),

      /// auth sign up screen
      GoRoute(
        path: "/authSignUpScreen",
        name: "authSignUpScreen",
        builder: (context, state) {
          return AuthSignUpScreen();
        },
      ),

      /// bottom nav screens
      GoRoute(
        path: "/bottomNav",
        name: "bottomNav",
        builder: (context, state) {
          return BottomNav();
        },
      ),
    ],
  );
}
