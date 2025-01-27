import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomNfcToolsCard extends StatelessWidget {
  final VoidCallback cardOnTap;
  final String cardTitle;
  final String cardSubTitle;
  final String cardSvgPath;

  const CustomNfcToolsCard({
    super.key,
    required this.cardOnTap,
    required this.cardTitle,
    required this.cardSubTitle,
    required this.cardSvgPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomHapticFeedbackUtility.lightImpact();

        cardOnTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.nfcToolsCardColor,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8.h,
            children: [
              Row(
                spacing: 10.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// title
                  Text(
                    cardTitle,
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w700,
                      color: AppColors.titleColor,
                      fontSize: 18.sp,
                    ),
                  ),

                  /// icon
                  SvgPicture.asset(
                    "assets/icons/svg/$cardSvgPath.svg",
                    height: 30.h,
                    width: 30.w,
                    fit: BoxFit.cover,
                    color: AppColors.primaryColor,
                  )
                ],
              ),

              /// subtitle
              Text(
                textAlign: TextAlign.start,
                cardSubTitle,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontWeight: FontWeight.w500,
                  color: AppColors.nfcToolsCardSubTitleColor,
                  fontSize: 14.sp,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10.w,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Scan",
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryColor,
                    size: 20.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
