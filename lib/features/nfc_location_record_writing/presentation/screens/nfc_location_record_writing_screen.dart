import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/commons/widgets/custom_text_btn.dart';
import 'package:nfcreadertools/commons/widgets/nfc_writing_text_field.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/helper/toast_helper.dart';
import 'package:nfcreadertools/features/nfc_location_record_writing/google_map_func/google_map_utils.dart';

class NfcLocationRecordWritingScreen extends StatefulWidget {
  const NfcLocationRecordWritingScreen({super.key});

  @override
  State<NfcLocationRecordWritingScreen> createState() =>
      _NfcLocationRecordWritingScreenState();
}

class _NfcLocationRecordWritingScreenState
    extends State<NfcLocationRecordWritingScreen>
    with TickerProviderStateMixin {
  /// form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// controllers
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController locationURLController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    locationURLController.dispose();
    super.dispose();
  }

  String? validateLatitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Latitude is required";
    }
    final double? latitude = double.tryParse(value);
    if (latitude == null || latitude < -90 || latitude > 90) {
      return "Enter a valid latitude (-90 to 90)";
    }
    return null;
  }

  String? validateLongitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Longitude is required";
    }
    final double? longitude = double.tryParse(value);
    if (longitude == null || longitude < -180 || longitude > 180) {
      return "Enter a valid longitude (-180 to 180)";
    }
    return null;
  }

  void _handleSave() {
    final currentTabIndex = _tabController.index;

    if (currentTabIndex == 0) {
      // Validate URL Tab
      if (locationURLController.text.isEmpty) {
        ToastHelper.showErrorToast(
          context: context,
          message: "URL is required!",
        );
        return;
      }
      IntentUtils.launchGoogleMapsUrl(locationURLController.text);
    } else {
      // Validate Latitude/Longitude Tab
      if (formKey.currentState?.validate() ?? false) {
        double latitude = double.parse(latitudeController.text.trim());
        double longitude = double.parse(longitudeController.text.trim());
        IntentUtils.launchGoogleMaps(latitude, longitude);
      } else {
        ToastHelper.showErrorToast(
          context: context,
          message: "Latitude & Longitude may be wrong!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: DefaultTabController(
          length: 2,
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                actions: [
                  CustomTextBtn(
                    textBtnTitleText: "Save",
                    onTap: _handleSave,
                  ),
                ],
                appBarTitleText: "Add Location",
                leadingIconOnTap: () {
                  GoRouter.of(context).pop();
                },
                leadingIconPath: "arrow-back",
                centerTitle: true,
              ),
              body: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    // Add the controller here
                    tabs: [
                      const Tab(text: 'Location URL'),
                      const Tab(text: 'Location Specific'),
                    ],
                    labelStyle: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryColor,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 13.sp,
                      color: AppColors.nfcToolsCardSubTitleColor,
                      fontWeight: FontWeight.w800,
                    ),
                    indicatorColor: AppColors.primaryColor,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController, // Add the controller here
                      children: [
                        // Tab 1: Location URL
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            children: [
                              NfcWritingTextField(
                                textEditingController: locationURLController,
                                hintText: "Location URL",
                                labelText: "*Enter Location URL",
                                prefixIcon: Icons.link_sharp,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'URL is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        // Tab 2: Latitude/Longitude
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 30.h,
                            ),
                            child: Column(
                              children: [
                                NfcWritingTextField(
                                  textEditingController: latitudeController,
                                  hintText: "40.748817",
                                  labelText: "*Enter latitude",
                                  prefixIcon: Icons.map,
                                  validator: validateLatitude,
                                ),
                                SizedBox(height: 18.h),
                                NfcWritingTextField(
                                  textEditingController: longitudeController,
                                  hintText: "-73.985428",
                                  labelText: "*Enter longitude",
                                  prefixIcon: Icons.map,
                                  validator: validateLongitude,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
