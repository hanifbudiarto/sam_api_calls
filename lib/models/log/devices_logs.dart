part of sam_models_logs;

class DevicesLogs {
  final List<SensorData> list;

  DevicesLogs({this.list = const <SensorData>[]});

  DevicesLogs.fromJson(Map<String, dynamic> json, Property prop)
      : this.list = json.containsKey('body') ? getSensorData(json, prop) : [];

  static List<SensorData> getSensorData(
      Map<String, dynamic> json, Property prop) {
    List<SensorData> list = [];

    var collection = json['body'] as List;
    list = collection
        .expand((c) {
          if (c.containsKey('value') &&
              c.containsKey('datein') &&
              c['value'].toString().length > 0 &&
              c['value'].toString() != 'null' &&
              c['datein'].toString().length > 0 &&
              c['datein'].toString() != 'null') {
            try {
              DateUtil.convertToLocalDate(c['datein'].toString());
              return <SensorData>[SensorData.fromJson(c, prop)];
            } catch (e) {}
          }

          return <SensorData>[];
        })
        .toList();

    return list;
  }
}
