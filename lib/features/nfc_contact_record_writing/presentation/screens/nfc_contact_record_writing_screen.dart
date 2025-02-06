import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:provider/provider.dart';

class NfcContactRecordWritingScreen extends StatefulWidget {
  const NfcContactRecordWritingScreen({super.key});

  @override
  State<NfcContactRecordWritingScreen> createState() =>
      _NfcContactRecordWritingScreenState();
}

class _NfcContactRecordWritingScreenState
    extends State<NfcContactRecordWritingScreen> {
  @override
  Widget build(BuildContext context) {
    /// controllers
    final TextEditingController contactNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController websiteController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    /// nfc notifier provider
    final nfcProvider = Provider.of<NFCNotifier>(context);

    /// Form key for validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            /// save btn
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  bool operationStarted = await nfcProvider.startNFCOperation(
                    nfcOperation: NFCOperation.write,
                    dataType: "CALL",
                    payload: phoneNumberController.text.trim(),
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
                                          fit: BoxFit.contain,
                                        )
                                      : nfcNotifier.isSuccess
                                          ? Lottie.asset(
                                              "assets/lottie/success-animation.json",
                                              height: 200.h,
                                              width: 200.w,
                                              fit: BoxFit.contain,
                                            )
                                          : Container(),
                                  SizedBox(height: 30),
                                  Text(
                                    nfcNotifier.isSuccess
                                        ? "NFC Write Successfully!"
                                        : "Writing in NFC Tag...",
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18.sp,
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
                }
              },
            ),
          ],
          appBarTitleText: "Add Contact",
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
            child: Form(
              key: formKey,
              child: Column(
                spacing: 18.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// contact name text field
                  NfcWritingTextField(
                    textEditingController: contactNameController,
                    hintText: "John Doe",
                    labelText: "Contact name",
                    prefixIcon: Icons.person,
                  ),

                  /// email text field
                  NfcWritingTextField(
                    textEditingController: emailController,
                    hintText: "JohnDoe@gmail.com",
                    labelText: "Email",
                    prefixIcon: Icons.email,
                  ),

                  /// website text field
                  NfcWritingTextField(
                    textEditingController: websiteController,
                    hintText: "www.JohnDoeCompany.com",
                    labelText: "Website",
                    prefixIcon: Icons.web,
                  ),

                  /// phone number text field
                  NfcWritingTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a phone number";
                      }
                      final phonePattern = r'^\+?[0-9]{10,15}$';
                      final regex = RegExp(phonePattern);
                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                    textEditingController: phoneNumberController,
                    hintText: "+91 1234567890",
                    labelText: "*Phone Number",
                    prefixIcon: Icons.phone,
                  ),

                  /// phone number text field
                  NfcWritingTextField(
                    textEditingController: addressController,
                    hintText: "01 Puducherry City",
                    labelText: "Address",
                    prefixIcon: Icons.location_city,
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
