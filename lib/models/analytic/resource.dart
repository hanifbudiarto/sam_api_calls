import '../device/device.dart';

import 'option_resource.dart';

class Resource {
  String resourceId;
  String deviceId;
  String deviceParameter;
  String aliasParameter;
  int operationMode;
  double operationValue;
  DeviceIot device;
  OptionResource optionResource;

  Resource(
      {this.resourceId,
        this.deviceId,
        this.deviceParameter,
        this.aliasParameter = "",
        this.operationMode = 0,
        this.operationValue = 0.0,
        this.optionResource});

  factory Resource.fromJson(Map<String, dynamic> json) {
    OptionResource optionResource;
    try {
      if (json["options"] != "null") {
        optionResource = OptionResource.fromJson(json["options"]);
      }
    } catch (e) {
      print("Resource fromJson ${e.toString()}");
    }

    return Resource(
        resourceId: json["id"],
        deviceId: json["device_id"],
        deviceParameter: json["parameter"],
        aliasParameter: json["name"] == "null" ? null : json["name"],
        operationMode: int.parse(json["operation_mode"]),
        operationValue: double.parse(json["operation_value"]),
        optionResource: optionResource);
  }

  Map toJson() => {
    "id": this.resourceId,
    "device_id": this.deviceId,
    "parameter": this.deviceParameter,
    "name": this.aliasParameter,
    "operation_mode": this.operationMode.toString(),
    "operation_value": this.operationValue.toString(),
    "options": this.optionResource.toJson()
  };
}
