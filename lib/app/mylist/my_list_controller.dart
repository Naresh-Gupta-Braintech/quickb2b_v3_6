import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_data_service.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_repository.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';

import 'package:quickb2b_v3_6/network/data/response/my_list_model.dart';
import 'package:quickb2b_v3_6/network/data/response/user_item_model.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListController extends GetxController implements GetxService {
  MyListController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  MyListRepository repository;
  bool loading = false;
  MyListModel? myList;
  List<DataWithCategory>? dataWithCategory;
  int topNavigationIndex = 0;
  UserItemModel? item;
  List<CartItem> updatedInventoryArray = [];

  void getUserData(int reset) {
    getUserItems(reset);
  }

  void setSelectedTopNavigation(int index) {
    topNavigationIndex = index;
    update();
  }

  Future<void> updateUserInventoryMyList() async {
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
        updatedInventoryArray.add(cartItem);
      }
    });
    int length = dataWithCategory?.length ?? 0;
    for (int i = 0; i < length; i++) {
      if (dataWithCategory?[i].categoryTitle == "All Products") {
        dataWithCategory?[i].data?.forEach((item) {
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
    Get.find<HomeController>().updateUserInventoryForMyList(payload);
  }
}
