import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/product/product_dataservice.dart';
import 'package:quickb2b_v3_6/app/product/product_repository.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/all_inventory.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/categories_model.dart';
import 'package:quickb2b_v3_6/network/data/response/product_model.dart';
import 'package:quickb2b_v3_6/network/data/response/user_item_model.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:quickb2b_v3_6/utils/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  ProductRepository repository;
  ProductController({required this.sharedPreferences, required this.repository});
  bool loading = false;
  CategoriesModel? categories;
  ProductModel? productdata;
  List<ProductsInventories?> productsInventry = [];
  String previousCategory = "";
  UserItemModel? userItems;

  int page = 0;

  void getAllCategories() {
    getCategories();
  }

  void searchProductByCategoryId(String categoryId) {
    getAllProductByCategory(categoryId);
  }

  void addUserItemToMyList(String itemCode) {
    addItemsToMYList(itemCode);
  }

  void onChangeProduct(int index) {
    ProductsInventories? item = productdata?.data?.inventoriesList?[index];
    TextEditingController? controller = item?.textEditingController2;
    item?.originQty = controller?.text;
    String value = controller?.text.trim() ?? "";
    if (value == '.') value = '0$value';
    if (value.isEmpty) {
      Get.find<CartController>().removeItemFromCardLocally(itemCode: item?.itemCode);
    } else if (value.isQuantityValid()) {
      AllInventory inventory = AllInventory();
      inventory.categoryId = item?.categoryId;
      inventory.comment = item?.comment;
      inventory.controller1 = item?.textEditingController1;
      inventory.controller2 = item?.textEditingController2;
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
      inventory.status = item?.status.toString();
      inventory.thumbImage = item?.thumbImage;
      inventory.uom = item?.uom;
      Get.find<CartController>().addItemToCartLocall(product: inventory);
    } else {
      if ((!value.isQuantityValid()) && value.isNotEmpty) {
        controller?.text = value.substring(0, value.length - 1);
      }
    }
  }

  Future<void> updateUserInventory() async {
    CartData? cart = await LocalStorage.getCartDetails();
    List<CartItem> carts = [];
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
        carts.add(cartItem);
      }
    });

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
    payload.cartItems = carts;
    payload.orderFlag = 1;
    Get.find<HomeController>().updateInventoryFromProductView(payload);
  }
}
