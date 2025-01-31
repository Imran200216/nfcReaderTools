import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';

class CustomDropdownTextField<T> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final String labelText;
  final T? value;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;
  final EdgeInsetsGeometry margin;

  const CustomDropdownTextField({
    super.key,
    required this.items,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    this.value,
    this.validator,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
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
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: "DM Sans",
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: AppColors.textFieldHintColor,
          ),
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: TextStyle(
                fontFamily: "DM Sans",
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: AppColors.titleColor,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.titleColor,
        ),
        dropdownColor: AppColors.whiteColor,
      ),
    );
  }
}
