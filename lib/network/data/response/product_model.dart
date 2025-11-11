import 'dart:convert';
import 'package:quickb2b_v3_6/network/data/response/banner_list.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? message;
  int? status;
  String? showPrice;
  int? showItemInGridView;
  int? showAppBanner;
  String? showImage;
  bool? displayAllItemsInApp;
  Products? data;

  ProductModel({this.message, this.status, this.showPrice, this.showItemInGridView, this.showAppBanner, this.showImage, this.displayAllItemsInApp, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    message: json["message"],
    status: json["status"],
    showPrice: json["show_price"],
    showItemInGridView: json["show_item_in_grid_view"],
    showAppBanner: json["show_app_banner"],
    showImage: json["show_image"],
    displayAllItemsInApp: json["display_all_items_in_app"],
    data: json["data"] == null ? null : Products.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "show_price": showPrice,
    "show_item_in_grid_view": showItemInGridView,
    "show_app_banner": showAppBanner,
    "show_image": showImage,
    "display_all_items_in_app": displayAllItemsInApp,
    "data": data?.toJson(),
  };
}

class Products {
  List<BannerList>? bannerLists;
  List<Product>? inventoriesList;
  List<Product>? multiItems;

  Products({this.bannerLists, this.inventoriesList, this.multiItems});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    inventoriesList: json["inventoriesList"] == null ? [] : List<Product>.from(json["inventoriesList"]!.map((x) => Product.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<Product>.from(json["multi_items"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bannerLists": bannerLists == null ? [] : List<dynamic>.from(bannerLists!.map((x) => x.toJson())),
    "inventoriesList": inventoriesList == null ? [] : List<dynamic>.from(inventoriesList!.map((x) => x.toJson())),
    "multi_items": multiItems == null ? [] : List<dynamic>.from(multiItems!.map((x) => x)),
  };
}
