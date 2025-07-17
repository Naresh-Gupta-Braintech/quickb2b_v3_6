// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

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

  ProductModel({
    this.message,
    this.status,
    this.showPrice,
    this.showItemInGridView,
    this.showAppBanner,
    this.showImage,
    this.displayAllItemsInApp,
    this.data,
  });

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
  List<ProductsInventoriesList>? inventoriesList;
  List<dynamic>? multiItems;

  Products({this.bannerLists, this.inventoriesList, this.multiItems});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    inventoriesList:
        json["inventoriesList"] == null
            ? []
            : List<ProductsInventoriesList>.from(json["inventoriesList"]!.map((x) => ProductsInventoriesList.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<dynamic>.from(json["multi_items"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bannerLists": bannerLists == null ? [] : List<dynamic>.from(bannerLists!.map((x) => x.toJson())),
    "inventoriesList": inventoriesList == null ? [] : List<dynamic>.from(inventoriesList!.map((x) => x.toJson())),
    "multi_items": multiItems == null ? [] : List<dynamic>.from(multiItems!.map((x) => x)),
  };
}

class BannerList {
  String? image;
  String? bannerText;
  int? linkItem;
  String? linkItemType;
  String? linkItemTypeId;

  BannerList({this.image, this.bannerText, this.linkItem, this.linkItemType, this.linkItemTypeId});

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
    image: json["image"],
    bannerText: json["banner_text"],
    linkItem: json["link_item"],
    linkItemType: json["link_item_type"],
    linkItemTypeId: json["link_item_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "banner_text": bannerText,
    "link_item": linkItem,
    "link_item_type": linkItemType,
    "link_item_type_id": linkItemTypeId,
  };
}

class ProductsInventoriesList {
  String? itemCode;
  String? itemName;
  String? itemPrice;
  Status? status;
  String? uom;
  String? measureQty;
  String? originQty;
  String? quantity;
  String? comment;
  int? orderBy;
  int? specialItemId;
  int? specialTitle;
  int? orderByCat;
  String? portion;
  String? imageDescription;
  String? image;
  String? thumbImage;
  int? categoryId;
  int? retailCategoryId;
  int? isDelete;
  int? isMeasBox;
  int? inMyList;
  int? id;
  int? priority;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  ProductsInventoriesList({
    this.itemCode,
    this.itemName,
    this.itemPrice,
    this.status,
    this.uom,
    this.measureQty,
    this.originQty,
    this.quantity,
    this.comment,
    this.orderBy,
    this.specialItemId,
    this.specialTitle,
    this.orderByCat,
    this.portion,
    this.imageDescription,
    this.image,
    this.thumbImage,
    this.categoryId,
    this.retailCategoryId,
    this.isDelete,
    this.isMeasBox,
    this.inMyList,
    this.id,
    this.priority,
  });

  factory ProductsInventoriesList.fromJson(Map<String, dynamic> json) => ProductsInventoriesList(
    itemCode: json["item_code"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    status: statusValues.map[json["status"]]!,
    uom: json["uom"],
    measureQty: json["measureQty"],
    originQty: json["originQty"],
    quantity: json["quantity"],
    comment: json["comment"],
    orderBy: json["order_by"],
    specialItemId: json["special_item_id"],
    specialTitle: json["special_title"],
    orderByCat: json["order_by_cat"],
    portion: json["portion"],
    imageDescription: json["image_description"],
    image: json["image"],
    thumbImage: json["thumb_image"],
    categoryId: json["category_id"],
    retailCategoryId: json["retail_category_id"],
    isDelete: json["is_delete"],
    isMeasBox: json["is_meas_box"],
    inMyList: json["inMyList"],
    id: json["id"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode,
    "item_name": itemName,
    "item_price": itemPrice,
    "status": statusValues.reverse[status],
    "uom": uom,
    "measureQty": measureQty,
    "originQty": originQty,
    "quantity": quantity,
    "comment": comment,
    "order_by": orderBy,
    "special_item_id": specialItemId,
    "special_title": specialTitle,
    "order_by_cat": orderByCat,
    "portion": portion,
    "image_description": imageDescription,
    "image": image,
    "thumb_image": thumbImage,
    "category_id": categoryId,
    "retail_category_id": retailCategoryId,
    "is_delete": isDelete,
    "is_meas_box": isMeasBox,
    "inMyList": inMyList,
    "id": id,
    "priority": priority,
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
