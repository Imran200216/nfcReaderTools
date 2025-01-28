import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/models/nfc_writing_card_data.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class CustomNfcWritingCard extends StatelessWidget {
  final NFCWritingCardData data;

  const CustomNfcWritingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(data.route);
      },
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: AppColors.nfcToolsCardColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 5.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    data.iconPath,
                    height: 22.h,
                    width: 22.w,
                    fit: BoxFit.cover,
                    color: AppColors.primaryColor,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.nfcToolsCardSubTitleColor,
                    size: 14.h,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.start,
                data.title,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                textAlign: TextAlign.start,
                data.subtitle,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.nfcToolsCardSubTitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
