part of sam_models_logs;

class SensorData {
  late DateTime datein;
  late String value;
  late String additionalValue;

  SensorData(
      {required this.datein,
      required this.value,
      required this.additionalValue});

  SensorData.fromJson(Map<String, dynamic> json, Property prop) {
    String valueJson = json['value'].toString();
    String addValue = '';
    if (valueJson.contains('|')) {
      List<String> valueJsonSplitted = valueJson.split('|');
      if (valueJsonSplitted.length > 1) {
        valueJson = valueJsonSplitted[0];
        addValue = valueJsonSplitted[1];
      }
    }

    if (prop.datatype != null &&
        (prop.datatype!.toLowerCase() == 'float' ||
            prop.datatype!.toLowerCase() == 'integer')) {
      valueJson = NumberUtil.removeTrailingZero(num.parse(valueJson));
    }

    this.datein = DateUtil.convertToLocalDate(json['datein'].toString());
    this.value = valueJson;
    this.additionalValue = addValue;
  }
}
