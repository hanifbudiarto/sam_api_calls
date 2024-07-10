part of sam_models_logs;

class SensorData {
  DateTime datein;
  String value;
  String additionalValue;

  SensorData(
      {required this.datein, this.value = "", this.additionalValue = ""});

  SensorData.fromJson(Map<String, dynamic> json, Property prop)
      : this.datein = DateUtil.convertToLocalDate(json['datein'].toString()),
        this.value = getValue(json, prop),
        this.additionalValue = getAddValue(json);

  static String getValue(Map<String, dynamic> json, Property prop) {
    String valueJson = json['value'].toString();
    if (valueJson.contains('|')) {
      List<String> valueJsonSplit = valueJson.split('|');
      if (valueJsonSplit.length > 1) {
        valueJson = valueJsonSplit[0];
      }
    }

    if (prop.datatype.toLowerCase() == 'float' ||
            prop.datatype.toLowerCase() == 'integer') {
      valueJson = NumberUtil.removeTrailingZero(num.parse(valueJson));
    }

    return valueJson;
  }

  static String getAddValue(Map<String, dynamic> json) {
    String valueJson = json['value'].toString();
    String addValue = '';
    if (valueJson.contains('|')) {
      List<String> valueJsonSplitted = valueJson.split('|');
      if (valueJsonSplitted.length > 1) {
        valueJson = valueJsonSplitted[0];
        addValue = valueJsonSplitted[1];
      }
    }

    return addValue;
  }
}
