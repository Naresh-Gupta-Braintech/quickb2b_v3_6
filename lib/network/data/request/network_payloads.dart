import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';

class NetworkPayload {
  static Map<String, dynamic>? homeItemPayload({required HomeItemsPayload payload}) {
    return {"client_code": payload.clientCode, "user_code": payload.userCode, "device_id": payload.deviceId, "acm_code": payload.acmCode};
  }

  static Map<String, dynamic>? loginPayload({required LoginPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "acm_code": payload.acmCode,
      "username": payload.username,
      "password": payload.password,
      "client_code": payload.clientCode,
      "app_type": payload.appType,
      "type": payload.type,
      "device_type": payload.deviceType,
      "device_token": payload.deviceToken,
    };
  }

  static Map<String, dynamic>? companyDetailsPayload({required HomeItemsPayload payload}) {
    return {"client_code": payload.clientCode, "app_type": payload.appType, "type": payload.type, "user_code": payload.userCode};
  }

  static Map<String, dynamic>? cartPayload({required CartPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "app_type": payload.appType,
      "type": payload.type,
      "user_code": payload.userCode,
    };
  }

  static Map<String, dynamic>? customerListPayload({required CustomerListPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "app_type": payload.appType,
      "acm_code": payload.acmCode,
      "search": payload.search,
    };
  }

  static Map<String, dynamic>? outletPayload({required OutletPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "app_type": payload.appType,
      "acm_code": payload.acmCode,
      "type": payload.type,
      "user_code": payload.userCode,
    };
  }

  static Map<String, dynamic>? userProfilePayload({required ProfilePayload payload}) {
    return {"device_id": payload.deviceId, "client_code": payload.clientCode, "acm_code": payload.acmCode, "user_code": payload.userCode};
  }

  static Map<String, dynamic>? pastOrderPayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "type": payload.type,
      "app_type": payload.appType,
    };
  }

  static Map<String, dynamic>? appLinkPayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "type": payload.type,
      "app_type": payload.appType,
    };
  }

  static Map<String, dynamic>? appUserGuidePayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "type": payload.type,
      "app_type": payload.appType,
    };
  }

  static Map<String, dynamic>? customerDetailsPayload({required CustomerPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "app_type": payload.appType,
    };
  }

  static Map<String, dynamic>? updateProfilePayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      // "user_code": payload.userCode,
      "app_type": payload.appType,
      "user_code": payload.userCode,
      "business_name": payload.businessName,
      "first_name": payload.firstName,
      "last_name": payload.lastName,
      "phone": payload.phone,
      "mobile": payload.mobile,
      "email": payload.email,
      "delivery_note": payload.deliveryNote,
    };
  }

  static Map<String, dynamic>? updateBusinessDeliveryPayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "app_type": payload.appType,
      "delivery_address": payload.deliveryStreetNumber,
      "delivery_suburb": payload.deliverySuberb,
      "delivery_post_code": payload.deliveryPostal,
      "delivery_state": payload.deliveryStater,
      "delivery_country": payload.deliveryCountry,
    };
  }

  static Map<String, dynamic>? updatepostalAddressPayload({required ProfilePayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "app_type": payload.appType,
      "postal_address": payload.postalStreetNumber,
      "postal_suburb": payload.postalSuberb,
      "postal_post_code": payload.postalPostal,
      "postal_state": payload.postalStater,
      "postal_country": payload.postalCountry,
    };
  }

  static Map<String, dynamic>? categoryPayload({required CategoryPayload payload}) {
    return {"device_id": payload.deviceId, "client_code": payload.clientCode, "acm_code": payload.acmCode, "user_code": payload.userCode};
  }

  static Map<String, dynamic>? productPayload({required ProductPayload payload}) {
    return {
      "device_id": payload.deviceId,
      "client_code": payload.clientCode,
      "acm_code": payload.acmCode,
      "user_code": payload.userCode,
      "category_id": payload.categoryId,
      "page": payload.page,
    };
  }

  static Map<String, dynamic>? myListPayload({required MyListPayload payload}) {
    return {"device_id": payload.deviceId, "client_code": payload.clientCode, "user_code": payload.userCode, "reset": payload.reset};
  }

  static Map<String, dynamic>? getDevicePayload({required GetDevicePayload payload}) {
    return {
      "acm_code": payload.acmCode,
      "app_type": payload.appType,
      "client_code": payload.clientCode,
      "device_id": payload.deviceId,
      "device_ip_address": payload.ipAddress,
      "device_model": payload.deviceModel,
      "device_token": payload.deviceToken,
      "device_type": payload.deviceType,
      "type": payload.type,
      "user_code": payload.userCode,
    };
  }

  static Map<String, dynamic>? userItemPayload({required UserItemAddPayload payload}) {
    return {
      "user_code": payload.userCode,
      "item_code": payload.itemCode,
      "client_code": payload.clientCode,
      "app_type": payload.appType,
      "acm_code": payload.acmCode,
      "device_id": payload.deviceId,
      "type": payload.type,
    };
  }
}
