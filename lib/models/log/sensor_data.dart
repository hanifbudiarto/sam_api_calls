

import 'package:sam_api_calls/models/device/device.dart';
import 'package:sam_api_calls/util/util.dart';

class SensorData {
  DateTime datein;
  String value;
  String additionalValue;

  SensorData({this.datein, this.value, this.additionalValue});

  factory SensorData.fromJson(Map<String, dynamic> json, Property prop) {
    String valueJson = json["value"].toString();
    String addValue;
    if (valueJson.contains("|")) {
      List<String> valueJsonSplitted = valueJson.split("|");
      if (valueJsonSplitted.length > 1) {
        valueJson = valueJsonSplitted[0];
        addValue = valueJsonSplitted[1];
      }
    }

    if (prop != null && prop.datatype != null && (prop.datatype.toLowerCase() == "float" || prop.datatype.toLowerCase() == "integer")){
      valueJson = NumberUtil.removeTrailingZero(num.parse(valueJson));
    }

    return SensorData(
        datein: DateUtil.convertToLocalDate(json["datein"].toString()),
        value: valueJson,
        additionalValue: addValue);
  }
}
