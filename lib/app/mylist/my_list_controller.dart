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
  UserItemModel? item;
  List<CartItem> updatedInventoryArray = [];

  void getUserData(int reset) {
    getUserItems(reset);
  }

  void removeFromList(String itemCode) {
    removeFromMyList(itemCode);
  }

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
    Product? productItem = myList?.dataWithCategory?[outerIndex].data?[innerIndex];

    if (productItem?.isMeasBox == 0) {
      String value = productItem?.controller2?.text.trim() ?? "";

      if (value == '.') value = '0$value';
      if (value.isEmpty) {
        Get.find<CartController>().removeItemFromCardLocally(itemCode: productItem?.itemCode);
      } else if (value.isQuantityValid()) {
        addItemToCartLocally(product: productItem);
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
        addItemToCartLocally(product: productItem);
      } else {
        if ((!value1.isQuantityValid()) && value1.isNotEmpty) {
          productItem?.controller1?.text = value1.substring(0, value1.length - 1);
        }
        if ((!value2.isQuantityValid()) && value2.isNotEmpty) {
          productItem?.controller2?.text = value2.substring(0, value2.length - 1);
        }
      }
    }
  }

  void addItemToCartLocally({Product? product}) async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    int outerLength = myList?.dataWithCategory?.length ?? 0;
    for (int outer = 0; outer < outerLength; outer++) {
      var element = myList?.dataWithCategory?[outer];

      int length = element?.data?.length ?? 0;
      for (int inner = 0; inner < length; inner++) {
        Product? productItem = element?.data?[inner];
        double measureQty = 1;
        double orginQty = 0;

        if (productItem?.isMeasBox == 0) {
          orginQty = double.tryParse(product?.controller2?.text ?? "1") ?? 1;
        } else if (productItem?.isMeasBox == 1) {
          measureQty = double.tryParse(product?.controller1?.text ?? "1") ?? 1;
          orginQty = double.tryParse(product?.controller2?.text ?? "1") ?? 1;
        }
        double qty = orginQty * measureQty;
        print("calculate :: ${orginQty}");
        if (qty == 0) {
          return;
        }

        myList?.dataWithCategory?[outer].data?[inner].originQty = orginQty.toString();
        myList?.dataWithCategory?[outer].data?[inner].measureQty = measureQty.toString();
        myList?.dataWithCategory?[outer].data?[inner].quantity = qty.toString();

        int productAtIndexInCart = cart?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == product?.itemCode) ?? -1;
        Product inventory = myList?.dataWithCategory?[outer].data?[inner] ?? Product();
        if (productAtIndexInCart == -1) {
          cart?.data?.allInventories?.add(inventory);
        } else {
          cart?.data?.allInventories?[productAtIndexInCart].originQty = orginQty.toString();
          cart?.data?.allInventories?[productAtIndexInCart].measureQty = measureQty.toString();
          cart?.data?.allInventories?[productAtIndexInCart].quantity = qty.toString();
        }
      }
    }
    await LocalStorage.saveCartDetails(cart);
    Get.find<CartController>().cartData = cart;
    Get.find<CartController>().calculateCartPrice();
    update();
  }
}
