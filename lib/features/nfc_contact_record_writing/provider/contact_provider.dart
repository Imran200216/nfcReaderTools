import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _contacts = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get contacts => _contacts;
  String? get error => _error;

  /// Fetch contacts
  Future<void> fetchContacts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (await FlutterContacts.requestPermission()) {
        var contactList = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );

        _contacts = contactList.map((contact) {
          return {
            "displayName": contact.displayName,
            "photo": contact.photo, // Binary image (Uint8List)
            "phones": contact.phones.isNotEmpty
                ? contact.phones.map((e) => {"number": e.number}).toList()
                : [],
          };
        }).toList();
      } else {
        _error = 'Permission denied to access contacts.';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
