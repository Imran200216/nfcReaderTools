import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class CustomNotFoundItem extends StatelessWidget {
  final String notFoundImgPath;
  final String descriptionText;

  const CustomNotFoundItem({
    super.key,
    required this.notFoundImgPath,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 14.h,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/img/svg/$notFoundImgPath.svg",
            height: 240.h,
            width: 200.w,
            fit: BoxFit.contain,
          ),
          Text(
            descriptionText,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
