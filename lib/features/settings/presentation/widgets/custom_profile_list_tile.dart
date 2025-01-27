import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomProfileListTile extends StatelessWidget {
  final String listTileTitleText;
  final VoidCallback listTileOnTap;
  final String leadingIconPath;

  const CustomProfileListTile({
    super.key,
    required this.listTileTitleText,
    required this.listTileOnTap,
    required this.leadingIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 2.h,
      ),
      child: ListTile(
        onTap: () {
          CustomHapticFeedbackUtility.mediumImpact();

          listTileOnTap();
        },
        title: Text(listTileTitleText),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 14.h,
        ),
        leading: SvgPicture.asset(
          "assets/icons/svg/$leadingIconPath.svg",
          height: 20.h,
          width: 20.w,
          fit: BoxFit.cover,
          color: AppColors.listTileTitleColor,
        ),
        titleTextStyle: TextStyle(
          fontFamily: "DM Sans",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.listTileTitleColor,
        ),
      ),
    );
  }
}
