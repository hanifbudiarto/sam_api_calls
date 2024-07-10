part of sam_models_dashboards;

class DashboardItem {
  final int position;
  final int width; // default width on initial state is min_width
  final int height; // default height on initial state is min_height

  final String analyticId;

  final IotWidget? iotWidget;

  final List<ElementResources> elementResources;

  AnalyticWidget? analytic;

  DashboardItem({
    required this.position,
    required this.analyticId,
    required this.iotWidget,
    required this.analytic,
    this.elementResources = const <ElementResources>[],
    this.width = 0,
    this.height = 0,
  });

  DashboardItem.fromJson(Map<String, dynamic> json)
      : this.position = json['position'],
        this.width = json['width'],
        this.height = json['height'],
        this.iotWidget = json['widget_id'] == 'widget-flow'
            ? null
            : SamIotWidgets.instance.collection
                .singleWhereOrNull((wgt) => wgt.id == json['widget_id']),
        this.analyticId = ifNullReturnEmpty(json['analytic_id']),
        this.elementResources = (json['element_resources'] as List)
            .map((r) => ElementResources.fromJson(r))
            .toList();

  Map<String, dynamic> toJson() => {
        'position': position,
        'width': width,
        'height': height,
        'widget_id': analytic != null && analytic!.model == 'widget-flow'
            ? 'widget-flow'
            : iotWidget!.id,
        'analytic_id': analyticId,
        'element_resources': this
            .elementResources
            .map((ElementResources elemenRes) => elemenRes.toJson())
            .toList()
      };
}
