part of sam_models_analytics;

class Resource {
  late final String resourceId;
  late final String deviceId;
  late final String deviceParameter;
  late String aliasParameter;
  late int operationMode;
  late num operationValue;
  OptionResource? optionResource;
  DeviceIot? device;

  Resource(
      {required this.resourceId,
      required this.deviceId,
      required this.deviceParameter,
      this.aliasParameter = '',
      this.operationMode = 0,
      this.operationValue = 0.0,
      this.optionResource,
      this.device});

  Resource.fromJson(Map<String, dynamic> json) {
    OptionResource? optionResource;
    try {
      if (json['options'] != 'null') {
        optionResource = OptionResource.fromJson(json['options']);
      }
    } catch (e) {
      print('Resource fromJson ${e.toString()}');
    }

    this.resourceId = json['id'];
    this.deviceId = json['device_id'];
    this.deviceParameter = json['parameter'];
    this.aliasParameter = json['name'] == 'null' ? null : json['name'];
    this.operationMode = int.parse(json['operation_mode']);
    this.operationValue = double.parse(json['operation_value']);
    this.optionResource = optionResource;
  }

  Map toJson() => {
        'id': this.resourceId,
        'device_id': this.deviceId,
        'parameter': this.deviceParameter,
        'name': this.aliasParameter,
        'operation_mode': this.operationMode.toString(),
        'operation_value': this.operationValue.toString(),
        'options': this.optionResource!.toJson()
      };
}
