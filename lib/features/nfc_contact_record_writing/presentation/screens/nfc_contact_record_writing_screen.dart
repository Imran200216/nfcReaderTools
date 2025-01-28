import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/services/custom_haptic.dart';

class NfcContactRecordWritingScreen extends StatelessWidget {
  const NfcContactRecordWritingScreen({super.key});

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
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// contact name text field
                NfcWritingTextField(
                  hintText: "John Doe",
                  labelText: "*Contact name",
                  prefixIcon: Icons.person,
                ),

                /// email text field
                NfcWritingTextField(
                  hintText: "JohnDoe@gmail.com",
                  labelText: "Email",
                  prefixIcon: Icons.email,
                ),

                /// website text field
                NfcWritingTextField(
                  hintText: "www.JohnDoecompany.com",
                  labelText: "Website",
                  prefixIcon: Icons.web,
                ),

                /// phone number text field
                NfcWritingTextField(
                  hintText: "+91 1234567890",
                  labelText: "Phone Number",
                  prefixIcon: Icons.phone,
                ),

                /// phone number text field
                NfcWritingTextField(
                  hintText: "01 Puducherry City",
                  labelText: "Address",
                  prefixIcon: Icons.location_city,
                ),

                /// importing form the mobile
                TextButton(
                  onPressed: () {
                    CustomHapticFeedbackUtility.mediumImpact();
                  },
                  child: Row(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Import Your Contact",
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icons/svg/contact-record.svg",
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.cover,
                        color: AppColors.primaryColor,
                      ),
                    ],
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
