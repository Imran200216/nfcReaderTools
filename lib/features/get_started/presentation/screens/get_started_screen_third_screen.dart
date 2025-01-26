import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/get_started/presentation/widgets/get_started.dart';

class GetStartedThirdScreen extends StatelessWidget {
  const GetStartedThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: GetStarted(
          imgPath: "accuracy-img",
          getStartedTitle: "Your NFC, Your Way",
          getStartedSubTitle:
              "Experience a user-friendly NFC platform that prioritizes speed, accuracy, and security for all your needs.",
          onContinueTap: () {
            GoRouter.of(context).pushReplacementNamed("authSignUpScreen");
          },
          btnTitle: "Get Started",
        ),
      ),
    );
  }
}
