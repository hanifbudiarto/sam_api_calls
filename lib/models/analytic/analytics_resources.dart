part of sam_models_analytics;

class AnalyticsResources {
  final List<AnalyticResource> list;

  AnalyticsResources({this.list = const <AnalyticResource> []});

  AnalyticsResources.fromJson(Map<String, dynamic> json)
      : this.list = getList(json);

  static List<AnalyticResource> getList(Map<String, dynamic> json) {
    List<AnalyticResource> analyticResourceList = [];

    if (json.containsKey('body')) {
      var bodies = json['body'] as List;
      analyticResourceList =
          bodies.map((c) => AnalyticResource.fromJson(c)).toList();
    }

    return analyticResourceList;
  }
}
