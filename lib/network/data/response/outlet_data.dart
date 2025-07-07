// To parse this JSON data, do
//
//     final outletData = outletDataFromJson(jsonString);

import 'dart:convert';

OutletData outletDataFromJson(String str) => OutletData.fromJson(json.decode(str));

String outletDataToJson(OutletData data) => json.encode(data.toJson());

class OutletData {
  int? status;
  String? message;
  List<Datum>? data;

  OutletData({this.status, this.message, this.data});

  factory OutletData.fromJson(Map<String, dynamic> json) => OutletData(status: json["status"], message: json["message"], data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))};
}

class Datum {
  String? userCode;
  String? name;
  String? outlet;

  Datum({this.userCode, this.name, this.outlet});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(userCode: json["user_code"], name: json["name"], outlet: json["outlet"]);

  Map<String, dynamic> toJson() => {"user_code": userCode, "name": name, "outlet": outlet};
}
