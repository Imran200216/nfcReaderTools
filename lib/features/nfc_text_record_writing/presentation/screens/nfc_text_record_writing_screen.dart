import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_area.dart';

class NfcTextRecordWritingScreen extends StatelessWidget {
  const NfcTextRecordWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// nfc text record controllers
    final TextEditingController nfcTextRecord = TextEditingController();

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
          appBarTitleText: "Add a Text Record",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NfcWritingTextArea(
                textEditingController: nfcTextRecord,
                hintText: "Enter your text",
                labelText: "*Enter text record",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
