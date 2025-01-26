import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfcreadertools/commons/widgets/custom_icon_filled_btn.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class GetStarted extends StatelessWidget {
  final String imgPath;
  final String getStartedTitle;
  final String getStartedSubTitle;
  final VoidCallback onContinueTap;
  final String btnTitle;

  const GetStarted({
    super.key,
    required this.imgPath,
    required this.getStartedTitle,
    required this.getStartedSubTitle,
    required this.onContinueTap,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// svg image
          SvgPicture.asset(
            "assets/img/svg/$imgPath.svg",
            height: 300.h,
            width: 300.w,
            fit: BoxFit.cover,
          ),

          SizedBox(
            height: 20.h,
          ),

          /// title
          Text(
            textAlign: TextAlign.center,
            getStartedTitle,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.titleColor,
            ),
          ),

          /// description
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Text(
              textAlign: TextAlign.center,
              getStartedSubTitle,
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.subTitleColor,
              ),
            ),
          ),

          const Spacer(
            flex: 1,
          ),

          /// continue btn
          CustomIconFilledBtn(
            onTap: () {
              onContinueTap();
            },
            btnTitle: btnTitle,
            iconPath: "next",
          )
        ],
      ),
    );
  }
}
