import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isLoading = false;

  GoogleSignInAccount? get user => _user;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return;
      }

      _user = googleUser;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((_) {
        ToastHelper.showSuccessToast(
          context: context,
          message: "Google Sign In Successful!",
        );
      });
    } catch (e) {
      print('Error signing in with Google: $e');
      ToastHelper.showErrorToast(
        context: context,
        message: "Google Sign In Not Successful!",
      );
    } finally {
      _setLoading(false);
    }
  }

  // Sign out
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      _user = null;
    } catch (e) {
      print('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Check authentication state
  Future<bool> isUserSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
