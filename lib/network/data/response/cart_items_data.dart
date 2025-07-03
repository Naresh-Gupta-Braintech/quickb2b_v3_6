import 'dart:convert';

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

    Data({
        this.bannerLists,
        this.allInventories,
        this.multiItems,
    });

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

class AllInventory {
    String? itemCode;
    String? itemName;
    String? itemPrice;
    String? status;
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

    AllInventory({
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

    factory AllInventory.fromJson(Map<String, dynamic> json) => AllInventory(
        itemCode: json["item_code"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        status: json["status"],
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
        "status": status,
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

class BannerList {
    String? image;
    String? bannerText;
    int? linkItem;
    String? linkItemType;
    String? linkItemTypeId;

    BannerList({
        this.image,
        this.bannerText,
        this.linkItem,
        this.linkItemType,
        this.linkItemTypeId,
    });

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
