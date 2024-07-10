part of sam_models_devices;

class ValidDevice {
  final String id;
  final DeviceIot device;
  final bool valid;

  ValidDevice({required this.id, required this.device, this.valid = false});

  @override
  bool operator ==(other) {
    return (other is ValidDevice) && other.id == id;
  }

  int get hashCode => id.hashCode;
}
