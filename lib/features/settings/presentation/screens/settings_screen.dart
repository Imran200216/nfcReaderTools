import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_divider.dart';
import 'package:nfcreadertools/features/settings/presentation/widgets/custom_profile_list_tile.dart';
import 'package:share_plus/share_plus.dart';
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
                /// dev portfolio
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

            /// share app functionality
            CustomProfileListTile(
              listTileTitleText: "Share App",
              listTileOnTap: () {
                /// share functionality (Share our app)
                // Share.shareXFiles(
                //   [
                //     XFile(
                //       'https://play.google.com/store/apps/details?id=com.princeappstudio.nfctools',
                //     )
                //   ],
                //   text: 'Check out my app!',
                // );
              },
              leadingIconPath: "share",
            ),
            CustomProfileDivider(),

            /// privacy policy
            CustomProfileListTile(
              listTileTitleText: "Privacy policy",
              listTileOnTap: () {
                /// privacy policy
                launchUrl(Uri.parse("https://linktr.ee/Imran_B"));
              },
              leadingIconPath: "privacy-policy",
            ),
            CustomProfileDivider(),
            // Logout
            CustomProfileListTile(
              listTileTitleText: "Logout",
              listTileOnTap: () {
                FirebaseAuth.instance.signOut().then(
                  (value) async {
                    /// Remove GetStatus in Hive
                    var getStartedBox = Hive.box('userGetStartedStatusBox');
                    await getStartedBox.put('userGetStartedStatus', false);

                    /// Remove Auth Status in Hive
                    var authBox = Hive.box('userAuthStatusBox');
                    await authBox.put('userAuthStatus', false);

                    /// get started screen
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
