import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_area.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';
import 'package:nfcreadertools/features/nfc_text_record_writing/provider/nfc_text_record_writing_provider.dart';
import 'package:provider/provider.dart';

class NfcTextRecordWritingScreen extends StatelessWidget {
  const NfcTextRecordWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController for NFC text record input
    final TextEditingController nfcTextRecord = TextEditingController();

    // GlobalKey for the form validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    /// nfc text record writing provider
    final nfcTextRecordWritingProvider =
        Provider.of<NfcTextRecordWritingProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            /// Save button
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () {
                String recordType = "Text";
                String textRecord = nfcTextRecord.text.trim();

                if (formKey.currentState?.validate() ?? false) {
                  /// adding the text record writing
                  nfcTextRecordWritingProvider.addTextRecordWritingToNFCTag(
                      recordType, textRecord);

                  ToastHelper.showSuccessToast(
                    context: context,
                    message: "Text Record added to NFC Tag!",
                  );

                  /// clear the controller
                  nfcTextRecord.clear();
                } else {
                  ToastHelper.showErrorToast(
                    context: context,
                    message: "Text Record not updated to NFC Tag!",
                  );
                }
              },
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
          child: Form(
            key: formKey, // Attach the form key to the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NfcWritingTextArea(
                  textEditingController: nfcTextRecord,
                  hintText: "Enter your text",
                  labelText: "*Enter text record",
                  // Adding validator to the text area
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a text record.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
