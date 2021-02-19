import 'package:sam_api_calls/models/analytic/option.dart';

class ChartOptions {
  List<Option> list;

  ChartOptions({this.list});

  factory ChartOptions.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null || json['options'].toString() != "null") {
      List opts = new List<Option>();
      json['options'].forEach((v) {
        opts.add(new Option.fromJson(v, json["model"]));
      });

      return ChartOptions(list: opts);
    }

    return null;
  }

  List<Map<String, dynamic>> toJson() {
    if (this.list != null) {
      return this.list.map((v) => v.toJson()).toList();
    }
    return [];
  }
}



