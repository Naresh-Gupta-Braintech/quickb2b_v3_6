import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/utils/images.dart';

class NavigationController extends GetxController implements GetxService {
  int selectedIndex = 0;
  List<Navigation> bottomNavigation = [
    Navigation(iconUrl: Images.home, name: "Home", route: RoutesHelper.home),
    Navigation(iconUrl: Images.heart, name: "My List", route: RoutesHelper.home),
    Navigation(iconUrl: Images.search, name: "Products", route: RoutesHelper.home),
    Navigation(iconUrl: Images.cart, name: "My Order", route: RoutesHelper.home),
    Navigation(iconUrl: Images.home, name: "Account", route: RoutesHelper.account),
  ];

  void setSelectedIndex(int index) {
    selectedIndex = index;
    Get.offNamed(bottomNavigation[index].route);
    // update();
  }
}
