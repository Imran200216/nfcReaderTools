import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashProvider extends ChangeNotifier {
  bool _isAnimationCompleted = false;

  bool get isAnimationCompleted => _isAnimationCompleted;

  /// Sets the animation completion state
  void completeAnimation() {
    _isAnimationCompleted = true;
    notifyListeners();
  }

  /// Navigates to the "Get Started" screen
  void navigateToGetStarted(BuildContext context) {
    if (!_isAnimationCompleted) {
      _isAnimationCompleted = true;
      notifyListeners();

      /// pushing to get started screen
      GoRouter.of(context).pushReplacementNamed("getStartedFirstScreen");
    }
  }
}
