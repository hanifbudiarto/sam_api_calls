part of sam_models_devices;

class Wgt {
  final IotWidget? model;
  final String name;
  final String defaultTitle;
  final String defaultLogo;
  final int defaultWidth;
  final int defaultHeight;
  final List<WgtElements> elements;

  const Wgt(
      {required this.model,
      this.name = "",
      this.defaultTitle = "",
      this.defaultLogo = "",
      this.defaultWidth = 0,
      this.defaultHeight = 0,
      this.elements = const <WgtElements>[]});

  Wgt.fromJson(Map<String, dynamic> json) :
      this.model = SamIotWidgets.instance.collection
          .singleWhereOrNull((w) => w.id == json['model'].toString()),
      this.name = ifNullReturnEmpty(json['name']),
      this.defaultTitle = ifNullReturnEmpty(json['default_title']),
      this.defaultLogo = ifNullReturnEmpty(json['default_logo']),
      this.defaultWidth = json['default_width'],
      this.defaultHeight = json['default_height'],
      this.elements = getElements(json);

  static bool isWidgetExists(Map<String, dynamic> json) {
    return SamIotWidgets.instance.collection
        .any((w) => w.id == json['model'].toString());
  }

  static List<WgtElements> getElements(Map<String, dynamic> json) {
    List<WgtElements> el = <WgtElements>[];
    if (json['elements'] != null) {
      json['elements'].forEach((v) {
        el.add(new WgtElements.fromJson(v));
      });
    }

    return el;
  }

  Map<String, dynamic> toJson() => {
        'model': this.model,
        'name': this.name,
        'default_title': this.defaultTitle,
        'default_logo': this.defaultLogo,
        'default_width': this.defaultWidth,
        'default_height': this.defaultHeight,
        'elements': this.elements.map((v) => v.toJson()).toList(),
      };
}
