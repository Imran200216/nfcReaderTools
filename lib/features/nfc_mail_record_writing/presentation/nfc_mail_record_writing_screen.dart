import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';

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
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController composeMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            CustomTextBtn(
              textBtnTitleText: "Save",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // Proceed with saving logic
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// person to email
                NfcWritingTextField(
                  hintText: "Enter person email",
                  labelText: "*Person Email",
                  prefixIcon: Icons.alternate_email,
                ),

                SizedBox(height: 20.h),

                /// subject email
                NfcWritingTextField(
                  hintText: "Enter subject",
                  labelText: "*Subject",
                  prefixIcon: Icons.subject,
                ),

                SizedBox(height: 20.h),

                /// compose mail
                NfcWritingTextField(
                  hintText: "Enter compose",
                  labelText: "*Compose",
                  prefixIcon: Icons.text_fields,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
