import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/features/nfc_tools/presentation/widgets/custom_nfc_tools_card.dart';

class NfcToolsScreen extends StatelessWidget {
  const NfcToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitleText: "NFC Tools",
          leadingIconOnTap: () {},
          leadingIconPath: "nfc-splash-logo",
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// read the nfc card
                CustomNfcToolsCard(
                  cardOnTap: () {
                    // showModalBottomSheet(context: context, builder: (context) {
                    //
                    //   return
                    // },);
                  },
                  cardTitle: "Read",
                  cardSubTitle:
                      "Bring your phone to NFC Tag and read the information written on it.",
                  cardSvgPath: "visibility",
                ),

                SizedBox(
                  height: 20.h,
                ),

                /// write the nfc card
                CustomNfcToolsCard(
                  cardOnTap: () {
                    GoRouter.of(context)
                        .pushNamed("nfcWritingToolsRecordsScreen");
                  },
                  cardTitle: "write",
                  cardSubTitle:
                      "Bring your phone to NFC Tag and written the information written on it.",
                  cardSvgPath: "write",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
