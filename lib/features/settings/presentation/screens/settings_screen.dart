import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_divider.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                color: AppColors.primaryColor,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// email address text
                    Text(
                      textAlign: TextAlign.center,
                      "Settings",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.whiteColor,
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    Row(
                      spacing: 14.w,
                      children: [
                        // profile image
                        Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?q=80&w=1966&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                "assets/img/jpg/person-placeholder.jpeg",
                                // Path to your placeholder image
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/img/jpg/person-placeholder.jpeg",
                                // Path to your error image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// person name
                            Text(
                              "Mohammed Imran",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                                fontSize: 16.sp,
                              ),
                            ),

                            /// email address
                            Text(
                              "mohammedimran@gmail.com",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),

            /// about dev
            CustomProfileListTile(
              listTileTitleText: "About Dev",
              listTileOnTap: () {
                /// my profile website
                launchUrl(
                  Uri.parse("https://linktr.ee/Imran_B"),
                );
              },
              leadingIconPath: "dev",
            ),

            CustomProfileDivider(),

            /// review app
            CustomProfileListTile(
              listTileTitleText: "Review App",
              listTileOnTap: () {},
              leadingIconPath: "review",
            ),

            CustomProfileDivider(),

            /// review app
            CustomProfileListTile(
              listTileTitleText: "Share App",
              listTileOnTap: () {},
              leadingIconPath: "share",
            ),

            CustomProfileDivider(),

            /// privacy policy
            CustomProfileListTile(
              listTileTitleText: "Privacy policy",
              listTileOnTap: () {},
              leadingIconPath: "privacy-policy",
            ),

            CustomProfileDivider(),

            /// log out
            CustomProfileListTile(
              listTileTitleText: "Logout",
              listTileOnTap: () {},
              leadingIconPath: "logout",
            ),

            CustomProfileDivider(),
          ],
        ),
      ),
    );
  }
}
