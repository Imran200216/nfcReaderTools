import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitleText;
  final VoidCallback leadingIconOnTap;
  final String leadingIconPath;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.appBarTitleText,
    required this.leadingIconOnTap,
    required this.leadingIconPath,
    this.actions, // Optional actions
    this.centerTitle = false, // Default is false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      // Use the parameter
      backgroundColor: AppColors.transparentColor,
      leading: InkWell(
        onTap: () {
          CustomHapticFeedbackUtility.mediumImpact();
          leadingIconOnTap();
        },
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/svg/$leadingIconPath.svg",
            height: 26.h,
            width: 26.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(appBarTitleText),
      titleTextStyle: TextStyle(
        fontFamily: "DM Sans",
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.titleColor,
      ),
      actions: actions, // Pass the actions if provided
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
