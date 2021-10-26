part of sam_models_dashboards;

class DashboardProfileData {
  late List<DashboardItem> items;
  late List<DashboardItem> flows;
  String? background;

  DashboardProfileData(
      {this.items = const <DashboardItem>[],
      this.flows = const <DashboardItem>[],
      this.background});

  DashboardProfileData.fromJson(Map<String, dynamic> json) {
    List<DashboardItem> list = [];

    var data = json['items'] as List;
    data.forEach((element) {
      IotWidget? iotWidget = SamIotWidgets.instance.collection
          .singleWhereOrNull((wgt) => wgt.id == element['widget_id']);
      if (iotWidget != null) {
        list.add(DashboardItem.fromJson(element));
      }
    });

    List<DashboardItem> flowList = [];

    var flowData = json['flows'] as List;
    flowData.forEach((element) {
      IotWidget? iotWidget = SamIotWidgets.instance.collection
          .singleWhereOrNull((wgt) => wgt.id == element['widget_id']);
      if (iotWidget != null) {
        flowList.add(DashboardItem.fromJson(element));
      }
    });

    this.flows = flowList;
    this.items = list;
    this.background = json.containsKey('bg') ? json['bg'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = new Map<String, dynamic>();

    result['bg'] = background;
    result['items'] =
        this.items.map((DashboardItem item) => item.toJson()).toList();
    result['flows'] =
        this.flows.map((DashboardItem item) => item.toJson()).toList();

    return result;
  }
}
