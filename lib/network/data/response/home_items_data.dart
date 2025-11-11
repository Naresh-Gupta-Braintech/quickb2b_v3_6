import 'dart:convert';
import 'package:quickb2b_v3_6/network/data/response/banner_list.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';

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
  List<Product>? specialInventories;
  List<Product>? allInventories;
  List<Product>? multiItems;
  FeaturedItemImage? featuredItemImage;

  Data({this.bannerLists, this.categoryExists, this.allCategories, this.specialInventories, this.allInventories, this.multiItems, this.featuredItemImage});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannerLists: json["bannerLists"] == null ? [] : List<BannerList>.from(json["bannerLists"]!.map((x) => BannerList.fromJson(x))),
    categoryExists: json["category_exists"],
    allCategories: json["all_categories"] == null ? [] : List<AllCategory>.from(json["all_categories"]!.map((x) => AllCategory.fromJson(x))),
    specialInventories: json["special_inventories"] == null ? [] : List<Product>.from(json["special_inventories"]!.map((x) => x)),
    allInventories: json["all_inventories"] == null ? [] : List<Product>.from(json["all_inventories"]!.map((x) => Product.fromJson(x))),
    multiItems: json["multi_items"] == null ? [] : List<Product>.from(json["multi_items"]!.map((x) => Product.fromJson(x))),
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

  factory FeaturedItemImage.fromJson(Map<String, dynamic> json) => FeaturedItemImage(
    image: json["image"],
    content: json["content"],
    price: json["price"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    visibility: json["visibility"],
    show: json["show"],
    onLogin: json["on_login"],
    onLaunch: json["on_launch"],
  );

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
