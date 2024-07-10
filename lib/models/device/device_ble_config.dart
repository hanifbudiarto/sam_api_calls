import 'package:sam_api_calls/models/device/device_ble.dart';

class DeviceBleConfig {
  final List<DeviceBle> bleDevices;

  const DeviceBleConfig({this.bleDevices = const <DeviceBle>[]});

  DeviceBleConfig.fromJson(Map<String, dynamic> json)
      : bleDevices = getBleDevices(json);

  static List<DeviceBle> getBleDevices(Map<String, dynamic> json) {
    List<DeviceBle> bleDevices = [];
    if (json['devices'].runtimeType != Null ||
        json['devices'].toString() != 'null') {
      json['devices'].forEach((v) {
        bleDevices.add(DeviceBle.fromJson(v));
      });
    }

    return bleDevices;
  }

  Map<String, dynamic> toJson() => {'devices': this.bleDevices.map((v) => v.toJson()).toList()};
}
