// To parse this JSON data, do
//
//     final profileAppUserGuide = profileAppUserGuideFromJson(jsonString);

import 'dart:convert';

ProfileAppUserGuide profileAppUserGuideFromJson(String str) => ProfileAppUserGuide.fromJson(json.decode(str));

String profileAppUserGuideToJson(ProfileAppUserGuide data) => json.encode(data.toJson());

class ProfileAppUserGuide {
    int? status;
    String? message;
    Data? data;

    ProfileAppUserGuide({
        this.status,
        this.message,
        this.data,
    });

    factory ProfileAppUserGuide.fromJson(Map<String, dynamic> json) => ProfileAppUserGuide(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    CmsPage? cmsPage;

    Data({
        this.cmsPage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cmsPage: json["CmsPage"] == null ? null : CmsPage.fromJson(json["CmsPage"]),
    );

    Map<String, dynamic> toJson() => {
        "CmsPage": cmsPage?.toJson(),
    };
}

class CmsPage {
    String? id;
    String? title;
    String? text;
    String? retailerTitle;
    String? retailerText;
    String? retailerWebTitle;
    String? retailerWebText;
    String? pageName;

    CmsPage({
        this.id,
        this.title,
        this.text,
        this.retailerTitle,
        this.retailerText,
        this.retailerWebTitle,
        this.retailerWebText,
        this.pageName,
    });

    factory CmsPage.fromJson(Map<String, dynamic> json) => CmsPage(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        retailerTitle: json["retailer_title"],
        retailerText: json["retailer_text"],
        retailerWebTitle: json["retailer_web_title"],
        retailerWebText: json["retailer_web_text"],
        pageName: json["page_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "retailer_title": retailerTitle,
        "retailer_text": retailerText,
        "retailer_web_title": retailerWebTitle,
        "retailer_web_text": retailerWebText,
        "page_name": pageName,
    };
}
