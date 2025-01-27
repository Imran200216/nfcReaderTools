import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavIcon extends StatelessWidget {
  final String svgIconPath;

  const BottomNavIcon({super.key, required this.svgIconPath});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/svg/$svgIconPath.svg",
      height: 14.h,
      width: 14.w,
      fit: BoxFit.cover,
    );
  }
}
