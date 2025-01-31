import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nfcreadertools/commons/models/nfc_writing_card_data.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/features/nfc_add_writing_record/presentation/widgets/custom_nfc_writing_card.dart';

class NfcAddWritingRecordScreen extends StatelessWidget {
  const NfcAddWritingRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NFCWritingCardData> cardData = [
      /// text record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/text-record.svg",
        title: "Text",
        subtitle: "Add a text record",
        route: "nfcTextRecordWritingScreen",
      ),

      /// URL record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/url-record.svg",
        title: "URL",
        subtitle: "Add a URL record",
        route: "nfcUrlRecordWritingScreen",
      ),

      /// contact record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/contact-record.svg",
        title: "Contact",
        subtitle: "Add a contact record",
        route: "nfcContactRecordWritingScreen",
      ),

      /// write record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/wifi-record.svg",
        title: "Wifi",
        subtitle: "configure a Wifi-network",
        route: "nfcWifiRecordWritingScreen",
      ),

      /// location record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/location-record.svg",
        title: "Location",
        subtitle: "Add a location",
        route: "nfcLocationRecordWritingScreen",
      ),

      /// share record
      NFCWritingCardData(
        iconPath: "assets/icons/svg/share-record.svg",
        title: "Social Networks",
        subtitle: "Add a social network link",
        route: "nfcSocialShareRecordWritingScreen",
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitleText: "Add Records",
          leadingIconOnTap: () {
            GoRouter.of(context).pop();
          },
          leadingIconPath: "arrow-back",
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.9,
            ),
            itemCount: cardData.length,
            itemBuilder: (context, index) {
              final data = cardData[index];
              return CustomNfcWritingCard(data: data);
            },
          ),
        ),
      ),
    );
  }
}
