import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';

class NetworkPayload {
  static Map<String, dynamic>? homeItemPayload({required HomeItemsPayload payload}) {
    return {"client_code": payload.clientCode, "user_code": payload.userCode, "device_id": payload.deviceId, "acm_code": payload.acmCode};
  }
   static Map<String, dynamic>? loginPayload({required LoginPayload payload}) {
    return {
      
        "device_id":payload.deviceId,
        "acm_code":payload.acmCode,
        "username":payload.username,
        "password":payload.password,
        "client_code":payload.clientCode,
        "app_type":payload.appType,
        "type":payload.type,
        "device_type":payload.deviceType,
        "device_token":payload.deviceToken
      
      };
  }
}
