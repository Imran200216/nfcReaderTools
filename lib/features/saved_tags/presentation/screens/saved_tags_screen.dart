import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_not_found_item.dart';

class SavedTagsScreen extends StatelessWidget {
  const SavedTagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitleText: "Saved Tags",
          leadingIconOnTap: () {},
          leadingIconPath: "nfc-splash-logo",
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
