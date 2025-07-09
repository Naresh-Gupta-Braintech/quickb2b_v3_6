import 'dart:convert';

PastOrderModel pastOrderModelFromJson(String str) => PastOrderModel.fromJson(json.decode(str));

String pastOrderModelToJson(PastOrderModel data) => json.encode(data.toJson());

class PastOrderModel {
  int? status;
  String? message;
  List<Datum>? data;

  PastOrderModel({this.status, this.message, this.data});

  factory PastOrderModel.fromJson(Map<String, dynamic> json) => PastOrderModel(status: json["status"], message: json["message"], data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))};
}

class Datum {
  String? orderId;
  String? orderDate;
  String? orderTime;
  String? deliveryDate;
  String? status;
  String? shippedDate;

  Datum({this.orderId, this.orderDate, this.orderTime, this.deliveryDate, this.status, this.shippedDate});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(orderId: json["order_id"], orderDate: json["order_date"], orderTime: json["order_time"], deliveryDate: json["delivery_date"], status: json["status"], shippedDate: json["shipped_date"]);

  Map<String, dynamic> toJson() => {"order_id": orderId, "order_date": orderDate, "order_time": orderTime, "delivery_date": deliveryDate, "status": status, "shipped_date": shippedDate};
}
