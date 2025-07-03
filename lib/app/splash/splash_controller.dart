import 'dart:async';

import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  SplashController({required this.sharedPreferences});
  bool isCompanyDetailsFetchedSuccess = false;
  bool isCartFetchedSuccess = false;

  void init() async {
    // Future.delayed(Duration.zero, () {
    //   Timer(Duration(seconds: 3), () {
    //     final loginData = sharedPreferences.getString(Keys.loginData);
    //     if (loginData != null && loginData.isNotEmpty) {
    //       Get.offAllNamed(RoutesHelper.home);
    //     } else {
    //       Get.offAllNamed(RoutesHelper.login);
    //     }
    //   });
    // });
    await Get.find<HomeController>().getCompanyDetails();
    await Get.find<CartController>().getCart();
    print("$isCompanyDetailsFetchedSuccess ::   $isCartFetchedSuccess  ");
    if (isCompanyDetailsFetchedSuccess == true && isCartFetchedSuccess == true) {
      print("go to routes");
      final loginData = sharedPreferences.getString(Keys.loginData);
      if (loginData != null && loginData.isNotEmpty) {
        Get.offAllNamed(RoutesHelper.home);
      } else {
        Get.offAllNamed(RoutesHelper.login);
      }
    }
  }
}
