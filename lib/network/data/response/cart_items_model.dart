import 'dart:convert';

import 'package:quickb2b_v3_6/network/data/response/all_inventory.dart';
import 'package:quickb2b_v3_6/network/data/response/banner_list.dart';

CartData cartDataFromJson(String str) => CartData.fromJson(json.decode(str));

String cartDataToJson(CartData data) => json.encode(data.toJson());

class CartData {
  String? message;
  int? status;
  String? appName;
  String? dayslimit;
  String? showPrice;
  int? showDelivery;
  int? showItemInGridView;
  int? showAppBanner;
  int? showMyProduct;
  String? currencyCode;
  String? currencySymbol;
  int? showPo;
  String? customerType;
  Data? data;

  CartData({
    this.message,
    this.status,
    this.appName,
    this.dayslimit,
    this.showPrice,
    this.showDelivery,
    this.showItemInGridView,
    this.showAppBanner,
    this.showMyProduct,
    this.currencyCode,
    this.currencySymbol,
    this.showPo,
    this.customerType,
    this.data,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    message: json["message"],
    status: json["status"],
    appName: json["APP_NAME"],
    dayslimit: json["DAYSLIMIT"],
    showPrice: json["show_price"],
    showDelivery: json["show_delivery"],
    showItemInGridView: json["show_item_in_grid_view"],
    showAppBanner: json["show_app_banner"],
    showMyProduct: json["show_my_product"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    showPo: json["show_po"],
    customerType: json["customer_type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "APP_NAME": appName,
    "DAYSLIMIT": dayslimit,
    "show_price": showPrice,
    "show_delivery": showDelivery,
    "show_item_in_grid_view": showItemInGridView,
    "show_app_banner": showAppBanner,
    "show_my_product": showMyProduct,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "show_po": showPo,
    "customer_type": customerType,
    "data": data?.toJson(),
  };
}

class Data {
  List<BannerList>? bannerLists;
  List<AllInventory>? allInventories;
  List<dynamic>? multiItems;

  Data({this.bannerLists, this.allInventories, this.multiItems});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    allInventories: json["all_inventories"] == null ? [] : List<AllInventory>.from(json["all_inventories"]!.map((x) => AllInventory.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<dynamic>.from(json["multi_items"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bannerLists": bannerLists == null ? [] : List<dynamic>.from(bannerLists!.map((x) => x.toJson())),
    "all_inventories": allInventories == null ? [] : List<dynamic>.from(allInventories!.map((x) => x.toJson())),
    "multi_items": multiItems == null ? [] : List<dynamic>.from(multiItems!.map((x) => x)),
  };
}

