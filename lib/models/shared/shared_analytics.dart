part of sam_models_shared;

class SharedAnalytics {
  late final List<SharedAnalytic> list;

  SharedAnalytics({required this.list});

  SharedAnalytics.fromJson(Map<String, dynamic> json) {
    List<SharedAnalytic> shared = [];
    if (json.containsKey('body')) {
      var results = json['body'] as List;
      shared.addAll(results.map((a) => SharedAnalytic.fromJson(a)).toList());
    }

    this.list = shared;
  }
}
