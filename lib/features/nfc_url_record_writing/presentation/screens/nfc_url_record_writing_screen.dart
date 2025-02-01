import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';
import 'package:provider/provider.dart';

class NfcUrlRecordWritingScreen extends StatelessWidget {
  NfcUrlRecordWritingScreen({super.key});

  /// Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// controllers
    final TextEditingController urlController = TextEditingController();

    /// nfc notifier provider
    final nfcProvider = Provider.of<NFCNotifier>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            /// Save button with validation
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  /// writing the URL Record data in the NFC Tag
                  nfcProvider.startNFCOperation(
                    nfcOperation: NFCOperation.write,
                    dataType: "URL",
                    payload: urlController.text.trim(),
                    context: context,
                  );

                  // Debug print
                  print("NFC operation result: ${nfcProvider.isSuccess}");

                  // Show a toast based on the result
                  if (nfcProvider.isSuccess) {
                    ToastHelper.showSuccessToast(
                      context: context,
                      message: "The URL Record is added to the NFC Tag",
                    );
                  } else {
                    ToastHelper.showErrorToast(
                      context: context,
                      message: "Not Added successfully!",
                    );
                  }
                }
              },
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
          child: Form(
            key: _formKey, // Assign form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// Custom URL text field with validation
                NfcWritingTextField(
                  textEditingController: urlController,
                  hintText: "xxxxxxx.xxx",
                  labelText: "*Enter your URL",
                  prefixIcon: Icons.link,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a URL";
                    }
                    final urlPattern =
                        r'^(https?:\/\/)?([\w\d-]+\.)+\w{2,}(\/.*)?$';
                    final regex = RegExp(urlPattern);
                    if (!regex.hasMatch(value)) {
                      return "Please enter a valid URL";
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
