import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

enum NFCOperation { read, write }

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  bool _isSuccess = false;
  String _message = "";

  bool get isProcessing => _isProcessing;

  bool get isSuccess => _isSuccess;

  String get message => _message;

  /// Start the NFC operation (read or write).
  /// [context] is required here to show the alert dialog if NFC is not available.
  /// [payload] is an optional parameter containing the data to be written.
  /// Returns `true` if the NFC operation was initiated (i.e. NFC is available),
  /// or `false` if NFC is unavailable.
  Future<bool> startNFCOperation({
    required BuildContext context,
    required NFCOperation nfcOperation,
    String dataType = "",
    String? payload,
  }) async {
    try {
      _isProcessing = true;
      _isSuccess = false;
      _message = "";
      notifyListeners();

      bool isAvail = await NfcManager.instance.isAvailable();

      // If NFC is not available, show an alert dialog and exit the operation.
      if (!isAvail) {
        _isProcessing = false;
        _message = "NFC Unavailable";
        notifyListeners();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("NFC Unavailable"),
            titleTextStyle: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "DM Sans",
              color: AppColors.titleColor,
            ),
            contentTextStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "DM Sans",
              color: AppColors.subTitleColor,
            ),
            content: const Text(
                "Your device does not support NFC or it is disabled. Please enable NFC from settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "DM Sans",
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
        return false;
      }

      // NFC is available; update the message accordingly.
      if (nfcOperation == NFCOperation.read) {
        _message = "Scanning...";
      } else if (nfcOperation == NFCOperation.write) {
        _message = "Writing to Tag...";
      }
      notifyListeners();

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag nfcTag) async {
          if (nfcOperation == NFCOperation.read) {
            await _readFromTag(tag: nfcTag);
          } else if (nfcOperation == NFCOperation.write) {
            await _writeToTag(
                nfcTag: nfcTag, dataType: dataType, payload: payload);
            _message = "Done";
          }
          _isProcessing = false;
          notifyListeners();
          await NfcManager.instance.stopSession();
        },
        onError: (e) async {
          _isProcessing = false;
          _message = e.toString();
          notifyListeners();
        },
      );
      return true;
    } catch (e) {
      _isProcessing = false;
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> _readFromTag({required NfcTag tag}) async {
    // Example: extract NDEF data if available.
    Map<String, dynamic> nfcData = {
      'nfca': tag.data['nfca'],
      'mifareultralight': tag.data['mifareultralight'],
      'ndef': tag.data['ndef']
    };

    String? decodedText;
    if (nfcData.containsKey('ndef') && nfcData['ndef'] != null) {
      try {
        List<int> payload =
            nfcData['ndef']['cachedMessage']?['records']?[0]['payload'];
        decodedText = String.fromCharCodes(payload);
      } catch (e) {
        decodedText = null;
      }
    }

    if (decodedText != null && decodedText.isNotEmpty) {
      _message = "NFC Read Successfully!\nData: $decodedText";
      _isSuccess = true;
    } else {
      _message = "No Data Found";
      _isSuccess = false;
    }
    notifyListeners();

    // If the tag contains a phone number, dial it.
    if (decodedText != null && decodedText.startsWith('tel:')) {
      String phoneNumber = decodedText.replaceFirst('tel:', '');
      _dialPhone(phoneNumber);
    }
  }

  Future<void> _writeToTag({
    required NfcTag nfcTag,
    required String dataType,
    String? payload,
  }) async {
    NdefMessage message =
        _createNdefMessage(dataType: dataType, payload: payload);
    await Ndef.from(nfcTag)?.write(message);
  }

  /// Creates an NDEF message based on [dataType].
  /// For types like 'MAIL' or 'CALL', if a [payload] is provided from the UI,
  /// that value will be used instead of the default.
  NdefMessage _createNdefMessage({
    required String dataType,
    String? payload,
  }) {
    switch (dataType) {
      case 'URL':
        final url = payload ?? "No URL found";
        return NdefMessage([
          NdefRecord.createUri(Uri.parse(url)),
        ]);
      case 'MAIL':
        final emailData = payload ?? 'No email data';
        return NdefMessage([
          NdefRecord.createUri(Uri.parse(emailData)),
        ]);
      case 'CONTACT':
        final contactData = payload ?? 'no contact found';
        Uint8List contactBytes = Uint8List.fromList(utf8.encode(contactData));
        return NdefMessage([NdefRecord.createMime('text/vcard', contactBytes)]);
      case 'CALL':
        final phoneNumber = payload ?? 'NO Phone Number';
        return NdefMessage([
          NdefRecord.createUri(Uri.parse(phoneNumber)),
        ]);
      case 'WIFI':
        if (payload == null || payload.isEmpty) {
          return const NdefMessage([]);
        }

        // Extract values from the payload
        List<String> wifiData = payload.split('|');
        if (wifiData.length != 4) {
          return const NdefMessage([]); // Ensure valid format
        }

        final ssid = wifiData[0];
        final password = wifiData[1];
        final authType = wifiData[2];
        final encryptionType = wifiData[3];

        // Format WiFi configuration for NFC
        String wifiConfig =
            "WIFI:S:$ssid;T:$authType;P:$password;E:$encryptionType;;";
        Uint8List wifiBytes = Uint8List.fromList(utf8.encode(wifiConfig));

        return NdefMessage([
          NdefRecord.createMime('application/vnd.wfa.wsc', wifiBytes),
        ]);

      default:
        return const NdefMessage([]);
    }
  }

  void _dialPhone(String phoneNumber) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(dialUri.toString())) {
      await launch(dialUri.toString());
    } else {
      print('Could not launch $dialUri');
    }
  }
}
