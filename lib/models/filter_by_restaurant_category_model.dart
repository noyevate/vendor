// To parse this JSON data, do
//
//     final restaurantCategoryModel = restaurantCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RestaurantCategoryModel> restaurantCategoryModelFromJson(String str) => List<RestaurantCategoryModel>.from(json.decode(str).map((x) => RestaurantCategoryModel.fromJson(x)));

String restaurantCategoryModelToJson(List<RestaurantCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantCategoryModel {
    final List<Item> items;
    final String restaurantCategory;
    final bool restaurantCategoryAvailable;

    RestaurantCategoryModel({
        required this.items,
        required this.restaurantCategory,
        required this.restaurantCategoryAvailable,
    });

    factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) => RestaurantCategoryModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        restaurantCategory: json["restaurant_category"],
        restaurantCategoryAvailable: json["restaurantCategoryAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "restaurant_category": restaurantCategory,
        "restaurantCategoryAvailable": restaurantCategoryAvailable,
    };
}

class Item {
    final String id;
    final String title;
    final String time;
    final List<String> foodTags;
    final String category;
    final List<String> foodType;
    final String code;
    final bool isAvailable;
    final String restaurant;
    final int rating;
    final String ratingCount;
    final String description;
    final int price;
    final String priceDescription;
    final List<Additive> additive;
    final List<Pack> pack;
    final List<String> imageUrl;

    Item({
        required this.id,
        required this.title,
        required this.time,
        required this.foodTags,
        required this.category,
        required this.foodType,
        required this.code,
        required this.isAvailable,
        required this.restaurant,
        required this.rating,
        required this.ratingCount,
        required this.description,
        required this.price,
        required this.priceDescription,
        required this.additive,
        required this.pack,
        required this.imageUrl,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        category: json["category"],
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"],
        priceDescription: json["priceDescription"],
        additive: List<Additive>.from(json["additive"].map((x) => Additive.fromJson(x))),
        pack: List<Pack>.from(json["pack"].map((x) => Pack.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "category": category,
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "priceDescription": priceDescription,
        "additive": List<dynamic>.from(additive.map((x) => x.toJson())),
        "pack": List<dynamic>.from(pack.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    };
}

class Additive {
    final String restaurantId;
    final String additiveTitle;
    final List<Option> options;
    final int max;
    final int min;
    final bool isAvailable;

    Additive({
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
    };
}

class Option {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    Option({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        additiveName: json["additiveName"],
        price: json["price"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "additiveName": additiveName,
        "price": price,
        "isAvailable": isAvailable,
    };
}

class Pack {
    final String restaurantId;
    final String packName;
    final String packDescription;
    final int price;
    final bool isAvailable;

    Pack({
        required this.restaurantId,
        required this.packName,
        required this.packDescription,
        required this.price,
        required this.isAvailable,
    });

    factory Pack.fromJson(Map<String, dynamic> json) => Pack(
        restaurantId: json["restaurantId"],
        packName: json["packName"],
        packDescription: json["packDescription"],
        price: json["price"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "packName": packName,
        "packDescription": packDescription,
        "price": price,
        "isAvailable": isAvailable,
    };
}
