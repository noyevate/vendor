// To parse this JSON data, do
//
//     final categorySearchModel = categorySearchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CategorySearchModel> categorySearchModelFromJson(String str) => List<CategorySearchModel>.from(json.decode(str).map((x) => CategorySearchModel.fromJson(x)));

String categorySearchModelToJson(List<CategorySearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategorySearchModel {
    final String id;
    final String title;
    final String value;
    final String imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    CategorySearchModel({
        required this.id,
        required this.title,
        required this.value,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory CategorySearchModel.fromJson(Map<String, dynamic> json) => CategorySearchModel(
        id: json["_id"],
        title: json["title"],
        value: json["value"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "value": value,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
