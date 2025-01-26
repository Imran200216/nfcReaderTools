import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/get_started/presentation/widgets/get_started.dart';

class GetStartedSecondScreen extends StatelessWidget {
  const GetStartedSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: GetStarted(
          imgPath: "social-img",
          getStartedTitle: "Unlock NFC Potential",
          getStartedSubTitle:
              "Explore advanced features to manage, customize, and enhance your NFC interactions effortlessly.",
          onContinueTap: () {
            GoRouter.of(context).pushReplacementNamed("getStartedThirdScreen");
          },
          btnTitle: "Continue",
        ),
      ),
    );
  }
}
