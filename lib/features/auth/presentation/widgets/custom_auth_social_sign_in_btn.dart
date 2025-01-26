import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomAuthSocialSignInBtn extends StatelessWidget {
  final String socialIconPath;
  final VoidCallback onbtnTap;

  const CustomAuthSocialSignInBtn({
    super.key,
    required this.socialIconPath,
    required this.onbtnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomHapticFeedbackUtility.mediumImpact();
        onbtnTap();
      },
      child: Container(
        height: 48.h,
        width: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.transparentColor,
          border: Border.all(
            color: AppColors.dividerColor,
            width: 1.2,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/svg/$socialIconPath.svg",
            height: 20.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
