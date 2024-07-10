part of sam_models_shared;

class SharedAnalytics {
  final List<SharedAnalytic> list;

  SharedAnalytics({this.list = const <SharedAnalytic> []});

  SharedAnalytics.fromJson(Map<String, dynamic> json)
      : this.list = json.containsKey('body') ? getList(json) : [];

  static List<SharedAnalytic> getList(Map<String, dynamic> json) {
    List<SharedAnalytic> shared = [];
    var results = json['body'] as List;
    shared.addAll(results.map((a) => SharedAnalytic.fromJson(a)).toList());
    return shared;
  }
}
