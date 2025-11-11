import 'dart:convert';

import 'package:flutter/widgets.dart';

class Product {
  String? itemCode;
  String? itemName;
  String? itemPrice;
  String? status;
  String? uom;
  String? quantity;
  String? measureQty;
  String? originQty;
  String? comment;
  int? specialItemId;
  int? specialTitle;
  int? orderBy;
  int? orderByCat;
  String? portion;
  String? imageDescription;
  String? image;
  String? thumbImage;
  int? categoryId;
  int? retailCategoryId;
  int? isDelete;
  int? inMyList;
  int? isMeasBox;
  int? id;
  int? priority;
  String? priceType;
  String? priceTypeMessage;
  TextEditingController? controller1 = TextEditingController();
  TextEditingController? controller2 = TextEditingController();

  Product({
    this.itemCode,
    this.itemName,
    this.itemPrice,
    this.status,
    this.uom,
    this.quantity,
    this.measureQty,
    this.originQty,
    this.comment,
    this.specialItemId,
    this.specialTitle,
    this.orderBy,
    this.orderByCat,
    this.portion,
    this.imageDescription,
    this.image,
    this.thumbImage,
    this.categoryId,
    this.retailCategoryId,
    this.isDelete,
    this.inMyList,
    this.isMeasBox,
    this.id,
    this.priority,
    this.priceType,
    this.priceTypeMessage,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    itemCode: json["item_code"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    status: json["status"],
    uom: json["uom"],
    quantity: json["quantity"],
    measureQty: json["measureQty"],
    originQty: json["originQty"],
    comment: json["comment"],
    specialItemId: json["special_item_id"],
    specialTitle: json["special_title"],
    orderBy: json["order_by"],
    orderByCat: json["order_by_cat"],
    portion: json["portion"],
    imageDescription: json["image_description"],
    image: json["image"],
    thumbImage: json["thumb_image"],
    categoryId: json["category_id"],
    retailCategoryId: json["retail_category_id"],
    isDelete: json["is_delete"],
    inMyList: json["inMyList"],
    isMeasBox: json["is_meas_box"],
    id: json["id"],
    priority: json["priority"],
    priceType: json['price_type'],
    priceTypeMessage: json['price_type_message'],
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode,
    "item_name": itemName,
    "item_price": itemPrice,
    "status": status,
    "uom": uom,
    "quantity": quantity,
    "measureQty": measureQty,
    "originQty": originQty,
    "comment": comment,
    "special_item_id": specialItemId,
    "special_title": specialTitle,
    "order_by": orderBy,
    "order_by_cat": orderByCat,
    "portion": portion,
    "image_description": imageDescription,
    "image": image,
    "thumb_image": thumbImage,
    "category_id": categoryId,
    "retail_category_id": retailCategoryId,
    "is_delete": isDelete,
    "inMyList": inMyList,
    "is_meas_box": isMeasBox,
    "id": id,
    "priority": priority,
    'price_type': priceType,
    'price_type_message': priceTypeMessage,
  };
}
