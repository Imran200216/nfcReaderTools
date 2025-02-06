import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_drop_down_text_field.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:nfcreadertools/features/nfc_social_share_record_writing/provider/nfc_social_share_provider.dart';
import 'package:provider/provider.dart';

class NfcSocialShareRecordWritingScreen extends StatefulWidget {
  const NfcSocialShareRecordWritingScreen({super.key});

  @override
  State<NfcSocialShareRecordWritingScreen> createState() =>
      _NfcSocialShareRecordWritingScreenState();
}

class _NfcSocialShareRecordWritingScreenState
    extends State<NfcSocialShareRecordWritingScreen> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// controller
  final TextEditingController socialNetworkUrlController =
      TextEditingController();

  @override
  void dispose() {
    socialNetworkUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// nfc social share provider
    final nfcSocialShareProvider = Provider.of<NfcSocialShareProvider>(context);

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
                    dataType: "URL",
                    payload: socialNetworkUrlController.text.trim(),
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
          appBarTitleText: "Add Social Share Record",
          leadingIconOnTap: () => GoRouter.of(context).pop(),
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Social Network Dropdown Field
                CustomDropdownTextField<String>(
                  hintText: "Select a social option",
                  labelText: "*Social Networks",
                  items: [
                    "Instagram",
                    "Facebook",
                    "Linktree",
                    "Github",
                    "Youtube",
                    "Others",
                  ],
                  value: nfcSocialShareProvider.selectedSocialPlatform,
                  onChanged: nfcSocialShareProvider.setSocialPlatform,
                  validator: (value) =>
                      value == null ? "Please select a social network" : null,
                ),
                SizedBox(height: 20.h),

                /// Social Network URL Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: NfcWritingTextField(
                    textEditingController: socialNetworkUrlController,
                    hintText: "Enter Social Network URL",
                    labelText: "Social URL",
                    prefixIcon: Icons.link_sharp,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Please enter a valid social network URL"
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
