part of sam_models_analytics;

class ChartOptions {
  late final List<Option> list;

  ChartOptions({this.list = const <Option>[]});

  ChartOptions.fromJson(Map<String, dynamic> json) {
    List<Option> options = <Option>[];
    if (json['options'] != null || json['options'].toString() != 'null') {
      List opts = <Option>[];
      json['options'].forEach((v) {
        opts.add(new Option.fromJson(v, json['model']));
      });

      this.list = opts as List<Option>;
    } else {
      this.list = options;
    }
  }

  List<Map<String, dynamic>> toJson() {
    return this.list.map((v) => v.toJson()).toList();
  }
}
