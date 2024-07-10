part of sam_models_analytics;

class Resource {
  final String resourceId;
  final String deviceId;
  final String deviceParameter;
  final String aliasParameter;
  final int operationMode;
  final num operationValue;
  final OptionResource optionResource;

  DeviceIot? device;

  Resource(
      {required this.resourceId,
      required this.deviceId,
      required this.deviceParameter,
      this.aliasParameter = '',
      this.operationMode = 0,
      this.operationValue = 0.0,
      this.optionResource = const OptionResource(),
      this.device});

  Resource.fromJson(Map<String, dynamic> json)
      : this.resourceId = json['id'].toString(),
        this.deviceId = json['device_id'].toString(),
        this.deviceParameter = json['parameter'].toString(),
        this.aliasParameter = ifNullReturnEmpty(json['name']),
        this.operationMode =
            int.parse(ifNullReturnEmpty(json['operation_mode'])),
        this.operationValue =
            double.parse(ifNullReturnEmpty(json['operation_value'])),
        this.optionResource = json['options'].runtimeType != Null ||
                json['options'] != null ||
                json['options'].toString() != 'null'
            ? OptionResource.fromJson(json['options'])
            : OptionResource();

  Map toJson() => {
        'id': this.resourceId,
        'device_id': this.deviceId,
        'parameter': this.deviceParameter,
        'name': this.aliasParameter,
        'operation_mode': this.operationMode.toString(),
        'operation_value': this.operationValue.toString(),
        'options': this.optionResource.toJson()
      };
}
