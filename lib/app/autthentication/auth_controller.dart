import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_repository.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final AuthRepository repository;
  AuthController({required this.sharedPreferences, required this.repository});
  bool loading = false;
  LoginData? loginData;
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

  void signin() {
    login();
  }
}
