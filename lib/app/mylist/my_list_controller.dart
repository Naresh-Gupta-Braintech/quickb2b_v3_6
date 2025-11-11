import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_data_service.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_data_service.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_repository.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/my_list_model.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';
import 'package:quickb2b_v3_6/network/data/response/user_item_model.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:quickb2b_v3_6/utils/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListController extends GetxController implements GetxService {
  MyListController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  MyListRepository repository;
  bool loading = false;
  MyListModel? myList;
  // List<DataWithCategory>? dataWithCategory;
  // int topNavigationIndex = 0;
  UserItemModel? item;
  List<CartItem> updatedInventoryArray = [];

  void getUserData(int reset) {
    getUserItems(reset);
  }

  void removeFromList(String itemCode) {
    removeFromMyList(itemCode);
  }

  // void setSelectedTopNavigation(int index) {
  //   topNavigationIndex = index;
  //   update();
  // }

  Future<void> updateUserInventoryMyList() async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

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
        updatedInventoryArray.add(cartItem);
      }
    });
    int length = myList?.dataWithCategory?.length ?? 0;
    for (int i = 0; i < length; i++) {
      if (myList?.dataWithCategory?[i].categoryTitle == "All Products") {
        myList?.dataWithCategory?[i].data?.forEach((item) {
          CartItem cartItem = CartItem();
          cartItem.id = item.id;
          cartItem.isMeasBox = item.isMeasBox;
          cartItem.itemCode = item.itemCode;
          cartItem.measureQty = 1.toString();
          cartItem.originQty = 0.toString();
          cartItem.priority = -1;
          cartItem.quantity = 0.toString();
          updatedInventoryArray.add(cartItem);
        });
      }
    }

    UpdateInventoryHome payload = UpdateInventoryHome();
    payload.clientCode = GlobalConstants.clientCode;
    payload.appType = "Dual";
    payload.type = "Dual";
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.acmCode = "";
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    print("payload.userCode 1 : ${payload.userCode}");
    payload.userCode = await LocalStorage.getUserCode() ?? "";
    print("payload.userCode 2 : ${payload.userCode}");
    payload.cartItems = updatedInventoryArray;
    payload.orderFlag = 1;
    Get.find<HomeController>().updateUserInventoryForHome(payload);
  }

  void makeMyListFromLocalData() async {
    var cart = await Get.find<LocalStorage>().getCartDetails();

    cart?.data?.allInventories?.forEach((element) {
      print("make my list From Local Data :: ${element.itemCode} qty :: ${element.quantity}");
       int length = myList?.dataWithCategory?.length ?? 0;
       
       for (int i = 0; i < length; i++) {
      int dataLength = myList?.dataWithCategory?[i].data?.length ?? 0;
      for (int j = 0; j < dataLength; j++) {

        // compareAndUpdateMyList(data: myList?.dataWithCategory?[i].data?[j], outerIndex: i, innerIndex: j);
      }
    }
    });
  
    int length = myList?.dataWithCategory?.length ?? 0;
    for (int i = 0; i < length; i++) {
      int dataLength = myList?.dataWithCategory?[i].data?.length ?? 0;
      for (int j = 0; j < dataLength; j++) {
        // compareAndUpdateMyList(data: myList?.dataWithCategory?[i].data?[j], outerIndex: i, innerIndex: j);
      }
    }
    update();
  }

  

  void onChangeMyList(int outerIndex, int innerIndex) {
    Product? item = myList?.dataWithCategory?[outerIndex].data?[innerIndex];
    TextEditingController? controller = item?.controller1;
    item?.originQty = controller?.text;
    String value = controller?.text.trim() ?? "";
    if (value == '.') value = '0$value';
    if (value.isEmpty) {
      Get.find<CartController>().removeItemFromCardLocally(itemCode: item?.itemCode);
    } else if (value.isQuantityValid()) {
      Product inventory = Product();
      inventory.categoryId = item?.categoryId;
      inventory.comment = item?.comment;
      inventory.controller1 = item?.controller1;
      inventory.controller2 = item?.controller2;
      inventory.id = item?.id;
      inventory.image = item?.image;
      inventory.imageDescription = item?.imageDescription;
      inventory.inMyList = item?.inMyList;
      inventory.isDelete = item?.isDelete;
      inventory.isMeasBox = item?.isMeasBox;
      inventory.itemCode = item?.itemCode;
      inventory.itemName = item?.itemName;
      inventory.itemPrice = item?.itemPrice;
      inventory.measureQty = item?.measureQty;
      inventory.categoryId = item?.categoryId;
      inventory.orderBy = item?.orderBy;
      inventory.orderByCat = item?.orderByCat;
      inventory.originQty = item?.originQty;
      inventory.portion = item?.portion;
      inventory.priority = item?.priority;
      inventory.quantity = item?.quantity;
      inventory.retailCategoryId = item?.retailCategoryId;
      inventory.specialItemId = item?.specialItemId;
      inventory.specialTitle = item?.specialTitle;
      inventory.status = item?.status;
      inventory.thumbImage = item?.thumbImage;
      inventory.uom = item?.uom;
      Get.find<CartController>().addItemToCartLocall(product: inventory);
    } else {
      if ((!value.isQuantityValid()) && value.isNotEmpty) {
        controller?.text = value.substring(0, value.length - 1);
      }
    }
  }
}
