import 'package:get/route_manager.dart';
import 'package:quickb2b_v3_6/app/autthentication/forgot/forgot.dart';
import 'package:quickb2b_v3_6/app/autthentication/login/login_view.dart';
import 'package:quickb2b_v3_6/app/autthentication/register/registration_page.dart';
import 'package:quickb2b_v3_6/app/splash/splash.dart';

class RoutesHelper {
  static const String _home = '/';
  static const String _login = '/login';
  static const String _register = '/register';
  static const String _profile = '/profile';
  static const String _settings = '/settings';
  static const String _about = '/about';
  static const String _contact = '/contact';
  static const String _splash = '/splash';
  static const String _forgot = '/forgot';

  // Add more routes as needed
  static String get home => _home;
  static String get login => _login;
  static String get register => _register;
  static String get profile => _profile;
  static String get settings => _settings;
  static String get about => _about;
  static String get contact => _contact;
  static String get splash => _splash;
  static String get forgot => _forgot;

  static List<GetPage> getRoutes() {
    return [
      // GetPage(name: _home, page: () => const HomeScreen()),
      GetPage(name: _login, page: () => const LoginView()),
      GetPage(name: _register, page: () => RegistrationPage()),
      GetPage(name: _forgot, page: () => ForgetPasswordPage()),
      // GetPage(name: _profile, page: () => const ProfileScreen()),
      // GetPage(name: _settings, page: () => const SettingsScreen()),
      // GetPage(name: _about, page: () => const AboutScreen()),
      // GetPage(name: _contact, page: () => const ContactScreen()),
    ];
  }
}
