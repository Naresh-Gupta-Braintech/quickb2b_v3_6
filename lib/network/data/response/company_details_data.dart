import 'dart:convert';

CompanyDetailsData companyDetailsDataFromJson(String str) => CompanyDetailsData.fromJson(json.decode(str));

String companyDetailsDataToJson(CompanyDetailsData data) => json.encode(data.toJson());

class CompanyDetailsData {
  int? status;
  String? message;
  Data? data;

  CompanyDetailsData({this.status, this.message, this.data});

  factory CompanyDetailsData.fromJson(Map<String, dynamic> json) => CompanyDetailsData(status: json["status"], message: json["message"], data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  String? appName;
  String? enableRetailFeature;
  int? enableRegionSystem;
  List<Region>? regions;

  Data({this.appName, this.enableRetailFeature, this.enableRegionSystem, this.regions});

  factory Data.fromJson(Map<String, dynamic> json) => Data(appName: json["APP_NAME"], enableRetailFeature: json["ENABLE_RETAIL_FEATURE"], enableRegionSystem: json["ENABLE_REGION_SYSTEM"], regions: json["regions"] == null ? [] : List<Region>.from(json["regions"]!.map((x) => Region.fromJson(x))));

  Map<String, dynamic> toJson() => {"APP_NAME": appName, "ENABLE_RETAIL_FEATURE": enableRetailFeature, "ENABLE_REGION_SYSTEM": enableRegionSystem, "regions": regions == null ? [] : List<dynamic>.from(regions!.map((x) => x.toJson()))};
}

class Region {
  String? clientCode;
  String? companyName;

  Region({this.clientCode, this.companyName});

  factory Region.fromJson(Map<String, dynamic> json) => Region(clientCode: json["client_code"], companyName: json["company_name"]);

  Map<String, dynamic> toJson() => {"client_code": clientCode, "company_name": companyName};
}
