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

class UpdateUserInventory extends AbstractPayload {
  int? orderFlag;
  List<CartItemElement?> cartItems = [];

    factory UpdateUserInventory.fromJson(Map<String, dynamic> json) => CartItem(
        cartItems: json["cartItems"] == null ? [] : List<CartItemElement>.from(json["cartItems"]!.map((x) => CartItemElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cartItems": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
    };
}

class CartItemElement {
  int? id;
  int? isMeasBox;
  int? quantity;
  String? itemCode;
  int? measureQty;
  int? originQty;
  int? priority;

  CartItemElement({this.id, this.isMeasBox, this.quantity, this.itemCode, this.measureQty, this.originQty, this.priority});

  factory CartItemElement.fromJson(Map<String, dynamic> json) => CartItemElement(
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
