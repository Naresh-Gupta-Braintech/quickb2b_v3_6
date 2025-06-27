import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class GlobalConstants {
  static const String baseUrl = "https://develop.quickb2b.com/v3";

  static Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id; // OR androidInfo.androidId (more stable)
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting device ID: $e");
      return null;
    }
  }

  static String getDeviceType() {
    if (Platform.isAndroid) {
      return "A";
    } else {
      return "I";
    }
  }
}
