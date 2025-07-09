// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel profileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String profileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  int? status;
  String? message;
  Data? data;

  UserProfileModel({this.status, this.message, this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(status: json["status"], message: json["message"], data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  int? outlets;
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
  String? deliveryNote;

  Data({
    this.outlets,
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
    this.deliveryNote,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    outlets: json["outlets"],
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
    deliveryNote: json["delivery_note"],
  );

  Map<String, dynamic> toJson() => {
    "outlets": outlets,
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
    "delivery_note": deliveryNote,
  };
}
