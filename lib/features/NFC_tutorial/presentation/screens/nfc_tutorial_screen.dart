import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/commons/widgets/custom_app_bar.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NFCTutorialScreen extends StatefulWidget {
  const NFCTutorialScreen({super.key});

  @override
  State<NFCTutorialScreen> createState() => _NFCTutorialScreenState();
}

class _NFCTutorialScreenState extends State<NFCTutorialScreen> {
  /// video url
  final videoUrl = "https://www.youtube.com/watch?v=oTh5DvJQw60";

  late YoutubePlayerController playerController;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    playerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitleText: "NFC Tutorial",
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
              children: [
                /// user guide text
                Text(
                  '''
        To use the NFC Reader and Writer app, start by ensuring that NFC is enabled on your device. Open the app, where you'll see two main options: Read NFC and Write NFC. If you want to read an NFC tag, tap the Read NFC button and bring your phone close to an NFC-enabled card or tag. The app will scan the tag and display the stored data on the screen. If you want to write data to an NFC tag, tap the Write NFC button, enter the text or URL you want to store, and then place your phone near an NFC tag to complete the writing process. A confirmation message will appear once the writing is successful. If the tag is unsupported or an error occurs, the app will notify you with a message. This makes it easy to scan and store data effortlessly using NFC technology.
        ''',
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),

                SizedBox(height: 30.h),

                YoutubePlayer(controller: playerController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
