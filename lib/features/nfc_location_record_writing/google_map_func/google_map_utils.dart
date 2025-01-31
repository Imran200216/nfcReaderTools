import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntentUtils {
  IntentUtils._();

  // Open Google Maps using Latitude and Longitude
  static Future<void> launchGoogleMaps(
      double latitude, double longitude) async {
    final Uri uri = Uri.parse(
        "google.navigation:q=$latitude,$longitude"); // For navigation mode

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Error launching Google Maps with coordinates.');
      _showErrorToast("Failed to launch Google Maps.");
    }
  }

  // Open Google Maps directly with URL
  static Future<void> launchGoogleMapsUrl(String placeUrl) async {
    final Uri uri = Uri.parse(placeUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Error launching Google Maps URL.');
      _showErrorToast("Failed to launch Google Maps.");
    }
  }

  // Helper function to show error toasts
  static void _showErrorToast(String message) {
    debugPrint(message);
  }
}
