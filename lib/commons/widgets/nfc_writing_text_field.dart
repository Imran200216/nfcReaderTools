import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class NfcWritingTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final String labelText; // New label text
  final IconData prefixIcon;
  final bool isPassword;
  final bool hasBorder;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const NfcWritingTextField({
    super.key,
    required this.hintText,
    required this.labelText, // Added labelText parameter
    required this.prefixIcon,
    this.isPassword = false,
    this.hasBorder = true,
    this.textEditingController,
    this.onTap,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  State<NfcWritingTextField> createState() => _NfcWritingTextFieldState();
}

class _NfcWritingTextFieldState extends State<NfcWritingTextField> {
  bool _isObscure = true; // State for toggling visibility

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      validator: widget.validator,
      cursorColor: AppColors.primaryColor,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      controller: widget.textEditingController,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColors.titleColor,
      ),
      obscureText: widget.isPassword ? _isObscure : false,
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: widget.hasBorder
              ? BorderSide(
            color: AppColors.outlinedBtnBorderColor,
            width: 1,
          )
              : BorderSide.none, // No border if hasBorder is false
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: widget.hasBorder
              ? BorderSide(
            color: AppColors.outlinedBtnBorderColor,
            width: 1,
          )
              : BorderSide.none, // No border if hasBorder is false
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: widget.hasBorder
              ? BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          )
              : BorderSide.none, // No border if hasBorder is false
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        labelText: widget.labelText,
        // Ensures the label text appears initially
        labelStyle: TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.titleColor,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textFieldHintColor,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        )
            : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 12.w,
        ),
        errorStyle: TextStyle(
          fontFamily: "DM Sans",
          color: AppColors.errorTextFieldColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always, // Ensure label is always shown
      ),
    );
  }
}
