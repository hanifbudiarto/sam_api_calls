part of sam_models_dashboards;

class IotWidget {
  final String id;
  final String title;
  final String icon;
  final int minWidth;
  final int minHeight;
  final String tags;
  final List<String> compatibleModels;
  final String vendor;
  final List<IotWidgetElement> elements;

  IotWidget(
      {required this.id,
      this.title = "",
      this.icon = "",
      this.minWidth = 0,
      this.minHeight = 0,
      this.elements = const <IotWidgetElement>[],
      this.tags = "",
      this.compatibleModels = const <String>[],
      this.vendor = ""});

  IotWidget.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.title = ifNullReturnEmpty(json['title']),
        this.icon = ifNullReturnEmpty(json['icon']),
        this.minWidth = json['min_width'],
        this.minHeight = json['min_height'],
        this.tags = ifNullReturnEmpty(json['tags']),
        this.compatibleModels = getCompatibleModels(json),
        this.vendor = ifNullReturnEmpty(json['vendor']),
        this.elements = (json['elements'] as List)
            .map((e) => IotWidgetElement.fromJson(e))
            .toList();

  static List<String> getCompatibleModels(Map<String, dynamic> json) {
    var compatible = json['compatible_models'] as List;

    // convert to regex style
    compatible.forEach((compat) {
      compat.replaceAll('*', '\w+');
    });

    return compatible.map((e) => e.toString()).toList();
  }
}
