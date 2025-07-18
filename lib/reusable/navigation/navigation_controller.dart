import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  NavigationController({required this.sharedPreferences});
  int bottomNavigationSelectedIndex = 0;
  int topNavigationSelectedIndex = 0;
  List<Navigation> bottomNavigation = [
    Navigation(iconUrl: Images.home, name: "Home", route: RoutesHelper.home),
    Navigation(iconUrl: Images.heart, name: "My List", route: RoutesHelper.myList),
    Navigation(iconUrl: Images.search, name: "Products", route: RoutesHelper.products),
    Navigation(iconUrl: Images.cart, name: "My Order", route: RoutesHelper.myOrder),
    Navigation(iconUrl: Images.user, name: "Account", route: RoutesHelper.account),
  ];

  void setSelectedIndex(int index) {
    bottomNavigationSelectedIndex = index;
    Get.toNamed(bottomNavigation[index].route);
  }

  final List<String> list = ["Account", "Past Orders", "Links", "App user guide", "Reset My List A-Z", "Logout"];

  void setSelectedTopNavigation(int index) {
    topNavigationSelectedIndex = index;
    update();
  }
}
