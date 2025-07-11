import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_data_service.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_repository.dart';

import 'package:quickb2b_v3_6/network/data/response/my_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListController extends GetxController implements GetxService {
  MyListController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  MyListRepository repository;
  bool loading = false;
  MyListModel? myList;

  void getUserData(int reset) {
    getUserItems(reset);
  }
}
