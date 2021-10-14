part of sam_models_analytics;

class AnalyticsResources {
  late final List<AnalyticResource> list;

  AnalyticsResources({required this.list});

  AnalyticsResources.fromJson(Map<String, dynamic> json) {
    List<AnalyticResource> analyticResourceList = [];

    if (json.containsKey('body')) {
      var bodies = json['body'] as List;
      analyticResourceList =
          bodies.map((c) => AnalyticResource.fromJson(c)).toList();
    }

    this.list = analyticResourceList;
  }
}
