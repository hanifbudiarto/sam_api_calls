part of sam_models_analytics;

class AnalyticWidgetParam {
  final String title;
  final String model;
  final ChartOptions options;

  AnalyticWidgetParam({this.title = "", this.model = "", this.options = const ChartOptions()});

  Map<String, dynamic> toJson() => {
        'title': ifNullReturnEmpty(this.title),
        'model': ifNullReturnEmpty(this.model),
        'options': this.options.toJson()
      };
}
