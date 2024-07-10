part of sam_models_logs;

class StyledDevicesLogs {
  final List<Ohlc> list;

  StyledDevicesLogs({this.list = const <Ohlc> []});

  StyledDevicesLogs.fromJson(Map<String, dynamic> json)
      : this.list = json.containsKey('body') ? getList(json) : [];

  static List<Ohlc> getList(Map<String, dynamic> json) {
    List<Ohlc> list = [];
    var collection = json['body'] as List;
    list = collection.map((c) => Ohlc.fromJson(c)).toList();

    return list;
  }
}
