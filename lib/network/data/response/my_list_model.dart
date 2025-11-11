import 'dart:convert';
import 'package:quickb2b_v3_6/network/data/response/banner_list.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';

MyListModel myListModelFromJson(String str) => MyListModel.fromJson(json.decode(str));

String myListModelToJson(MyListModel data) => json.encode(data.toJson());

class MyListModel {
  String? message;
  int? status;
  int? outlets;
  String? outletName;
  String? appName;
  String? dayslimit;
  String? showPrice;
  int? showDelivery;
  int? showItemInGridView;
  int? showAppBanner;
  int? showPo;
  String? deliveryCharge;
  String? minOrderValue;
  String? customerType;
  int? showPickup;
  String? pickupContact;
  int? fuelLevyEnable;
  String? fuelLevyAmount;
  DeliveryAvailable? deliveryAvailable;
  List<DateTime>? deliveryAvailableDates;
  int? routeAssigned;
  String? showImage;
  String? featuredItemImage;
  String? currencyCode;
  String? currencySymbol;
  List<BannerList>? bannerLists;
  int? minimumOrderQty;
  bool? displayAllItemsInApp;
  int? categoryExists;
  dynamic data;
  List<DataWithCategory>? dataWithCategory;
  List<Product>? multiItems;

  MyListModel({
    this.message,
    this.status,
    this.outlets,
    this.outletName,
    this.appName,
    this.dayslimit,
    this.showPrice,
    this.showDelivery,
    this.showItemInGridView,
    this.showAppBanner,
    this.showPo,
    this.deliveryCharge,
    this.minOrderValue,
    this.customerType,
    this.showPickup,
    this.pickupContact,
    this.fuelLevyEnable,
    this.fuelLevyAmount,
    this.deliveryAvailable,
    this.deliveryAvailableDates,
    this.routeAssigned,
    this.showImage,
    this.featuredItemImage,
    this.currencyCode,
    this.currencySymbol,
    this.bannerLists,
    this.minimumOrderQty,
    this.displayAllItemsInApp,
    this.categoryExists,
    this.data,
    this.dataWithCategory,
    this.multiItems,
  });

  factory MyListModel.fromJson(Map<String, dynamic> json) => MyListModel(
    message: json["message"],
    status: json["status"],
    outlets: json["outlets"],
    outletName: json["outlet_name"],
    appName: json["APP_NAME"],
    dayslimit: json["DAYSLIMIT"],
    showPrice: json["show_price"],
    showDelivery: json["show_delivery"],
    showItemInGridView: json["show_item_in_grid_view"],
    showAppBanner: json["show_app_banner"],
    showPo: json["show_po"],
    deliveryCharge: json["delivery_charge"],
    minOrderValue: json["min_order_value"],
    customerType: json["customer_type"],
    showPickup: json["show_pickup"],
    pickupContact: json["pickup_contact"],
    fuelLevyEnable: json["fuel_levy_enable"],
    fuelLevyAmount: json["fuel_levy_amount"],
    deliveryAvailable: json["delivery_available"] == null ? null : DeliveryAvailable.fromJson(json["delivery_available"]),
    deliveryAvailableDates: json["delivery_available_dates"] == null ? [] : List<DateTime>.from(json["delivery_available_dates"]!.map((x) => DateTime.parse(x))),
    routeAssigned: json["route_assigned"],
    showImage: json["show_image"],
    featuredItemImage: json["featured_item_image"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    minimumOrderQty: json["minimum_order_qty"],
    displayAllItemsInApp: json["display_all_items_in_app"],
    categoryExists: json["category_exists"],
    data: json["data"],
    dataWithCategory: json["data_with_category"] == null ? [] : List<DataWithCategory>.from(json["data_with_category"]!.map((x) => DataWithCategory.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<Product>.from(json["multi_items"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "outlets": outlets,
    "outlet_name": outletName,
    "APP_NAME": appName,
    "DAYSLIMIT": dayslimit,
    "show_price": showPrice,
    "show_delivery": showDelivery,
    "show_item_in_grid_view": showItemInGridView,
    "show_app_banner": showAppBanner,
    "show_po": showPo,
    "delivery_charge": deliveryCharge,
    "min_order_value": minOrderValue,
    "customer_type": customerType,
    "show_pickup": showPickup,
    "pickup_contact": pickupContact,
    "fuel_levy_enable": fuelLevyEnable,
    "fuel_levy_amount": fuelLevyAmount,
    "delivery_available": deliveryAvailable?.toJson(),
    "delivery_available_dates":
        deliveryAvailableDates == null
            ? []
            : List<dynamic>.from(deliveryAvailableDates!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "route_assigned": routeAssigned,
    "show_image": showImage,
    "featured_item_image": featuredItemImage,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "bannerLists": bannerLists == null ? [] : List<dynamic>.from(bannerLists!.map((x) => x.toJson())),
    "minimum_order_qty": minimumOrderQty,
    "display_all_items_in_app": displayAllItemsInApp,
    "category_exists": categoryExists,
    "data": data,
    "data_with_category": dataWithCategory == null ? [] : List<dynamic>.from(dataWithCategory!.map((x) => x.toJson())),
    "multi_items": multiItems == null ? [] : List<dynamic>.from(multiItems!.map((x) => x)),
  };
}

class DataWithCategory {
  String? categoryTitle;
  List<Product>? data;
  List<String>? itemCodes;

  DataWithCategory({this.categoryTitle, this.data, this.itemCodes});

  factory DataWithCategory.fromJson(Map<String, dynamic> json) => DataWithCategory(
    categoryTitle: json["category_title"],
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
    itemCodes: json["item_codes"] == null ? [] : List<String>.from(json["item_codes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category_title": categoryTitle,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "item_codes": itemCodes == null ? [] : List<dynamic>.from(itemCodes!.map((x) => x)),
  };
}

class DeliveryAvailable {
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;

  DeliveryAvailable({this.sun, this.mon, this.tue, this.wed, this.thu, this.fri, this.sat});

  factory DeliveryAvailable.fromJson(Map<String, dynamic> json) =>
      DeliveryAvailable(sun: json["sun"], mon: json["mon"], tue: json["tue"], wed: json["wed"], thu: json["thu"], fri: json["fri"], sat: json["sat"]);

  Map<String, dynamic> toJson() => {"sun": sun, "mon": mon, "tue": tue, "wed": wed, "thu": thu, "fri": fri, "sat": sat};
}
