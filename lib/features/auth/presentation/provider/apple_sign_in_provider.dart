import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInProvider extends ChangeNotifier {
  /// Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    try {
      // Get Apple ID credentials
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuth credential for Firebase authentication
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredentials.identityToken,
        accessToken: appleCredentials.authorizationCode,
      );

      // Sign in with the Apple credential using Firebase Authentication
      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Sign In Successfull!",
          );
        },
      );

      // You can now use the Firebase user for your application.
    } catch (error) {
      print("Apple Sign-In Error: ${error.toString()}");
      ToastHelper.showErrorToast(
        context: context,
        message: "Sign In Unsuccessfull!",
      );
    }
  }
}
