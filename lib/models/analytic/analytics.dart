part of sam_models_analytics;

class Analytics {
  late final List<AnalyticWidget> list;

  Analytics({required this.list});

  Analytics.fromJson(Map<String, dynamic> json) {
    List<AnalyticWidget> analytics = [];

    List? results = json['body'] as List?;

    if (results != null) {
      analytics = results.map((a) => AnalyticWidget.fromJson(a)).toList();
    }

    this.list = analytics;
  }
}
