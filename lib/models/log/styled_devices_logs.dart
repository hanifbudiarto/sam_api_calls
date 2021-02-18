import 'ohlc.dart';

class StyledDevicesLogs {
  final int totalrecords;
  final List<Ohlc> list;

  StyledDevicesLogs({this.totalrecords, this.list});

  factory StyledDevicesLogs.fromJson(Map<String, dynamic> json) {
    int total = 0;

    if (json.containsKey("totalrecords")) {
      try {
        total = int.tryParse(json["totalrecords"].toString());
      } on FormatException {}
    }

    List<Ohlc> list = [];

    if (json.containsKey("body")) {
      var collection = json["body"] as List;
      list = collection
          .map((c) => Ohlc.fromJson(c))
          .where((oh) => oh != null)
          .toList();
    }

    return StyledDevicesLogs(totalrecords: total, list: list);
  }
}
