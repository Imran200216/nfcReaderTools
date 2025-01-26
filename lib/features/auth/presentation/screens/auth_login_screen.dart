import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_icon_filled_btn.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_field.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_footer.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_headers.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_social_sign_in_btn.dart';

class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// auth sign in form key
    final GlobalKey formKey = GlobalKey<FormState>();

    /// textfield controllers
    final TextEditingController authLoginEmailController =
        TextEditingController();

    final TextEditingController authLoginPasswordController =
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
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// auth headers
                    CustomAuthHeaders(
                      authHeaderTitle: "Sign In To NFC Reader",
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
                      textEditingController: authLoginEmailController,
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
                      textEditingController: authLoginPasswordController,
                      hintText: "************",
                      prefixIcon: Icons.lock_outline,
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    /// Sign Up btn
                    CustomIconFilledBtn(
                      onTap: () {},
                      btnTitle: "Sign In",
                      iconPath: "next",
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    Row(
                      spacing: 6.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    Row(
                      spacing: 30.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// sign in with google
                        CustomAuthSocialSignInBtn(
                          socialIconPath: "google-auth",
                          onbtnTap: () {},
                        ),

                        /// sign in with apple
                        CustomAuthSocialSignInBtn(
                          socialIconPath: "apple-auth",
                          onbtnTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// don't have an account btn
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomAuthFooter(
                  authFooterText: "Don't have an account?",
                  authFooterTextBtnTitle: "Sign Up",
                  authFooterTextBtnOnTap: () {
                    GoRouter.of(context).pushNamed("authSignUpScreen");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
