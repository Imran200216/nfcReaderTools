import 'package:cloud_firestore/cloud_firestore.dart';

class NfcTextRecordModal {
  final String userEmail;
  final String recordType;
  final String textRecordData;
  final Timestamp nfcCreatedTimeStamp;
  final String userUID;

  NfcTextRecordModal({
    required this.userEmail,
    required this.userUID,
    required this.recordType,
    required this.textRecordData,
    required this.nfcCreatedTimeStamp,
  });

  // Convert the modal to a map for Firestore saving
  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'recordType': recordType,
      'textRecordData': textRecordData,
      'nfcCreatedTimeStamp': nfcCreatedTimeStamp,
      'userUID': userUID,
    };
  }
}
