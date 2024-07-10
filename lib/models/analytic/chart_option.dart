part of sam_models_analytics;

class ChartOptions {
  final List<Option> list;

  const ChartOptions({this.list = const <Option>[]});

  ChartOptions.fromJson(Map<String, dynamic> json)
      : this.list = getOptions(json);

  static List<Option> getOptions(Map<String, dynamic> json) {
    List<Option> options = <Option>[];
    if (json['options'].runtimeType != Null ||
        json['options'].toString() != 'null') {
      List opts = <Option>[];
      json['options'].forEach((v) {
        opts.add(new Option.fromJson(v, json['model']));
      });

      options.addAll(opts as List<Option>);
    }

    return options;
  }



  List<Map<String, dynamic>> toJson() {
    return this.list.map((v) => v.toJson()).toList();
  }
}
