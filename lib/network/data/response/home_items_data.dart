import 'dart:convert';

class HomeItemsData {
  String? message;
  int? status;
  int? outlets;
  String? outletName;
  String? appName;
  String? appVersionUpdate;
  String? appVersionUpdateType;
  String? appVersionUpdateContent;
  String? dayslimit;
  String? showPrice;
  int? showDelivery;
  bool? displayAllItemsInApp;
  int? showItemInGridView;
  int? showAppBanner;
  int? showMyProduct;
  int? showPo;
  String? customerType;
  String? specialHeaderTitle;
  String? showImage;
  Data? data;

  HomeItemsData({
    this.message,
    this.status,
    this.outlets,
    this.outletName,
    this.appName,
    this.appVersionUpdate,
    this.appVersionUpdateType,
    this.appVersionUpdateContent,
    this.dayslimit,
    this.showPrice,
    this.showDelivery,
    this.displayAllItemsInApp,
    this.showItemInGridView,
    this.showAppBanner,
    this.showMyProduct,
    this.showPo,
    this.customerType,
    this.specialHeaderTitle,
    this.showImage,
    this.data,
  });

  factory HomeItemsData.fromRawJson(String str) => HomeItemsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeItemsData.fromJson(Map<String, dynamic> json) => HomeItemsData(
    message: json["message"],
    status: json["status"],
    outlets: json["outlets"],
    outletName: json["outlet_name"],
    appName: json["APP_NAME"],
    appVersionUpdate: json["app_version_update"],
    appVersionUpdateType: json["app_version_update_type"],
    appVersionUpdateContent: json["app_version_update_content"],
    dayslimit: json["DAYSLIMIT"],
    showPrice: json["show_price"],
    showDelivery: json["show_delivery"],
    displayAllItemsInApp: json["display_all_items_in_app"],
    showItemInGridView: json["show_item_in_grid_view"],
    showAppBanner: json["show_app_banner"],
    showMyProduct: json["show_my_product"],
    showPo: json["show_po"],
    customerType: json["customer_type"],
    specialHeaderTitle: json["special_header_title"],
    showImage: json["show_image"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "outlets": outlets,
    "outlet_name": outletName,
    "APP_NAME": appName,
    "app_version_update": appVersionUpdate,
    "app_version_update_type": appVersionUpdateType,
    "app_version_update_content": appVersionUpdateContent,
    "DAYSLIMIT": dayslimit,
    "show_price": showPrice,
    "show_delivery": showDelivery,
    "display_all_items_in_app": displayAllItemsInApp,
    "show_item_in_grid_view": showItemInGridView,
    "show_app_banner": showAppBanner,
    "show_my_product": showMyProduct,
    "show_po": showPo,
    "customer_type": customerType,
    "special_header_title": specialHeaderTitle,
    "show_image": showImage,
    "data": data?.toJson(),
  };
}

class Data {
  List<BannerList>? bannerLists;
  int? categoryExists;
  List<AllCategory>? allCategories;
  List<dynamic>? specialInventories;
  List<AllInventory>? allInventories;
  List<AllInventory>? multiItems;
  FeaturedItemImage? featuredItemImage;

  Data({this.bannerLists, this.categoryExists, this.allCategories, this.specialInventories, this.allInventories, this.multiItems, this.featuredItemImage});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    categoryExists: json["category_exists"],
    allCategories: json["all_categories"] == null ? [] : List<AllCategory>.from(json["all_categories"]!.map((x) => AllCategory.fromJson(x))),
    specialInventories: json["special_inventories"] == null ? [] : List<dynamic>.from(json["special_inventories"]!.map((x) => x)),
    allInventories: json["all_inventories"] == null ? [] : List<AllInventory>.from(json["all_inventories"]!.map((x) => AllInventory.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<AllInventory>.from(json["multi_items"]!.map((x) => AllInventory.fromJson(x))),
    featuredItemImage: json["featured_item_image"] == null ? null : FeaturedItemImage.fromJson(json["featured_item_image"]),
  );

  Map<String, dynamic> toJson() => {
    "bannerLists": bannerLists == null ? [] : List<dynamic>.from(bannerLists!.map((x) => x.toJson())),
    "category_exists": categoryExists,
    "all_categories": allCategories == null ? [] : List<dynamic>.from(allCategories!.map((x) => x.toJson())),
    "special_inventories": specialInventories == null ? [] : List<dynamic>.from(specialInventories!.map((x) => x)),
    "all_inventories": allInventories == null ? [] : List<dynamic>.from(allInventories!.map((x) => x.toJson())),
    "multi_items": multiItems == null ? [] : List<dynamic>.from(multiItems!.map((x) => x.toJson())),
    "featured_item_image": featuredItemImage?.toJson(),
  };
}

class AllCategory {
  int? id;
  String? name;
  String? thumbImage;

  AllCategory({this.id, this.name, this.thumbImage});

  factory AllCategory.fromRawJson(String str) => AllCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(id: json["id"], name: json["name"], thumbImage: json["thumb_image"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "thumb_image": thumbImage};
}

class AllInventory {
  String? itemCode;
  String? itemName;
  String? itemPrice;
  Status? status;
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

  AllInventory({
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

  factory AllInventory.fromRawJson(String str) => AllInventory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllInventory.fromJson(Map<String, dynamic> json) => AllInventory(
    itemCode: json["item_code"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    status: statusValues.map[json["status"]]!,
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
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode,
    "item_name": itemName,
    "item_price": itemPrice,
    "status": statusValues.reverse[status],
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
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class BannerList {
  String? image;
  String? bannerText;
  int? linkItem;
  String? linkItemType;
  String? linkItemTypeId;

  BannerList({this.image, this.bannerText, this.linkItem, this.linkItemType, this.linkItemTypeId});

  factory BannerList.fromRawJson(String str) => BannerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(image: json["image"], bannerText: json["banner_text"], linkItem: json["link_item"], linkItemType: json["link_item_type"], linkItemTypeId: json["link_item_type_id"]);

  Map<String, dynamic> toJson() => {"image": image, "banner_text": bannerText, "link_item": linkItem, "link_item_type": linkItemType, "link_item_type_id": linkItemTypeId};
}

class FeaturedItemImage {
  String? image;
  String? content;
  String? price;
  DateTime? date;
  int? visibility;
  int? show;
  int? onLogin;
  int? onLaunch;

  FeaturedItemImage({this.image, this.content, this.price, this.date, this.visibility, this.show, this.onLogin, this.onLaunch});

  factory FeaturedItemImage.fromRawJson(String str) => FeaturedItemImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeaturedItemImage.fromJson(Map<String, dynamic> json) =>
      FeaturedItemImage(image: json["image"], content: json["content"], price: json["price"], date: json["date"] == null ? null : DateTime.parse(json["date"]), visibility: json["visibility"], show: json["show"], onLogin: json["on_login"], onLaunch: json["on_launch"]);

  Map<String, dynamic> toJson() => {
    "image": image,
    "content": content,
    "price": price,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "visibility": visibility,
    "show": show,
    "on_login": onLogin,
    "on_launch": onLaunch,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
