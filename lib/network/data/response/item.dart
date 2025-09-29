import 'package:flutter/material.dart';

class Item {
    String? itemCode;
    String? itemName;
    String? itemPrice;
    String? status;
    String? uom;
    String? measureQty;
    String? originQty;
    String? quantity;
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
    int? departmentId;
    int? retailCategoryId;
    int? isDelete;
    int? userItem;
    int? inMyList;
    int? isMeasBox;
    int? id;
    int? priority;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  Item({
    this.itemCode,
    this.itemName,
    this.itemPrice,
    this.status,
    this.uom,
    this.measureQty,
    this.originQty,
    this.quantity,
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
    this.departmentId,
    this.retailCategoryId,
    this.isDelete,
    this.userItem,
    this.inMyList,
    this.isMeasBox,
    this.id,
    this.priority,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemCode: json["item_code"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    status: json["status"],
    uom: json["uom"],
    measureQty: json["measureQty"],
    originQty: json["originQty"],
    quantity: json["quantity"],
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
    departmentId: json["department_id"],
    retailCategoryId: json["retail_category_id"],
    isDelete: json["is_delete"],
    userItem: json["user_item"],
    inMyList: json["inMyList"],
    isMeasBox: json["is_meas_box"],
    id: json["id"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode,
    "item_name": itemName,
    "item_price": itemPrice,
    "status": status,
    "uom": uom,
    "measureQty": measureQty,
    "originQty": originQty,
    "quantity": quantity,
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
    "department_id": departmentId,
    "retail_category_id": retailCategoryId,
    "is_delete": isDelete,
    "user_item": userItem,
    "inMyList": inMyList,
    "is_meas_box": isMeasBox,
    "id": id,
    "priority": priority,
  };
}
