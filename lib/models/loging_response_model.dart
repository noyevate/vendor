// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String fcm;
    final String pin;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final int v;
    final String userToken;
    final Restaurant? restaurant;

    LoginResponseModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.fcm,
        required this.pin,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.v,
        required this.userToken,
        this.restaurant,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        fcm: json["fcm"],
        pin: json["pin"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        v: json["__v"],
        userToken: json["userToken"],
        restaurant: json["restaurant"] != null ?  Restaurant.fromJson(json["restaurant"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fcm": fcm,
        "pin": pin,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "__v": v,
        "userToken": userToken,
        "restaurant": restaurant?.toJson(),
    };
}

class Restaurant {
    final String id;
    final String title;
    final List<Time> time;
    final String imageUrl;
    final List<String> foods;
    final bool pickup;
    final String restaurantMail;
    final bool delivery;
    final bool isAvailabe;
    final String phone;
    final String code;
    final String logoUrl;
    final String userId;
    final double rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final Coords coords;
    final String restaurantFcm;
    final String accountName;
    final String accountNumber;
    final String bank;

    Restaurant({
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.foods,
        required this.pickup,
        required this.restaurantMail,
        required this.delivery,
        required this.isAvailabe,
        required this.phone,
        required this.code,
        required this.logoUrl,
        required this.userId,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.coords,
        required this.restaurantFcm,
        required this.accountName,
        required this.accountNumber,
        required this.bank,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        title: json["title"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
        imageUrl: json["imageUrl"],
        foods: List<String>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        restaurantMail: json["restaurantMail"],
        delivery: json["delivery"],
        isAvailabe: json["isAvailabe"],
        phone: json["phone"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        userId: json["userId"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        coords: Coords.fromJson(json["coords"]),
        restaurantFcm: json["restaurantFcm"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "restaurantMail": restaurantMail,
        "delivery": delivery,
        "isAvailabe": isAvailabe,
        "phone": phone,
        "code": code,
        "logoUrl": logoUrl,
        "userId": userId,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "coords": coords.toJson(),
        "restaurantFcm": restaurantFcm,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bank": bank,
    };
}

class Coords {
    final String id;
    final double latitude;
    final double longitude;
    final String address;
    final String title;
    final double latitudeDelta;
    final double longitudeDelta;

    Coords({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.title,
        required this.latitudeDelta,
        required this.longitudeDelta,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
    };
}

class Time {
    final String orderType;
    final String day;
    final String open;
    final String close;
    final String? orderCutOffTime;
    final String? menuReadyTime;

    Time({
        required this.orderType,
        required this.day,
        required this.open,
        required this.close,
        this.orderCutOffTime,
        this.menuReadyTime,
    }) {
        // Validation logic for orderType
    if (orderType != 'Pre-order' && orderType != 'Instant delivery') {
      throw ArgumentError('Invalid orderType: must be "Pre-order" or "Instant delivery".');
    }

    // Additional checks based on orderType
    if (orderType == 'Pre-order' && (orderCutOffTime == null || menuReadyTime == null)) {
      throw ArgumentError('Pre-order requires orderCutOffTime and menuReadyTime.');
    }

    if (orderType == 'Instant delivery' && (orderCutOffTime != null || menuReadyTime != null)) {
      throw ArgumentError('Instant delivery should not have orderCutOffTime or menuReadyTime.');
    }
    }

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        orderType: json["orderType"],
        day: json["day"],
        open: json["open"],
        close: json["close"],
        orderCutOffTime: json["orderCutOffTime"],
        menuReadyTime: json["menuReadyTime"],
    );

    Map<String, dynamic> toJson() => {
        "orderType": orderType,
        "day": day,
        "open": open,
        "close": close,
        "orderCutOffTime": orderCutOffTime,
        "menuReadyTime": menuReadyTime,
    };
}
