import 'device_iot.dart';

class Devices {
  List<DeviceIot> list;

  Devices({this.list});

  factory Devices.fromJson(Map<String, dynamic> json) {
    List<DeviceIot> devices = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      devices = list.map((dev) => DeviceIot.fromJson(dev)).toList();
    }

    return Devices(list: devices);
  }
}
