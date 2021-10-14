part of sam_models_analytics;

class AnalyticResource {
  late final String analyticId;
  late final List<Resource> resources;

  AnalyticResource({
    required this.analyticId,
    required this.resources,
  });

  AnalyticResource.fromJson(Map<String, dynamic> json) {
    List<Resource> list = [];
    var res = json['resources'] as List;
    if (res.length > 0) {
      list = res.map((c) => Resource.fromJson(c)).toList();
    }
    
    this.analyticId = json['analytic_id'];
    this.resources = list;
  }
}





