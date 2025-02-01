import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:nfcreadertools/commons/provider/nfc_notifier.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/features/nfc_tools/presentation/widgets/custom_nfc_tools_card.dart';

class NfcToolsScreen extends StatelessWidget {
  const NfcToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// nfc provider
    final nfcProvider = Provider.of<NFCNotifier>(context);

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
                /// Read NFC Card
                CustomNfcToolsCard(
                  cardOnTap: () async {
                    // Start the NFC operation and get whether it was started or not
                    bool operationStarted = await nfcProvider.startNFCOperation(
                      context: context,
                      nfcOperation: NFCOperation.read,
                    );

                    /// Only show the bottom sheet if the NFC operation started (i.e. NFC is available)
                    if (operationStarted) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Consumer<NFCNotifier>(
                            builder: (context, nfcNotifier, child) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    nfcNotifier.isProcessing
                                        ? Lottie.asset(
                                            "assets/lottie/reading-animation.json",
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.contain,
                                          )
                                        : nfcNotifier.isSuccess
                                            ? Lottie.asset(
                                                "assets/lottie/success-animation.json",
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.contain,
                                              )
                                            : Container(),
                                    SizedBox(height: 30),
                                    Text(
                                      nfcNotifier.isSuccess
                                          ? "NFC Read Successfully!"
                                          : "Reading NFC Tag...",
                                      style: const TextStyle(
                                        fontFamily: "DM Sans",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                  cardTitle: "Read",
                  cardSubTitle:
                      "Bring your phone to NFC Tag and read the information written on it.",
                  cardSvgPath: "visibility",
                ),

                SizedBox(height: 20.h),

                /// Write NFC Card
                CustomNfcToolsCard(
                  cardOnTap: () {
                    GoRouter.of(context)
                        .pushNamed("nfcWritingToolsRecordsScreen");
                  },
                  cardTitle: "Write",
                  cardSubTitle:
                      "Bring your phone to NFC Tag and write information to it.",
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
