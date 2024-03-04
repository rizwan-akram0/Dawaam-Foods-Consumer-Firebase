// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.categories,
  });

  List<Category> categories;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.name,
    required this.subcategory,
  });

  String name;
  List<String> subcategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
      };
}
