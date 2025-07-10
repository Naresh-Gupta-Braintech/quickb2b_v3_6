import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_dataservice.dart';
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

  // customer details
  TextEditingController customerIdController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController deliveryNoteController = TextEditingController();

  //delivery address
  TextEditingController deliveryStreetNumberController = TextEditingController();
  TextEditingController deliverySuberbController = TextEditingController();
  TextEditingController deliveryCountryController = TextEditingController();
  TextEditingController deliveryStaterController = TextEditingController();
  TextEditingController deliveryPostalController = TextEditingController();

  //postal address
  TextEditingController postalStreetNumberController = TextEditingController();
  TextEditingController postalSuberbController = TextEditingController();
  TextEditingController postalCountryController = TextEditingController();
  TextEditingController postalStaterController = TextEditingController();
  TextEditingController postalPostalController = TextEditingController();

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
    deliveryStreetNumberController.text = userProfile?.data?.deliveryAddress ?? "";
    deliverySuberbController.text = userProfile?.data?.deliverySuburb ?? "";
    deliveryCountryController.text = userProfile?.data?.deliveryCountry ?? "";
    deliveryStaterController.text = userProfile?.data?.deliveryState ?? "";
    deliveryPostalController.text = userProfile?.data?.deliveryPostCode ?? "";
    isEditDeliverSection = true;
    update();
  }

  void makeCustomerEditable() {
    customerIdController.text = userProfile?.data?.userCode ?? "";
    businessNameController.text = userProfile?.data?.businessName ?? "";
    firstNameController.text = userProfile?.data?.firstName ?? "";
    lastNameController.text = userProfile?.data?.lastName ?? "";
    phoneController.text = userProfile?.data?.phone ?? "";
    mobileController.text = userProfile?.data?.mobile ?? "";
    emailController.text = userProfile?.data?.email ?? "";
    deliveryNoteController.text = userProfile?.data?.deliveryAddress ?? "";
    isEditCustomerDetailsSection = true;
    update();
  }

  void makePostalEditable() {
    postalStreetNumberController.text = userProfile?.data?.postalAddress ?? "";
    postalSuberbController.text = userProfile?.data?.postalSuburb ?? "";
    postalCountryController.text = userProfile?.data?.postalCountry ?? "";
    postalStaterController.text = userProfile?.data?.postalState ?? "";
    postalPostalController.text = userProfile?.data?.postalPostCode ?? "";
    isEditPostalAddressSection = true;
    update();
  }

  void makePCustomerReadOnly() {
    updateProfile();
    isEditCustomerDetailsSection = false;
    update();
  }

  void makeDeliveryReadOnly() {
    updateDeliveryAddressForBusiness();
    isEditDeliverSection = false;
    update();
  }

  void makePostalReadOnly() {
    updatePostalAdress();
    isEditPostalAddressSection = false;
    update();
  }

  final List<String> list = ["Account", "Past Orders", "Links", "App user guide", "Reset My List A-Z", "Logout"];

  void getProfile() {
    getUserProfile();
  }

  void getPastOrders() {
    getPastUserOrder();
  }

  void getLinkDeatils() {
    getLinks();
  }

  void getUserGuide() {
    getAppUserGuide();
  }
}
