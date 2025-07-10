class HomeItemsPayload {
  String? clientCode;
  String? userCode;
  String? deviceId;
  String? acmCode;
  String? appType;
  String? type;
}

class LoginPayload {
  String? deviceId;
  String? acmCode;
  String? username;
  String? password;
  String? clientCode;
  String? appType;
  String? type;
  String? deviceType;
  String? deviceToken;
}

class CartPayload {
  String? deviceId;
  String? clientCode;
  String? appType;
  String? type;
  String? userCode;
  String? acmCode;
}

class CustomerListPayload {
  String? deviceId;
  String? acmCode;
  String? appType;
  String? clientCode;
  String? search;
  
}

class OutletPayload {
  String? userCode;
  String? clientCode;
  String? deviceId;
  String? acmCode;
  String? appType;
  String? type;
}

class ProfilePayload {
  String? userCode;
  String? clientCode;
  String? acmCode;
  String? deviceId;
  String? appType;
  String? type;
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

class CustomerPayload {
  String? deviceId;
  String? acmCode;
  String? clientCode;
  String? appType;
  String? userCode;
}
