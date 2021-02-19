import 'package:sam_api_calls/models/dashboard/dashboard.dart';
import 'package:sam_api_calls/models/device/wgt_elements.dart';
import 'package:sam_api_calls/models/sam_iot_widgets.dart';

class Wgt {
  IotWidget model;
  String name;
  String defaultTitle;
  String defaultLogo;
  int defaultWidth;
  int defaultHeight;
  List<WgtElements> elements;

  Wgt(
      {this.model,
      this.name,
      this.defaultTitle,
      this.defaultLogo,
      this.defaultWidth,
      this.defaultHeight,
      this.elements});

  factory Wgt.fromJson(Map<String, dynamic> json) {
    bool widgetExists =
        SamIotWidgets().collection.any((w) => w.id == json['model'].toString());

    List<WgtElements> el = new List<WgtElements>();
    if (json['elements'] != null) {
      json['elements'].forEach((v) {
        el.add(new WgtElements.fromJson(v));
      });
    }

    if (widgetExists) {
      return Wgt(
          model: SamIotWidgets()
              .collection
              .singleWhere((w) => w.id == json['model'].toString()),
          name: json['name'],
          defaultTitle: json['default_title'],
          defaultLogo: json['default_logo'],
          defaultWidth: json['default_width'],
          defaultHeight: json['default_height'],
          elements: el);
    }

    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['name'] = this.name;
    data['default_title'] = this.defaultTitle;
    data['default_logo'] = this.defaultLogo;
    data['default_width'] = this.defaultWidth;
    data['default_height'] = this.defaultHeight;
    if (this.elements != null) {
      data['elements'] = this.elements.map((v) => v.toJson()).toList();
    } else {
      data['elements'] = [];
    }
    return data;
  }
}
