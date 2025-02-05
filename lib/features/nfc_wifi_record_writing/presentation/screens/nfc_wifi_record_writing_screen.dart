import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_drop_down_text_field.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:nfcreadertools/features/nfc_wifi_record_writing/provider/nfc_wifi_setting_provider.dart';
import 'package:provider/provider.dart';

class NfcWifiRecordWritingScreen extends StatelessWidget {
  NfcWifiRecordWritingScreen({super.key});

  /// Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// Wifi setting provider to get selected options.
    final wifiSettingProvider = Provider.of<WifiSettingsProvider>(context);

    /// Controllers for SSID and Password.
    final TextEditingController wifiSSIDController = TextEditingController();
    final TextEditingController wifiPasswordController =
        TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  // Retrieve NFCNotifier provider.
                  final nfcProvider =
                      Provider.of<NFCNotifier>(context, listen: false);

                  // Construct the payload string from the input fields and dropdown values.
                  // The payload format is: SSID|Password|AuthType|EncryptionType
                  final String payload = "${wifiSSIDController.text}|"
                      "${wifiPasswordController.text}|"
                      "${wifiSettingProvider.selectedAuthWifiOption}|"
                      "${wifiSettingProvider.selectedEncryptionWifiOption}";

                  // Start the NFC write operation with the "WIFI" data type.
                  bool operationStarted = await nfcProvider.startNFCOperation(
                    context: context,
                    nfcOperation: NFCOperation.write,
                    dataType: "WIFI",
                    payload: payload,
                  );

                  // Optionally, if you want to show a bottom sheet after a successful start:
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
                                      ? SizedBox(
                                          height: 200.h,
                                          width: 200.w,
                                          child:
                                              const CircularProgressIndicator(),
                                        )
                                      : nfcNotifier.isSuccess
                                          ? SizedBox(
                                              height: 200.h,
                                              width: 200.w,
                                              child: const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 150,
                                              ),
                                            )
                                          : Container(),
                                  SizedBox(height: 30.h),
                                  Text(
                                    nfcNotifier.isSuccess
                                        ? "WiFi details written to NFC successfully!"
                                        : "Writing WiFi details to NFC...",
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
          appBarTitleText: "Add WiFi NFC Record",
          leadingIconOnTap: () {
            GoRouter.of(context).pop();
          },
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Wifi Authentication Dropdown Field
                  CustomDropdownTextField<String>(
                    hintText: "Select an option",
                    labelText: "Wifi Authentication",
                    items: [
                      "Open",
                      "WPA-Personal",
                      "Shared",
                      "WPA-Enterprise",
                      "WPA2-Enterprise",
                      "WPA2-Personal",
                      "WPA/WPA2-Personal",
                    ],
                    value: wifiSettingProvider.selectedAuthWifiOption,
                    onChanged: wifiSettingProvider.setAuthWifiOption,
                    validator: (value) => value == null
                        ? "Please select an authentication method"
                        : null,
                  ),

                  SizedBox(height: 20.h),

                  /// Wifi Encryption Dropdown Field
                  CustomDropdownTextField<String>(
                    hintText: "Select an option",
                    labelText: "Wifi Encryption",
                    items: [
                      "None",
                      "WEP",
                      "TKIP",
                      "AES",
                      "AES/TKIP",
                    ],
                    value: wifiSettingProvider.selectedEncryptionWifiOption,
                    onChanged: wifiSettingProvider.setEncryptionWifiOption,
                    validator: (value) => value == null
                        ? "Please select an encryption type"
                        : null,
                  ),

                  SizedBox(height: 20.h),

                  /// SSID Text Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: NfcWritingTextField(
                      textEditingController: wifiSSIDController,
                      hintText: "Enter SSID",
                      labelText: "SSID",
                      prefixIcon: Icons.wifi,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter SSID"
                          : null,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// Password Text Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: NfcWritingTextField(
                      isPassword: true,
                      textEditingController: wifiPasswordController,
                      hintText: "********",
                      labelText: "Password",
                      prefixIcon: Icons.lock,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter Password"
                          : null,
                    ),
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
