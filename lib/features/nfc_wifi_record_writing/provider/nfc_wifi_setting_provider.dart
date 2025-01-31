import 'package:flutter/material.dart';

class WifiSettingsProvider extends ChangeNotifier {
  String? _selectedAuthWifiOption;
  String? _selectedEncryptionWifiOption;

  String? get selectedAuthWifiOption => _selectedAuthWifiOption;
  String? get selectedEncryptionWifiOption => _selectedEncryptionWifiOption;

  void setAuthWifiOption(String? newValue) {
    _selectedAuthWifiOption = newValue;
    notifyListeners();
  }

  void setEncryptionWifiOption(String? newValue) {
    _selectedEncryptionWifiOption = newValue;
    notifyListeners();
  }
}