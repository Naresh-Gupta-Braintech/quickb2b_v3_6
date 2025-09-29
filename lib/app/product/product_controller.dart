import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/product/product_dataservice.dart';
import 'package:quickb2b_v3_6/app/product/product_repository.dart';
import 'package:quickb2b_v3_6/network/data/response/categories_model.dart';
import 'package:quickb2b_v3_6/network/data/response/product_model.dart';
import 'package:quickb2b_v3_6/network/data/response/user_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  ProductRepository repository;
  ProductController({required this.sharedPreferences, required this.repository});
  bool loading = false;
  CategoriesModel? categories;
  ProductModel? productdata;
  List<ProductsInventoriesList?> productsInventry = [];
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
}
