import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';

class EmailPasswordAuthProvider extends ChangeNotifier {
  /// loading state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sign up with email and password
  Future<void> signUpWithEmailPassword(
      String name, // <-- Add name parameter
      String emailAddress,
      String password,
      BuildContext context,
      ) async {
    _setLoading(true);
    try {
      // Create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Set display name for Firebase user
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      final uid = FirebaseAuth.instance.currentUser!.uid;

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "userName": name,
        "userEmail": emailAddress,
        "userUID": uid,
      });

      ToastHelper.showSuccessToast(
        context: context,
        message: "Authentication Success",
      );

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Password is too weak",
        );
      } else if (e.code == 'email-already-in-use') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Account already exists",
        );
      }

      notifyListeners();
    } catch (e) {
      ToastHelper.showErrorToast(
        context: context,
        message: e.toString(),
      );
      notifyListeners();
    } finally {
      _setLoading(false);
    }

    notifyListeners();
  }


  /// Sign in with email and password
  Future<void> signInWithEmailPassword(
      String emailAddress, String password, BuildContext context) async {
    _setLoading(true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: emailAddress,
        password: password,
      )
          .then(
        (value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Sign In Successfull",
          );
        },
      );

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastHelper.showErrorToast(
          context: context,
          message: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Incorrect password!",
        );
      }

      notifyListeners();
    } finally {
      _setLoading(false);
    }

    notifyListeners();
  }
}
