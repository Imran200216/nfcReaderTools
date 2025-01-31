import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class NfcWritingTextArea extends StatelessWidget {
  final String hintText;
  final String labelText; // Added label text
  final TextEditingController? textEditingController;
  final bool readOnly;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const NfcWritingTextArea({
    super.key,
    required this.hintText,
    required this.labelText, // Added labelText parameter
    this.textEditingController,
    this.readOnly = false,
    this.maxLines = 5,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      readOnly: readOnly,
      maxLines: maxLines,
      controller: textEditingController,
      onChanged: onChanged,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColors.titleColor,
      ),
      decoration: InputDecoration(
        labelText: labelText, // Ensures label is always visible
        floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps label at the top
        fillColor: AppColors.whiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.outlinedBtnBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.outlinedBtnBorderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        labelStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 14.w,
        ),
      ),
    );
  }
}
