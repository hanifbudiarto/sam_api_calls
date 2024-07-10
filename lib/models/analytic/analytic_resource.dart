part of sam_models_analytics;

class AnalyticResource {
  final String analyticId;
  final List<Resource> resources;

  AnalyticResource({
    required this.analyticId,
    this.resources = const <Resource>[],
  });

  AnalyticResource.fromJson(Map<String, dynamic> json)
      : this.analyticId = json['analytic_id'].toString(),
        this.resources = (json['resources'] as List).length > 0
            ? (json['resources'] as List)
                .map((c) => Resource.fromJson(c))
                .toList()
            : [];
}
