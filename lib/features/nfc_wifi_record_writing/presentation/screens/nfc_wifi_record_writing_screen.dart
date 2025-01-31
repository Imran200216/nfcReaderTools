import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
    /// wifi setting provider
    final wifiSettingProvider = Provider.of<WifiSettingsProvider>(context);

    /// controllers
    final TextEditingController wifiSSIDController = TextEditingController();
    final TextEditingController wifiPasswordController =
        TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                  print("Form is valid. Submitting data...");
                }
              },
            ),
          ],
          appBarTitleText: "Add Social Share Record",
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
                  /// Wifi Auth Dropdown Field
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

                  /// SSID Password Text Field
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
