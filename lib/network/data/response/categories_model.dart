// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  List<Category>? categories;
  int? status;

  CategoriesModel({this.categories, this.status});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))), status: json["status"]);

  Map<String, dynamic> toJson() => {"categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())), "status": status};
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
