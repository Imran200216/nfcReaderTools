import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomAuthFooter extends StatelessWidget {
  final String authFooterText;
  final String authFooterTextBtnTitle;
  final VoidCallback authFooterTextBtnOnTap;

  const CustomAuthFooter({
    super.key,
    required this.authFooterText,
    required this.authFooterTextBtnTitle,
    required this.authFooterTextBtnOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          authFooterText,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.titleColor,
          ),
        ),
        TextButton(
          onPressed: () {
            CustomHapticFeedbackUtility.mediumImpact();
            authFooterTextBtnOnTap();
          },
          child: Text(
            authFooterTextBtnTitle,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
