import 'package:sam_api_calls/models/analytic/chart_option.dart';

class AnalyticWidget {
  String id;
  String title;
  String model;
  ChartOptions options;
  String adminId;

  AnalyticWidget(
      {this.id,
        this.title,
        this.model,
        this.options,
        this.adminId});

  factory AnalyticWidget.fromJson(Map<String, dynamic> json) {
    try {
      return AnalyticWidget(
          id: json['id'],
          title: json['title'],
          model: json['model'],
          options: ChartOptions.fromJson(json),
          adminId: json['admin_id']);
    } catch (e) {
      print("Analytic fromJson ${e.toString()}");
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['model'] = this.model;
    data['options'] = this.options != null ? this.options.toJson() : null;
    data['admin_id'] = this.adminId;
    return data;
  }
}
