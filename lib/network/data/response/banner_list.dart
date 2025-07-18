import 'dart:convert';

class BannerList {
  String? image;
  String? bannerText;
  int? linkItem;
  String? linkItemType;
  String? linkItemTypeId;

  BannerList({this.image, this.bannerText, this.linkItem, this.linkItemType, this.linkItemTypeId});

  factory BannerList.fromRawJson(String str) => BannerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(image: json["image"], bannerText: json["banner_text"], linkItem: json["link_item"], linkItemType: json["link_item_type"], linkItemTypeId: json["link_item_type_id"]);

  Map<String, dynamic> toJson() => {"image": image, "banner_text": bannerText, "link_item": linkItem, "link_item_type": linkItemType, "link_item_type_id": linkItemTypeId};
}
