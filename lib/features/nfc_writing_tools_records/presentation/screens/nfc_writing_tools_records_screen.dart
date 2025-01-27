import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_icon_filled_btn.dart';
import 'package:nfcreadertools/commons/widgets/custom_not_found_item.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class NfcWritingToolsRecordsScreen extends StatelessWidget {
  const NfcWritingToolsRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            IconButton(
              onPressed: () {
                CustomHapticFeedbackUtility.lightImpact();
                GoRouter.of(context).pushNamed("nfcAddWritingRecordsScreen");
              },
              icon: Icon(
                Icons.add,
                color: AppColors.titleColor,
              ),
            )
          ],
          appBarTitleText: "Records",
          leadingIconOnTap: () {
            GoRouter.of(context).pop();
          },
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        bottomSheet: SizedBox(
          height: 80.h, // Specify the height of the bottom sheet
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: AppColors.whiteColor,
            child: Center(
              child: CustomIconFilledBtn(
                onTap: () {
                  GoRouter.of(context).pushNamed("nfcAddWritingRecordsScreen");
                },
                btnTitle: "Add Records",
                iconPath: "nfc-splash-logo",
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: CustomNotFoundItem(
            notFoundImgPath: "no-saved-tag-found",
            descriptionText: "No Writing Records Found",
          ),
        ),
      ),
    );
  }
}
