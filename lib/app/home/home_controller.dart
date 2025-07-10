import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/utils/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  HomeRepository repository;
  bool loading = false;
  HomeItemsData? homeItems;
  int selectedOutlet = 0;
  bool toggleOutlet = false;
  CustomersData? customers;
  OutletData? outlet;
  List<List<TextEditingController?>> myListControllers = [];
  int productCount = 0;
  HashMap<String, dynamic> productItemsMap = HashMap();
  CustomerDetailsModel? customerDetails;

  List<String> customer = ["Additional Contact - Foresglen", "Additional Contact - Foresglen", "Additional Contact - Foresglen", "Additional Contact - Foresglen", "Additional Contact - Foresglen", "Additional Contact - Foresglen"];

  List<String> outlets = ["Flaming Grill Airport", "Flaming Grill City"];

  void gethomeItems() {
    getHomeDetails();
  }

  void initializeController() {
    int l = homeItems?.data?.allInventories?.length ?? 0;
    for (int i = 0; i < l; i++) {
      TextEditingController? first = TextEditingController();
      TextEditingController? second;
      if (homeItems?.data?.allInventories?[i].isMeasBox == 1) {
        second = TextEditingController();
      }
      myListControllers.add([first, second]);
    }
  }

  void setToogleOutlet() {
    toggleOutlet = !toggleOutlet;
    update();
  }

  void getCustomersList() {
    getCustomers();
  }

  void customerDetail(SingleCustmer customer) {
     getCustomersDetails(customer);
  }

  void onChaged(TextEditingController? controller, int index) {
    String value = controller?.text.trim() ?? "";
    if (value.isQuantityValid()) {
    } else {
      if (value.isNotEmpty) {
        controller?.text = value.substring(0, value.length - 1);
      }
      update();
    }
  }

  void increaseCount(String productId) {}
}
