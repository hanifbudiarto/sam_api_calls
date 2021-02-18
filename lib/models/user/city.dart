import 'package:flutter/material.dart';

class City {
  /*
  "id": "744",
  "name": "Witbank",
  "country_code": "ZAF",
  "district": "Mpumalanga"
   */

  String id;
  String name, countryCode, district;

  City(
      {@required this.id,
        @required this.name,
        @required this.countryCode,
        @required this.district});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json["id"].toString(),
        name: json["name"],
        countryCode: json["country_code"],
        district: json["district"]);
  }
}