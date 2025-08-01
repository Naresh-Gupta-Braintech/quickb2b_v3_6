import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/all_inventory.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/company_details_data.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
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
  List<CartItem> cartItems = [];
  bool isUpdateInventory = false;
  int modifyingValOfX = 0;

  List<String> outlets = ["Flaming Grill Airport", "Flaming Grill City"];

  void gethomeItems() {
    getHomeDetails();
  }

  @override
  void onInit() {
    super.onInit();
    print("initilized Home controller");
  }

  @override
  void dispose() {
    super.dispose();
    print("disposed Home controller");
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
    Get.find<SplashController>().isCompanyDetailsFetchedSuccess = false;
    Get.find<CartController>().isCartFetchedSuccess = false;
    Get.find<AuthController>().isGetDeviceFetchCompleted = false;
    print("selected outlet ::${outlet?.data?[index].userCode ?? "TapOutlet"}");
    sharedPreferences.setString(Keys.userCode, outlet?.data?[index].userCode ?? "TapOutlet");

    LocalStorage.setUserCode(outlet?.data?[index].userCode ?? "TapOutlet"); //setUserCode

    await Get.find<AuthController>().getDevice();
    if (Get.find<AuthController>().isGetDeviceFetchCompleted) {
      await Get.find<CartController>().getCart();
    }
    if (Get.find<CartController>().isCartFetchedSuccess) {
      Get.offNamed(RoutesHelper.home);
    }
  }

  Future<void> updateUserInventoryHome() async {
    CartData? cart = await LocalStorage.getCartDetails();
    cart?.data?.allInventories?.forEach((item) {
      if (item.isMeasBox == 0 &&
          (double.tryParse(item.originQty ?? "0") != 0 || item.orderBy != "")) {
        CartItem cartItem = CartItem();
        cartItem.id = item.id;
        cartItem.isMeasBox = item.isMeasBox;
        cartItem.itemCode = item.itemCode;
        cartItem.measureQty = item.measureQty;
        cartItem.originQty = item.originQty;
        cartItem.priority = item.priority;
        cartItem.quantity = item.quantity;
        cartItems.add(cartItem);
      }
    });

    UpdateInventoryHome payload = UpdateInventoryHome();
    payload.clientCode = GlobalConstants.clientCode;
    payload.appType = "Dual";
    payload.type = "Dual";
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.acmCode = "";
    payload.userCode = sharedPreferences.getString(Keys.userCode); //raja
    payload.cartItems = cartItems;
    payload.orderFlag = 0;
    updateUserInventoryForHome(payload);
  }

  Future<void> updateUserInventoryForMyList(UpdateInventoryHome payload) async {
    updateUserInventoryForHome(payload);
  }

  void updateUserInventory(String previouRoutes) {
    print("updateUserInventory called with route: $previouRoutes");
    if (previouRoutes == "/mylist") {
      print("updateUserInventory 222222");
      Get.find<MyListController>().updateUserInventoryMyList();
      return;
    } else {
      print("updateUserInventory 333333");
      if (modifyingValOfX == 0) {
        updateUserInventoryHome();
        modifyingValOfX++;
      }
      return;
    }
    // switch (previouRoutes) {
    //   case "/":
    //     updateUserInventoryHome();
    //     break;
    //   case "/mylist":
    //     Get.find<MyListController>().updateUserInventoryMyList();
    //     break;
    //   case "/products":
    //     updateUserInventoryHome();
    //     break;
    //   case "/cart":
    //     updateUserInventoryHome();
    //     break;
    // }
  }
}
