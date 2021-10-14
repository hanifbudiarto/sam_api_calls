part of sam_models_devices;

class Devices {
  late final List<DeviceIot> list;

  Devices({required this.list});

  Devices.fromJson(Map<String, dynamic> json) {
    List<DeviceIot> devices = [];

    if (json.containsKey('body')) {
      var list = json['body'] as List;
      devices = list.map((dev) => DeviceIot.fromJson(dev)).toList();
    }

    this.list = devices;
  }
}
