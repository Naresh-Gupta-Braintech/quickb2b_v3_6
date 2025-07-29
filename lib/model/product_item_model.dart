import 'package:flutter/widgets.dart';

class ProductItemModel {
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
  TextEditingController? controller1 = TextEditingController();
  TextEditingController? controller2 = TextEditingController();

  ProductItemModel({
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
  });
}
