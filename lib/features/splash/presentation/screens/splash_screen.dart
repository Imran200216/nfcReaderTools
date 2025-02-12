import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final Future<String> Function() onDecideRoute;

  const SplashScreen({super.key, required this.onDecideRoute});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimationCompleted = false;
  late GoRouter _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _router = GoRouter.of(context);
  }

  /// navigation after animation
  void _navigateAfterAnimation() async {
    final nextRoute = await widget.onDecideRoute();
    if (mounted) {
      _router.replace(nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () async {
      if (!_isAnimationCompleted) {
        _navigateAfterAnimation();
      }
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // App logo
          Padding(
            padding: EdgeInsets.only(top: 130.h),
            child: Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/icons/svg/nfc-splash-logo.svg",
                color: AppColors.primaryColor,
                height: 80.h,
                width: 80.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Lottie animation with onLoaded callback
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(
              "assets/lottie/splash-animation.json",
              height: 280.h,
              fit: BoxFit.contain,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  if (mounted && !_isAnimationCompleted) {
                    _isAnimationCompleted = true;
                    _navigateAfterAnimation();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
