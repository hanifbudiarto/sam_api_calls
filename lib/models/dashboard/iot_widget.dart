import 'package:flutter/material.dart';

import 'iot_widget_element.dart';

class IotWidget {
  String id;
  String title;
  String icon;
  int minWidth;
  int minHeight;
  String tags;
  List<String> compatibleModels;
  String vendor;
  List<IotWidgetElement> elements;

  IotWidget(
      {@required this.id,
        @required this.title,
        @required this.icon,
        @required this.minWidth,
        @required this.minHeight,
        @required this.elements,
        @required this.tags,
        @required this.compatibleModels,
        @required this.vendor});

  factory IotWidget.fromJson(Map<String, dynamic> json) {
    var elements = json["elements"] as List;
    var compatible = json["compatible_models"] as List;

    // convert to regex style
    compatible.forEach((compat) {
      compat.replaceAll("*", "\w+");
    });

    return IotWidget(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        minWidth: json["min_width"],
        minHeight: json["min_height"],
        tags: json["tags"],
        compatibleModels: compatible.map((e) => e.toString()).toList(),
        vendor: json["vendor"],
        elements: elements.map((e) => IotWidgetElement.fromJson(e)).toList());
  }
}