import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  HomeRepository repository;
  bool loading = false;
  HomeItemsData? homeItems;
  int selectedOutlet = 0;

  List<String> outlets = ["Flaming Grill Airport", "Flaming Grill City"];

  void gethomeItems() {
    getHomeDetails();
  }
}
