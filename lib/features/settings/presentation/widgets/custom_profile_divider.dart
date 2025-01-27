import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class CustomProfileDivider extends StatelessWidget {
  const CustomProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.7.h,
      color: AppColors.profileDividerColor,
    );
  }
}
