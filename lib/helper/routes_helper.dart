import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:quickb2b_v3_6/app/autthentication/forgot/forgot.dart';
import 'package:quickb2b_v3_6/app/autthentication/login/login_view.dart';
import 'package:quickb2b_v3_6/app/autthentication/register/registration_page.dart';
import 'package:quickb2b_v3_6/app/home/customers_list.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_view.dart';
import 'package:quickb2b_v3_6/app/profile/past_order.dart';
import 'package:quickb2b_v3_6/app/home/view/home_view.dart';
import 'package:quickb2b_v3_6/app/splash/view/splash.dart';

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

  static List<GetPage> getRoutes() {
    return [
      GetPage(name: _home, page: () => HomeView()),
      GetPage(name: _login, page: () => const LoginView()),
      GetPage(name: _register, page: () => RegistrationPage()),
      GetPage(name: _forgot, page: () => ForgetPasswordPage()),
      GetPage(name: _account, page: () => ProfileDashboardView()),
      GetPage(name: _splash, page: () => Splash()),
      GetPage(name: _customerList, page: () => CustomersList()),

      // GetPage(name: _settings, page: () => const SettingsScreen()),
      // GetPage(name: _about, page: () => const AboutScreen()),
      // GetPage(name: _contact, page: () => const ContactScreen()),
    ];
  }
}

void debugConsole(String? message) {
  if (kDebugMode) {
    log(message ?? "Console null");
  }
}
