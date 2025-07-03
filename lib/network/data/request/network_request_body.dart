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
