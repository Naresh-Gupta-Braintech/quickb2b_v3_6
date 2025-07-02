import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/dashboard/account.dart';
import 'package:quickb2b_v3_6/app/dashboard/app_user_guide.dart';
import 'package:quickb2b_v3_6/app/dashboard/links_page.dart';
import 'package:quickb2b_v3_6/app/dashboard/past_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  SharedPreferences sharedPreferences;
  DashboardController({required this.sharedPreferences});
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  Widget changePage() {
    switch (selectedIndex) {
      case 0:
        return Account();
      case 1:
        return PastOrder();
      case 2:
        return LinksPage();
      case 3:
        return AppUserGuide();
      default:
        return Account();
    }
  }

  final List<String> list = ["Account", "Past Orders", "Links", "App user guide", "Reset My List A-Z", "Logout"];
}
