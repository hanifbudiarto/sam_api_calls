import 'package:sam_api_calls/models/analytic/analytic_widget.dart';

class Analytics {
  final List<AnalyticWidget> list;

  Analytics({this.list});

  factory Analytics.fromJson(Map<String, dynamic> json) {
    List<AnalyticWidget> analytics = [];

    var results = json["body"] as List;

    if (results != null) {
      analytics = results.map((a) => AnalyticWidget.fromJson(a)).toList();
    }

    return Analytics(list: analytics);
  }
}
