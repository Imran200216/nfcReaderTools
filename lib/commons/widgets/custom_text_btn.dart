import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomTextBtn extends StatelessWidget {
  final String textBtnTitleText;
  final VoidCallback onTap;

  const CustomTextBtn({
    super.key,
    required this.textBtnTitleText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        CustomHapticFeedbackUtility.mediumImpact();

        onTap();
      },
      child: Text(
        textBtnTitleText,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
