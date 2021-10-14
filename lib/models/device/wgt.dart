part of sam_models_devices;

class Wgt {
  late final IotWidget model;
  late final String name;
  late final String defaultTitle;
  late final String defaultLogo;
  late final int defaultWidth;
  late final int defaultHeight;
  late final List<WgtElements> elements;

  Wgt(
      {required this.model,
      required this.name,
      required this.defaultTitle,
      required this.defaultLogo,
      required this.defaultWidth,
      required this.defaultHeight,
      required this.elements});

  Wgt.fromJson(Map<String, dynamic> json) {
    bool widgetExists =
        SamIotWidgets.instance.collection.any((w) => w.id == json['model'].toString());

    List<WgtElements> el = <WgtElements>[];
    if (json['elements'] != null) {
      json['elements'].forEach((v) {
        el.add(new WgtElements.fromJson(v));
      });
    }

    if (widgetExists) {
      this.model = SamIotWidgets.instance
          .collection
          .singleWhere((w) => w.id == json['model'].toString());
      this.name = json['name'];
      this.defaultTitle = json['default_title'];
      this.defaultLogo = json['default_logo'];
      this.defaultWidth = json['default_width'];
      this.defaultHeight = json['default_height'];
      this.elements = el;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['name'] = this.name;
    data['default_title'] = this.defaultTitle;
    data['default_logo'] = this.defaultLogo;
    data['default_width'] = this.defaultWidth;
    data['default_height'] = this.defaultHeight;
    data['elements'] = this.elements.map((v) => v.toJson()).toList();
    return data;
  }
}
