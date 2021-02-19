import 'package:sam_api_calls/models/shared/shared_analytic.dart';

class SharedAnalytics {
  final List<SharedAnalytic> list;

  SharedAnalytics({this.list});

  factory SharedAnalytics.fromJson(Map<String, dynamic> json) {
    List<SharedAnalytic> shared = [];
    if (json.containsKey("body")) {
      var results = json["body"] as List;
      shared.addAll(results.map((a) => SharedAnalytic.fromJson(a)).toList());
    }

    return SharedAnalytics(list: shared);
  }
}
