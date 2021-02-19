import 'package:flutter/material.dart';
import 'package:sam_api_calls/models/dashboard/dashboard_item.dart';
import 'package:sam_api_calls/models/dashboard/iot_widget.dart';
import 'package:sam_api_calls/models/sam_iot_widgets.dart';

class DashboardProfileData {
  List<DashboardItem> items;
  String background;

  DashboardProfileData(
      {this.items = const <DashboardItem>[], @required this.background});

  factory DashboardProfileData.fromJson(Map<String, dynamic> json) {
    List<DashboardItem> list = [];

    var data = json["items"] as List;
    data.forEach((element) {
      IotWidget iotWidget = SamIotWidgets().collection.singleWhere(
          (wgt) => wgt.id == element["widget_id"],
          orElse: () => null);
      if (iotWidget != null) {
        list.add(DashboardItem.fromJson(element));
      }
    });

    return DashboardProfileData(
      items: list,
      background: json.containsKey("bg") ? json["bg"] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result["bg"] = background;

    if (this.items != null) {
      result["items"] =
          this.items.map((DashboardItem item) => item.toJson()).toList();
    } else {
      result["items"] = [];
    }

    return result;
  }
}
