import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> launchInBrowser(String uri) async {
    Uri url = Uri.parse(uri);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print("could not launch url $e");
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    if (!phoneNumber.startsWith("+")) {
      phoneNumber = "+$phoneNumber";
    }
    print(phoneNumber);
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $phoneUri';
      }
    } catch (e) {
      print("could not launch url scheme $e");
    }
  }

  static Future<void> sendEmail(String email) async {
    try {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': 'Hello', 'body': 'How are you?'});

      print('constructed email${emailLaunchUri.toString()}');

      if (!await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $emailLaunchUri');
      }
    } catch (e) {
      print('Could not launch $e');
    }
  }
}
