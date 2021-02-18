import 'package:flutter/material.dart';

class IotWidgetElement {
  String id;
  String title;
  String icon;
  bool settable;
  bool retained;
  int numOfParameters;
  List<String> acceptedParameters;

  IotWidgetElement(
      {@required this.id,
        @required this.title,
        @required this.icon,
        @required this.settable,
        @required this.retained,
        @required this.numOfParameters,
        @required this.acceptedParameters});

  factory IotWidgetElement.fromJson(Map<String, dynamic> json) {
    var acceptedParams = json["accepted_parameters"] as List;

    return IotWidgetElement(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        settable: json["settable"],
        retained: json["retained"],
        numOfParameters: json["num_of_parameters"],
        acceptedParameters: acceptedParams.map((a) => a.toString()).toList());
  }
}