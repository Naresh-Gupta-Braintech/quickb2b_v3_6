import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/all_inventory.dart';
import 'package:quickb2b_v3_6/network/data/response/company_details_data.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
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
  CompanyDetailsData? companyDetails;
  int selectedOutled = 0;

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

  void getCompanyDetail() {
    getCompanyDetails();
  }

  void onChaged(TextEditingController? controller, int index) {
    AllInventory? productItem = homeItems?.data?.allInventories?[index];
    String value = controller?.text.trim() ?? "";
    if (value == '.') value = '0$value';
    if (value.isEmpty) {
      Get.find<CartController>().removeItemFromCardLocally(itemCode: productItem?.itemCode);
    } else if (value.isQuantityValid()) {
      Get.find<CartController>().addItemToCartLocally(itemCode: productItem?.itemCode);
    } else {
      if (value.isNotEmpty) {
        controller?.text = value.substring(0, value.length - 1);
      }
      update();
    }
  }

  void getOutletinfo() {
    getOutlets();
  }

  void increaseCount(String productId) {}

  void handleOnTapOutlet(int index) async {
    sharedPreferences.setString(Keys.userCode, outlet?.data?[index].userCode ?? "");
    Get.find<AuthController>().getDevice();
    Get.find<CartController>().getCartData();
    Get.offAllNamed(RoutesHelper.home);
  }
}
