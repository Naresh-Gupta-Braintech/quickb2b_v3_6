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
