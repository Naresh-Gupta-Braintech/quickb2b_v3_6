import 'dart:convert';

import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/company_details_data.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/get_device_type_model.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? pref;

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
    final jsonData = customer?.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.customerDetails, data);
  }

  static Future<void> saveCompanyDetails(CompanyDetailsData? company) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = company!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.companyDetails, data);
  }

  static Future<void> saveDeviceData(GetDeviceTypeModel? deviceData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = deviceData!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.deviceData, data);
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

  static Future<GetDeviceTypeModel?> getDeviceData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.deviceData);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return GetDeviceTypeModel.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }

  static setUserCode(String str) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.userCode, str);
    print("User Keys.userCode ${Keys.userCode}");
    print("User code set: $str");
  }

  static Future<String?> getUserCode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print("User Keys.userCode ${Keys.userCode}");
      final data = prefs.getString(Keys.userCode);
      if (data == null || data.isEmpty) {
        return null;
      }
      print("User code retrieved: $data");
      return data;
    } catch (e) {
      print("Error user code: $e");
      return null;
    }
  }

  static Future<void> saveCartDetails(CartData? cart) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = cart!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.cart, data);
  }

  static Future<void> saveOutletsInfo(OutletData? outlet) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = outlet!.toJson();
    String data = jsonEncode(jsonData);
    await prefs.setString(Keys.outlet, data);
  }

  static Future<CartData?> getOutletsDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.outlet);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return CartData.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }

  static Future<CartData?> getCartDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.cart);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return CartData.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }

  static Future<CompanyDetailsData?> getCompanyDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(Keys.companyDetails);
      if (data == null || data.isEmpty) {
        return null;
      }
      final jsonData = jsonDecode(data);
      return CompanyDetailsData.fromJson(jsonData);
    } catch (e) {
      print("Error retrieving login data: $e");
      return null;
    }
  }
}
