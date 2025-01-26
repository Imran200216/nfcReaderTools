import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/splash/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Stack(
            children: [
              /// App logo
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

              /// Lottie animation
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  "assets/lottie/splash-animation.json",
                  height: 280.h,
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    // Wait for the animation to complete
                    Future.delayed(composition.duration, () {
                      splashProvider.navigateToGetStarted(context);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
