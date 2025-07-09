// To parse this JSON data, do
//
//     final customerDetailsModel = customerDetailsModelFromJson(jsonString);

import 'dart:convert';

CustomerDetailsModel customerDetailsModelFromJson(String str) => CustomerDetailsModel.fromJson(json.decode(str));

String customerDetailsModelToJson(CustomerDetailsModel data) => json.encode(data.toJson());

class CustomerDetailsModel {
  Data? data;
  int? status;
  int? outlets;

  CustomerDetailsModel({this.data, this.status, this.outlets});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) => CustomerDetailsModel(data: json["data"] == null ? null : Data.fromJson(json["data"]), status: json["status"], outlets: json["outlets"]);

  Map<String, dynamic> toJson() => {"data": data?.toJson(), "status": status, "outlets": outlets};
}

class Data {
  String? appName;
  String? appCompanyName;
  String? userCode;
  String? email;
  String? businessName;
  String? firstName;
  String? lastName;
  String? contactName;
  String? phone;
  String? mobile;
  String? deliveryAddress;
  String? deliverySuburb;
  String? deliveryPostCode;
  String? deliveryState;
  String? deliveryCountry;
  String? postalAddress;
  String? postalSuburb;
  String? postalPostCode;
  String? postalState;
  String? postalCountry;
  String? showPrice;
  String? customerType;
  int? showDelivery;

  Data({
    this.appName,
    this.appCompanyName,
    this.userCode,
    this.email,
    this.businessName,
    this.firstName,
    this.lastName,
    this.contactName,
    this.phone,
    this.mobile,
    this.deliveryAddress,
    this.deliverySuburb,
    this.deliveryPostCode,
    this.deliveryState,
    this.deliveryCountry,
    this.postalAddress,
    this.postalSuburb,
    this.postalPostCode,
    this.postalState,
    this.postalCountry,
    this.showPrice,
    this.customerType,
    this.showDelivery,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appName: json["APP_NAME"],
    appCompanyName: json["APP_COMPANY_NAME"],
    userCode: json["user_code"],
    email: json["email"],
    businessName: json["business_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    contactName: json["contact_name"],
    phone: json["phone"],
    mobile: json["mobile"],
    deliveryAddress: json["delivery_address"],
    deliverySuburb: json["delivery_suburb"],
    deliveryPostCode: json["delivery_post_code"],
    deliveryState: json["delivery_state"],
    deliveryCountry: json["delivery_country"],
    postalAddress: json["postal_address"],
    postalSuburb: json["postal_suburb"],
    postalPostCode: json["postal_post_code"],
    postalState: json["postal_state"],
    postalCountry: json["postal_country"],
    showPrice: json["show_price"],
    customerType: json["customer_type"],
    showDelivery: json["show_delivery"],
  );

  Map<String, dynamic> toJson() => {
    "APP_NAME": appName,
    "APP_COMPANY_NAME": appCompanyName,
    "user_code": userCode,
    "email": email,
    "business_name": businessName,
    "first_name": firstName,
    "last_name": lastName,
    "contact_name": contactName,
    "phone": phone,
    "mobile": mobile,
    "delivery_address": deliveryAddress,
    "delivery_suburb": deliverySuburb,
    "delivery_post_code": deliveryPostCode,
    "delivery_state": deliveryState,
    "delivery_country": deliveryCountry,
    "postal_address": postalAddress,
    "postal_suburb": postalSuburb,
    "postal_post_code": postalPostCode,
    "postal_state": postalState,
    "postal_country": postalCountry,
    "show_price": showPrice,
    "customer_type": customerType,
    "show_delivery": showDelivery,
  };
}
