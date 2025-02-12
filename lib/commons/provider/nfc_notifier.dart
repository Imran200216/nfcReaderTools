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

      if (!isAvail) {
        _isProcessing = false;
        _isSuccess = false;
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

      _message = nfcOperation == NFCOperation.read
          ? "Scanning..."
          : "Writing to Tag...";
      notifyListeners();

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag nfcTag) async {
          try {
            if (nfcOperation == NFCOperation.read) {
              await _readFromTag(tag: nfcTag);
            } else if (nfcOperation == NFCOperation.write) {
              await _writeToTag(
                  nfcTag: nfcTag, dataType: dataType, payload: payload);
            }
            _message = "Done";
            _isSuccess = true;
          } catch (e) {
            _message = "Failed: ${e.toString()}";
            _isSuccess = false;
          }
          _isProcessing = false;
          notifyListeners();
          await NfcManager.instance.stopSession();
        },
        onError: (e) async {
          _isProcessing = false;
          _isSuccess = false;
          _message = "Error: ${e.toString()}";
          notifyListeners();
        },
      );
      return true;
    } catch (e) {
      _isProcessing = false;
      _isSuccess = false;
      _message = "Exception: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  Future<void> _readFromTag({required NfcTag tag}) async {
    try {
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

      if (decodedText != null && decodedText.startsWith('tel:')) {
        String phoneNumber = decodedText.replaceFirst('tel:', '');
        _dialPhone(phoneNumber);
      }
    } catch (e) {
      _message = "Read Failed: ${e.toString()}";
      _isSuccess = false;
      notifyListeners();
    }
  }

  Future<void> _writeToTag({
    required NfcTag nfcTag,
    required String dataType,
    String? payload,
  }) async {
    try {
      NdefMessage message =
          _createNdefMessage(dataType: dataType, payload: payload);
      await Ndef.from(nfcTag)?.write(message);
      _message = "Data Written Successfully";
      _isSuccess = true;
    } catch (e) {
      _message = "Write Failed: ${e.toString()}";
      _isSuccess = false;
    }
    notifyListeners();
  }

  NdefMessage _createNdefMessage({required String dataType, String? payload}) {
    switch (dataType) {
      case 'URL':
        return NdefMessage([
          NdefRecord.createUri(
            Uri.parse(payload ?? "No URL found"),
          ),
        ]);
      case 'MAIL':
        String emailData = 'mailto:$payload';
        return NdefMessage(
          [
            NdefRecord.createUri(
              Uri.parse(emailData),
            ),
          ],
        );

      case 'CONTACT':
        return NdefMessage([
          NdefRecord.createMime(
            'text/vcard',
            Uint8List.fromList(
              utf8.encode(payload ?? 'No contact found'),
            ),
          ),
        ]);
      case 'CALL':
        if (payload == null || payload.isEmpty) {
          return NdefMessage([]); // Return an empty NdefMessage if no payload
        }
        String phoneNumber = "tel:$payload"; // Format the phone number as a URI
        return NdefMessage([
          NdefRecord.createUri(
            Uri.parse(
              phoneNumber,
            ),
          ),
        ]);

      case 'WIFI':
        if (payload == null || payload.isEmpty) return const NdefMessage([]);

        List<String> wifiData = payload.split('|');
        if (wifiData.length != 4) return const NdefMessage([]);

        String wifiConfig =
            "WIFI:S:${wifiData[0]};T:${wifiData[2]};P:${wifiData[1]};H:false;;";

        return NdefMessage([
          NdefRecord.createMime(
            'application/vnd.wfa.wsc',
            Uint8List.fromList(
              utf8.encode(wifiConfig),
            ),
          ),
        ]);
      default:
        return const NdefMessage([]); // Ensure we always return an NdefMessage
    }
  }

  void _dialPhone(String phoneNumber) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(dialUri.toString())) {
      await launch(dialUri.toString());
    } else {
      _message = 'Could not launch $dialUri';
      _isSuccess = false;
      notifyListeners();
    }
  }
}
