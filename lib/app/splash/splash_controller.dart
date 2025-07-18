import 'dart:async';

import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
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
    LoginData? loginData = await LocalStorage.getLoginData();
    if (loginData != null) {
      print("already login");
      print("started company details api");

      await Get.find<HomeController>().getCompanyDetails();
      print("company details api completed");
      print("started cart api");

      await Get.find<CartController>().getCart();
      print("start cart api completed");

      String acmCode = sharedPreferences.getString(Keys.acmCode) ?? "";
      acmCode.isNotEmpty ? routeifManagerLogin() : routes();
    } else {
      Get.offAllNamed(RoutesHelper.login);
    }
  }

  void routes() async {
    if (isCompanyDetailsFetchedSuccess == true && isCartFetchedSuccess == true) {
      Get.offAllNamed(RoutesHelper.home);
    }
  }

  void routeifManagerLogin() async {
    CustomerDetailsModel? customerDetails = await LocalStorage.getCustomerDetails();
    if (customerDetails == null) {
      print("go to company login");

      Get.offAllNamed(RoutesHelper.customerList);
      return;
    } else {
      Get.offAllNamed(RoutesHelper.home);
      return;
    }
  }
}
