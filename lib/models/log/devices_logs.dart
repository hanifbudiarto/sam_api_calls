import 'package:sam_api_calls/models/device/device.dart';
import 'package:sam_api_calls/models/log/sensor_data.dart';
import 'package:sam_api_calls/util/util.dart';

class DevicesLogs {
  final int totalrecords;
  final List<SensorData> list;

  DevicesLogs({this.totalrecords, this.list});

  factory DevicesLogs.fromJson(Map<String, dynamic> json, Property prop) {
    int total = 0;

    if (json.containsKey("totalrecords")) {
      try {
        total = int.tryParse(json["totalrecords"].toString());
      } on FormatException {}
    }

    List<SensorData> list = [];

    if (json.containsKey("body")) {
      var collection = json["body"] as List;
      list = collection.expand((c) => getSensorData(c, prop)).toList();
    }

    return DevicesLogs(totalrecords: total, list: list);
  }

  static List<SensorData> getSensorData(
      Map<String, dynamic> json, Property prop) {
    if (json.containsKey("value") &&
        json.containsKey("datein") &&
        json["value"].toString() != null &&
        json["value"].toString().length > 0 &&
        json["value"].toString() != "null" &&
        json["datein"].toString() != null &&
        json["datein"].toString().length > 0 &&
        json["datein"].toString() != "null") {
      try {
        DateUtil.convertToLocalDate(json["datein"].toString());
        return [SensorData.fromJson(json, prop)];
      } catch (e) {}
    }

    return [];
  }
}
