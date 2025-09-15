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

  void removedItem(index) {
    // templist.add(cartData?.data?.allInventories?[index]);
    cartData?.data?.allInventories?.removeAt(index);
    update();
  }

  void addItemToCartLocally({String? itemCode}) async {
    CartData? cart = await LocalStorage.getCartDetails();
    HomeItemsData? home = Get.find<HomeController>().homeItems;
    int index =
        home?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    if (index == -1) {
      return;
    }
    print("item find");

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

    int productAtIndexInCart =
        cart?.data?.allInventories?.indexWhere((inventory) => inventory.itemCode == itemCode) ?? -1;
    print("productAtIndexInCart :: ${productAtIndexInCart}");
    AllInventory inventory = home?.data?.allInventories?[index] ?? AllInventory();
    if (productAtIndexInCart == -1) {
      print("value not find");
      cart?.data?.allInventories?.add(inventory);
    } else {
      cart?.data?.allInventories?[productAtIndexInCart].originQty = orginQty;
      cart?.data?.allInventories?[productAtIndexInCart].measureQty = measureQty.toString();
      cart?.data?.allInventories?[productAtIndexInCart].quantity = qty.toString();
    }

    LocalStorage.saveCartDetails(cart);
    cartData = cart;
    print("saved items");
    calculateCartPrice();

    update();
  }

  void removeItemFromCardLocally({String? itemCode}) async {
    CartData? cart = await LocalStorage.getCartDetails();
    print(" before deletion length :: ${cart?.data?.allInventories?.length ?? 0}");
    cart?.data?.allInventories?.removeWhere((inventory) => inventory.itemCode == itemCode);
    print("after deletion length :: ${cart?.data?.allInventories?.length ?? 0}");
    LocalStorage.saveCartDetails(cart);
    CartData? updateCart = await LocalStorage.getCartDetails();
    print("updated deletion length :: ${cart?.data?.allInventories?.length ?? 0}");
    cartData = cart;
    calculateCartPrice();
    update();
  }

  void calculateCartPrice() {
    print("start calculating price $cartPrice");
    double totalPrice = 0;
    cartData?.data?.allInventories?.forEach((item) {
      double itemPrice = double.tryParse(item.itemPrice ?? "0") ?? 0;
      double qty = double.tryParse(item.quantity ?? "0") ?? 0;
      double price = itemPrice * qty;
      totalPrice += price;
    });
    double rounded = double.parse(totalPrice.toStringAsFixed(2));
    cartPrice = rounded;
    print("completed calculating price $cartPrice");
  }
}
