import 'package:flutter/material.dart';

import '../analytic/analytic.dart';
import '../sam_iot_widgets.dart';
import 'iot_widget.dart';

class DashboardItem {
  int position;
  int width; // default width on initial state is min_width
  int height; // default height on initial state is min_height

  String analyticId;
  AnalyticWidget analytic;

  IotWidget iotWidget;

  List<ElementResources> elementResources;

  DashboardItem(
      {@required this.position,
      @required this.analyticId,
      @required this.elementResources,
      @required this.iotWidget,
      this.width = 0,
      this.height = 0,
      this.analytic});

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    List<ElementResources> list = [];
    var res = json["element_resources"] as List;
    list = res.map((r) => ElementResources.fromJson(r)).toList();

    return DashboardItem(
        position: json["position"],
        width: json["width"],
        height: json["height"],
        iotWidget: SamIotWidgets().collection.singleWhere(
            (wgt) => wgt.id == json["widget_id"],
            orElse: () => null),
        analyticId: json["analytic_id"],
        elementResources: list);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result["position"] = position;
    result["width"] = width;
    result["height"] = height;
    result["widget_id"] = iotWidget.id;
    result["analytic_id"] = analytic.id;

    if (this.elementResources != null && elementResources.length > 0) {
      result["element_resources"] = this
          .elementResources
          .map((ElementResources elemenRes) => elemenRes.toJson())
          .toList();
    } else {
      result["element_resources"] = [];
    }

    return result;
  }
}
