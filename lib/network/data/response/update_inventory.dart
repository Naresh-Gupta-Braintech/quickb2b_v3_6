// To parse this JSON data, do
//
//     final updateInventoryModel = updateInventoryModelFromJson(jsonString);

import 'dart:convert';

UpdateInventoryModel updateInventoryModelFromJson(String str) => UpdateInventoryModel.fromJson(json.decode(str));

String updateInventoryModelToJson(UpdateInventoryModel data) => json.encode(data.toJson());

class UpdateInventoryModel {
    int? status;
    String? message;
    List<dynamic>? data;

    UpdateInventoryModel({
        this.status,
        this.message,
        this.data,
    });

    factory UpdateInventoryModel.fromJson(Map<String, dynamic> json) => UpdateInventoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
