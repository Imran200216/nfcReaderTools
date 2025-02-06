import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:provider/provider.dart';

class NfcMailRecordWritingScreen extends StatefulWidget {
  const NfcMailRecordWritingScreen({super.key});

  @override
  State<NfcMailRecordWritingScreen> createState() =>
      _NfcMailRecordWritingScreenState();
}

class _NfcMailRecordWritingScreenState
    extends State<NfcMailRecordWritingScreen> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// controller
  final TextEditingController toMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// nfc notifier provider
    final nfcProvider = Provider.of<NFCNotifier>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  bool operationStarted = await nfcProvider.startNFCOperation(
                    nfcOperation: NFCOperation.write,
                    dataType: "MAIL",
                    payload: toMailController.text.trim(),
                    context: context,
                  );
                  if (operationStarted) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Consumer<NFCNotifier>(
                          builder: (context, nfcNotifier, child) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  nfcNotifier.isProcessing
                                      ? Lottie.asset(
                                          "assets/lottie/reading-animation.json",
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.contain,
                                        )
                                      : nfcNotifier.isSuccess
                                          ? Lottie.asset(
                                              "assets/lottie/success-animation.json",
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.contain,
                                            )
                                          : Container(),
                                  SizedBox(height: 30),
                                  Text(
                                    nfcNotifier.isSuccess
                                        ? "NFC Write Successfully!"
                                        : "Writing in NFC Tag...",
                                    style: const TextStyle(
                                      fontFamily: "DM Sans",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  // Debug print
                  print("NFC operation result: ${nfcProvider.isSuccess}");
                }
              },
            ),
          ],
          appBarTitleText: "Add Mail Record",
          leadingIconOnTap: () => GoRouter.of(context).pop(),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// person to mail
                  NfcWritingTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a mail id";
                      }

                      return null;
                    },
                    textEditingController: toMailController,
                    hintText: "Enter person email",
                    labelText: "*Person Email",
                    prefixIcon: Icons.alternate_email,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
