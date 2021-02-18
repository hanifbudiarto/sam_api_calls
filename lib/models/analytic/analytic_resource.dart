import 'resource.dart';

class AnalyticResource {
  String analyticId;
  List<Resource> resources;

  AnalyticResource({
    this.analyticId,
    this.resources,
  });

  factory AnalyticResource.fromJson(Map<String, dynamic> json) {
    List<Resource> list = [];
    var res = json["resources"] as List;
    if (res.length > 0) {
      list = res.map((c) => Resource.fromJson(c)).toList();
    }

    return AnalyticResource(
        analyticId: json["analytic_id"].toString(), resources: list);
  }
}





