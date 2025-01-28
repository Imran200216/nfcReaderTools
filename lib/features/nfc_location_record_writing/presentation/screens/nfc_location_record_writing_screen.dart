import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';

class NfcLocationRecordWritingScreen extends StatelessWidget {
  const NfcLocationRecordWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            /// save btn
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () {},
            ),
          ],
          appBarTitleText: "Add Location",
          leadingIconOnTap: () {
            GoRouter.of(context).pop();
          },
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NfcWritingTextField(
                  hintText: "https://maps.google.com?q=40.748817,-73.985428",
                  labelText: "*Enter the location URL",
                  prefixIcon: Icons.link,
                ),
                NfcWritingTextField(
                  hintText: "40.748817",
                  labelText: "*Enter latitude",
                  prefixIcon: Icons.map,
                ),
                NfcWritingTextField(
                  hintText: "-73.985428",
                  labelText: "*Enter longitude",
                  prefixIcon: Icons.map,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
