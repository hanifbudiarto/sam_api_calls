part of sam_models_dashboards;


class DashboardItem {
  late int position;
  late int width; // default width on initial state is min_width
  late int height; // default height on initial state is min_height

  late String analyticId;
  late AnalyticWidget? analytic;

  late IotWidget? iotWidget;

  late List<ElementResources> elementResources;

  DashboardItem(
      {required this.position,
      required this.analyticId,
      required this.elementResources,
      required this.iotWidget,
      this.width = 0,
      this.height = 0,
      required this.analytic});

  DashboardItem.fromJson(Map<String, dynamic> json) {
    List<ElementResources> list = [];
    var res = json['element_resources'] as List;
    list = res.map((r) => ElementResources.fromJson(r)).toList();

    this.position = json['position'];
    this.width = json['width'];
    this.height = json['height'];
    this.iotWidget = SamIotWidgets.instance.collection.singleWhereOrNull(
            (wgt) => wgt.id == json['widget_id']);
    this.analyticId = json['analytic_id'];
    this.elementResources = list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result['position'] = position;
    result['width'] = width;
    result['height'] = height;
    result['widget_id'] = iotWidget!.id;
    result['analytic_id'] = analytic!.id;
    result['element_resources'] = this
        .elementResources
        .map((ElementResources elemenRes) => elemenRes.toJson())
        .toList();

    return result;
  }
}
