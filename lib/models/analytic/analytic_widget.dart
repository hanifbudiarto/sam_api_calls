part of sam_models_analytics;

class AnalyticWidget {
  late final String id;
  late final String title;
  late final String model;
  late final ChartOptions? options;
  late final String adminId;

  AnalyticWidget(
      {required this.id,
      required this.title,
      required this.model,
      required this.options,
      required this.adminId});

  AnalyticWidget.fromJson(Map<String, dynamic> json) {
    try {
      this.id = json['id'];
      this.title = json['title'];
      this.model = json['model'];
      this.options = ChartOptions.fromJson(json);
      this.adminId = json['admin_id'];
    } catch (e) {
      print("Analytic fromJson ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['model'] = this.model;
    data['options'] = this.options != null ? this.options!.toJson() : null;
    data['admin_id'] = this.adminId;
    return data;
  }
}
