import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_icon_filled_btn.dart';
import 'package:nfcreadertools/commons/widgets/custom_outlined_icon_btn.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_field.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/apple_sign_in_provider.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/email_password_auth_provider.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/google_sign_in_provider.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_footer.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_headers.dart';
import 'package:nfcreadertools/features/auth/presentation/widgets/custom_auth_social_sign_in_btn.dart';
import 'package:provider/provider.dart';

class AuthLoginScreen extends StatelessWidget {
  AuthLoginScreen({super.key});

  /// Form key for validation¬
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController authLoginEmailController =
      TextEditingController();
  final TextEditingController authLoginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// email auth provider
    final emailPasswordAuthProvider =
        Provider.of<EmailPasswordAuthProvider>(context);

    /// google auth provider
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    /// apple auth provider
    final appleSignInProvider = Provider.of<AppleSignInProvider>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.authBgColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Stack(
            children: [
              Form(
                key: _formKey, // Attach form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Auth Header
                    CustomAuthHeaders(authHeaderTitle: "Sign In To NFC Reader"),

                    SizedBox(height: 30.h),

                    /// Email Label
                    Text(
                      "Email Address",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Email Text Field with Validation
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: authLoginEmailController,
                      hintText: "Enter your email address...",
                      prefixIcon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15.h),

                    /// Password Label
                    Text(
                      "Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Password Text Field with Validation
                    CustomTextField(
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      textEditingController: authLoginPasswordController,
                      hintText: "************",
                      prefixIcon: Icons.lock_outline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30.h),

                    /// Sign In Button
                    CustomIconFilledBtn(
                      isLoading: emailPasswordAuthProvider.isLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          /// Proceed with sign-in
                          emailPasswordAuthProvider
                              .signInWithEmailPassword(
                            authLoginEmailController.text.trim(),
                            authLoginPasswordController.text.trim(),
                            context,
                          )
                              .then((value) {
                            GoRouter.of(context).pushNamed("bottomNav");
                          });
                        }
                      },
                      btnTitle: "Sign In",
                      iconPath: "next",
                    ),

                    SizedBox(height: 30.h),

                    /// OR Divider
                    Row(
                      spacing: 6.w,
                      mainAxisAlignment: MainAxisAlignment.center,
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

                    SizedBox(height: 30.h),

                    Platform.isAndroid
                        ? CustomOutlinedIconBtn(
                            onTap: () {
                              googleSignInProvider
                                  .signInWithGoogle(context)
                                  .then(
                                (value) {
                                  GoRouter.of(context)
                                      .pushReplacementNamed("bottomNav");
                                },
                              );
                            },
                            btnTitle: "Login with Google",
                            isLoading: googleSignInProvider.isLoading,
                            iconPath: "google-auth",
                          )
                        :

                        /// Social Login Buttons
                        Row(
                            spacing: 30.w,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// google auth sign in btn
                              CustomAuthSocialSignInBtn(
                                socialIconPath: "google-auth",
                                onBtnTap: () {
                                  googleSignInProvider
                                      .signInWithGoogle(context)
                                      .then(
                                    (value) {
                                      GoRouter.of(context)
                                          .pushReplacementNamed("bottomNav");
                                    },
                                  );
                                },
                              ),

                              /// apple auth sign in btn
                              CustomAuthSocialSignInBtn(
                                socialIconPath: "apple-auth",
                                onBtnTap: () {
                                  appleSignInProvider
                                      .signInWithApple(context)
                                      .then(
                                    (value) {
                                      GoRouter.of(context)
                                          .pushReplacementNamed("bottomNav");
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),

              /// Sign Up Footer
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
