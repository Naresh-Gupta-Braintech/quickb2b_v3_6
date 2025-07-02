import 'dart:async';

import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  SplashController({required this.sharedPreferences});
  void init() {
    Future.delayed(Duration.zero, () {
      Timer(Duration(seconds: 3), () {
        final loginData = sharedPreferences.getString(Keys.loginData);
        if (loginData != null && loginData.isNotEmpty) {
          Get.offAllNamed(RoutesHelper.home);
        } else {
          Get.offAllNamed(RoutesHelper.login);
        }
      });
    });
  }
}
