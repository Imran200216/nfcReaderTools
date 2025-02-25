import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/features/bottom_nav/presentation/provider/bottom_nav_provider.dart';
import 'package:nfcreadertools/features/bottom_nav/presentation/widgets/bottom_nav_icon.dart';
import 'package:nfcreadertools/features/nfc_tools/presentation/screens/nfc_tools_screen.dart';
import 'package:nfcreadertools/features/NFC_tutorial/presentation/screens/nfc_tutorial_screen.dart';
import 'package:nfcreadertools/features/settings/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            return NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: AppColors.whiteColor,
                indicatorColor: AppColors.primaryColor.withOpacity(0.2),
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "DM Sans",
                    color: AppColors.titleColor,
                  ),
                ),
              ),
              child: NavigationBar(
                height: 80,
                elevation: 0,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                // Always show labels
                selectedIndex: provider.selectedIndex,
                onDestinationSelected: (value) {
                  provider.updateIndex(value); // Update the index in provider
                },
                destinations: [
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(svgIconPath: "nfc-filled"),
                    icon: BottomNavIcon(svgIconPath: "nfc-outlined"),
                    label: "NFC Tools",
                  ),
                  NavigationDestination(
                    selectedIcon:
                        BottomNavIcon(svgIconPath: "saved-tags-filled"),
                    icon: BottomNavIcon(svgIconPath: "saved-tags-outlined"),
                    label: "NFC Tutorial",
                  ),
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(svgIconPath: "settings-filled"),
                    icon: BottomNavIcon(svgIconPath: "settings-outlined"),
                    label: "Settings",
                  ),
                ],
              ),
            );
          },
        ),
        body: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            switch (provider.selectedIndex) {
              case 0:
                return NfcToolsScreen();
              case 1:
                return NFCTutorialScreen();
              case 2:
                return const SettingsScreen();
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
