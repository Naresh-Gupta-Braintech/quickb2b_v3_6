// To parse this JSON data, do
//
//     final userItemModel = userItemModelFromJson(jsonString);

import 'dart:convert';

UserItemModel userItemModelFromJson(String str) => UserItemModel.fromJson(json.decode(str));

String userItemModelToJson(UserItemModel data) => json.encode(data.toJson());

class UserItemModel {
  int? status;
  String? message;
  List<dynamic>? data;

  UserItemModel({this.status, this.message, this.data});

  factory UserItemModel.fromJson(Map<String, dynamic> json) => UserItemModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x))};
}
