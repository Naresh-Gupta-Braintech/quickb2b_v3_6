// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  int? status;
  String? message;
  Data? data;

  UpdateProfileModel({this.status, this.message, this.data});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(status: json["status"], message: json["message"], data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  String? userCode;
  String? appName;

  Data({this.userCode, this.appName});

  factory Data.fromJson(Map<String, dynamic> json) => Data(userCode: json["user_code"], appName: json["APP_NAME"]);

  Map<String, dynamic> toJson() => {"user_code": userCode, "APP_NAME": appName};
}
