import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/company_details_data.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_details_model.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';
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
  List<List<TextEditingController?>> myListControllers = []; // only for special items for testing
  int productCount = 0;
  HashMap<String, dynamic> productItemsMap = HashMap();
  CustomerDetailsModel? customerDetails;
  CompanyDetailsData? companyDetails;
  int selectedOutled = 0;
  bool isUpdateInventory = false;
  int modifyingValOfX = 0;
  bool outletLoading = false;

  void gethomeItems() {
    getHomeDetails();
  }

  void updateToggleOutlet() {
    toggleOutlet = !toggleOutlet;
    update();
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

  void onTapPlusIconforMultiItem(int index) async {
    Product? productItem = homeItems?.data?.allInventories?[index];
    print("clicked plus icon for multi item :: ${productItem?.priority}");
    // Get the local cart and find the item in cart
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    int productAtIndexInCart =
        cart?.data?.allInventories?.indexWhere(
          (inventory) =>
              inventory.itemCode == productItem?.itemCode && inventory.measureQty == productItem?.measureQty && inventory.originQty == productItem?.originQty && inventory.priority == 1,
        ) ??
        -1;

    print("productAtIndexInCart :: $productAtIndexInCart");
    if (productAtIndexInCart == -1) {
      return;
    }

    cart?.data?.allInventories?[productAtIndexInCart].priority = 0;
    await LocalStorage.saveCartDetails(cart);
    // set priority to 0 in array that shows in home screen and find the item
    homeItems?.data?.allInventories?[index].priority = 1;
    homeItems?.data?.allInventories?[index].controller1?.text = "";
    homeItems?.data?.allInventories?[index].controller2?.text = "";
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

  void onChagedHomeProduct(int index) {
    Product? productItem = homeItems?.data?.allInventories?[index];
    print("product item isMeasBox :: ${productItem?.isMeasBox}. itemCode :: ${productItem?.itemCode}");
    if (productItem?.isMeasBox == 0) {
      String value = productItem?.controller2?.text.trim() ?? "";

      if (value == '.') value = '0$value';
      if (value.isEmpty) {
        Get.find<CartController>().removeItemFromCardLocally(itemCode: productItem?.itemCode);
      } else if (value.isQuantityValid()) {
        Get.find<CartController>().addItemToCartLocally(itemCode: productItem?.itemCode);
      } else {
        if ((!value.isQuantityValid()) && value.isNotEmpty) {
          productItem?.controller2?.text = value.substring(0, value.length - 1);
        }
      }
    } else if (productItem?.isMeasBox == 1) {
      String value1 = productItem?.controller1?.text.trim() ?? "";
      String value2 = productItem?.controller2?.text.trim() ?? "";
      print("value before processing :: $value1 value2 :: $value2");
      if (value1 == '.') value1 = '0$value1';
      if (value2 == '.') value2 = '0$value2';

      if (value1.isEmpty || value2.isEmpty) {
        Get.find<CartController>().removeItemFromCardLocally(itemCode: productItem?.itemCode);
      } else if (value1.isQuantityValid() && value2.isQuantityValid()) {
        Get.find<CartController>().addItemToCartLocally(itemCode: productItem?.itemCode);
      } else {
        if ((!value1.isQuantityValid()) && value1.isNotEmpty) {
          productItem?.controller1?.text = value1.substring(0, value1.length - 1);
        }
        if ((!value2.isQuantityValid()) && value2.isNotEmpty) {
          productItem?.controller2?.text = value2.substring(0, value2.length - 1);
        }
      }
    }

    // update();
  }

  void getOutletinfo() {
    getOutlets();
  }

  void increaseCount(String productId) {}

  void handleOnTapOutlet(int index) async {
    print("in Handle Outlet");
    Get.find<SplashController>().isCompanyDetailsFetchedSuccess = false;
    Get.find<CartController>().isCartFetchedSuccess = false;
    Get.find<AuthController>().isGetDeviceFetchCompleted = false;
    print("selected outlet ::${outlet?.data?[index].userCode ?? "TapOutlet"}");
    sharedPreferences.setString(Keys.userCode, outlet?.data?[index].userCode ?? "TapOutlet");

    LocalStorage.setUserCode(outlet?.data?[index].userCode ?? "TapOutlet"); //setUserCode
    await Get.find<LocalStorage>().saveSelectedOutlet(outlet?.data?[index]);

    await Get.find<AuthController>().getDevice();
    if (Get.find<AuthController>().isGetDeviceFetchCompleted) {
      await Get.find<CartController>().getCart();
    }
    if (Get.find<CartController>().isCartFetchedSuccess) {
      Get.offNamed(RoutesHelper.home);
    }
  }

  Future<void> updateUserInventoryHome() async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    List<CartItem> cartItems = [];

    int val = 1;
    cart?.data?.allInventories?.forEach((item) {
      if (item.isMeasBox == 0 && (double.tryParse(item.originQty ?? "0") != 0 || item.orderBy != "")) {
        CartItem cartItem = CartItem();
        cartItem.id = item.id;
        cartItem.isMeasBox = item.isMeasBox;
        cartItem.itemCode = item.itemCode;
        cartItem.measureQty = item.measureQty;
        cartItem.originQty = item.originQty;
        cartItem.priority = item.priority;
        cartItem.quantity = item.quantity;
        cartItems.add(cartItem);
      } else if (item.isMeasBox == 1 && (double.tryParse(item.originQty ?? "0") != 0 && double.tryParse(item.measureQty ?? "0") != 0 || item.orderBy != "")) {
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
    payload.deviceType = 'I';
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

  Future<void> updateInventoryFromProductView(UpdateInventoryHome payload) async {
    updateUserInventoryForHome(payload);
  }

  void removedItemFromCartForCartView(Product? allInventory) async {
    List<CartItem> cartItems = [];
    CartItem cart = CartItem();
    cart.id = allInventory?.id;
    cart.isMeasBox = allInventory?.isMeasBox;
    cart.itemCode = allInventory?.itemCode;
    cart.measureQty = allInventory?.measureQty;
    cart.originQty = allInventory?.originQty;
    cart.priority = allInventory?.priority;
    cart.quantity = allInventory?.quantity;
    cartItems.add(cart);

    UpdateInventoryHome payload = UpdateInventoryHome();
    payload.deviceType = 'I';
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

  Future<void> updateOutlesForHome(Outlet outlet) async {
    await Get.find<LocalStorage>().saveSelectedOutlet(outlet);
    toggleOutlet = false;
  }
}
