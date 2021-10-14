part of sam_models_logs;

class StyledDevicesLogs {
  late final List<Ohlc> list;

  StyledDevicesLogs({required this.list});

  StyledDevicesLogs.fromJson(Map<String, dynamic> json) {
    List<Ohlc> list = [];

    if (json.containsKey('body')) {
      var collection = json['body'] as List;
      list = collection
          .map((c) => Ohlc.fromJson(c))
          .toList();
    }

    this.list = list;
  }
}
