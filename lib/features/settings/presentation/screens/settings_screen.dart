import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_divider.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get the current user for firebase
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final currentUserName = currentUser?.displayName ?? "No Name";
    final currentUserEmail = currentUser?.email ?? "No Email";

    return Scaffold(
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
                    /// Settings title text
                    Text(
                      "Settings",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      spacing: 20.w,
                      children: [
                        // Profile image
                        Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  currentUser?.photoURL ?? "default_image_url",
                              // Add default image URL if null
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                "assets/img/jpg/person-placeholder.jpeg",
                                // Path to placeholder image
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/img/jpg/person-placeholder.jpeg",
                                // Path to error image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// User name
                            Text(
                              currentUserName,
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                                fontSize: 16.sp,
                              ),
                            ),

                            /// User email
                            Text(
                              currentUserEmail,
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
            SizedBox(height: 12.h),
            // About Dev section
            CustomProfileListTile(
              listTileTitleText: "About Dev",
              listTileOnTap: () {
                launchUrl(Uri.parse("https://linktr.ee/Imran_B"));
              },
              leadingIconPath: "dev",
            ),
            CustomProfileDivider(),
            // Other options like review, share, privacy policy, etc.
            CustomProfileListTile(
              listTileTitleText: "Review App",
              listTileOnTap: () {},
              leadingIconPath: "review",
            ),
            CustomProfileDivider(),
            CustomProfileListTile(
              listTileTitleText: "Share App",
              listTileOnTap: () {},
              leadingIconPath: "share",
            ),
            CustomProfileDivider(),
            CustomProfileListTile(
              listTileTitleText: "Privacy policy",
              listTileOnTap: () {},
              leadingIconPath: "privacy-policy",
            ),
            CustomProfileDivider(),
            // Logout
            CustomProfileListTile(
              listTileTitleText: "Logout",
              listTileOnTap: () {
                FirebaseAuth.instance.signOut().then(
                  (value) {
                    GoRouter.of(context)
                        .pushReplacementNamed("getStartedFirstScreen");
                  },
                );
              },
              leadingIconPath: "logout",
            ),
            CustomProfileDivider(),
          ],
        ),
      ),
    );
  }
}
