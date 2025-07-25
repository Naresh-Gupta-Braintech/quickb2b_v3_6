import 'dart:convert';

GetDeviceTypeModel getDeviceTypeModelFromJson(String str) => GetDeviceTypeModel.fromJson(json.decode(str));

String getDeviceTypeModelToJson(GetDeviceTypeModel data) => json.encode(data.toJson());

class GetDeviceTypeModel {
  int? result;
  String? message;
  Data? data;

  GetDeviceTypeModel({this.result, this.message, this.data});

  factory GetDeviceTypeModel.fromJson(Map<String, dynamic> json) =>
      GetDeviceTypeModel(result: json["result"], message: json["message"], data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"result": result, "message": message, "data": data?.toJson()};
}

class Data {
  String? id;
  String? userCode;
  String? deviceId;
  String? deviceType;
  String? deviceToken;
  String? type;
  String? deviceModel;
  String? deviceIpAddress;
  DateTime? created;
  DateTime? updated;
  dynamic androidDeviceVersion;

  Data({
    this.id,
    this.userCode,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.type,
    this.deviceModel,
    this.deviceIpAddress,
    this.created,
    this.updated,
    this.androidDeviceVersion,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userCode: json["user_code"],
    deviceId: json["device_id"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    type: json["type"],
    deviceModel: json["device_model"],
    deviceIpAddress: json["device_ip_address"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    androidDeviceVersion: json["android_device_version"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_code": userCode,
    "device_id": deviceId,
    "device_type": deviceType,
    "device_token": deviceToken,
    "type": type,
    "device_model": deviceModel,
    "device_ip_address": deviceIpAddress,
    "created": created?.toIso8601String(),
    "updated": updated?.toIso8601String(),
    "android_device_version": androidDeviceVersion,
  };
}
