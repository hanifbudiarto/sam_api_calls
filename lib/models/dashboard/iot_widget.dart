part of sam_models_dashboards;

class IotWidget {
  late final String id;
  late final String title;
  late final String icon;
  late final int minWidth;
  late final int minHeight;
  late final String tags;
  late final List<String> compatibleModels;
  late final String vendor;
  late final List<IotWidgetElement> elements;

  IotWidget(
      {required this.id,
      required this.title,
      required this.icon,
      required this.minWidth,
      required this.minHeight,
      required this.elements,
      required this.tags,
      required this.compatibleModels,
      required this.vendor});

  IotWidget.fromJson(Map<String, dynamic> json) {
    var elements = json['elements'] as List;
    var compatible = json['compatible_models'] as List;

    // convert to regex style
    compatible.forEach((compat) {
      compat.replaceAll('*', '\w+');
    });

    this.id = json['id'];
    this.title = json['title'];
    this.icon = json['icon'];
    this.minWidth = json['min_width'];
    this.minHeight = json['min_height'];
    this.tags = json['tags'];
    this.compatibleModels = compatible.map((e) => e.toString()).toList();
    this.vendor = json['vendor'];
    this.elements = elements.map((e) => IotWidgetElement.fromJson(e)).toList();
  }
}
