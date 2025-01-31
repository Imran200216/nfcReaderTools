import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfcreadertools/features/nfc_text_record_writing/modals/nfc_text_record_modal.dart';

class NfcTextRecordWritingProvider extends ChangeNotifier {
  // Add a new NFC text record to Firestore
  Future<void> addTextRecordWritingToNFCTag(
      String recordType, String textRecordData) async {
    try {
      final userCurrentDocId = FirebaseAuth.instance.currentUser!.uid;
      final userCurrentEmailAddress = FirebaseAuth.instance.currentUser!.email;

      // Create a new NfcTextRecordModal object
      NfcTextRecordModal newRecord = NfcTextRecordModal(
        userEmail: userCurrentEmailAddress ?? "No email Address",
        recordType: recordType,
        textRecordData: textRecordData,
        nfcCreatedTimeStamp: Timestamp.now(),
        userUID: userCurrentDocId,
      );

      // First: Update the user's document with the NFC text record
      await FirebaseFirestore.instance
          .collection("nfcTagWriteRecords")
          .doc(userCurrentDocId)
          .set({
        'nfcRecord': newRecord.toMap(),
        // Assuming you want to add a field with this record
      });

      print("NFC text record added successfully!");
    } catch (e) {
      print("Error adding NFC text record: $e");
    }
  }
}
