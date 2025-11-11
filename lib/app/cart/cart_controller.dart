import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_repository.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';
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
  List<Product?> templist = [];
  bool isCartFetchedSuccess = false;

  void makeEditable() {
    cartData?.data?.allInventories?.forEach((order) {
      order.controller2?.text = order.quantity ?? "";
      order.controller1?.text = order.measureQty ?? "";
      debugConsole("controller1 :: ${order.controller1?.text} controller2 :: ${order.controller2?.text}");
    });
    isEdit = true;
    update();
  }

  void saveEditable() {
    cartData?.data?.allInventories?.forEach((order) {
      order.quantity = order.controller2?.text;
      order.measureQty = order.controller1?.text;
      calculateCartPrice();
      debugConsole("controller1 :: ${order.controller1?.text} controller2 :: ${order.controller2?.text}");
    });
    isEdit = false;
    update();
  }

  void getCartData() {
    getCart();
  }

  void getCartDataLocally() async {
    loading = true;
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    cartData = cart;
    loading = false;
    update();
  }

  void removedItem(index) async {
    cartData?.data?.allInventories?.removeAt(index);

    CartData? localcartData = await Get.find<LocalStorage>().getCartDetails();

    Product? inventory = localcartData?.data?.allInventories?[index];
    inventory?.quantity = 0.toString();
    inventory?.originQty = 0.toString();
    localcartData?.data?.allInventories?.removeAt(index);
    await LocalStorage.saveCartDetails(localcartData);
    Get.find<HomeController>().removedItemFromCartForCartView(inventory);

    update();
  }

  void addItemToCartLocally({String? itemCode}) async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    if (index == -1) {
      return;
    }

    Product? productItem = home?.data?.allInventories?[index];
    double measureQty = 1;
    double orginQty = 0;

    if (productItem?.isMeasBox == 0) {
      orginQty = double.tryParse(productItem?.controller2?.text ?? "1") ?? 1;
    } else if (productItem?.isMeasBox == 1) {
      measureQty = double.tryParse(productItem?.controller1?.text ?? "1") ?? 1;
      orginQty = double.tryParse(productItem?.controller2?.text ?? "1") ?? 1;
    }
    double qty = orginQty * measureQty;
    if (qty == 0) {
      return;
    }

    home?.data?.allInventories?[index].originQty = orginQty.toString();
    home?.data?.allInventories?[index].measureQty = measureQty.toString();
    home?.data?.allInventories?[index].quantity = qty.toString();

    int productAtIndexInCart = cart?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    Product inventory = home?.data?.allInventories?[index] ?? Product();
    if (productAtIndexInCart == -1) {
      cart?.data?.allInventories?.add(inventory);
    } else {
      cart?.data?.allInventories?[productAtIndexInCart].originQty = orginQty.toString();
      cart?.data?.allInventories?[productAtIndexInCart].measureQty = measureQty.toString();
      cart?.data?.allInventories?[productAtIndexInCart].quantity = qty.toString();
    }

    await LocalStorage.saveCartDetails(cart);
    cartData = cart;
    calculateCartPrice();
    update();
  }

  void addItemToCartLocall({required Product product}) async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

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

    Product inventory = product;
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
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    cart?.data?.allInventories?.removeWhere((inventory) => inventory.itemCode == itemCode);
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    if (index == -1) {
      return;
    }

    home?.data?.allInventories?[index].originQty = "";
    LocalStorage.saveCartDetails(cart);
    cartData = cart;
    calculateCartPrice();
    update();
  }

  void removeItemFromCardLocall({required Product product}) async {
    CartData? cart = await Get.find<LocalStorage>().getCartDetails();

    cart?.data?.allInventories?.removeWhere((inventory) => inventory.itemCode == product.itemCode);
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index = home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == product.itemCode) ?? -1;
    if (index == -1) {
      return;
    }
    product.originQty = "";
    LocalStorage.saveCartDetails(cart);
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
