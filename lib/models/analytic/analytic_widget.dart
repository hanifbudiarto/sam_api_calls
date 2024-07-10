part of sam_models_analytics;

class AnalyticWidget {
  final String id;
  final String title;
  final String model;
  final ChartOptions options;
  final String adminId;

  AnalyticWidget(
      {required this.id,
        this.title = "",
      this.model = "",
      this.options = const ChartOptions(),
      this.adminId = ""});

  AnalyticWidget.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.title = ifNullReturnEmpty(json['title']),
        this.model = ifNullReturnEmpty(json['model']),
        this.options = ChartOptions.fromJson(json),
        this.adminId = ifNullReturnEmpty(json['admin_id']);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'title': this.title,
        'model': this.model,
        'options': this.options.toJson(),
        'admin_id': this.adminId,
      };
}
