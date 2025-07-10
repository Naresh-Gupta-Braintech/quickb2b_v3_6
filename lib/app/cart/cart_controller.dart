import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_repository.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  CartRepository repository;
  CartController({required this.sharedPreferences, required this.repository});
  bool loading = true;
  CartData? cartData;
}
