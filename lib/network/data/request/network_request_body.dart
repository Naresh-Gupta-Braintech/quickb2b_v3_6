import 'dart:convert';

class AbstractPayload {
  String? deviceId;
  String? clientCode;
  String? userCode;
  String? acmCode;
  String? appType;
  String? type;
}

class HomeItemsPayload extends AbstractPayload {}

class LoginPayload extends AbstractPayload {
  String? username;
  String? password;
  String? deviceType;
  String? deviceToken;
}

class CartPayload extends AbstractPayload {}

class CustomerListPayload extends AbstractPayload {
  String? search;
}

class OutletPayload extends AbstractPayload {}

class ProfilePayload extends AbstractPayload {
  String? customerId;
  String? businessName;
  String? firstName;
  String? lastName;
  String? phone;
  String? mobile;
  String? email;
  String? deliveryNote;
  String? deliveryStreetNumber;
  String? deliverySuberb;
  String? deliveryCountry;
  String? deliveryStater;
  String? deliveryPostal;
  String? postalStreetNumber;
  String? postalSuberb;
  String? postalCountry;
  String? postalStater;
  String? postalPostal;
}

class CustomerPayload extends AbstractPayload {}

class CategoryPayload extends AbstractPayload {}

class ProductPayload extends AbstractPayload {
  String? categoryId;
  int? page;
}

class MyListPayload extends AbstractPayload {
  int? reset;
}

class GetDevicePayload extends AbstractPayload {
  String? ipAddress;
  String? deviceModel;
  String? deviceToken;
  String? deviceType;
}

class UserItemAddPayload extends AbstractPayload {
  String? itemCode;
}

UpdateInventoryHome updateInventoryHomeFromJson(String str) => UpdateInventoryHome.fromJson(json.decode(str));

String updateInventoryHomeToJson(UpdateInventoryHome data) => json.encode(data.toJson());

class UpdateInventoryHome {
  String? acmCode;
  String? userCode;
  String? clientCode;
  String? type;
  int? orderFlag;
  String? appType;
  String? deviceId;
  String? deviceType;
  List<CartItem>? cartItems;

  UpdateInventoryHome({
    this.acmCode,
    this.userCode,
    this.clientCode,
    this.type,
    this.orderFlag,
    this.appType,
    this.deviceId,
    this.cartItems,
    this.deviceType,
  });

  factory UpdateInventoryHome.fromJson(Map<String, dynamic> json) => UpdateInventoryHome(
        acmCode: json["acm_code"],
        userCode: json["user_code"],
        clientCode: json["client_code"],
        type: json["type"],
        orderFlag: json["orderFlag"],
        appType: json["app_type"],
        deviceId: json["device_id"],
        deviceType: json["device_type"],
        cartItems: json["cartItems"] == null ? [] : List<CartItem>.from(json["cartItems"]!.map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "acm_code": acmCode,
        "user_code": userCode,
        "client_code": clientCode,
        "type": type,
        "orderFlag": orderFlag,
        "app_type": appType,
        "device_id": deviceId,
        "device_type": deviceType,
        "cartItems": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
      };
}

class CartItem {
  int? id;
  int? isMeasBox;
  String? quantity;
  String? itemCode;
  String? measureQty;
  String? originQty;
  int? priority;

  CartItem({
    this.id,
    this.isMeasBox,
    this.quantity,
    this.itemCode,
    this.measureQty,
    this.originQty,
    this.priority,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        isMeasBox: json["is_meas_box"],
        quantity: json["quantity"],
        itemCode: json["item_code"],
        measureQty: json["measureQty"],
        originQty: json["originQty"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_meas_box": isMeasBox,
        "quantity": quantity,
        "item_code": itemCode,
        "measureQty": measureQty,
        "originQty": originQty,
        "priority": priority,
      };
}
