import 'dart:convert';

import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String?>? getStringData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(key);
    return token;
  }

  static Future<void> clearLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveLoginData(LoginData? loginData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.acmCode, loginData?.data?.acmCode ?? "");
    final jsonData = loginData!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.loginData, data);
  }

  static Future<LoginData?> getLoginData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.loginData);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return LoginData.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }

  static Future<void> saveCustomerDeatils(CustomerDetailsModel? customer) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = customer!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.customerDetails, data);
  }

  static Future<CustomerDetailsModel?> getCustomerDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.customerDetails);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return CustomerDetailsModel.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }

  static setUserCode(String str) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.userCode, str);
  }
}
