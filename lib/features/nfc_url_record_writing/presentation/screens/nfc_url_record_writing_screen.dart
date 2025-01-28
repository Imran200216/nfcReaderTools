import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';

class NfcUrlRecordWritingScreen extends StatelessWidget {
  const NfcUrlRecordWritingScreen({super.key});

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
          appBarTitleText: "Add a URL",
          leadingIconOnTap: () {
            GoRouter.of(context).pop();
          },
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// custom url text field
              NfcWritingTextField(
                hintText: "xxxxxxx.xxx",
                labelText: "*Enter your URL",
                prefixIcon: Icons.link,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
