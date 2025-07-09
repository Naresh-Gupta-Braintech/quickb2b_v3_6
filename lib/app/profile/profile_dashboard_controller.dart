import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_repository.dart';
import 'package:quickb2b_v3_6/app/profile/view/account.dart';
import 'package:quickb2b_v3_6/app/profile/view/app_user_guide.dart';
import 'package:quickb2b_v3_6/app/profile/view/links_page.dart';
import 'package:quickb2b_v3_6/app/profile/view/past_order.dart';
import 'package:quickb2b_v3_6/network/data/response/past_order_model.dart';
import 'package:quickb2b_v3_6/network/data/response/profile_app_link.dart';
import 'package:quickb2b_v3_6/network/data/response/profile_app_user_guide.dart';
import 'package:quickb2b_v3_6/network/data/response/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDashboardController extends GetxController {
  SharedPreferences sharedPreferences;
  ProfileDashboardRepository repository;
  ProfileDashboardController({required this.sharedPreferences, required this.repository});
  int selectedIndex = 0;
  bool isEditDeliverSection = false;
  bool isEditCustomerDetailsSection = false;
  bool isEditPostalAddressSection = false;
  bool loading = false;
  UserProfileModel? userProfile;
  PastOrderModel? pastOrder;
  ProfileAppLinkModel? links;
  ProfileAppUserGuide? appUserGuide;

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  Widget changePage(int selectedIndex) {
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

  void makeDeliveryEditable() {
    isEditDeliverSection = true;
    update();
  }

  void makeCustomerEditable() {
    isEditCustomerDetailsSection = true;
    update();
  }

  void makePostalEditable() {
    isEditPostalAddressSection = true;
    update();
  }

  void makePCustomerReadOnly() {
    isEditCustomerDetailsSection = false;
    update();
  }

  void makeDeliveryReadOnly() {
    isEditDeliverSection = false;
    update();
  }

  void makePostalReadOnly() {
    isEditPostalAddressSection = false;
    update();
  }

  final List<String> list = ["Account", "Past Orders", "Links", "App user guide", "Reset My List A-Z", "Logout"];
}
