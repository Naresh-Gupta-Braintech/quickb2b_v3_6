import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:quickb2b_v3_6/app/autthentication/forgot/forgot.dart';
import 'package:quickb2b_v3_6/app/autthentication/login/login_view.dart';
import 'package:quickb2b_v3_6/app/autthentication/register/registration_page.dart';
import 'package:quickb2b_v3_6/app/cart/view/cart_view.dart';
import 'package:quickb2b_v3_6/app/home/customers_list.dart';
import 'package:quickb2b_v3_6/app/mylist/view/my_list_view.dart';
import 'package:quickb2b_v3_6/app/product/view/product_view.dart';
import 'package:quickb2b_v3_6/app/profile/view/profile_dashboard_view.dart';
import 'package:quickb2b_v3_6/app/home/view/home_view.dart';
import 'package:quickb2b_v3_6/app/splash/outlet/outlet_view.dart';
import 'package:quickb2b_v3_6/app/splash/view/splash.dart';
import 'package:quickb2b_v3_6/app/temp.dart';

class RoutesHelper {
  static const String _home = '/';
  static const String _login = '/login';
  static const String _register = '/register';
  static const String _profile = '/profile';
  static const String _settings = '/settings';
  static const String _customerList = '/customer_list';
  static const String _contact = '/contact';
  static const String _splash = '/splash';
  static const String _forgot = '/forgot';
  static const String _account = '/account';
  static const String _products = '/products';
  static const String _myList = '/mylist';
  static const String _myOrder = '/my_order';
  static const String _outlet = '/outlet';
  static const String _temp = '/temp';

  // Add more routes as needed
  static String get home => _home;
  static String get login => _login;
  static String get register => _register;
  static String get profile => _profile;
  static String get settings => _settings;
  static String get customerList => _customerList;
  static String get contact => _contact;
  static String get splash => _splash;
  static String get forgot => _forgot;
  static String get account => _account;
  static String get products => _products;
  static String get myList => _myList;
  static String get myOrder => _myOrder;
  static String get outlet => _outlet;
  static String get temp => temp;

  static List<GetPage> getRoutes() {
    return [
      GetPage(name: _home, page: () => HomeView()),
      GetPage(name: _login, page: () => const LoginView()),
      GetPage(name: _register, page: () => RegistrationPage()),
      GetPage(name: _forgot, page: () => ForgetPasswordPage()),
      GetPage(name: _account, page: () => ProfileDashboardView()),
      GetPage(name: _splash, page: () => Splash()),
      GetPage(name: _customerList, page: () => CustomersList()),
      GetPage(name: _products, page: () => ProductView()),
      GetPage(name: _myList, page: () => MyListView()),
      GetPage(name: _myOrder, page: () => CartView()),
      GetPage(name: _outlet, page: () => OutletView()),
      GetPage(name: _temp, page: () => Temp()),
    ];
  }
}

void debugConsole(String? message) {
  if (kDebugMode) {
    log(message ?? "Console null");
  }
}
