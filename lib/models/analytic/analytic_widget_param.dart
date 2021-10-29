part of sam_models_analytics;

class AnalyticWidgetParam {
  final String title;
  final String model;
  final ChartOptions? options;

  AnalyticWidgetParam({required this.title, required this.model, this.options});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['model'] = this.model;
    if (options != null) data['options'] = this.options;

    return data;
  }
}
