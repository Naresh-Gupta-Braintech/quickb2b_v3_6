import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_repository.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_repository.dart';
import 'package:quickb2b_v3_6/app/profile/dashboard_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';
import 'package:quickb2b_v3_6/reusable/carousel_banner_controller.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => NetworkManager());

  //Repository
  Get.lazyPut(() => HomeRepository(network: Get.find()));
  Get.lazyPut(() => AuthRepository(network: Get.find()));
  Get.lazyPut(() => CartRepository(network: Get.find()));

  // Controllers
  Get.lazyPut(() => AuthController(sharedPreferences: sharedPreferences, repository: Get.find()));
  Get.lazyPut(() => HomeController(sharedPreferences: sharedPreferences, repository: Get.find()));
  Get.lazyPut(() => DashboardController(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => CarouselBannerController());
  Get.lazyPut(() => SplashController(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => NavigationController());
  Get.lazyPut(() => CartController(sharedPreferences: sharedPreferences, repository: Get.find()));
}
