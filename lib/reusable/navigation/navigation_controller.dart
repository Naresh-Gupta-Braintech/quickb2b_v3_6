import 'package:get/get.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/utils/images.dart';

class NavigationController extends GetxController implements GetxService {

  int selectedIndex = 0;
  List<Navigation> bottomNavigation =[
    Navigation(iconUrl: Images.home, name: "Home"),
    Navigation(iconUrl: Images.heart, name: "My List"),
    Navigation(iconUrl: Images.search, name: "Products"),
    Navigation(iconUrl: Images.cart, name: "My Order"),
    Navigation(iconUrl: Images.home, name: "Account"),
  ];
}
