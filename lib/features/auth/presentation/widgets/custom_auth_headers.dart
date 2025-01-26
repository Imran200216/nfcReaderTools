import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class CustomAuthHeaders extends StatelessWidget {
  final String authHeaderTitle;
  const CustomAuthHeaders({
    super.key,
    required this.authHeaderTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),

        /// app logo
        Center(
          child: SvgPicture.asset(
            "assets/icons/svg/nfc-splash-logo.svg",
            height: 40.h,
            width: 40.w,
            fit: BoxFit.cover,
            color: AppColors.primaryColor,
          ),
        ),

        SizedBox(
          height: 20.h,
        ),

        /// title
        Text(
          textAlign: TextAlign.center,
          authHeaderTitle,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.titleColor,
          ),
        ),
      ],
    );
  }
}
