part of sam_models_logs;

class DevicesLogs {
  late final List<SensorData> list;

  DevicesLogs({required this.list});

  DevicesLogs.fromJson(Map<String, dynamic> json, Property prop) {
    List<SensorData> list = [];

    if (json.containsKey('body')) {
      var collection = json['body'] as List;
      list = collection.expand((c) => getSensorData(c, prop)).toList();
    }

    this.list = list;
  }

  static List<SensorData> getSensorData(
      Map<String, dynamic> json, Property prop) {
    if (json.containsKey('value') &&
        json.containsKey('datein') &&
        json['value'].toString().length > 0 &&
        json['value'].toString() != 'null' &&
        json['datein'].toString().length > 0 &&
        json['datein'].toString() != 'null') {
      try {
        DateUtil.convertToLocalDate(json['datein'].toString());
        return [SensorData.fromJson(json, prop)];
      } catch (e) {}
    }

    return [];
  }
}
