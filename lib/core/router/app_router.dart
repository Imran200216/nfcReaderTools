import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfcreadertools/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:nfcreadertools/features/auth/presentation/screens/auth_sign_up_screen.dart';
import 'package:nfcreadertools/features/bottom_nav/presentation/screens/bottom_nav.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_first_screen.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_second_screen.dart';
import 'package:nfcreadertools/features/get_started/presentation/screens/get_started_screen_third_screen.dart';
import 'package:nfcreadertools/features/nfc_add_writing_record/presentation/screens/nfc_add_writing_record_screen.dart';
import 'package:nfcreadertools/features/nfc_contact_record_writing/presentation/screens/nfc_contact_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_location_record_writing/presentation/screens/nfc_location_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_mail_record_writing/presentation/nfc_mail_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_social_share_record_writing/presentation/screens/nfc_social_share_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_text_record_writing/presentation/screens/nfc_text_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_url_record_writing/presentation/screens/nfc_url_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_wifi_record_writing/presentation/screens/nfc_wifi_record_writing_screen.dart';
import 'package:nfcreadertools/features/nfc_writing_tools_records/presentation/screens/nfc_writing_tools_records_screen.dart';
import 'package:nfcreadertools/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      /// Splash Screen
      GoRoute(
        path: "/",
        name: "splashScreen",
        builder: (context, state) {
          return SplashScreen(
            onDecideRoute: decideNextRoute,
          );
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

      /// nfc writing tools records screen
      GoRoute(
        path: "/nfcWritingToolsRecordsScreen",
        name: "nfcWritingToolsRecordsScreen",
        builder: (context, state) {
          return NfcWritingToolsRecordsScreen();
        },
      ),

      /// nfc add writing records screens
      GoRoute(
        path: "/nfcAddWritingRecordsScreen",
        name: "nfcAddWritingRecordsScreen",
        builder: (context, state) {
          return NfcAddWritingRecordScreen();
        },
      ),

      /// nfc contact record writing screen
      GoRoute(
        path: "/nfcContactRecordWritingScreen",
        name: "nfcContactRecordWritingScreen",
        builder: (context, state) {
          return NfcContactRecordWritingScreen();
        },
      ),

      /// nfc location record writing screen
      GoRoute(
        path: "/nfcLocationRecordWritingScreen",
        name: "nfcLocationRecordWritingScreen",
        builder: (context, state) {
          return NfcLocationRecordWritingScreen();
        },
      ),

      /// nfc social share record writing screen
      GoRoute(
        path: "/nfcSocialShareRecordWritingScreen",
        name: "nfcSocialShareRecordWritingScreen",
        builder: (context, state) {
          return NfcSocialShareRecordWritingScreen();
        },
      ),

      /// nfc text record writing screen
      GoRoute(
        path: "/nfcTextRecordWritingScreen",
        name: "nfcTextRecordWritingScreen",
        builder: (context, state) {
          return NfcTextRecordWritingScreen();
        },
      ),

      /// nfc url record writing screen
      GoRoute(
        path: "/nfcUrlRecordWritingScreen",
        name: "nfcUrlRecordWritingScreen",
        builder: (context, state) {
          return NfcUrlRecordWritingScreen();
        },
      ),

      /// nfc wifi record writing screen
      GoRoute(
        path: "/nfcWifiRecordWritingScreen",
        name: "nfcWifiRecordWritingScreen",
        builder: (context, state) {
          return NfcWifiRecordWritingScreen();
        },
      ),

      /// nfc mail record writing screen
      GoRoute(
        path: "/nfcMailRecordWritingScreen",
        name: "nfcMailRecordWritingScreen",
        builder: (context, state) {
          return NfcMailRecordWritingScreen();
        },
      ),
    ],
  );

  static Future<String> decideNextRoute() async {
    /// To check the get started status for user
    var userGetStartedBox = Hive.box("userGetStartedStatusBox");
    bool userGetStartedStatus =
        userGetStartedBox.get("userGetStartedStatus", defaultValue: false);

    /// To check the get started status for user
    var userAuthBox = Hive.box("userAuthStatusBox");
    bool userAuthStatusBox =
        userAuthBox.get("userAuthStatus", defaultValue: false);

    // Return the appropriate route based on login status
    if (userGetStartedStatus && userAuthStatusBox) {
      return "/bottomNav";
    } else if (userGetStartedStatus) {
      return "/authLoginScreen";
    } else {
      return "/getStartedFirstScreen";
    }
  }
}
