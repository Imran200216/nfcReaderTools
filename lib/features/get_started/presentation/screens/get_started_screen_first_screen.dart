import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/get_started/presentation/widgets/get_started.dart';

class GetStartedScreenFirstScreen extends StatelessWidget {
  const GetStartedScreenFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: GetStarted(
          imgPath: "share-img",
          getStartedTitle: "Seamless NFC Interaction",
          getStartedSubTitle:
              "Effortlessly read and write all NFC formats while keeping your data up-to-date and secure.",
          onContinueTap: () {
            GoRouter.of(context).pushReplacementNamed("getStartedSecondScreen");
          },
          btnTitle: "Continue",
        ),
      ),
    );
  }
}
