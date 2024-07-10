part of sam_models_dashboards;

class DashboardProfileData {
  final List<DashboardItem> items;
  final List<DashboardItem> flows;
  final String background;

  const DashboardProfileData(
      {this.items = const <DashboardItem>[],
      this.flows = const <DashboardItem>[],
      this.background = ""});

  DashboardProfileData.fromJson(Map<String, dynamic>? json)
      : this.flows = getFlowList(json),
        this.items = getList(json),
        this.background = json != null &&
                json.runtimeType != Null &&
                json.toString() != 'null' &&
                json.containsKey('bg') &&
                json['bg'] != null
            ? json['bg']
            : "";

  static List<DashboardItem> getList(Map<String, dynamic>? json) {
    List<DashboardItem> list = [];

    if (json != null &&
        json.runtimeType != Null &&
        json.toString() != 'null' &&
        json.containsKey('items') &&
        json['items'] != null) {
      var data = json['items'] as List;
      data.forEach((element) {
        IotWidget? iotWidget = SamIotWidgets.instance.collection
            .singleWhereOrNull((wgt) => wgt.id == element['widget_id']);
        if (iotWidget != null) {
          list.add(DashboardItem.fromJson(element));
        }
      });
    }

    return list;
  }

  static List<DashboardItem> getFlowList(Map<String, dynamic>? json) {
    List<DashboardItem> flowList = [];

    if (json != null &&
        json.runtimeType != Null &&
        json.toString() != 'null' &&
        json.containsKey('flows') &&
        json['flows'] != null) {
      var flowData = json['flows'] as List;
      flowData.forEach((element) {
        flowList.add(DashboardItem.fromJson(element));
      });
    }

    return flowList;
  }

  Map<String, dynamic> toJson() => {
        'bg': background,
        'items': this.items.map((DashboardItem item) => item.toJson()).toList(),
        'flows': this.flows.map((DashboardItem item) => item.toJson()).toList()
      };
}
