import 'package:sam_api_calls/models/device/device_ble.dart';

class DeviceBleConfig {
  late List<DeviceBle> bleDevices;

  DeviceBleConfig(this.bleDevices);

  DeviceBleConfig.fromJson(Map<String, dynamic> json) {
    bleDevices = [];
    if (json['devices'].toString() != 'null') {
      json['devices'].forEach((v) {
        bleDevices.add(DeviceBle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['devices'] = bleDevices;
    return data;
  }
}