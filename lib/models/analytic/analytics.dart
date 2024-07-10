part of sam_models_analytics;

class Analytics {
  final List<AnalyticWidget> list;

  Analytics({this.list = const <AnalyticWidget> []});

  Analytics.fromJson(Map<String, dynamic> json) : this.list = getList(json);

  static List<AnalyticWidget> getList(Map<String, dynamic> json) {
    List<AnalyticWidget> analytics = [];

    List? results = json['body'] as List?;

    if (results != null) {
      analytics = results.map((a) => AnalyticWidget.fromJson(a)).toList();
    }

    return analytics;
  }
}
