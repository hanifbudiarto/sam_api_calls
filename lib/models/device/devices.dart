part of sam_models_devices;

class Devices {
  final List<DeviceIot> list;

  Devices({this.list = const <DeviceIot> []});

  Devices.fromJson(Map<String, dynamic> json) : this.list = getList(json);

  static List<DeviceIot> getList(Map<String, dynamic> json) {
    List<DeviceIot> devices = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      devices = list.map((dev) => DeviceIot.fromJson(dev)).toList();
    }

    return devices;
  }
}
