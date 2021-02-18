import 'package:flutter/material.dart';
import 'city.dart';

class Cities {
  List<City> list;

  Cities({@required this.list});

  factory Cities.fromJson(Map<String, dynamic> json) {
    List<City> cities = [];

    if (json.containsKey("body")) {
      var list = json["body"] as List;
      cities = list.map((item) => City.fromJson(item)).toList();
    }
    return Cities(list: cities);
  }
}
