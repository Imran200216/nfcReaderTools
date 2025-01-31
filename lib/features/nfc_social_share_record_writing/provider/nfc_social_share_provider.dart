import 'package:flutter/material.dart';

class NfcSocialShareProvider extends ChangeNotifier {
  String? _selectedSocialPlatform;

  String? get selectedSocialPlatform => _selectedSocialPlatform;

  void setSocialPlatform(String? newValue) {
    _selectedSocialPlatform = newValue;
    notifyListeners();
  }
}
