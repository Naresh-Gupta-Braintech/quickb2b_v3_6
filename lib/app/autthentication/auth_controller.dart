import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_repository.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/get_device_type_model.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

class AuthController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final AuthRepository repository;
  AuthController({required this.sharedPreferences, required this.repository});
  bool loading = false;
  LoginData? loginData;
  bool isGetDeviceFetchCompleted = false;
  TextEditingController customerIdController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController saveController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController numberStreetController = TextEditingController();
  TextEditingController suburbCityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateRegionController = TextEditingController();
  TextEditingController postcodeZipController = TextEditingController();
  TextEditingController postalAddressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  GetDeviceTypeModel? deviceData;

  void initregister() {
    customerIdController = TextEditingController();
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userIdController = TextEditingController();
    businessNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    deliveryAddressController = TextEditingController();
    numberStreetController = TextEditingController();
    suburbCityController = TextEditingController();
    countryController = TextEditingController();
    stateRegionController = TextEditingController();
    postcodeZipController = TextEditingController();
    postalAddressController = TextEditingController();
  }

  void initLogin() {
    passwordController = TextEditingController();
    userNameController = TextEditingController();
  }

  void signin(BuildContext context,{FToast? ftoast}) {
    login(context,ftoast: ftoast);
  }

  void loginRoutes() async {
    try {
      sharedPreferences.setString(Keys.userCode, "QB2BDEV");

      await Future.wait([Get.find<AuthController>().getDevice()]);

      if (isGetDeviceFetchCompleted) {
        await Future.wait([Get.find<HomeController>().getCompanyDetails()]);
      }

      if (Get.find<SplashController>().isCompanyDetailsFetchedSuccess) {
        await Get.find<CartController>().getCart();
      }

      print("cart api status :: ${Get.find<CartController>().isCartFetchedSuccess}");

      if (Get.find<CartController>().isCartFetchedSuccess) {
        String acmCode = sharedPreferences.getString(Keys.acmCode) ?? "";
        acmCode.isNotEmpty ? routeifManagerLogin() : routes();
      }
    } catch (e) {
      print(e);
    }
  }

  void routes() async {
    int outletLength = Get.find<AuthController>().loginData?.outlets ?? 0;
    print("Outlet :: $outletLength");
    if (outletLength > 0) {
      print("going to outlet");
      Get.offNamed(RoutesHelper.outlet);
    } else {
      print("going to home");
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

  Future<void> goToRoutes() async {
    LoginData? data = await LocalStorage.getLoginData();
    if (data?.data?.acmCode != null && data?.data?.acmCode?.length != 0) {
      Get.offAllNamed(RoutesHelper.customerList);
    } else {
      Get.offAllNamed(RoutesHelper.home);
    }
  }
}
