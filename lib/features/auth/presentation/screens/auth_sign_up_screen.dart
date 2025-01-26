import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_icon_filled_btn.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_field.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_footer.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_headers.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    /// auth sign up form key
    final GlobalKey formKey = GlobalKey<FormState>();

    /// textfield controllers
    final TextEditingController authSignUpEmailController =
        TextEditingController();

    final TextEditingController authSignUpPasswordController =
        TextEditingController();

    final TextEditingController authSignUpConfirmPasswordController =
        TextEditingController();

    return SafeArea(
      child: Scaffold( 
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.authBgColor,
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// auth headers
                CustomAuthHeaders(
                  authHeaderTitle: "Sign Up For Free",
                ),

                SizedBox(height: 30.h),

                /// email address text
                Text(
                  textAlign: TextAlign.center,
                  "Email Address",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                ),

                SizedBox(
                  height: 12.h,
                ),

                /// email address text field
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: authSignUpEmailController,
                  hintText: "Enter your email address...",
                  prefixIcon: Icons.email_outlined,
                ),

                SizedBox(
                  height: 15.h,
                ),

                /// password text
                Text(
                  textAlign: TextAlign.center,
                  "Password",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                ),

                SizedBox(
                  height: 12.h,
                ),

                /// password text field
                CustomTextField(
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: authSignUpPasswordController,
                  hintText: "************",
                  prefixIcon: Icons.lock_outline,
                ),

                SizedBox(
                  height: 15.h,
                ),

                ///  confirm password text
                Text(
                  textAlign: TextAlign.center,
                  "Confirm Password",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                ),

                SizedBox(
                  height: 12.h,
                ),

                /// confirm password text field
                CustomTextField(
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: authSignUpConfirmPasswordController,
                  hintText: "************",
                  prefixIcon: Icons.lock_outline,
                ),

                const Spacer(
                  flex: 1,
                ),

                /// Sign Up btn
                CustomIconFilledBtn(
                  onTap: () {
                    GoRouter.of(context).pushNamed("bottomNav");
                  },
                  btnTitle: "Sign Up",
                  iconPath: "next",
                ),

                SizedBox(
                  height: 10.h,
                ),

                /// Login screen navigation btn
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomAuthFooter(
                    authFooterText: "Already have an account?",
                    authFooterTextBtnTitle: "Sign In",
                    authFooterTextBtnOnTap: () {
                      GoRouter.of(context).pushNamed("authLoginScreen");
                    },
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
