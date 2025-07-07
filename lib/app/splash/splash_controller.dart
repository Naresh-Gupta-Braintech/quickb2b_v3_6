import 'dart:async';

import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  SplashController({required this.sharedPreferences});
  bool isCompanyDetailsFetchedSuccess = false;
  bool isCartFetchedSuccess = false;

  void init() async {
    await Get.find<HomeController>().getCompanyDetails();
    await Get.find<CartController>().getCart();
    final loginData = sharedPreferences.getString(Keys.loginData);
    LoginData? data = await LocalStorage.getLoginData();

    if (isCompanyDetailsFetchedSuccess == true && isCartFetchedSuccess == true) {
      if (loginData != null && loginData.isNotEmpty) {
        Get.offAllNamed(RoutesHelper.home);
        // ignore: prefer_is_empty
      } else if (data?.data?.acmCode != null && data?.data?.acmCode?.length != 0) {
        Get.offAllNamed(RoutesHelper.customerList);
      } else {
        Get.offAllNamed(RoutesHelper.login);
      }
    }
  }
}
