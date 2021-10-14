part of sam_models_analytics;

class AnalyticWidgetParam {
  final String title;
  final String model;

  AnalyticWidgetParam(
      {required this.title, required this.model});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['model'] = this.model;
    return data;
  }
}
