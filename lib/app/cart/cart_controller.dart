import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_repository.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/network/data/response/all_inventory.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  CartRepository repository;
  CartController({required this.sharedPreferences, required this.repository});
  bool loading = true;
  CartData? cartData;
  double? cartPrice = 0.00;
  bool isEdit = false;
  List<AllInventory?> templist = [];
  bool isCartFetchedSuccess = false;

  void makeEditable() {
    cartData?.data?.allInventories?.forEach((order) {
      order.controller2?.text = order.quantity ?? "";
      order.controller1?.text = order.measureQty ?? "";
      print("controller1 :: ${order.controller1?.text} controller2 :: ${order.controller2?.text}");
    });
    isEdit = true;
    update();
  }

  void saveEditable() {
    cartData?.data?.allInventories?.forEach((order) {
      order.quantity = order.controller2?.text;
      order.measureQty = order.controller1?.text;
      calculateCartPrice();
      print("controller1 :: ${order.controller1?.text} controller2 :: ${order.controller2?.text}");
    });
    isEdit = false;
    update();
  }

  void getCartData() {
    getCart();
  }

  void removedItem(index) async {
    cartData?.data?.allInventories?.removeAt(index);

    CartData? localcartData = await LocalStorage.getCartDetails();
    AllInventory? inventory = localcartData?.data?.allInventories?[index];
    inventory?.quantity = 0.toString();
    inventory?.originQty = 0.toString();
    localcartData?.data?.allInventories?.removeAt(index);
    await LocalStorage.saveCartDetails(localcartData);
    Get.find<HomeController>().removedItemFromCartForCartView(inventory);

    update();
  }

  void addItemToCartLocally({String? itemCode}) async {
    CartData? cart = await LocalStorage.getCartDetails();
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    if (index == -1) {
      return;
    }

    final orginQty = home?.data?.allInventories?[index].controller2?.text ?? "";
    final measureQty = 1;
    double qty = double.tryParse(orginQty) ?? 0;
    qty = qty * measureQty;
    if (qty == 0) {
      return;
    }

    home?.data?.allInventories?[index].originQty = orginQty;
    home?.data?.allInventories?[index].measureQty = measureQty.toString();
    home?.data?.allInventories?[index].quantity = qty.toString();

    int productAtIndexInCart = cart?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;

    AllInventory inventory = home?.data?.allInventories?[index] ?? AllInventory();
    inventory.uom = inventory.controller2?.text ?? "";
    if (productAtIndexInCart == -1) {
      cart?.data?.allInventories?.add(inventory);
    } else {
      cart?.data?.allInventories?[productAtIndexInCart].originQty = orginQty;
      cart?.data?.allInventories?[productAtIndexInCart].measureQty = measureQty.toString();
      cart?.data?.allInventories?[productAtIndexInCart].quantity = qty.toString();
    }

    await LocalStorage.saveCartDetails(cart);
    cartData = cart;
    CartData? tempcart = await LocalStorage.getCartDetails();
    calculateCartPrice();

    update();
  }

  void addItemToCartLocall({required AllInventory product}) async {
    CartData? cart = await LocalStorage.getCartDetails();

    final orginQty = product.controller2?.text ?? "";
    final measureQty = 1;
    double qty = double.tryParse(orginQty) ?? 0;
    qty = qty * measureQty;
    if (qty == 0) {
      return;
    }

    product.originQty = orginQty;
    product.measureQty = measureQty.toString();
    product.quantity = qty.toString();

    int productAtIndexInCart = cart?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == product.itemCode) ?? -1;

    AllInventory inventory = product;
    if (productAtIndexInCart == -1) {
      cart?.data?.allInventories?.add(inventory);
    } else {
      cart?.data?.allInventories?[productAtIndexInCart].originQty = orginQty;
      cart?.data?.allInventories?[productAtIndexInCart].measureQty = measureQty.toString();
      cart?.data?.allInventories?[productAtIndexInCart].quantity = qty.toString();
    }

    await LocalStorage.saveCartDetails(cart);
    cartData = cart;
    calculateCartPrice();

    update();
  }

  void removeItemFromCardLocally({String? itemCode}) async {
    CartData? cart = await LocalStorage.getCartDetails();
    cart?.data?.allInventories?.removeWhere((inventory) => inventory.itemCode == itemCode);
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    if (index == -1) {
      return;
    }
    home?.data?.allInventories?[index].originQty = "";
    // home?.data?.allInventories?[index].uom = home.data?.allInventories?[index].controller2?.text ?? "";

    LocalStorage.saveCartDetails(cart);
    CartData? tempcart = await LocalStorage.getCartDetails();
    cartData = cart;
    calculateCartPrice();
    update();
  }

  void removeItemFromCardLocall({required AllInventory product}) async {
    CartData? cart = await LocalStorage.getCartDetails();
    cart?.data?.allInventories?.removeWhere((inventory) => inventory.itemCode == product.itemCode);
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == product.itemCode) ?? -1;
    if (index == -1) {
      return;
    }
    product.originQty = "";
    LocalStorage.saveCartDetails(cart);
    CartData? tempcart = await LocalStorage.getCartDetails();
    cartData = cart;
    calculateCartPrice();
    update();
  }

  void calculateCartPrice() {
    double totalPrice = 0;
    cartData?.data?.allInventories?.forEach((item) {
      double itemPrice = double.tryParse(item.itemPrice ?? "0") ?? 0;
      double qty = double.tryParse(item.quantity ?? "0") ?? 0;
      double price = itemPrice * qty;
      totalPrice += price;
    });
    double rounded = double.parse(totalPrice.toStringAsFixed(2));
    cartPrice = rounded;
  }
}
