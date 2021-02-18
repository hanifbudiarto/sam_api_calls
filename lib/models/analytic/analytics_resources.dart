import 'analytic_resource.dart';

class AnalyticsResources {
  final List<AnalyticResource> list;

  AnalyticsResources({this.list});

  factory AnalyticsResources.fromJson(Map<String, dynamic> json) {
    List<AnalyticResource> analyticResourceList = [];

    if (json.containsKey("body")) {
      var bodies = json["body"] as List;
      analyticResourceList =
          bodies.map((c) => AnalyticResource.fromJson(c)).toList();
    }

    return AnalyticsResources(list: analyticResourceList);
  }
}
